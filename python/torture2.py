import time
import math
import MServo

servo = MServo.MServo(0x10)

servo.write_position_setpoint(90)
servo.write_mode(1)

time.sleep(1)

for i in range(0,10):
    servo.write_position_setpoint(170)
    time.sleep(0.3)
    servo.write_position_setpoint(10)
    time.sleep(0.3)

