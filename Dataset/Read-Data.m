%connector on 12345;

clear m;

% create the mobile object

m = mobiledev;

% Enable the accelerometer

m.AccelerationSensorEnabled = 1;
m.OrientationSensorEnabled = 1;

%m.SampleRate='medium';
% Start to capture data for pause(x) seconds

m.Logging = 1;

pause(10);

% Stop capturing 

m.Logging = 0;

% Store the acquired data to a matrix

[a, ta] = accellog(m);
[o, to] = orientlog(m);
nsample_acl_1= [ta , a];
nsample_gyr_1= [to , o];

% Plot the acquired data

plot(ta, a);
hold on;
plot(to, o);

%plot(acl_P);
%legend('X', 'Y', 'Z');
%xlabel('Relative time (s)');
%ylabel('Acceleration (m/s^2)');

save nsampleacl_a2200 nsample_acl_1;
save nsamplegyr_a2200 nsample_gyr_1;
