# Lista 4: zadanie 1
# Autor: Józef Piechaczek
module IlorazyRoznicowe
export ilorazyRoznicowe

debug = false
# Funkcja obliczająca ilorazy różnicowe
#       x  - wektor długości n+1 zawierający węzły x_0, ..., x_n
#       f  - wektor długości n+1 zawierający wartości interpolowanej funkcji w węzłach f(x_0), .., f(x_n)
#       fx - wektor długości n+1 zawierający obliczone ilorazy różnicowe
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    l = length(x)
    fx::Vector{Float64} = []
    foreach(value -> push!(fx, value), f)                                       # Przekopiowanie wartości z f do fx
    for j = 2:l             
		for i = l:-1:j
            fx[i] = (fx[i] - fx[i - 1]) / (x[i] - x[i - j + 1])                 # Wzór rekurencyjny na ilorazy różnicowe
            if debug 
                println("DEBUG: 
                $(fx) : $(fx[i]) : $(fx[i-1]) : $(x[i]) : $(x[i - j + 1])") 
            end
		end
	end
    return fx
end

end