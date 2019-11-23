include("../zad1/bisection.jl")
include("../zad2/newton.jl")
include("../zad3/sieczne.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych
using .Sieczne:msiecznych

f1(x) = MathConstants.e^(1-x) - 1
f2(x) = x*MathConstants.e^(-x)

