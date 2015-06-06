import time
import MServo

servo = MServo.MServo(0x10)

print "position control mode"
servo.write_position_setpoint(20)
servo.write_mode(1)

print ""

while servo.read_position() < 19 or servo.read_position() > 21:
    time.sleep(0.05)
    print "current [mA]", servo.read_current()


servo.write_position_setpoint(160)
servo.write_mode(1)

print ""

while servo.read_position() < 159 or servo.read_position() > 161:
    time.sleep(0.05)
    print "current [mA]", servo.read_current()

time.sleep(1)

print ""

print "pwm mode"
servo.write_pwm_setpoint(-10)
servo.write_mode(0)

while servo.read_position() > 21:
    time.sleep(0.05)

servo.write_position_setpoint(20)
servo.write_mode(1)

time.sleep(1)

print ""

print "speed control mode"
servo.write_speed_setpoint(100)
servo.write_mode(2)

while servo.read_position() < 159:
    time.sleep(0.05)
    print "pwm [%]", servo.read_pwm()

servo.write_position_setpoint(160)
servo.write_mode(1)

time.sleep(1)
