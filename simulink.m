clear all
close all
clc


opts = detectImportOptions('MCT.csv','NumHeaderLines',0,'PreserveVariableNames',true);

Raw_Data = readtable('MCT.csv',opts) ;
Cycle_Data = readtable('HWFET.csv',opts) ; 


%electric_consumption = table2array(readtable('electric_consumption.csv'));
electric_consumption = table2array(readtable('electric_consumption_INR.csv'));
%battery_SOC = table2array(readtable('battery_SOC.csv'));
battery_SOC = table2array(readtable('battery_SOC_INR.csv'));
motor_torque = readtable('motor_torque.csv');
motor_efficiency = readtable('motor_efficiency.csv');
drag_coefficient = readtable('drag_coefficient.csv');


battery_SOC_SOC = battery_SOC(:,1);
battery_SOC_voltage = battery_SOC(:,2);
electric_consumption_voltage = electric_consumption(:,1);
electric_consumption_ressistancce = electric_consumption(:,2);


motor_efficiency_RPM = table2array(motor_efficiency(2:height(motor_efficiency),1));
motor_efficiency_torque = table2array(motor_efficiency(1,2:width(motor_efficiency)));
motor_efficiency_efficiency = table2array(motor_efficiency(2:height(motor_efficiency),2:width(motor_efficiency)));
motor_efficiency_torque = transpose(motor_efficiency_torque);


Cycle_Speed = table2array(Raw_Data(:,:));
HWFET_Speed = table2array(Cycle_Data(:,:));
motor_torque_RPM = table2array(motor_torque(1:14,2));
motor_RPM_torque = table2array(motor_torque(1:14,1));

drag_coefficient_input = table2array(drag_coefficient(:,1));
drag_coefficient_LV = table2array(drag_coefficient(:,2));
drag_coefficient_FV1 = table2array(drag_coefficient(:,3));
drag_coefficient_FV2 = table2array(drag_coefficient(:,4));

slope = [1,0];
Tire_Inertia_Moment = [1,0.1431];
Brake_Inertia_Moment = [1,0.02];
Differential_Inertia_Moment_In = [1,0.015];
Differential_Inertia_Moment_Out1 = [1,0.015];
Differential_Inertia_Moment_Out2 = [1,0.015];
Final_Drive_Inertia_Moment_In = [1,0.01];
Final_Drive_Inertia_Moment_Out = [1,0.015];
Motor_Inertia_Moment_In = [1,0.0226];
Vehicle_Weight = [1,20000];
Amb_Temp = [1,25];
Amb_Press = [1,101.325];
Wheel_Radius = [1,0.316];
Differential_Efficiency = [1,0.96];
Final_Drive_Efficiency = [1,0.96];
Final_Gear_Ratio = [1,7.4];
%Resistance_F0 = [1,53.905];
Resistance_rolling = [1,588.6];
Resistance_friction = [1,0.21857];
Resistance_aero = [1,0.029304];
Regenerative_percent = [1,0.7];
Battery_Capacity = [1,625500];

Total_time = [1,length(Cycle_Speed)];

simulation_time = 10381 ;
load('EV_Modeling.mat');
sim_outputs = sim('EV_Modeling',simulation_time);

output_data = sim_outputs.yout(1);

% R_Out_Time_sec = output_data{1}.Values.Time;
% R_Out_Distance_km = output_data{1}.Values.Data;
% R_Out_Battery_SOC_perc = output_data{2}.Values.Data;
% R_Out_Motor_RPS = output_data{3}.Values.Data;
% R_Out_Motor_RPM = output_data{4}.Values.Data;
% R_Out_Current_Speed = output_data{5}.Values.Data;
% R_Out_Motor_Torque = output_data{7}.Values.Data;
% R_Out_SOC_Voltage = output_data{8}.Values.Data;
% R_Out_Electric_consumption_Current = output_data{9}.Values.Data;
% R_Out_Electric_Power = output_data{10}.Values.Data;


% R_Output_table = {Out_Time_sec,Out_Distance_km};

% 
% n = 1;
% for i = 1:length(R_Out_Time_sec)
%     if fix(R_Out_Time_sec(i)) - R_Out_Time_sec(i) == 0
%        Out_Time_sec(n,1) = R_Out_Time_sec(i);
%        Out_Battery_SOC_perc(n,1) = R_Out_Battery_SOC_perc(i);
%        Out_Current_Speed(n,1) = R_Out_Current_Speed(i);
%        Out_Distance_km(n,1) = R_Out_Distance_km(i);
%        Out_Electric_consumption_Current(n,1) = R_Out_Electric_consumption_Current(i);
%        Out_Electric_Power(n,1) = R_Out_Electric_Power(i);
%        Out_Motor_RPM(n,1) = R_Out_Motor_RPM(i);
%        Out_Motor_RPS(n,1) = R_Out_Motor_RPS(i);
%        Out_Motor_Torque(n,1) = R_Out_Motor_Torque(i);
%        Out_SOC_Voltage(n,1) = R_Out_SOC_Voltage(i);
% 
%          n = n + 1; 
%     end
% 
% end
% 
% 
% a = horzcat(Out_Time_sec,Out_Distance_km,Out_Battery_SOC_perc,Out_Motor_RPS,Out_Motor_RPM,Out_Current_Speed,Out_Motor_Torque,Out_SOC_Voltage,Out_Electric_consumption_Current,Out_Electric_Power);
% 
% Name = ["Time","Distance[km]","Battery SOC[%]","Motor RPS","Motor RPM","Speed[km/h]","Motor Torque","SOC Voltage[V]","Electric_consumption_current[A]","Electirc Power[W]"];
% 
% datasheet = vertcat(Name,a);
% 
% 
% writematrix(datasheet,'data.csv');
