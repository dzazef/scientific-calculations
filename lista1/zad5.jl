# Lista 1: zadanie 5
# autor: Józef Piechaczek

function zad5_a(type)
    x::Array{type, 1} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
    y::Array{type, 1} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
    S::type = 0
    for i = 1:length(x)
        S = S + x[i] * y[i]
    end
    return S
end

function zad5_b(type)
    x::Array{type, 1} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
    y::Array{type, 1} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
    S::type = 0
    for i = length(x):-1:1
        S = S + x[i] * y[i]
    end
    return S
end

function zad5_c(type)
    x::Array{type, 1} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
    y::Array{type, 1} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
    S::type = 0
    results::Array{type, 1} = []

    for i = 1:length(x)
        append!(results, x[i] * y[i])
    end

    results = sort(results)
    counter = length(x)
    plus::type = 0
    minus::type = 0

    while(results[counter] > 0)
        plus = plus + results[counter]
        counter = counter - 1
    end

    for i = 1:counter
        minus = minus + results[i]
    end

    return plus + minus
end

function zad5_d(type)
    x::Array{type, 1} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
    y::Array{type, 1} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
    S::type = 0
    results::Array{type, 1} = []

    for i = 1:length(x)
        append!(results, x[i] * y[i])
    end

    results = sort(results)
    counter = length(x)
    plus::type = 0
    minus::type = 0

    counter = 1
    while (results[counter] < 0 && counter <= length(results))
        counter = counter + 1
    end

    for i = (counter-1):-1:1
        minus = minus + results[i]
    end

    for i = counter:length(results)
        plus = plus + results[i]
    end

    return plus + minus
end


println("Zad5_a")
println(zad5_a(Float32))
println(zad5_a(Float64))
println()

println("Zad5_b")
println(zad5_b(Float32))
println(zad5_b(Float64))
println()

println("Zad5_c")
println(zad5_c(Float32))
println(zad5_c(Float64))
println()

println("Zad5_d")
println(zad5_d(Float32))
println(zad5_d(Float64))
println()
