function [liftActBucket, tiltActBucket, inertiaLoadBucket] = sm_wheel_loader_act_input_bucket(grapple_lift)
% Parameterized function to define actuator commands for bucket

% Copyright 2023-2024 The MathWorks, Inc.

bucket_tilt_prof = [...
    0.0         0
    9.0    0.0000
   10.0    0.0894
   12.0    0.0894
   13.0    0.0459
   15.0   -0.1350
   20.0   -0.1350
   25.1    0.0162
   31.0    0.0894
   44.0    0.0894
   45.0    0.1110
   47.0    0.0894
   58.0   -0.1418
   61.0   -0.1418
   64.0    0.1504
   67.0    0.0900
   70.0    0.0900    
    ].*[1 1000];

inertiaLoadBucket_time = [0 15.8 17.0 54.0 57.5 70];
inertiaLoadBucket_load = [0 0     1    1    0   0]*0.5;

bucket_lift_prof = squeeze(grapple_lift.Data);
neg_inds         = find(bucket_lift_prof<0);
bucket_lift_prof(neg_inds) = bucket_lift_prof(neg_inds)*-186.172/min(squeeze(grapple_lift.Data));
bucket_lift_prof_time = grapple_lift.Time;

liftActBucket.pos = timeseries(bucket_lift_prof,bucket_lift_prof_time);
tiltActBucket.pos = timeseries(bucket_tilt_prof(:,2),bucket_tilt_prof(:,1));
inertiaLoadBucket.load = timeseries(inertiaLoadBucket_load,inertiaLoadBucket_time);