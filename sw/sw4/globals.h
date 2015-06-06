unsigned char fw_version_major = 0;
unsigned char fw_version_minor = 4;
unsigned char fw_version_revision = 0;

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
float Pos_vec[] = {0,0,0,0};
int Pos_vec_i = 0;

// torque estimation (not in use)
float Torque = 0;
float Torque_target = 0;

// current limiter (not in use)
float Current_limit = 3500;

// speed calculation
float Old_pos = 0;
float Speed = 0;
float Speed_filt = 0;
float Speed_filt2 = 0;
float Speed_filter_gain = 0.8;
float Speed_filter_gain_curve_y[] = {0.6, 0.3, 0.6};
float Speed_filter_gain_curve_x[] = {-10, 0, 10};
int Speed_filter_gain_curve_len = 3;

// damper
float Dampening_gain = 0.2;
float Pos_damp_gain_curve_y[] = {-0.3, -0.2, -0.15, -0.2, -0.3};
float Speed_damp_gain_curve_y[] = {-0.001, -0.001, -0.0005, -0.001, -0.001};
float Damp_gain_curve_x[] = {-10, -5, 0, 5, 10};
int Damp_gain_curve_len = 3;

// position controller parameters
float Pos_p_gain = 10;
float Pos_i_gain = 5;
float Pos_d_gain = 10;
float Pos_i_limit = 100;
float Pos_ctrl_limit = 10;
float Pos_i_filter_gain = 1;

float Pos_p_gain_curve_y[] = {10, 0.5, 10};
float Pos_d_gain_curve_y[] = {10, 0.5, 10};
float Pos_gain_curve_x[] = {-10, 0, 10};
int Pos_gain_curve_len = 3;

float Pos_i_filter_gain_curve_y[] = {1, 0.15, 1};
float Pos_i_filter_gain_curve_x[] = {-5, 0, 5};

// position controller signals
float Pos_p = 0;
float Pos_i = 0;
float Pos_d = 0;
float Pos_err = 0;
float Pos_old_err = 0;
float Pos_target = 50;
float Pos_ctrl_value_ulim = 0;
float Pos_ctrl_value_lim = 0;

// Speed controller parameters
float Speed_p_gain = 0.02;
float Speed_i_gain = 0.01;
float Speed_d_gain = 0.01;
float Speed_ctrl_limit = 100;
float Speed_speed_filter_gain = 0.45;
float Speed_dampening_gain = -0.05;

float Speed_p_gain_curve_y[] = {0.3, 0.05, 0.3};
float Speed_i_gain_curve_y[] = {0.02, 0.005, 0.02};
float Speed_gain_curve_x[] = {-20, 0, 20};
int Speed_gain_curve_len = 3;

// Speed controller signals
float Speed_p = 0;
float Speed_i = 0;
float Speed_d = 0;
float Speed_err = 0;
float Speed_err_filt = 0;
float Speed_old_err = 0;
float Speed_target = 0;
float Speed_ctrl_value_ulim = 0;
float Speed_ctrl_value_lim = 0;

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

