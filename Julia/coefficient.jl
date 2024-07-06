function coeffient(k,P,a)
    Pk = 0
    for j in 1:k-1
        Pk += P[k-j+1]*P[j+1]
    end
    Pk *= conj(a)/(a^(k-1)-1)
    return Pk
end