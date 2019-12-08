# Lista 4: zadanie 2
# Autor: Józef Piechaczek
module WarNewton
export warNewton

debug = false
# Funkcja obliczająca wartość wielomianu interpolacyjnego stopnia n w postani Newtona
# w punkcie t za pomocą uogólnionego alorytmu Hornera w czasie O(n)
#       x  - wektor długości n+1 zawierający węzły x_0, ..., x_n
#       fx - wektor długości n+1 zawierający ilorazy różnicowe
#       t  - punkt w którym należy obliczyć wartość wielomianu
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    l = length(x)
    nt = fx[l]
    for i = (l-1):-1:1
        nt = fx[i] + (t - x[i]) * nt            # Uogólniony algorytm Hornera
    end
    return nt
end

end