
import smbus
#import smbus_dummy

import time



class MServo:
    def __init__(self, address):
        self.interface = {"pos":             {"reg": 0, "scale": 100.0, "offset": 0.0, "length": 2, "unit": "deg", "value": 0},
                          "speed":           {"reg": 2, "scale": 10.0, "offset": 0.0, "length": 2, "unit": "deg/s", "value": 0},
                          "temp":            {"reg": 4, "scale": 1.0, "offset": 100.0, "length": 1, "unit": "degC", "value": 0},
                          "voltage":         {"reg": 5, "scale": 10.0, "offset": 0.0, "length": 1, "unit": "V", "value": 0},
                          "current":         {"reg": 6, "scale": 0.05, "offset": 0.0, "length": 1, "unit": "mA", "value": 0},
                          "torque":          {"reg": 7, "scale": 100.0, "offset": 0.0, "length": 1, "unit": "Nm", "value": 0},
                          "pwm":             {"reg": 8, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "%", "value": 0},
                          "mode":            {"reg": 9, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "", "value": 0},
                          "pos_setpoint":    {"reg": 10, "scale": 100.0, "offset": 0.0, "length": 2, "unit": "deg", "value": 0},
                          "speed_setpoint":  {"reg": 12, "scale": 10.0, "offset": 0.0, "length": 2, "unit": "deg/s", "value": 0},
                          "torque_setpoint": {"reg": 14, "scale": 100.0, "offset": 0.0, "length": 1, "unit": "Nm", "value": 0},
                          "pwm_setpoint":    {"reg": 15, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "%", "value": 0},
                          "current_limit":   {"reg": 16, "scale": 0.05, "offset": 0.0, "length": 1, "unit": "mA", "value": 0},
                          "i2c_address":     {"reg": 17, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "", "value": 0},
                          "fw_version_major":{"reg": 18, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "", "value": 0},
                          "fw_version_minor":{"reg": 19, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "", "value": 0},
                          "fw_version_rev":  {"reg": 20, "scale": 1.0, "offset": 0.0, "length": 1, "unit": "", "value": 0}}
        
        self.error5_count = 0
        self.error5_tot_count = 0
        self.error5_reset_time = time.time()

        self.interface["i2c_address"]["value"] = address
        self.i2c_bus = smbus.SMBus(1)
        #self.i2c_bus = smbus_dummy.SMBus(1)
        
    def write_mode(self, mode):
        """ Changes operating mode. 1=pwm, 2=pos, 3=speed, 4=torque """ 
        self.write_register_byte("mode", mode)

    def write_position_setpoint(self, position_setpoint):
        """ Changes position setpoint [deg]. Effective when position control mode is activated """
        self.write_register_word("pos_setpoint", position_setpoint)

    def write_speed_setpoint(self, speed_setpoint):
        """ Changes speed setpoint [deg/s]. Effective when speed control mode is activated """
        self.write_register_word("speed_setpoint", speed_setpoint)

    def write_torque_setpoint(self, torque_setpoint):
        """ Changes torque setpoint [Nm]. Effective when torque control mode is activated """
        self.write_register_byte("torque_setpoint", torque_setpoint)

    def write_pwm_setpoint(self, pwm_setpoint):
        """ Changes PWM percentage [%]. Effective when PWM mode is activated """
        self.write_register_byte("pwm_setpoint", pwm_setpoint)

    def write_current_limit(self, current_limit):
        """ Changes current limit [mA]. Effective always """
        self.write_register_byte("current_limit", current_limit)

    def write_i2c_address(self, i2c_address):
        """ Changes I2C address. Servo will change it's address immediately """
        self.write_register_byte("i2c_address", i2c_address)

    def read_position(self):
        """ Gives position in [deg] """
        return self.read_register_word("pos", True)

    def read_speed(self):
        """ Gives speed in [deg/s] """
        return self.read_register_word("speed", True)

    def read_temperature(self):
        """ Gives temperature in [degC] """
        return self.read_register_byte("temp", True)

    def read_voltage(self):
        """ Gives supply voltage in [V] """
        return self.read_register_byte("voltage")

    def read_current(self):
        """ Gives motor current in [mA] """
        return self.read_register_byte("current")

    def read_torque(self):
        """ Gives motor torque in [Nm] (calculated from current) """
        return self.read_register_byte("torque", True)

    def read_pwm(self):
        """ Gives motor PWM in [%] """
        return self.read_register_byte("pwm", True)

    def read_mode(self):
        """ Gives active operating mode """
        return self.read_register_byte("mode")

    def read_position_setpoint(self):
        """ Gives position setpoint in [deg] """
        return self.read_register_word("pos_setpoint", True)

    def read_speed_setpoint(self):
        """ Gives speed setpoint in [deg/s]. """
        return self.read_register_word("speed_setpoint", True)

    def read_torque_setpoint(self):
        """ Gives torque setpoint in [Nm]. """
        return self.read_register_byte("torque_setpoint", True)

    def read_pwm_setpoint(self):
        """ Gives PWM percentage in [%]. """
        return self.read_register_byte("pwm_setpoint", True)

    def read_current_limit(self):
        """ Gives current limit in [mA]. """
        return self.read_register_byte("current_limit")

    def read_i2c_address(self):
        """ Gives I2C address. """
        self.interface["i2c_address"]["value"] = int(self.read_register_byte("i2c_address"))
        return self.interface["i2c_address"]["value"]

    def read_firmware_version(self):
        """ Gives firmware version (string) """
        major = self.read_register_byte("fw_version_major")
        minor = self.read_register_byte("fw_version_minor")
        rev = self.read_register_byte("fw_version_rev")
        return str(int(major)) + "." + str(int(minor)) + "." + str(int(rev))

    def get_error5_count(self):
        """ Gives total count of IOErrors and rate of IOErrors between function calls

        This function is implemented because Raspberry pi and Atmega doesn't work
        very well together. Atmega is slowish especially with 8MHz clock, so it
        (probably) uses clock stretching. In the other hand, clock stretching implementation
        in Rasperry pi is faulty. This causes occasional IOErrors. With
        standard 100kHz clock, error rate is in acceptable level. With 40kHz clock,
        I2C works without errors.

        For more information google: raspberry pi i2c bug"""
        error5_rate = self.error5_count / (time.time() - self.error5_reset_time)
        return self.error5_tot_count, error5_rate


    def write_register_word(self, name, value):
        i2c_value = int(value*self.interface[name]["scale"] + self.interface[name]["offset"])
        #print "write w", i2c_value
        try:
            self.i2c_bus.write_word_data(self.interface["i2c_address"]["value"], self.interface[name]["reg"], i2c_value) 
        except IOError:
            print "IO error, write word"
            self.error5_count += 1
            self.error5_tot_count += 1

    def write_register_byte(self, name, value):
        i2c_value = int(value*self.interface[name]["scale"] + self.interface[name]["offset"])
        #print "write b", i2c_value
        try:
            self.i2c_bus.write_byte_data(self.interface["i2c_address"]["value"], self.interface[name]["reg"], i2c_value) 
        except IOError:
            print "IO error, write byte"
            self.error5_count += 1
            self.error5_tot_count += 1

    def read_register_word(self, name, twos_complement = False):
        try:
            lsb = self.i2c_bus.read_byte_data(self.interface["i2c_address"]["value"], self.interface[name]["reg"])
            msb = self.i2c_bus.read_byte(self.interface["i2c_address"]["value"]) # servo autoincrements
            i2c_value = (msb << 8) + lsb
            if twos_complement and i2c_value > 32767:
                i2c_value = i2c_value - 65536
            #print "read w", lsb, msb
            value = i2c_value / self.interface[name]["scale"] - self.interface[name]["offset"]
            self.interface[name]["value"] = value
            return value
            
        except IOError:
            print "IO error, read word"
            self.error5_count += 1
            self.error5_tot_count += 1
            return self.interface[name]["value"]

    def read_register_byte(self, name, twos_complement = False):
        try:
            i2c_value = self.i2c_bus.read_byte_data(self.interface["i2c_address"]["value"], self.interface[name]["reg"])
            if twos_complement and i2c_value > 127:
                i2c_value = i2c_value - 256
                
            value = i2c_value / self.interface[name]["scale"] - self.interface[name]["offset"]
            
            self.interface[name]["value"] = value
            return value
            
        except IOError:
            print "IO error, read byte"
            self.error5_count += 1
            self.error5_tot_count += 1
            return self.interface[name]["value"]



