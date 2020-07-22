function [err_est_all] = calc_errors(est_all, realVals)
 %{
    Calculate relative estimation error between estimates and real values.
    The Frobenius norm is used for errors within the inertia tensor
  %}
    % Final values of the estimates
%     est = est_all(:,end);
%     I = [est(1) est(4) est(5);
%              est(4) est(2) est(6)
%              est(5) est(6) est(3)];
%     offset = est(7:9);
%     mass = est(10);
%     I_s = I - mass*((offset'*offset)*eye(3) - offset*offset');

    err_est_all = zeros(3,size(est_all,2));
    for i = 1:size(est_all,2)
        err_est_all(:,i) = [norm(getI(est_all(1:6,i))-getI(realVals(1:6)),'fro')/norm(getI(realVals(1:6)),'fro'); norm(est_all(7:9,i)-realVals(7:9))/norm(realVals(7:9));abs(est_all(10,i)-realVals(10))/realVals(10)];
    end
    
end