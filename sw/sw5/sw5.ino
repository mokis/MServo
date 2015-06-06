#include <Wire.h>

#include "TimerOne.h"

#include "globals.h"


// Reads servo position
// Units in degrees. Usefull range is 0..180 deg. 
// The value increases to anti clock wise direction when looked from the top of the servo
float get_pos() {
  int deg0 = 84;
  int deg180 = 922; 
  float delta = deg180 - deg0;
  Pos_raw = analogRead(A2);
  return 180 - ((Pos_raw - deg0) / delta) * 180.0;
}

void pos_controller() {
  Pos = get_pos();
  Pos_err = Pos_target - Pos;
  
  //Pos_p_gain = curve_interpolation_lim(Pos_gain_curve_x, Pos_p_gain_curve_y, Pos_err, Pos_gain_curve_len);
  Pos_p = Pos_err * Pos_p_gain;
  
  /*
  // unlimited control value
  Pos_ctrl_value_ulim = Pos_p; //+ damper();
  Pos_ctrl_value_lim = Pos_ctrl_value_ulim; 
   
  // control value saturation
  if (Pos_ctrl_value_lim > Pos_ctrl_limit) {
    Pos_ctrl_value_lim = Pos_ctrl_limit;
  }
  
  if (Pos_ctrl_value_lim < -Pos_ctrl_limit) {
    Pos_ctrl_value_lim = -Pos_ctrl_limit;
  } 
  */
  motor(Pos_p);
}

// Motor driver
// ctrl_value should be given in percents. Range is 100..-100
// Positive control values will cause torque to positive direction (see get_pos())
void motor(float ctrl_value) {
  Motor_ctrl = ctrl_value;
  
  //if (Motor_disabled == 1) {
  //  ctrl_value = 0;
  //}
  
  if (ctrl_value > 0) {
    if (ctrl_value > 100) { 
      ctrl_value = 100;
    }
    Timer1.setPwmDuty(10, 0);
    delay(3);
    My_pwm = int(ctrl_value*2.54);
    Timer1.setPwmDuty(9, My_pwm);
  } else if (ctrl_value < 0) {
    if (ctrl_value < -100) { 
      ctrl_value = -100;
    }
    Timer1.setPwmDuty(9, 0);
    delay(3);
    My_pwm = int(-ctrl_value*2.54);
    Timer1.setPwmDuty(10, My_pwm);
  } else {
    Timer1.setPwmDuty(9, 0);
    Timer1.setPwmDuty(10, 0);
  }
}


void setup() {
  Serial.begin(57600);
  pinMode(2, OUTPUT); 

  Timer1.initialize(100);
  Timer1.pwm(9, 0, 100);
  Timer1.pwm(10, 0, 100); 
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
}


void loop() {
  Old_micros = micros();
  
  long udelta;

  pos_controller();
  //pwm_generator();


  if (My_count > 333) {
    Serial.print(millis());
    Serial.print(", ");
    Serial.print(Pos_err);
    Serial.print(", ");
    Serial.println(My_pwm);
    My_count = 0;
  }

  My_count++;
  
  
  TET = micros() - Old_micros;
  
  udelta = micros() - Old_micros2;
  while (udelta < 2935 && udelta > 0) {
    udelta = micros() - Old_micros2;
  }
  
  Cycle_time = micros() - Old_micros2;
  Old_micros2 = micros();
}
 
