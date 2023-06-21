function newP = rotate_by_a(P, a)
% Rotate a taylor series P by a
    newP = zeros(length(P),1);
    for j = 1:length(P)
       newP(j) = P(j)*a^(j-1); 
    end % for loop
end % function