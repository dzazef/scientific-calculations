# Lista 1: zadanie 4
# autor: Józef Piechaczek

# type - typ dla którego wykonujemy obliczenia
# n - rozpatrywana liczba w danej iteracji

function zad4_a(type)
    n = type(1.0)
    while(n < 2.0)
        if (n * (1.0 / n) != 1.0)
            break
        end
        n = nextfloat(n)
    end
    n
end

function zad4_b(type)
    n = typemin(type)
    while(true)
        n = nextfloat(type(n))
        if (n * (1.0 / n) != 1.0)
            break
        end
    end
    n
end

println(zad4_a(Float64))
# 1.000000057228997
println(zad4_b(Float64))
# -1.7976931348623157e308 - min in Float64