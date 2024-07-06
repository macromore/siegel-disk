function sobolevNorm = sobolevNorm(P, s)
% Takes a Taylor series and returns the sobolev norm 
% H^s from Rafael de la Llave p 28
if nargin == 1
    s = 1;
end % if
sobolevNorm = 0;
for k = 1:length(P)
    sobolevNorm = sobolevNorm + (1+abs(k-1)^2)^s*abs(P(k))^2;
end % for
sobolevNorm = sqrt(sobolevNorm);
end % function

