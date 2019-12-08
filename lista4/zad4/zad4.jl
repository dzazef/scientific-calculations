# Lista 4: zadanie 4
# Autor: Józef Piechaczek
module RysujNnfx
export rysujNnfx

include("../zad1/zad1.jl")
include("../zad2/zad2.jl")
include("../zad3/zad3.jl")
using .IlorazyRoznicowe:ilorazyRoznicowe
using .WarNewton:warNewton
using .Naturalna:naturalna
using Plots

# Funkcja która zinterpoluje zadaną funkcję f(x) w przedziale [a, b] za pomocą wielomianu 
# interpolacyjnego stopnia n w postaci Newtona. Następnie narysuje wielomian interpolacyjny 
# i interpolowaną funkcję. W interpolacji używa węzłów równoodległych.
#       f       - funkcja zadana jako anonimowa
#       a,b     - przedział
#       n       - stopień wielomianu
#       name    - nazwa zapisywanego wykresu (dodatkowo)
function rysujNnfx(f, a::Float64, b::Float64, n::Int, name::String)
    accuracy = 25                               # zagęszczenie węzłów w rysowanej funkcji
    nodes = n + 1
    
    x = Vector{Float64}(undef, nodes)
    y = Vector{Float64}(undef, nodes)

    h = (b - a) / n

    for i = 1:nodes                             # oblicznie węzłów i wartości funkcji
        x[i] = a + h * (i - 1)
        y[i] = f(x[i])
    end

    fx = ilorazyRoznicowe(x, y)                 # obliczanie ilorazów różnicowych
    nodes = nodes * accuracy                    
    h = (b - a) / (nodes - 1)

    p_x  = Vector{Float64}(undef, nodes)
    p_y  = Vector{Float64}(undef, nodes)
    p_iy = Vector{Float64}(undef, nodes)

    for i = 1:nodes                             
        p_x[i] = a + h * (i - 1)                # obliczanie węzłów dla rysowanej funkcji
        p_y[i] = f(p_x[i])                      # obliczanie wartości funkcji w węzłach
        p_iy[i] = warNewton(x, fx, p_x[i])      # obliczenie wartości wielomianu interpolującego
    end

    plot(p_x, p_y, label="f")
    plot!(p_x, p_iy, label="w")

    savefig("myplot_$(name).png")
end

end
