function defect = fcnPhi(P,a)
% The objective function, we expect to find a zero.
    defect = map_f(P,a) - rotate_by_a(P,a);
end % function