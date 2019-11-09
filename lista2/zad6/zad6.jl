# Lista 2: zadanie 6
# autor: Józef Piechaczek

using Printf

# równanie rekurencyjne
# n - liczba iteracji
# x0, c - parametry równania
function x(n, x0, c)
    x = x0
    for i = 0:(n-1)
        # do LATEX
        # @printf("%.6e\n", x) 
        println("$(x)")
        x = x^2 + c
    end
    # do LATEX
    # @printf("%.6e\n", x)
    println("$(x)")
end

# wartości dla których wykonujemy eksperymenty
values = [
    [-2, 1],
    [-2, 2],
    [-2, 1.99999999999999],
    [-1, 1],
    [-1, -1],
    [-1, 0.75],
    [-1, 0.25]
]

function zad6()
    for i = 1:length(values)
        println()
        println("-----------------")
        println("c: $(values[i][1]), x0: $(values[i][2])")
        println("-----------------")
        x(40, values[i][2], values[i][1])
    end
end

zad6()
