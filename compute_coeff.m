function P_k = compute_coeff(k, P, a)
% A basic implementation of equation (6), the recursive definition of
% Fourier coefficents.
    P_k = 0;
    for j = 1:k-1
        P_k = P_k + P(k-j+1)*P(j+1);
    end % for loop
    P_k = P_k * conj(a) / (a^(k-1) - 1);
end % function