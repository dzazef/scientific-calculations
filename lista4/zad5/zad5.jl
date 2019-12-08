# Lista 4: zadanie 5
# Autor: Józef Piechaczek
include("../zad4/zad4.jl")
using .RysujNnfx:rysujNnfx

function zad5()
    rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 5, "1_5")
    rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 10, "1_10")
    rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 15, "1_15")

    rysujNnfx(x -> x*x*sin(x), -1.0, 1.0, 5, "2_5")
    rysujNnfx(x -> x*x*sin(x), -1.0, 1.0, 10, "2_10")
    rysujNnfx(x -> x*x*sin(x), -1.0, 1.0, 15, "2_15")
end

zad5()