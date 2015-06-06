unsigned char fw_version_major = 0;
unsigned char fw_version_minor = 5;
unsigned char fw_version_revision = 0;

int Err_flag = 0;

int My_pwm = -110;
int My_count = 0;

int Mode = 0;

int Const_pwm = 0;

// raw sensor values
int Voltage_raw = 0;
int Current_raw = 0;
int Temp_raw = 0;
int Pos_raw = 0;

// scaled sensor values
float Voltage = 0;
float Current = 0;
float Current_filt = 0;
float Temp = 0;
float Pos = 0;
float Pos_filt = 0;

// torque estimation (not in use)
float Torque = 0;
float Torque_target = 0;

// current limiter (not in use)
float Current_limit = 3500;

// position controller parameters
float Pos_p_gain = 0.4;
float Pos_ctrl_limit = 15;

float Pos_p_gain_curve_y[] = {10, 0.5, 10};
float Pos_gain_curve_x[] = {-10, 0, 10};
int Pos_gain_curve_len = 3;

// position controller signals
float Pos_p = 0;
float Pos_err = 0;
float Pos_old_err = 0;
float Pos_target = 50;
float Pos_ctrl_value_ulim = 0;
float Pos_ctrl_value_lim = 0;

float Motor_ctrl = 0;
int Motor_disabled = 0;  // for debugging

float Pos_integrator  = 0;
float Pos_old_pos = -999;

float Old_micros = 0;
float TET = 0;

float Old_micros2 = 0;
float Cycle_time = 0;

int Task_index = 0;

// I2C stuff
int i2c_mode = 1; // 0 => values can only read via i2c, 1 => read and write are possible, overrides debug interface
volatile unsigned char i2c_address = 0x10;
volatile unsigned char i2c_register = 0;
volatile unsigned char i2c_array[21];

