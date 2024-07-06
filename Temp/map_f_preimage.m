function [newP1, newP2] = map_f_preimage(z, a)
    dis = sqrt(a^2+4.*z);
    newP1 = (-a + dis)/2;
    newP2 = (-a - dis)/2;
end