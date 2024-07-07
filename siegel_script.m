% Seigel Disk approximation
% Clean up MatLab
clear, close all, hold on
tic
% Order of approximation
N = 2500;
% Scaling of preimage
r = 1;
% Number of concentric circles
K = 1;
% Number of points to plot on each circle
numPoints = 2000;
% Paramerter
a = exp(1i*(1+sqrt(5))/2);
%P1 value%exp(1i*sqrt(2)*pi);
% P1 value
P1 = .3033;
fprintf('P1 value = %f\n', P1)
% Storage vector for P
P = zeros(N+1,1);
% Storage for output points
Pz = zeros(numPoints,1);
% Compute coeffients
P(1) = 0;
P(2) = P1;
for n = 2:N
    P(n+1) = compute_coeff(n, P, a);
end
% Look at the last coeff magnitude
mag = abs(P(end));
fprintf('Norm of last coefficient: %d\n', mag)
% Graph the image of concentric circles
for k = 1:K
   for n = 1:numPoints
       Pz(n) = evaluate_taylor(P,(r)*exp(2*pi*1i*n/numPoints));
   end
   plot(Pz)
end
% Compute the norm of the image under the operator
normF = norm(fcnPhi(P, a),2);
fprintf('Norm of defect: %d\n', normF)
toc