if __name__ == "__main__":
    servo = MServo(0x10)

    print "position"
    print servo.read_position()
    print ""

    print "speed"
    print servo.read_speed()
    print ""

    print "temperature"
    print servo.read_temperature()
    print ""

    print "voltage"
    print servo.read_voltage()
    print ""

    print "current"
    print servo.read_current()
    print ""

    print "torque"
    print servo.read_torque()
    print ""

    print "pwm"
    print servo.read_pwm()
    print ""
    
    print "mode"
    servo.write_mode(2)
    print servo.read_mode()
    servo.write_mode(0)
    print ""

    print "position setpoint"    
    servo.write_position_setpoint(45)
    print servo.read_position_setpoint()
    print ""

    print "speed setpoint"    
    servo.write_speed_setpoint(-1)
    print servo.read_speed_setpoint()
    #servo.write_speed_setpoint(0)
    print ""

    print "torque setpoint"    
    servo.write_torque_setpoint(1.25)
    print servo.read_torque_setpoint()
    servo.write_torque_setpoint(0.0)
    print ""

    print "pwm setpoint"    
    servo.write_pwm_setpoint(-5)
    print servo.read_pwm_setpoint()
    servo.write_pwm_setpoint(0)
    print ""

    print "current limit"    
    servo.write_current_limit(4500)
    print servo.read_current_limit()
    print ""

    print "I2C address"    
    print servo.read_i2c_address()
    print ""

    print "Firmware version"
    print servo.read_firmware_version()
    print ""
    
