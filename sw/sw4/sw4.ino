#include <Wire.h>

#include "TimerOne.h"

#include "globals.h"

// Reads supply voltage of the servo
// Units in volts
void get_voltage() {
  float voltage_scale_factor = 0.01619;
  Voltage_raw = analogRead(A1);
  Voltage = Voltage_raw * voltage_scale_factor;
}


// Reads servo position
// Units in degrees. Usefull range is 0..180 deg. 
// The value increases to anti clock wise direction when looked from the top of the servo
void get_pos() {
  int deg0 = 84;
  int deg180 = 922; 
  float delta = deg180 - deg0;
  Pos_raw = analogRead(A2);
  Pos = 180 - ((Pos_raw - deg0) / delta) * 180.0;
  
  float delta2 = Pos - Pos_filt;
  Pos_filt = Pos_filt + delta2 * 0.8;
}


// Virtual sensor for angular speed, calculated from servo position
// Units in deg/s
void get_speed() {
  int update_freq = 333; //[Hz]
  
  Speed = (Pos - Old_pos) * update_freq;
  float delta = Speed - Speed_filt;
  float delta2 = Speed - Speed_filt2;
  
  if (Mode == 1) {
    Speed_filter_gain = curve_interpolation_lim(Speed_filter_gain_curve_x, Speed_filter_gain_curve_y, Pos_target - Pos, Speed_filter_gain_curve_len);
  } else if (Mode == 2) {
    Speed_filter_gain = 1.0;
  }
  
  Speed_filt = Speed_filt + delta * Speed_filter_gain;
  Speed_filt2 = Speed_filt2 + delta2 * 0.015;

  Old_pos = Pos;
}


// Reads current from supply line of MOSFETs
// Units in milliampers
void get_current() {
  float current_scale_factor = 3.45;
  Current_raw = analogRead(A0);
  
  if (Current_raw == 0) {
    Current = 0;
  } else {
    Current = 230 + Current_raw * current_scale_factor;
  }
  
  float delta = Current - Current_filt;
  Current_filt = Current_filt + delta * 0.03;
}


// Reads TI temperature sensor
// Units in degC
void get_temp() { 
  int temp130 = 89;
  int temp0 = 550;
  float delta = temp0 - temp130;
  Temp_raw = analogRead(A3);
  Temp = 130.0 - (float(Temp_raw - temp130) / delta) * 130.0;
}  


void read_sensors() {
  get_voltage();
  get_current();
  get_temp();
  get_pos();
  get_speed();
}


float curve_interpolation_lim(float *curve_x, float *curve_y, float input_val, int array_len) {
  int last = array_len - 1;
  int i = 0;

  float ratio;
  float dy;
  float output_val;
  
  if (input_val <= curve_x[0]) {
    return curve_y[0];
  }

  if (input_val >= curve_x[last]) {
    return curve_y[last];
  }    

  while (curve_x[i] < input_val) {
    i++;
  }

  ratio = (float)(input_val - curve_x[i-1]) / (curve_x[i] - curve_x[i-1]);

  dy = curve_y[i] - curve_y[i-1];
  output_val = curve_y[i-1] + ratio * dy;

  return output_val;
}


float damper() {
  if (Mode == 1) {
    Dampening_gain = curve_interpolation_lim(Damp_gain_curve_x, Pos_damp_gain_curve_y, Pos_target - Pos, Damp_gain_curve_len);
  } else {
    Dampening_gain = curve_interpolation_lim(Damp_gain_curve_x, Speed_damp_gain_curve_y, Speed_target - Speed_filt2, Damp_gain_curve_len);
  }
  return Dampening_gain * Speed_filt;
}


void pos_controller() {
  if (Pos_old_pos < -900) {
    Pos_old_pos = Pos_filt;
  } 

  // delta for derivative part
  float delta = Pos_filt - Pos_old_pos;
  Pos_old_pos = Pos_filt;
  
  Pos_err = Pos_target - Pos_filt;
  
  Pos_p_gain = curve_interpolation_lim(Pos_gain_curve_x, Pos_p_gain_curve_y, Pos_err, Pos_gain_curve_len);
  Pos_d_gain = curve_interpolation_lim(Pos_gain_curve_x, Pos_d_gain_curve_y, Pos_err, Pos_gain_curve_len); 
  
  Pos_p = Pos_err * Pos_p_gain;
  Pos_d = delta * Pos_d_gain;
  
  // integrator is disabled if actual position is too far a way from target position
  if (abs(Pos_err) < 10) {
    Pos_i = Pos_i + (Pos_err * Pos_i_gain);
  }
  
  // integrator is artificially decreased when actual position is near current position
  // kind of integrator reset functionality  
  Pos_i_filter_gain = curve_interpolation_lim(Pos_i_filter_gain_curve_x, Pos_i_filter_gain_curve_y, Pos_err, Pos_gain_curve_len);
  Pos_i = Pos_i * Pos_i_filter_gain;
  
  // unlimited control value
  Pos_ctrl_value_ulim = Pos_p + Pos_i + Pos_d + damper();
  Pos_ctrl_value_lim = Pos_ctrl_value_ulim; 
  
  // integrator saturation
  if (Pos_i > Pos_i_limit) {
    Pos_i = Pos_i_limit;
  }

  if (Pos_i < -Pos_i_limit) {
    Pos_i = -Pos_i_limit;
  }  
  
  // control value saturation
  if (Pos_ctrl_value_lim > Pos_ctrl_limit) {
    Pos_ctrl_value_lim = Pos_ctrl_limit;
  }
  
  if (Pos_ctrl_value_lim < -Pos_ctrl_limit) {
    Pos_ctrl_value_lim = -Pos_ctrl_limit;
  } 
  
  // driver
  motor(Pos_ctrl_value_lim);
}


