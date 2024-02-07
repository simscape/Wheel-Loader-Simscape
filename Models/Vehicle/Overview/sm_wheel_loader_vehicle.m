%% Wheel Loader Chassis, Drivetrain, and Linkage
% 
% <<sm_wheel_loader_vehicle_Overview.png>>
%
% (<matlab:web('Wheel_Loader_Design_Overview.html') return to Wheel Loader Design with Simscape Overview>)
% 
% This example models a wheel loader drivetrain and chassis.
%
% Copyright 2023-2024 The MathWorks, Inc.

%% Model
%
% This example models a wheel loader drivetrain and chassis.
%
% <matlab:open_system('sm_wheel_loader_vehicle'); Open Model>

open_system('sm_wheel_loader_vehicle')

set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints')
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_surface','Plane (Spheres)');

set_param(find_system('sm_wheel_loader_vehicle','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Vehicle Subsystem
%
% Vehicle model with articulated chassis, driveline, and linkage.
%
% <matlab:open_system('sm_wheel_loader_vehicle');open_system('sm_wheel_loader_vehicle/Wheel%20Loader/Vehicle','force'); Open Subsystem>

set_param('sm_wheel_loader_vehicle/Wheel Loader/Vehicle','LinkStatus','none')
open_system('sm_wheel_loader_vehicle/Wheel Loader/Vehicle','force')

%% Simulation Results: Load Cycle, 1D Driveline
%%
%
% Run load cycle test with 1D driveline and bucket. 
%

set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints')
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_surface','Plane (Spheres)');

sim('sm_wheel_loader_vehicle');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader_vehicle,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader_vehicle)
sm_wheel_loader_plot4linkage(logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader_vehicle.Wheel_Loader,logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)

%% Simulation Results: Load Cycle, 1D Driveline, Multibody Magic Formula Tire
%%
%
% Run load cycle test with 1D driveline and bucket. 
%

set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints')
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_surface','Plane (Tires)');

sim('sm_wheel_loader_vehicle');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader_vehicle,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader_vehicle)
sm_wheel_loader_plot4linkage(logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader_vehicle.Wheel_Loader,logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)

%% Simulation Results: Load Cycle, 3D Driveline, CV Joints
%%
%
% Run load cycle test with 1D driveline and bucket. 
%

set_param([bdroot '/Wheel Loader'],'popup_driveline','3D, CV Joints')
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_surface','Plane (Spheres)');
sim('sm_wheel_loader_vehicle');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader_vehicle,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader_vehicle)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader_vehicle.Wheel_Loader,logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)

%% Simulation Results: Load Cycle, 3D Driveline, U-Joints
%%
%
% Run load cycle test with 1D driveline and bucket. 
%

set_param([bdroot '/Wheel Loader'],'popup_driveline','3D, U Joints')
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_surface','Plane (Spheres)');
sim('sm_wheel_loader_vehicle');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader_vehicle,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader_vehicle)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader_vehicle.Wheel_Loader,logsout_sm_wheel_loader_vehicle.get('mVehicle').Values)

%%

close all
bdclose('sm_wheel_loader_vehicle');
