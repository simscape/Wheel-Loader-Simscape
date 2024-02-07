%% Wheel Loader with Hydromechanical Power Split Transmission
% 
% <<sm_wheel_loader_Overview.png>>
%
% (<matlab:web('Wheel_Loader_Design_Overview.html') return to Wheel Loader Design with Simscape Overview>)
% 
% This example models a wheel loader with a power-split hydromechanical
% continuously variable transmission (CVT). The engine, CVT, driveline,
% chassis, and linkage system are all modeled using Simscape.  The control
% systems are modeled in Simulink.  A bucket or a grapple can be attached
% to the linkage.
%
% Copyright 2023-2024 The MathWorks, Inc.

%% Model
%
% This example models a wheel loader with a power-split hydromechanical
% continuously variable transmission (CVT).
%
% <matlab:open_system('sm_wheel_loader'); Open Model>

open_system('sm_wheel_loader')
set_param(bdroot,'LibraryLinkDisplay','none')
ann_h = find_system('sm_wheel_loader','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for anhi=1:length(ann_h)
    set_param(ann_h(anhi),'Interpreter','off');
end

set_param([bdroot '/Wheel Loader'],'popup_engine','Droop');
set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints');
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_cvt','Power Split Hydromechanical')

%% Wheel Loader Subsystem
%
% The wheel loader is powered by an engine.  The continuously variable
% transmission varies its ratio to drive the vehicle at the desired speed.
% The vehicle includes the driveline, articulated chassis, and linkage
% which operates the implements.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader','force'); Open Subsystem>

set_param('sm_wheel_loader/Wheel Loader','LinkStatus','none')
open_system('sm_wheel_loader/Wheel Loader','force')
%set_param(find_system('sm_wheel_loader/Wheel Loader','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Transmission Variant Subsystems
%
% Three options for modeling the CVT are included in the model.  Using
% variant subsystems, one of them can be activated for a test.  The
% subsystems all have the same interface, which includes a mechanical
% connection to the engine and a mechanical connection to the driveline.
% Intefaces based on physical connections are particularly well-suited to
% swapping between models of different technologies or fidelity.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Transmission','force'); Open Subsystem>

set_param('sm_wheel_loader/Wheel Loader/Transmission','LinkStatus','none')
open_system('sm_wheel_loader/Wheel Loader/Transmission','force')

%% Abstract CVT Subsystem
%
% Models a CVT as a variable ratio gear. This model can be used in early
% stages of development to refine requirements for the transmission.  It
% can also be tuned to match a more detailed model of the CVT so as to
% provide accurate behavior with less computation.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Transmission/Abstract','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_cvt','Abstract')
set_param([bdroot '/Wheel Loader/Transmission/Abstract'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Transmission/Abstract'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Hydrostatic Transmission Subsystem
%
% Hydrostatic transmission with variable-displacement pump and
% fixed-displacement motor.  This system alone can also serve as a CVT, but
% it is not as efficient as the power-split design, as the mechanical path
% has a higher efficiency.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Transmission/Hydrostatic','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_cvt','Hydrostatic')
set_param([bdroot '/Wheel Loader/Transmission/Hydrostatic'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Transmission/Hydrostatic'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Power Split Hydromechanical CVT Subsystem
%
% Transmission with four planetary gears, clutches, and a parallel power
% path through a hydrostatic transmission. A hydraulic regenerative braking
% system is also included to improve fuel economy by storing kinetic energy
% as pressure in an accumulator.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Transmission/Power%20Split%20Hydromech','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_cvt','Power Split Hydromechanical')
set_param([bdroot '/Wheel Loader/Transmission/Power Split Hydromech'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Transmission/Power Split Hydromech'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Vehicle Subsystem
%
% Model of the wheel loader vehicle, including front and rear articulated
% chassis, driveline, and linkage.  An optional load can be added using
% variant subsystems.  The power required to actuate the linkages is drawn
% from the engine PTO shaft.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Vehicle','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader/Vehicle'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Vehicle'],'force')

%% Driveline 3D Subsystem
%
% Models a four-wheel drive driveline using parts imported from a CAD
% assembly.  The output of the CVT connects to the output transfer gear
% which is connected via differentials to all four wheels.  A separate
% variant models the driveline as a 1D mechanical model that can be used
% for exploring the design space of shaft sizes and gear ratios.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Vehicle/Driveline/Driveline/Driveline%203D','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_driveline','3D, U Joints')
set_param([bdroot '/Wheel Loader/Vehicle/Driveline/Driveline/Driveline 3D'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Vehicle/Driveline/Driveline/Driveline 3D'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Driveline 1D Subsystem
%
% Models a four-wheel drive driveline using parts imported from a CAD
% assembly.  The output of the CVT connects to the output transfer gear
% which is connected via differentials to all four wheels.  A separate
% variant models the driveline as a 1D mechanical model that can be used
% for exploring the design space of shaft sizes and gear ratios.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Vehicle/Driveline/Driveline/Driveline%201D','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints')
set_param([bdroot '/Wheel Loader/Vehicle/Driveline/Driveline/Driveline 1D/Driveline'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Vehicle/Driveline/Driveline/Driveline 1D/Driveline'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Linkage Subsystem
%
% Models the linkage subsystem for actuating the implement.  Lift and tilt
% actuators actuate the linkage to raise and lower the implement.  The
% implement can be configured to a bucket or a grapple using variant
% subsystems.
%
% <matlab:open_system('sm_wheel_loader');open_system('sm_wheel_loader/Wheel%20Loader/Vehicle/Linkage','force'); Open Subsystem>

set_param([bdroot '/Wheel Loader'],'popup_driveline','3D, U Joints')
set_param([bdroot '/Wheel Loader/Vehicle/Linkage'],'LinkStatus','none')
open_system([bdroot '/Wheel Loader/Vehicle/Linkage'],'force')
set_param(bdroot,'SimulationCommand','update')

%% Simulation Results: Y Loading Cycle with Droop Control, Power-Split CVT, 1D Driveline, Bucket
%%
%
% The results below come from a simulation test where the wheel loader
% completes a standard Y-cycle.
%

set_param([bdroot '/Wheel Loader'],'popup_engine','Droop');
set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints');
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_cvt','Power Split Hydromechanical')

sim('sm_wheel_loader');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader)
sm_wheel_loader_plot3clutches(simlog_sm_wheel_loader.Wheel_Loader.Transmission)
sm_wheel_loader_plot4linkage(logsout_sm_wheel_loader.get('mVehicle').Values)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader.Wheel_Loader,logsout_sm_wheel_loader.get('mVehicle').Values)

% Get engine torque data
trqCVT = simlog_sm_wheel_loader.Wheel_Loader.Engine.Engine_Droop.Torque_Sensor.Torque_Sensor.t.series.values('N*m');
timCVT = simlog_sm_wheel_loader.Wheel_Loader.Engine.Engine_Droop.Torque_Sensor.Torque_Sensor.t.series.time;

%% Simulation Results: Y Loading Cycle with Droop Control, Abstract CVT, 1D Driveline, Bucket
%%
%
% The results below come from a simulation test where the wheel loader
% completes a standard Y-cycle.
%

set_param([bdroot '/Wheel Loader'],'popup_engine','Droop');
set_param([bdroot '/Wheel Loader'],'popup_driveline','1D, CV Joints');
sm_wheel_loader_config_impl(bdroot,'Bucket')
set_param([bdroot '/Wheel Loader'],'popup_cvt','Abstract')

sim('sm_wheel_loader');

sm_wheel_loader_plot1whlspd(simlog_sm_wheel_loader,HMPST.Tire.Rad)
sm_wheel_loader_plot2vehpos(simlog_sm_wheel_loader)
sm_wheel_loader_plot5steer(simlog_sm_wheel_loader.Wheel_Loader,logsout_sm_wheel_loader.get('mVehicle').Values)

% Get engine torque data
trqAbs = simlog_sm_wheel_loader.Wheel_Loader.Engine.Engine_Droop.Torque_Sensor.Torque_Sensor.t.series.values('N*m');
timAbs = simlog_sm_wheel_loader.Wheel_Loader.Engine.Engine_Droop.Torque_Sensor.Torque_Sensor.t.series.time;

%% Comparison of CVT Models
%
% The following plot compares the input torque for tests with the power
% split CVT and the abstract CVT models.

figure(44)
plot(timAbs,trqAbs,'LineWidth',1,'DisplayName','Abstract');
hold on
plot(timCVT,trqCVT,'LineWidth',1,'DisplayName','Power Split');
hold off
ylabel('CVT Input Torque (N*m)')
xlabel('Time (s)');
legend('Location','Best')
yRange = abs(max(trqAbs)-min(trqAbs));
set(gca,'YLim',[min(trqAbs)-0.1*yRange max(trqAbs)+0.1*yRange])
title('Comparison of CVT Models')

%%

close all
bdclose('sm_wheel_loader');