void speed_controller() {
  Speed_err = Speed_target - Speed_filt;
  Speed_err_filt = Speed_target - Speed_filt2;
  
  Speed_p_gain = curve_interpolation_lim(Speed_gain_curve_x, Speed_p_gain_curve_y, Speed_err_filt, Speed_gain_curve_len);
  Speed_i_gain = curve_interpolation_lim(Speed_gain_curve_x, Speed_i_gain_curve_y, Speed_err_filt, Speed_gain_curve_len);
  
  Speed_p = Speed_p_gain * Speed_err;
  Speed_i = Speed_i + Speed_i_gain * Speed_err_filt;
  
  Speed_ctrl_value_ulim = Speed_p + Speed_i + damper();
  Speed_ctrl_value_lim = Speed_ctrl_value_ulim;
  
  if (Speed_ctrl_value_lim > Speed_ctrl_limit) {
    Speed_ctrl_value_lim = Speed_ctrl_limit;
  }
  
  if (Speed_ctrl_value_lim < -Speed_ctrl_limit) {
    Speed_ctrl_value_lim = -Speed_ctrl_limit;
  }
  
  if (Pos < 0 || Pos > 180) {
    Speed_i = 0;
    //Speed_ctrl_value_lim = 0;
  } 
  
  motor(Speed_ctrl_value_lim + end_stops());
}


// "spring" that prevents driving to mechanical end stops
float end_stops() {
  float ctrl; 
  if (Pos < 0) {
    ctrl = 7 * -Pos;
  }
  if (Pos > 180) {
    ctrl = 7 * (180 - Pos);
  }
  return ctrl;
}


// Motor driver
// ctrl_value should be given in percents. Range is 100..-100
// Positive control values will cause torque to positive direction (see get_pos())
void motor(float ctrl_value) {
  Motor_ctrl = ctrl_value;
  
  if (Motor_disabled == 1) {
    ctrl_value = 0;
  }
  
  if (ctrl_value > 0) {
    if (ctrl_value > 100) { 
      ctrl_value = 100;
    }
    Timer1.pwm(10, 0);
    Timer1.pwm(9, int(ctrl_value*10.23));
  } else if (ctrl_value < 0) {
    if (ctrl_value < -100) { 
      ctrl_value = -100;
    }
    Timer1.pwm(9, 0);
    Timer1.pwm(10, int(-ctrl_value*10.23));
  } else {
    Timer1.pwm(9, 0);
    Timer1.pwm(10, 0);
  }
}


void setup() {
  Serial.begin(57600);
  pinMode(2, OUTPUT); 

  // 25kHz 
  Timer1.initialize(40);
  Timer1.pwm(9, 0, 40);
  Timer1.pwm(10, 0, 40); 
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  
  i2c_init_array();
  
  Wire.begin(i2c_address);
  Wire.onRequest(i2c_request_event);
  Wire.onReceive(i2c_receive_event);
}


void loop() {
  Old_micros = micros();
  
  long udelta;
  
  if (i2c_mode == 1) {
    i2c_read_write_array();
  } else {
    i2c_init_array();
  }
  
  serial_com();
  read_sensors();

  if (Mode == 0) {
    motor(Const_pwm);
  }
  
  if (Mode == 1) {
    pos_controller();
  }
  
  if (Mode == 2) {
    speed_controller();
  }
  
  if (Mode == 9) {
    motor( damper() );
  }
  
  TET = micros() - Old_micros;
  
  udelta = micros() - Old_micros2;
  while (udelta < 2935 && udelta > 0) {
    udelta = micros() - Old_micros2;
  } 
  
  Cycle_time = micros() - Old_micros2;
  Old_micros2 = micros();
}


