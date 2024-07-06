using DSP
function mapf(P,a)
    if length(P) == 1
        newP = P*P + a*P
    else
        prod = conv(P,P)
        newP = prod[1:length(P)] + a*P
    end
    return newP
end