# Lista 4: zadanie 3
# Autor: Józef Piechaczek
module Naturalna
export naturalna

debug = false
# Funkcja obliczająca współczynniki wielomianu interpolującego w postaci natralnej
#       x  - wektor długości n+1 zawierający węzły x_0, ..., x_n
#       fx - wektor długości n+1 zawierający ilorazy różnicowe
#       a  - wektór długości n+1 zawierający współczynniki postaci naturalnej
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    l = length(fx)
    a = Vector{Float64}(undef, l)
    a[l] = fx[l]

    for i = l-1:-1:1
        a[i] = fx[i] - a[i + 1] * x[i]              # wartość częściowa z Hornera
        if debug println(a) end
        for j = i+1:l-1                             # zamiana na postać naturalną
            a[j] = a[j] - a[j + 1] * x[i]
            if debug println(a) end
        end
    end
    return a
end

end