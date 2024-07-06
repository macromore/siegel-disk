include("mapf.jl")
include("rotatebya.jl")
function fcnPhi(P,a)
    return mapf(P,a) - rotatebya(P,a)
end