void i2c_init_array() {
  // position [deg], 2 bytes, scale 100, offset 0
  i2c_array[0] = (int(Pos) * 100);
  i2c_array[1] = (int(Pos) * 100) >> 8;
  
  // speed [deg/s], 2 bytes, scale 10, offset 0
  i2c_array[2] = int(Speed_filt2 * 10);
  i2c_array[3] = int(Speed_filt2 * 10) >> 8;  
  
  // temp [degC], 1 byte, scale 1, offset +100
  i2c_array[4] = int(Temp) + 100;

  // voltage [v], 1 byte, scale 10, offset 0
  i2c_array[5] = int(Voltage * 10);   
  
  // current [mA], 1 byte, scale 1/20, offset 0
  i2c_array[6] = int(Current_filt / 20);  
  
  // Torque [Nm], 1 byte, scale 100, offset 0
  i2c_array[7] = int(Torque * 100);  
  
  // PWM [%], 1 byte, scale 1, offset 0
  i2c_array[8] = int(Motor_ctrl); 
  
  // Mode, 1 byte, scale 1, offset 0
  i2c_array[9] = Mode;
  
  // Pos setpoint [deg], 2 bytes, scale 100, offset 0
  i2c_array[10] = int(Pos_target * 100);
  i2c_array[11] = int(Pos_target * 100) >> 8; 
 
  // Speed setpoint [deg/s], 2 bytes, scale 10, offset 0
  i2c_array[12] = int(Speed_target * 10);
  i2c_array[13] = int(Speed_target * 10) >> 8; 

  // Torque setpoint [Nm], 1 byte, scale 100, offset 0
  i2c_array[14] = int(Torque_target * 100); 
 
  // PWM [%], 1 byte, scale 1, offset 0
  i2c_array[15] = int(Const_pwm); 
  
  // current limit [mA], 1 byte, scale 1/20, offset 0
  i2c_array[16] = int(Current_limit / 20); 
 
  // i2c address, 1 byte
  i2c_array[17] = i2c_address;  
  
  // firmware version, 3 bytes
  i2c_array[18] = fw_version_major; 
  i2c_array[19] = fw_version_minor;
  i2c_array[20] = fw_version_revision;
}


// just for keeping interrupts light and quick
void i2c_read_write_array() {
  // position [deg], 2 bytes, scale 100, offset 0
  i2c_array[0] = int(Pos * 100);
  i2c_array[1] = int(Pos * 100) >> 8;
  
  // speed [deg/s], 2 bytes, scale 10, offset 0
  i2c_array[2] = int(Speed_filt2 * 10);
  i2c_array[3] = int(Speed_filt2 * 10) >> 8;  
  
  // temp [degC], 1 byte, scale 1, offset +100
  i2c_array[4] = int(Temp) + 100;

  // voltage [v], 1 byte, scale 10, offset 0
  i2c_array[5] = int(Voltage * 10);   
  
  // current [mA], 1 byte, scale 1/20, offset 0
  i2c_array[6] = int(Current_filt / 20);  
  
  // Torque [Nm], 1 byte, scale 100, offset 0
  i2c_array[7] = int(Torque * 100);  
  
  // PWM [%], 1 byte, scale 1, offset 0
  i2c_array[8] = int(Motor_ctrl); 
  
  // Mode, 1 byte, scale 1, offset 0
  Mode = i2c_array[9];
  
  // Pos setpoint [deg], 2 bytes, scale 100, offset 0
  Pos_target = float(i2c_array[10] + (i2c_array[11] << 8)) / 100.0;
 
  // Speed setpoint [deg/s], 2 bytes, scale 10, offset 0
  Speed_target = float(i2c_array[12] + (i2c_array[13] << 8)) / 10.0;

  // Torque setpoint [Nm], 1 byte, scale 100, offset 0
  Torque_target = float(i2c_array[14]) / 100.0;

  // PWM [%], 1 byte, scale 1, offset 0
  Const_pwm = char(i2c_array[15]);
  
  // current limit [mA], 1 byte, scale 20, offset 0
  Current_limit = float(i2c_array[16]) * 20;
 
  // i2c address, 1 byte
  i2c_array[17] = i2c_address;  
  
  // firmware version, 3 bytes
  i2c_array[18] = fw_version_major; 
  i2c_array[19] = fw_version_minor;
  i2c_array[20] = fw_version_revision;  
}  

  
void i2c_request_event() {
  Wire.write(i2c_array[i2c_register]);
  i2c_register++;
}


void i2c_receive_event(int bytes_received) {
  i2c_register = Wire.read();
  
  while(Wire.available()) {
    i2c_array[i2c_register] = Wire.read();
    i2c_register++;
  
    if (i2c_register > 19) {
      i2c_register = 0;
    }
  }
}

 
