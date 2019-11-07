# Lista 2: zadanie 5
# autor: Józef Piechaczek

using LinearAlgebra

function p1(type, p0, r)
    p::type = p0
    for i = 1:40
        p = p + r*p*(1-p)
        println("$(i);$(p)")
        # println("\\\\\n\\hline")
    end
    p
end

function p2(type, p0, r)
    p::type = p0
    for i = 1:9
        p = p + r*p*(1-p)
        println("$(i);$(p)")
        # println("\\\\\n\\hline")
    end
    p = floor(p + r*p*(1-p), digits=3)
    println("10;$(p)")
    # println("\\\\\n\\hline")
    for i = 11:40
        p = p + r*p*(1-p)
        println("$(i);$(p)")
        # println("\\\\\n\\hline")
    end
    p
end

p1(Float32, 0.01, 3)
p2(Float32, 0.01, 3)
p1(Float64, 0.01, 3)
