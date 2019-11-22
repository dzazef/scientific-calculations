include("../zad1/bisection.jl")
include("../zad2/newton.jl")
include("../zad3/sieczne.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych
using .Sieczne:msiecznych

f(x) = sin(x) - (0.5*x)^2
pf(x) = cos(x) - 0.5*x


mbisekcji(f, 1.5, 2.0, 0.5*1e-5, 0.5*1e-5)
mstycznych(f, pf, 1.5, 0.5*1e-5, 0.5*1e-5, 1000)
msiecznych(f, 1.0, 2.0, 0.5*1e-5, 0.5*1e-5, 1000)