using Plots
include("coefficient.jl")
include("evaluateTaylor.jl")
include("fcnPhi.jl")
# Order of ApproximationO
N = 10000
# Scaling of preimge
r = 1
# Number of concentric circles
K = 1
# Number of plots to point in each circle
numPoints = 2000
# Parameter
a = exp(im*(1+sqrt(5))/2)
# P1 value
P1 = 0.3
println("P1 value = ", P1)
# Storage vector for coeffients
P = zeros(ComplexF64,N+1,1)
# Storage for output points 
Pz = zeros(ComplexF64,numPoints,1)
P[1] = 0;
P[2] = P1;
for k in 2:N
    P[k+1] = coeffient(k,P,a) 
end
# Look at the last coeff magnitude
mag = abs(P[end])
println("Norm of last coeffient: ", mag)


for k in 1:K
    for n in 1:numPoints
        Pz[n] = evaluateTaylor(P,(r)*exp(2*pi*im*n/numPoints))
    end
    display(plot(real(Pz),imag(Pz)))
end

defect = sqrt(sum(broadcast(abs,fcnPhi(P,a)).^2))

println("Defect: ", defect)