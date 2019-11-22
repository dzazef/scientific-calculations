include("../zad1/bisection.jl")
include("../zad2/newton.jl")
include("../zad3/sieczne.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych
using .Sieczne:msiecznych

f(x) = 3*x
g(x) = MathConstants.e^x
h(x) = f(x) - g(x)

mbisekcji(h, 0.5, 1.0, 1e-4, 1e-4)
mbisekcji(h, 1.5, 2.0, 1e-4, 1e-4)