# Lista 1: zadanie 2
# autor: Józef Piechaczek

# type - typ dla którego wykonujemy obliczenia

kahan(type) = type(type(3) * (type(4) / type(3) - type(1)) - type(1))

println("KahanEps: ", kahan(Float16), " Macheps: ", eps(Float16))
println("KahanEps: ", kahan(Float32), " Macheps: ", eps(Float32))
println("KahanEps: ", kahan(Float64), " Macheps: ", eps(Float64))