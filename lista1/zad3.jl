delta = 2e-52

function zad3_1()
    n = 1.0
    for i = 1:9
        println(bitstring(n))
        n = n + delta
    end
end

zad3_1()