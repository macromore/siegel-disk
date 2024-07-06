function rotatebya(P,a)
    newP = zeros(ComplexF64,length(P),1)
    for j in eachindex(P)
        newP[j] = P[j]*a^(j-1)
    end
    return newP
end