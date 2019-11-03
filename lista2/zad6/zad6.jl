# f(n, x0, c) = n==0 ? x0 : f(n-1, x0, c)^2 + c

function x(n, x0, c)
    x = x0
    for i = 0:(n-1)
        println("i: $(i), val: $(x)")
        x = x^2 + c
    end
    println("i: $(n), val: $(x)")
end

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
