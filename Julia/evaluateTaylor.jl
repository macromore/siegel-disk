function evaluateTaylor(P,z)
    Pz = ComplexF64(0.0)
    for j in eachindex(P)
        Pz += P[j]*z^(j-1)
    end
    return Pz
end