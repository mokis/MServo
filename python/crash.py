import time
import math
import MServo

servo = MServo.MServo(0x10)

servo.write_position_setpoint(90)
servo.write_mode(1)

time.sleep(1)
servo.write_mode(2)

for i in range(0,1000):
    servo.write_pwm_setpoint(100)
    servo.write_pwm_setpoint(0)
    #time.sleep(0.01)
    servo.write_pwm_setpoint(-100)
    servo.write_pwm_setpoint(0)
    #time.sleep(0.01)

servo.write_mode(1)
servo.write_pwm_setpoint(0)
