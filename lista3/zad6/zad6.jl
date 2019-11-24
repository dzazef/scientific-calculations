# Lista 3: zadanie 6
# autor: Józef Piechaczek
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
mbisekcji(f1, -2.0, 3.0, d, d)
mbisekcji(f1, -20.0, 10.0, d, d)
mbisekcji(f1, -2000.0, 3000.0, d, d)

mbisekcji(f2, -0.5, 0.5, d, d)
mbisekcji(f2, -2.0, 3.0, d, d)
mbisekcji(f2, -20.0, 15.0, d, d)
mbisekcji(f2, -2000.0, 3000.0, d, d)



mstycznych(f1, pf1, 1.0, d, d, 100000)
mstycznych(f1, pf1, 5.0, d, d, 100000)
mstycznych(f1, pf1, 6.0, d, d, 100000)
mstycznych(f1, pf1, 7.5, d, d, 100000)
mstycznych(f1, pf1, 10.0, d, d, 100000)
mstycznych(f1, pf1, 100.0, d, d, 100000)
mstycznych(f1, pf1, 1000.0, d, d, 100000)

mstycznych(f2, pf2, 0.0, d, d, 100000)
mstycznych(f2, pf2, 0.5, d, d, 100000)
mstycznych(f2, pf2, 1.0, d, d, 100000)
mstycznych(f2, pf2, 1.01, d, d, 100000)
mstycznych(f2, pf2, 10.0, d, d, 100000)
mstycznych(f2, pf2, 100.0, d, d, 100000)
mstycznych(f2, pf2, 1000.0, d, d, 100000)



msiecznych(f1, 0.5, 1.5, d, d, 100000)
msiecznych(f1, 0.0, 3.0, d, d, 100000)
msiecznych(f1, -5.0, 5.0, d, d, 100000)
msiecznych(f1, -10.0, 10.0, d, d, 100000)
msiecznych(f1, 0.0, 100.0, d, d, 100000)

msiecznych(f2, -0.5, 0.5, d, d, 100000)
msiecznych(f2, 0.5, 1.5, d, d, 100000)
msiecznych(f2, -8.0, 7.0, d, d, 100000)
msiecznych(f2, -10.0, 10.0, d, d, 100000)
msiecznych(f2, -1.0, 100.0, d, d, 100000)

