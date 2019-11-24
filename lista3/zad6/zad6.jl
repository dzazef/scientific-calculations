include("../zad1/bisection.jl")
include("../zad2/newton.jl")
include("../zad3/sieczne.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych
using .Sieczne:msiecznych

f1(x) = MathConstants.e^(1-x) - 1
f2(x) = x*MathConstants.e^(-x)

pf1(x) = -(MathConstants.e^(1-x))
pf2(x) = -((MathConstants.e^(-x))*(x-1))

d = 1e-5

mbisekcji(f1, 0.5, 1.5, d, d)
mstycznych(f1, pf1, 1.0, d, d, 1000)
msiecznych(f1, 0.5, 1.5, d, d, 1000)

mbisekcji(f2, -0.5, 0.5, d, d)
mstycznych(f2, pf2, 0.0, d, d, 1000)
msiecznych(f2, -0.5, 0.5, d, d, 1000)

mstycznych(f1, pf1, 1000.0, d, d, 1000)
mstycznych(f2, pf2, 1000.0, d, d, 1000)
mstycznych(f2, pf2, 1.0, d, d, 1000)