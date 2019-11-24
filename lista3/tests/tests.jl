# Lista 3: testy do zadań 1, 2 i 3
# autor: Józef Piechaczek
module zad1_testing

using Test
include("../zad1/bisection.jl")
include("../zad2/newton.jl")
include("../zad3/sieczne.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych
using .Sieczne:msiecznych


@testset "zad1" begin
    value = mbisekcji((x -> x), -1.0, 1.0, 0.1, 0.1)
    @test value[4] == 0
    @test value[1] < 0.1 && value[1] > -0.1
    @test value[3] == 1
    @test value[2] < 0.1 && value[2] > -0.1

    value = mbisekcji((x -> x^2), -1.0, 1.0, 0.1, 0.1)
    @test value[4] == 1

    value = mbisekcji((x -> x+1), -2.0, -1.0, 0.01, 0.01)
    @test value[4] == 0
    @test value[1] < -0.99 && value[1] > -1.01
    @test value[2] < 0.01 && value[2] > -0.01

    value = mbisekcji((x -> sin(x)), pi-1, pi+1, 0.01, 0.01)
    @test value[4] == 0
    @test value[1] < pi+0.1 && value[1] > pi-0.1
    @test value[2] < sin(pi - 0.01) && value[2] > sin(pi + 0.01)
    
    println()
end

@testset "zad2" begin
    value = mstycznych((x -> x), (x -> 1), 1.0, 0.1, 0.1, 100)
    @test value[4] == 0
    @test value[1] < 0.1 && value[1] > -0.1
    @test value[2] < 0.1 && value[2] > -0.1 

    value = mstycznych((x -> x^2), (x -> 1), 1.0, 0.1, 0.1, 0)
    @test value[4] == 1

    value = mstycznych((x -> 2), (x -> 0), 1.0, 0.1, 0.1, 5)
    @test value[4] == 2

    value = mstycznych((x -> x+1), (x -> 1), 1.0, 0.01, 0.01, 100)
    @test value[4] == 0
    @test value[1] < -0.99 && value[1] > -1.01
    @test value[2] < 0.01 && value[2] > -0.01

    value = mstycznych((x -> sin(x)), (x -> cos(x)), pi+0.2, 0.1, 0.1, 100)
    @test value[4] == 0
    @test value[1] < pi+0.01 && value[1] > pi-0.01
    @test value[2] < sin(pi - 0.01) && value[2] > sin(pi + 0.01)

    value = mstycznych((x -> sin(x)), (x -> cos(x)), 2*pi, 0.1, 0.1, 100)
    @test value[4] == 0
    @test value[1] < 2*pi+0.01 && value[1] > 2*pi-0.01
    @test value[2] < sin(2*pi + 0.01) && value[2] > sin(2*pi - 0.01)
    
    println()
end

@testset "zad3" begin
    value = msiecznych((x -> x), -1.0, 1.0, 0.1, 0.1, 1000)
    @test value[4] == 0
    @test value[1] < 0.1 && value[1] > -0.1
    @test value[2] < 0.1 && value[2] > -0.1 

    value = msiecznych((x -> x^2), -1.0, 1.0, 0.1, 0.1, 0)
    @test value[4] == 1

    value = msiecznych((x -> x+1), -1000.0, 100000.0, 0.01, 0.01, 10000)
    @test value[4] == 0
    @test value[1] < -0.99 && value[1] > -1.01
    @test value[2] < 0.01 && value[2] > -0.01

    value = msiecznych((x -> sin(x)), pi/2, 3*pi/2, 0.01, 0.01, 50) 
    @test value[4] == 0
    @test value[1] < pi+0.01 && value[1] > pi-0.01
    @test value[2] < sin(pi - 0.01) && value[2] > sin(pi + 0.01)
    
    println()
end





end