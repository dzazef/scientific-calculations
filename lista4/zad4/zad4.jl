module RysujNnfx
export rysujNnfx


include("../zad1/zad1.jl")
include("../zad2/zad2.jl")
include("../zad3/zad3.jl")
using .IlorazyRoznicowe:ilorazyRoznicowe
using .WarNewton:warNewton
using .Naturalna:naturalna
using Plots
using Dates
using Random

function rysujNnfx(f, a::Float64, b::Float64, n::Int, name::String)
    accuracy = 25
    nodes = n + 1
    
    x = Vector{Float64}(undef, nodes)
    y = Vector{Float64}(undef, nodes)

    h = (b - a) / n

    for i = 1:nodes
        x[i] = a + h * (i - 1)
        y[i] = f(x[i])
    end

    fx = ilorazyRoznicowe(x, y)
    nodes = nodes * accuracy
    h = (b - a) / (nodes - 1)
    kh = 0.0

    p_x  = Vector{Float64}(undef, nodes)
    p_y  = Vector{Float64}(undef, nodes)
    p_iy = Vector{Float64}(undef, nodes)

    for i = 1:nodes
        p_x[i] = a + h * (i - 1)
        p_y[i] = f(p_x[i])
        p_iy[i] = warNewton(x, fx, p_x[i])
    end

    plot(p_x, p_y, label="f")
    plot!(p_x, p_iy, label="w")

    Random.seed!(0)
    savefig("myplot_$(name).png")
end

end
