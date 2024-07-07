## Dependencies
using Plots, Quadmath, DSP
include("coefficient.jl")
include("evaluateTaylor.jl")
include("fcnPhi.jl")
## Set up parameters
# Order of Approximation
N = 2_500
# Scaling of preimage
r = 1
# Number of points to plot
numPoints = 1_000
# Rotation parameters
a = exp(im*(1+sqrt(5))/2)
# Number of iterations
maxIter = 250
# Max Error or Tail Size
tolerance = 1e-10
# Minimum ste size for h_1 as 10^-maxPower
maxPower = 15
# Maximum s in sobolev H^s Norm
maxSobolev = 10
## Set up output file
# Todo
## Set up loop variables
# Storage vector for coeffients
P = zeros(ComplexF64,N+1,maxIter)
# Storage for output points 
Pz = zeros(ComplexF64,numPoints+1,1)
# Iteration counter
let i = 0
# Starting h_1 value
h_1 = 0.1
## Record Keeping
# Todo
## Main computation
@time begin
for j in range(2,maxPower)
    println("Step size: ", 10.0^-j)
    while i <= maxIter
        i += 1
        h_1 += 10.0^-j
        println("h_1 value: ", h_1)
        P[1,i] = 0
        P[2,i] = h_1
        for k in range(2,N)
            P[k+1,i] = coeffient(k,P[:,i],a)
        end
        mag = abs(P[end,i])
        normF = sqrt(sum(broadcast(abs,fcnPhi(P[:,i],a)).^2))
        if normF > tolerance || mag > tolerance
            println("Attempt ", i, " failed.")
            P[:,i] = zeros(ComplexF64,N+1,1)
            h_1 -= 10.0^-j
            break
        else
            for n in range(1,numPoints+1)
                Pz[n] = evaluateTaylor(P[:,i],(r)*exp(2*pi*im*n/numPoints))
            end
            println("Attempt ", i, " successful.")
            println("    Norm of last coeffieint: ", mag)
            println("    Norm of defect: ", normF)
            display(plot!(real(Pz[:]),imag(Pz[:]),legend=false,title="Siegel Disk Boundary Approximation"))
        end
    end
end
end
end