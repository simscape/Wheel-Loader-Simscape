function sm_wheel_loader_config_impl(mdl,impl)
% Function to set block dropdown menus according to desired configuration
%
%   mdl   Model name
%   impl  Name of implement configuration

% Copyright 2023-2024 The MathWorks, Inc.


blkpth_veh = [mdl '/Wheel Loader'];
blkpth_inp = [mdl '/Actuator Inputs'];

switch(lower(impl))
    case 'bucket'
        set_param(blkpth_inp,'popup_impl','Bucket');
        set_param(blkpth_veh,'popup_impl','Bucket');
    case 'bucket load'
        set_param(blkpth_inp,'popup_impl','Bucket');
        set_param(blkpth_veh,'popup_impl','Bucket Load');
    case 'grapple none'
        set_param(blkpth_inp,'popup_impl','Grapple');
        set_param(blkpth_veh,'popup_impl','Grapple');
    case 'grapple log'
        set_param(blkpth_inp,'popup_impl','Grapple');
        set_param(blkpth_veh,'popup_impl','Grapple Log');
end
        