module zad1_testing

using Test
include("../zad1/bisection.jl")
include("../zad2/newton.jl")
using .Bisection:mbisekcji
using .Newton:mstycznych

@testset "zad1" begin
    value = mbisekcji((x -> x), -1.0, 1.0, 0.1, 0.1)
    @test value[4] == 0
    @test value[1] < 0.1
    @test value[1] > -0.1
    @test value[3] == 0
    @test value[2] < 0.1
    @test value[2] > -0.1 

    value = mbisekcji((x -> x^2), -1.0, 1.0, 0.1, 0.1)
    @test value[4] == 1

    value = mbisekcji((x -> x+1), -2.0, -1.0, 0.01, 0.01)
    @test value[4] == 0
    @test value[1] < -0.99
    @test value[1] > -1.01
    @test value[2] < 0.01
    @test value[2] > -0.01

    value = mbisekcji((x -> sin(x)), pi-1, pi+1, 0.01, 0.01)
    @test value[4] == 0
    @test value[1] < pi+0.01
    @test value[1] > pi-0.01
    @test value[2] < sin(pi - 0.01)
    @test value[2] > sin(pi + 0.01)
end

@testset "zad2" begin
    @test true
end







end