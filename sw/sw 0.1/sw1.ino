
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
  int deg0 = 89;
  int deg180 = 932; 
  float delta = deg180 - deg0;
  Pos_raw = analogRead(A2);
  Pos = 180 - ((Pos_raw - deg0) / delta) * 180.0;
  
  //Pos_vec[Pos_vec_i] = Pos;
  //if (Pos_vec_i < 3) {
  //  Pos_vec_i++;
  //} else {
  //  Pos_vec_i = 0;
  //}
  
  //Pos_filt = 0;
  
  //for (int i; i < 3; i++) {
  //  Pos_filt = Pos_filt + Pos_vec[i];
  //}
  float delta2 = Pos - Pos_filt;
  Pos_filt = Pos_filt + delta2 * 1.0;
}

// Virtual sensor for angular speed, calculated from servo position
// Units in deg/s
void get_speed() {
  int update_freq = 333; //[Hz]
  
  Speed = (Pos - Old_pos) * update_freq;
  float delta = Speed - Speed_filt;
  Speed_filt = Speed_filt + delta * 0.7;

  Old_pos = Pos;
}

// Reads current from supply line of MOSFETs
// Units in ampers
void get_current() {
  float current_scale_factor = 0.00339;
  Current_raw = analogRead(A0);
  Current = Current_raw * current_scale_factor;
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

float damper() {
  return Dampening_gain * Speed_filt;
}

void pos_controller() {
  if (Pos_old_pos < -900) {
    Pos_old_pos = Pos_filt;
  } 

  float delta = Pos_filt - Pos_old_pos;
  Pos_old_pos = Pos_filt;
  
  // controller
  Pos_err = Pos_target - Pos;
  Pos_p = Pos_err * Pos_p_gain;
  
  if (abs(Pos_err) < 10) {
    Pos_i = Pos_i + Pos_err * Pos_i_gain;
  }
  
  Pos_d = delta * Pos_d_gain;
  Pos_ctrl_value_ulim = Pos_p + Pos_i + Pos_d + damper();
  Pos_ctrl_value_lim = Pos_ctrl_value_ulim; 
  
  // anti wind up
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

// Motor driver
// ctrl_value should be given in percents. Range is 100..-100
// Positive control values will cause torque to positive direction (see get_pos())
void motor(float ctrl_value) {
  Motor_ctrl = ctrl_value;
  
  if (ctrl_value > 0) {
    if (ctrl_value > 100) { 
      ctrl_value = 100;
    }
    analogWrite(10, 0);
    analogWrite(9, int(ctrl_value*2.55));
  } else if (ctrl_value < 0) {
    if (ctrl_value < -100) { 
      ctrl_value = -100;
    }
    analogWrite(9, 0);
    analogWrite(10, int(-ctrl_value*2.55));
  } else {
    analogWrite(9, 0);
    analogWrite(10, 0);
  }
}

/*
void controller_task() {
  Jitter = 1000 - (micros() - Old_micros);
  Old_micros = micros();
  
  if (Task_index == 0) {
    get_current();
  } else if (Task_index == 1) {
    get_voltage();
  } else if (Task_index == 2) {
    //get_pos();
  } else if (Task_index == 3) {  
    get_current();
  } else if (Task_index == 4) {  
    if (Mode == 0) {
      motor(0);
    }
  
    if (Mode == 1) {
      pos_controller();
    }
  }
  
  Task_index++;
  if (Task_index > 4) {
    Task_index = 0;
  }
}
*/


void setup() {
  Serial.begin(57600);
  pinMode(2, OUTPUT);  
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
    motor(0);
  }
  
  if (Mode == 1) {
    pos_controller();
  }
  
  if (Mode == 2) {
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
