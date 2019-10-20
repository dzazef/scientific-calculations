# Lista 1: zadanie 3
# autor: Józef Piechaczek

# delta - wykonywany krok
# n - rozpatrywana liczba w danej iteracji

delta1 = Float64(2^(-52))

function zad3_1()
    n = 1.0 
    for i = 1:9
        println(bitstring(n))
        n = n + delta1
    end
end

delta2 = Float64(2^(-53)) 
# wyjaśnienie w sprawozdaniu

function zad3_2()
    n = 0.5
    for i = 1:9
        println(bitstring(n))
        n = n + delta2
    end
end

delta3 = Float64(2^(-51)) 
# wyjaśnienie w sprawozdaniu

function zad3_3()
    n = 2.0
    for i = 1:9
        println(bitstring(n))
        n = n + delta3
    end
end

zad3_1()
println()
zad3_2()
println()
zad3_3()