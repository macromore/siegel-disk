%% Seigel Disc boundary approximation
% Clean up MatLab
clear, close all, hold on
%% Set up parameters
% Order of approximation
N = 2500;
% Scaling of preimage 
r = 1;
% Number of points to plot on each circle
numPoints = 1000;
% Paramerter
% a = exp(1i*(1+sqrt(5))*pi);
% a = exp(1i*(1+sqrt(5))/2*pi);
a = exp(1i*(1+sqrt(5))/2);
% Number of iterations
maxIter = 250;
% Maximum error or norm of last coeff for next iteration
tolerance = 1e-10;
% Minimum step size for h_1 expressed as 10^-maxPower
maxPower = 15;
% Maximum s in sobolev H^s norm
maxSobolev = 10;
%% Record results for posterity
diary siegel_disk_output.txt
fprintf('f map parameter               %.15f\n',a)
fprintf('Order of Taylor polynomials   %d\n', N)
fprintf('Radius of preimage            %d\n', r)
fprintf('Number of points plotted      %d\n', numPoints)
fprintf('Maximum defect                %g\n', tolerance)
fprintf('Minimum step size of h_1      %g\n', 10^(-maxPower))
fprintf('Maximum number of iterations  %d\n\n', maxIter)
%% Set up loop variables
% Storage vector for P
P = zeros(N+1,maxIter);
% Storage for output points
Pz = zeros(numPoints+1,maxIter);
% Limit number of iterations
iter = 0;
% Starting h_1 value
h_1 = 0.1;
% Record keeping
successes = [];
errorValues = [];
tailMagnitude = [];
h_1Values = [];
%% Set up output figure
figSuccesses = figure(1);
set(figSuccesses, 'Units', 'Normalized', 'OuterPosition', [.05 .4 .3 .5]);
title('Siegel Disks')
%% Main Computation Section
tic
for j = 2:maxPower % j will control the attempted step size
    fprintf('Step size %g.\n',(10^(-j)))
    while iter <= maxIter % Repeatedly try larger h_1 values
        iter = iter + 1;
        h_1 = h_1 + (10^(-j)); % Enlarge h_1
        fprintf('h_1 value = %.15f\n', h_1)
        % Compute coeffients
        P(1,iter) = 0;
        P(2,iter) = h_1;
        for k = 2:N
            P(k+1,iter) = compute_coeff(k, P(:,iter), a);
        end % for loop
        % Look at the last coeff magnitude
        mag = abs(P(end,iter));
        % Compute the norm of the image under the operator phi
        normF = norm(fcnPhi(P(:,iter), a),2);
        if normF > tolerance || mag > tolerance % Backtrack on failure
            fprintf('Attempt %d failed. \n\n', iter)
            % Zero out failed attempt
            P(:,iter) = zeros(N+1,1);
            Pz(:,iter) = zeros(numPoints+1, 1);
            % Reset P1 to previous value
            h_1 = h_1 - (10^(-j));
            break % Exit the while loop and decreas step size
        else % Report success and plot
            % Compute the image of concentric circles under P
            for m = 1:numPoints+1
                Pz(m,iter) = ...
                    evaluate_taylor(P(:,iter),(r)*exp(2*pi*1i*m/numPoints));
            end % for loop
            fprintf('Attempt %d successful. \n',iter)
            successes(length(successes)+1) = iter; %#ok<SAGROW>
            h_1Values(length(successes)) = h_1; %#ok<SAGROW>
            fprintf('    Norm of last coefficient: %1.2g\n', mag)
            tailMagnitude(length(successes)) = mag; %#ok<SAGROW>
            fprintf('    Norm of defect:           %1.2g\n', normF)
            errorValues(length(successes)) = normF; %#ok<SAGROW>
            plot(Pz(:,iter));
            figure(1)
        end % if
    end % while loop
end % for loop
toc
%% Report end of computation information. 
figError = figure(2);
set(figError, 'Units', 'Normalized', 'OuterPosition', [.4 .2 .5 .7]);
subplot(2,2,1); 
semilogy(h_1Values, tailMagnitude);
title('Log Tail magnitudes');
xlabel('h_1 value')
subplot(2,2,2); 
semilogy(h_1Values, errorValues);
title('Log Conjugacy Error');
xlabel('h_1 value')
subplot(2,2,3);
plot(log(abs(P(:,successes(end)))));
title('Log Norm of Last Disk Coefficients');
subplot(2,2,4);
sobolevNorms = zeros(length(successes),maxSobolev);
for k = 1:length(successes)
    for s = 1:maxSobolev
        sobolevNorms(k, s) = sobolevNorm(P(:,successes(k)),s);
    end % for loop
end % for loop
mesh(1:size(sobolevNorms,2),1:size(sobolevNorms,1),sobolevNorms);
title('Sobolev Norm of Successes H^s');
xlabel('Sobolev Parameter s')
ylabel('Success number')
fprintf('Number of successes = %d\n', length(successes))
fprintf('Final h_1 value = %.15f\n', h_1)
% Comment to not overwrite the figures in the paper.
saveas(figSuccesses, 'siegel_disk.png')
saveas(figError, 'siegel_disk_defect.png')
diary off