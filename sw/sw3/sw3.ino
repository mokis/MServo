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
  Timer1.initialize(25);
  Timer1.pwm(9, 0);
  Timer1.pwm(10, 0); 
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  
  // set controller task execution frequency to 500Hz (2ms interval)
  //FlexiTimer2::set(10, 1.0/10000, controller_task);
  //FlexiTimer2::start();
}

void loop() {
  Old_micros = micros();
  
  long udelta;
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
