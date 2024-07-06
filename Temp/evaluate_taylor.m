function Pz = evaluate_taylor(P,z)
% Evaluate the Taylor polynomial P at Z
    Pz= 0;
    for j = 1:length(P)
       Pz = Pz + P(j)*z^(j-1); 
    end % for loop
end % function