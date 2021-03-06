% The integrator sim_6DoF is used to simulate the system, i.e., calculate the states in the next time
% step given current state and control input. 
% sim_6DoF is generated by running ACADO_Int.m
function[rhist_RK,qhist_RK,whist_RK,vhist_RK,vhist_RK_body,tau_hist_body] = RunACADOIntegrator(x0,tau_hist,tau_hist_n,Mass,Is,roff)

    global noise_states
    n = 1/0.05;
    if noise_states == 0
        noise_rms = 0;
    else
        noise_rms = sqrt(n/2)*10^-5;
    end
    state_sim = x0;
    
    dim = size(tau_hist(:,1:end-1));
    tau_hist_body = zeros(dim);
    qhist_RK = zeros(4,dim(2));
    whist_RK = zeros(3,dim(2));
    vhist_RK = zeros(3,dim(2));
        
    qhist_RK(:,1) = x0(1:4);
    whist_RK(:,1) = x0(5:7);
    vhist_RK(:,1) = x0(11:13);
    rhist_RK(:,1) = x0(8:10);
    vhist_RK_body(:,1) = x0(11:13);
    
    

    input_sim.od = [getVec(inv(Is));getVec(Is);roff;Mass];% the simulator will use the inertial parameters specified at the beginning of the sim
    for i = 1:dim(2) 
        input_sim.x = [qhist_RK(:,i);whist_RK(:,i);state_sim(8:13,end)];  % latest state of simulation
        input_sim.u = [tau_hist(1:3,i);   tau_hist(4:6,i)]  ;     % first input from NMPC optimization
        % Apply input and evaluated forward dynamics over timestep dt
        output_sim = sim_6DoF(input_sim);
        state_sim = [state_sim output_sim.value];
        qhist_RK(:,i+1) = state_sim(1:4,end);
        whist_RK(:,i+1) = state_sim(5:7,end)+noise_rms*rand(3,1); % perturb velocities before the next time step
        vhist_RK(:,i+1) = state_sim(11:13,end)+noise_rms*rand(3,1);
        vhist_RK_body(:,i+1) = qrot([-qhist_RK(1:3,i+1);qhist_RK(4,i+1)],vhist_RK(:,i+1)); %velocity, body frame  
        
        %tau = torques and forces in body frame
        forces_body(:,1) = qrot([-qhist_RK(1:3,i);qhist_RK(4,i)],tau_hist_n(4:6,i));
        tau_hist_body(:,i) = [tau_hist_n(1:3,i);forces_body(1:3)];
        
    end
    rhist_RK = state_sim(8:10,:);
  
    function [vec] = getVec(M)
        vec = [M(1,1); M(2,2); M(3,3); M(1,2); M(1,3); M(2,3)]; 
    end
end