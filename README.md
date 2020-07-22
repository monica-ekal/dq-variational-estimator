#dq-variational-param-est

A variational approach based on dual quaternions for inertial parameter estimation of a rigid body.  

This is an example implementation of the estimation approach presented in the paper "A Dual Quaternion-Based Discrete Variational Approach for Accurate
and Online Inertial Parameter Estimation in Free-Flying robots", M. Ekal and R. Ventura, ICRA 2020.

##To run
The fie that launches everything is `main.m`.

Simulation of the 6DoF rigid body is done using fast integrators exported via the ACADO toolkit. To install ACADO, follow the instructions [here](https://acado.github.io/matlab_overview.html). ACADO needs to be added to path, which can be done in `Simulation/ACADO_Int.m`. Running `ACADO_Int.m` should generate the directory SIM_export/.

