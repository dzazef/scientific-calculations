# Lista 1: zadanie 1
# autor: Józef Piechaczek

function macheps(type)
    i = type(1)
        prev = type(0)
    while(1 + i > 1) 
        prev = i
        i /= 2
    end
    prev
end

println("MyEps: ", macheps(Float16), " Macheps: ", eps(Float16))
println("MyEps: ", macheps(Float32), " Macheps: ", eps(Float32))
println("MyEps: ", macheps(Float64), " Macheps: ", eps(Float64))

function eta(type)
    i = type(1)
    prev = type(0)
    while(i > 0)
        prev = i
        i /= 2
    end
    prev
end

println("MyEta: ", eta(Float16), " Eta: ", nextfloat(Float16(0.0)))
println("MyEta: ", eta(Float32), " Eta: ", nextfloat(Float32(0.0)))
println("MyEta: ", eta(Float64), " Eta: ", nextfloat(Float64(0.0)))

function inf(type)
    i = prevfloat(type(1.0))
    prev = type(0)
    while(!isinf(i))
        prev = i
        i *= 2
    end
    prev
end

println("MyMax: ", inf(Float16), " Max: ", floatmax(Float16))
println("MyMax: ", inf(Float32), " Max: ", floatmax(Float32))
println("MyMax: ", inf(Float64), " Max: ", floatmax(Float64))
