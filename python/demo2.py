import time
import math
import MServo

servo = MServo.MServo(0x10)

servo.write_position_setpoint(180)
servo.write_mode(1)

while abs(servo.read_position() - 180) > 1:
    time.sleep(0.01)

for i in range(0, 299*5):
    pos = math.cos(i/50.0)*90 + 90
    servo.write_position_setpoint(pos)
    time.sleep(0.01)

servo.write_mode(1)
servo.write_position_setpoint(90)
