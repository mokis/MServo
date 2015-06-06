int Mode = 1;

// raw sensor values
int Voltage_raw = 0;
int Current_raw = 0;
int Temp_raw = 0;
int Pos_raw = 0;

// scaled sensor values
float Voltage = 0;
float Current = 0;
float Temp = 0;
float Pos = 0;
float Pos_filt = 0;
float Pos_vec[] = {0,0,0,0};
int Pos_vec_i = 0;

// speed calculation
float Old_pos = 0;
float Speed = 0;
float Speed_filt = 0;

// damper
float Dampening_gain = -0.1;

// position controller parameters
float Pos_p_gain = 10;
float Pos_i_gain = 0.05;
float Pos_d_gain = 10;
float Pos_i_limit = 100;
float Pos_ctrl_limit = 100;

// position controller signals
float Pos_p = 0;
float Pos_i = 0;
float Pos_d = 0;
float Pos_err = 0;
float Pos_target = 50;
float Pos_ctrl_value_ulim = 0;
float Pos_ctrl_value_lim = 0;

float Motor_ctrl = 0;

float Pos_integrator  = 0;
float Pos_old_pos = -999;

float Old_micros = 0;
float TET = 0;

float Old_micros2 = 0;
float Cycle_time = 0;

int Task_index = 0;

