%% Time steps and inputs
function[tau_hist,tau_hist_n] = Inputs(dt,end_time)
global noise
end_time_p = 5;
n = 1/0.05;
if noise == 0
    noise_rms = 0;
else
    noise_rms = sqrt(n/2)*10^-3;
end

% ----- Input torques ----- %
phase = [0.05 0.2 0.6 0 0.3 1].*pi;
tau_hist = [.01*cos(2*pi*(0:dt:end_time)/end_time_p + phase(1)); .03*cos(2*pi*(0:dt:end_time)/end_time_p+ phase(2)); .008*cos(2*pi*(0:dt:end_time)/end_time_p + phase(3)); .0052*cos(2*pi*(0:dt:end_time)/end_time_p + phase(4)); .021*cos(2*pi*(0:dt:end_time)/end_time_p + phase(5)); .0058*cos(2*pi*(0:dt:end_time)/end_time_p + phase(6))] ;
tau_hist_n = tau_hist + noise_rms*randn(size(tau_hist)); % adding noise on measured torques

end