%connector on 12345;

clear m;

% create the mobile object

m = mobiledev;

% Enable the accelerometer

m.AccelerationSensorEnabled = 1;
m.OrientationSensorEnabled = 1;
m.AngularVelocitySensorEnabled= 1;


%m.SampleRate='medium';
% Start to capture data for pause(x) seconds

m.Logging = 1;

pause(18);

% Stop capturing 

m.Logging = 0;

% Store the acquired data to a matrix

[ac, tac] = accellog(m);
[or, tor] = orientlog(m);
[an, tan] = angvellog(m);


sample_acl= [tac , ac];
sample_ori= [tor , or];
sample_ang= [tan , an];


% Plot the acquired data
hold on;
plot(tac, ac);
plot(tor, or);
plot(tan, an);

save sample_acl sample_acl;
save sample_ori sample_ori;
save sample_ang sample_ang;



