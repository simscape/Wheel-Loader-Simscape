function sm_wheel_loader_plot2vehpos(simlog_veh)
% Code to plot simulation results from sm_wheel_loader
%
% Copyright 2023-2024 The MathWorks, Inc.

%% Reuse figure if it exists, else create new figure
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
simlog_t    = simlog_veh.Wheel_Loader.Body_to_World.Px.p.series.time;
simlog_posx = simlog_veh.Wheel_Loader.Body_to_World.Px.p.series.values('m');
simlog_posy = simlog_veh.Wheel_Loader.Body_to_World.Py.p.series.values('m');

%% Plot results
plot(simlog_posx, simlog_posy,'LineWidth', 1,'DisplayName','Vehicle Position')
grid on
title('Vehicle Position')
ylabel('Speed (rev/s)')
%legend('Location','Best');

axis equal
