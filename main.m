clc
close all
clear all
addpath('Dual Quaternion Library')
addpath('DQVI specific functions')
addpath('Estimator functions')
addpath('SIM_export')
addpath('Quaternion Library')
addpath('Misc. functions and plotting')
addpath('Simulation')


%% Initilaization
%Simulation with and without noise on the measured torques
global noise;
noise = 1;
global noise_states ;
noise_states = 1;

% Set the true values of inertial parameters to be estimated
Set_inertial_params_for_sim;
[tau_hist,tau_hist_n] = Inputs(dt, end_time);

%% Simulation
% IRK-GL4 fast integrators are used to simulate the physical system
% Quirynen, R., et al., Fast auto generated ACADO integrators and
% application to MHE with multi-rate measurements, IEEE European Control
% Conference (ECC) (pp. 3077-3082), July 2013

[rhist_RK,qhist_RK,whist_RK,vhist_RK,vhist_body_RK,tau_hist_body_RK]= RunACADOIntegrator(x0,tau_hist,tau_hist_n,Mass,I_s,off);
    
%% Estimated using the variational integrator approach
% Run estimator
[est_all_VI]= estimatorVI(rhist_RK,qhist_RK,tau_hist_body_RK,dt);
% Calculate the values of the estimates
err_est_all_VI = calc_errors(est_all_VI, realVals);

%% Estimated using Finite differences
% Run estimator
[est_all_FD] = estimatorFD(rhist_RK,qhist_RK,vhist_RK, whist_RK,tau_hist_body_RK,dt);
% Calculate the values of the estimates
err_est_all_FD = calc_errors(est_all_FD, realVals);

 %  draw_figs;
plotColorMap(err_est_all_VI, err_est_all_FD,dt,end_time)
% Accuracy using VI as a multiple of accuracy using FD
err_est_all_FD(:,end)./err_est_all_VI(:,end)