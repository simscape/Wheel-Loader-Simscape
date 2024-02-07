%% Wheel Loader Linkage
% 
% <<sm_wheel_loader_linkage_Overview.png>>
%
% (<matlab:web('Wheel_Loader_Design_Overview.html') return to Wheel Loader Design with Simscape Overview>)
% 
% This example models a wheel loader linkage with two interchangeable
% implements, a bucket and a grapple.
%
%
% Copyright 2023-2024 The MathWorks, Inc.

%% Model
%
% This example models a wheel loader linkage.
%
% <matlab:open_system('sm_wheel_loader_linkage'); Open Model>

open_system('sm_wheel_loader_linkage')

set_param(find_system('sm_wheel_loader_linkage','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Linkage Subsystem
%
% The wheel loader linkage has a lift and tilt actuator.  The implement can
% be configured to be a bucket or a grapple.
%
% <matlab:open_system('sm_wheel_loader_linkage/Linkage');open_system('sm_wheel_loader_linkage/Linkage','force'); Open Subsystem>

set_param('sm_wheel_loader_linkage/Linkage','LinkStatus','none')
open_system('sm_wheel_loader_linkage/Linkage','force')

%% Simulation Results: Bucket Implement
%%
%
% Run test with bucket. The load added to the bucket is a variable mass
% whose mass and size changes based on an input signal.
%

set_param([bdroot '/Actuator Inputs'],'popup_impl','Bucket')
set_param([bdroot '/Linkage'],'popup_impl','Bucket')
set_param([bdroot '/Load'],'LabelModeActiveChoice','Inertia')

sim('sm_wheel_loader_linkage');
sm_wheel_loader_plot4linkage(logsout_sm_wheel_loader_linkage.get('mVehicle').Values)

%% Simulation Results: Grapple Implement
%%
%
% Run test with grapple. The load is a log that is resting on a base.
% Contact forces are modeled between the log and the base, grapple, and
% bin.
%

set_param([bdroot '/Actuator Inputs'],'popup_impl','Grapple')
set_param([bdroot '/Linkage'],'popup_impl','Grapple')
set_param([bdroot '/Load'],'LabelModeActiveChoice','Log')

sim('sm_wheel_loader_linkage');
sm_wheel_loader_plot4linkage(logsout_sm_wheel_loader_linkage.get('mVehicle').Values)

%%

close all
bdclose('sm_wheel_loader_linkage');
