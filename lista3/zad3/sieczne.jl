# Lista 3: zadanie 3
# autor: Józef Piechaczek
module Sieczne
export msiecznych

debug = true
# Funkcja obliczająca wartość miejsc zerowych funkcji f metodą siecznych
# f - funkcja
# x0, x1 - przybliżenia początkowe
# delta, epsilon - dokładności obliczeń
# maxit - maksymalna liczba iteracji
# (r, v, it, err) - wynik, gdzie
#           r - miejsce zerowe
#           v - f(r)
#           it - liczba iteracji
#           err - kod błędu
#                 0 - brak błędu
#                 1 - nie osiągnięto dokładności w maxit
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    f_x0 = f(x0)
    f_x1 = f(x1)
    for it = 1:maxit 
        if (abs(f_x0) > abs(f_x1))
            temp = x0
            x0 = x1
            x1 = temp

            temp = f_x0
            f_x0 = f_x1
            f_x1 = temp
        end

        s = (x1-x0)/(f_x1-f_x0)
        x1 = x0
        f_x1 = f_x0
        x0 = x0 - f_x0*s
        f_x0 = f(x0)

        if (abs(x1 - x0) < delta || abs(f_x0) < epsilon)
            println(x1,"   ", x0)
            println(abs(f_x0))
            res = (x0, f_x0, it, 0)
            if debug println("DEBUG3a: $(res)") end
            return res
        end
    end

    res = ("undef", "undef", "undef", 1)
    if debug println("DEBUG3b: $(res)")  end
    return res
end

end