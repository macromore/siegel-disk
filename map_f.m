function newP = map_f(P, a)
% P is input complex taylor list
% a is the parameter
% newP is the image of P under f
    if size(P,1) == 1 % P is scalar
        newP = P*P + a*P;
    else % P is vector
        prod = conv(P,P);
        newP = prod(1:length(P)) + a*P; 
    end % if
end % function