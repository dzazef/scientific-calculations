# Lista 1: zadanie 7
# autor: Józef Piechaczek

f(x) = sin(x) + cos(3.0 * x)
df(x) = cos(x) - 3.0 * sin(3.0 * x)
df2(x,h) = (f(x+h) - f(x)) / h

# derivative - wartość pochodnej obliczona z dokładnego wzoru
# derivative2 - wartość pochodnej obliczona z wzoru z przybliżeniem
x = 1.0
derivative = df(x)
println("df(x) = ", derivative)
for n = 0:54
    h = 2.0^(n * (-1.0))
    derivative2 = df2(x, h)
    # println("$n & $derivative2 & $(abs(derivative - derivative2))\\\\\n\\hline") - tabela do latex
    # println("$n & $h & $(1+h)\\\\\n\\hline") - tabela do latex
    println("n = ", n, ", df2(x) = ", derivative2, ", err = ", abs(derivative - derivative2), ", h = ", h, ", 1+h = ", (1.0 + h))
end