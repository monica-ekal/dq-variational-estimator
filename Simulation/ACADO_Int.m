%{ 
This script calls ACADO to generate MEX files of C++ NMPC and system
simulator code. Edit and run this with correct paths to the ACADO folder 
ONLY if the dynamics need to be modified.
%}

addpath(genpath('../../../../ACADOtoolkit'));  % set this to your ACADOtoolkit folder
clear all
acadoSet('results_to_file', false); 

%% ACADO declarations and setup
% Declare all differential states, controls, parameters
DifferentialState q(4) w(3) r(3) v(3)
OnlineData  Is_inv(6) Is(6) roff(3) Mass
Control u(6)  % [F_x F_y F_z T_x T_y T_z], force is in inertial frame; torque is in body frame
getMat = @(vec) [vec(1) vec(4) vec(5); vec(4) vec(2) vec(6); vec(5) vec(6) vec(3)];

Ts = 0.05;
Is = getMat(Is);
Is_inv = getMat(Is_inv);


%% Set up simulator
tau = u(1:3);
force = u(4:6);
dot_w = @(I_inv,I,w,roff,tau,force) I_inv*(tau - cross(w,I*w) - cross(roff,convToBody(q,force)) );

% dynamic equations for 6DoF RBD about CoM
f = [ dot(q);  dot(w);dot(r); dot(v)] == ...
    [ .5*[hat(q(1:3)) + q(4)*eye(3); -q(1:3)']*w; ...
      dot_w(Is_inv,Is,w,roff,tau,force);...
      v;               ...
      (force/Mass) - convToWorld(q,cross(w,cross(w,roff))+cross(dot_w(Is_inv,Is,w,roff,tau,force),roff))  ];   % accelerations
   
%% Export simulation code
acadoSet('problemname', 'my_sim');
sim = acado.SIMexport(Ts); % sampling time
sim.setModel(f);

sim.set( 'INTEGRATOR_TYPE',             'INT_IRK_GL4' );
sim.set( 'NUM_INTEGRATOR_STEPS',        10      );

sim.exportCode( 'SIM_export' );
cd 'SIM_export'
make_acado_integrator('sim_6DoF')  % place in subdirectory
cd '..'

%% Support functions
% quaternion conversion matrix: quaternion uses scalar last convention,
% w_IB expressed in body frame
  function [v_body] = convToBody(q,v)
        v_body = qmult([-q(1:3);q(4)],qmult([v;0],q));
        v_body = v_body(1:3);
    end

    function [v_world] = convToWorld(q,v)
        v_world = qmult(q,qmult([v;0],[-q(1:3);q(4)]));
        v_world = v_world(1:3);
    end