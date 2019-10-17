# Lista 1: zadanie 6
# autor: Józef Piechaczek

f(x) = sqrt(x * x + 1) - 1
g(x) = (x * x) / (sqrt(x * x + 1) + 1)

for i = -1:-1:-20
    x = 8.0 ^ i
    println("8^", i, " = ", x)
    println("f(x) = ", f(x))
    println("g(x) = ", g(x))
    println()
end