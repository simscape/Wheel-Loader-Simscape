function ssc_hydromech_power_split_cvt_plot1whlspd(simlog_veh, tire_radius)
% Code to plot simulation results from ssc_hydromech_power_split_cvt

% Copyright 2023-2024 The MathWorks, Inc.

figString = ['h1_' mfilename];
% Only create a figure if no figure exists
figExist = 0;
fig_hExist = evalin('base',['exist(''' figString ''')']);
if (fig_hExist)
    figExist = evalin('base',['ishandle(' figString ') && strcmp(get(' figString ', ''type''), ''figure'')']);
end
if ~figExist
    fig_h = figure('Name',figString);
    assignin('base',figString,fig_h);
else
    fig_h = evalin('base',figString);
end
figure(fig_h)
clf(fig_h)

%% Get simulation results
simlog_t   = simlog_veh.Tire_FL.A.w.series.time;
simlog_vLF = simlog_veh.Tire_FL.A.w.series.values('rad/s')*tire_radius*3.6;
simlog_vRF = simlog_veh.Tire_FR.A.w.series.values('rad/s')*tire_radius*3.6;
simlog_vLR = simlog_veh.Tire_RL.A.w.series.values('rad/s')*tire_radius*3.6;
simlog_vRR = simlog_veh.Tire_RR.A.w.series.values('rad/s')*tire_radius*3.6;
simlog_vVeh = simlog_veh.Vehicle_Body.v.series.values('km/hr');

%% Plot results
tmpclr = colororder(gca);

plot(simlog_t, simlog_vVeh,'k-.','LineWidth', 1,'DisplayName','Chassis')
hold on
plot(simlog_t, simlog_vLF,'LineWidth', 1,'Color',tmpclr(1,:),'DisplayName','LF')
plot(simlog_t, simlog_vRF,'--','LineWidth', 1,'Color',tmpclr(2,:),'DisplayName','RF')
plot(simlog_t, simlog_vLR,'LineWidth', 1,'Color',tmpclr(3,:),'DisplayName','LR')
plot(simlog_t, simlog_vRR,'--','LineWidth', 1,'Color',tmpclr(4,:),'DisplayName','RR')
%hold off
grid on
title('Vehicle Wheel Speeds (km/h)')
ylabel('Speed (km/h)')
legend('Location','Best');
xlabel('Time (s)');

%% Remove temporary variables
