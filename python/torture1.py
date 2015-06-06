import time
import math
import MServo

# - high rate i2c write
# - close to maximum motor current
# - big current transitions -> big ripple voltage

servo = MServo.MServo(0x10)

servo.write_position_setpoint(90)
servo.write_mode(1)

time.sleep(1)
servo.write_mode(0)

for i in range(0,1000):
    servo.write_pwm_setpoint(50)
    servo.write_pwm_setpoint(0)
    servo.write_pwm_setpoint(-50)
    servo.write_pwm_setpoint(0)

servo.write_mode(1)
servo.write_pwm_setpoint(0)
