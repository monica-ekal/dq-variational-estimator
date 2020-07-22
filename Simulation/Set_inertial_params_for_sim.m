%{
Define mass parameters and initial points
%}


Mass = 10;
I = [2.08 -0.0478 0.073;-0.0478 3.19 -0.0655;0.073 -0.0655 4.16];  % Inertia about the origin of the body frame
off = [-0.08; 0.06; 0.15];

% Parameters for the integrator
I_s = I - Mass*((off'*off)*eye(3) - off*off'); % Inertia about the new centre of mass, after applying offset
r0 = [0;0;0];
v0 = [0.05;0.05;0.05];
q0 = [0;0;0;1];
w0 = [pi/8 pi/8 pi/8]';
x0 = [q0;w0;r0;v0];


realVals = [getJ(I);off;Mass]; %True values of params to be estimated
dt = 0.05;
end_time = 30;