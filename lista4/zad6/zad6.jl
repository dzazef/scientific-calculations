# Lista 4: zadanie 6
# Autor: Józef Piechaczek
include("../zad4/zad4.jl")
using .RysujNnfx:rysujNnfx

function zad6()
    rysujNnfx(x -> abs(x), -1.0, 1.0, 5, "3_5")
    rysujNnfx(x -> abs(x), -1.0, 1.0, 10, "3_10")
    rysujNnfx(x -> abs(x), -1.0, 1.0, 15, "3_15")

    rysujNnfx(x -> 1 / (1 + x*x), -5.0, 5.0, 5, "4_5")
    rysujNnfx(x -> 1 / (1 + x*x), -5.0, 5.0, 10, "4_10")
    rysujNnfx(x -> 1 / (1 + x*x), -5.0, 5.0, 15, "4_15")
end

zad6()