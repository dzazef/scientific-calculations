module lista4_testy

using Test
include("../zad1/zad1.jl")
include("../zad2/zad2.jl")
using .IlorazyRoznicowe:ilorazyRoznicowe
using .WarNewton:warNewton

x1 = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
y1 = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]

@testset "zad1" begin
    fx1 = ilorazyRoznicowe(x1, y1)
    @test sort(fx1) == sort([-25.0, 28.0, -15.0, 5.0, 0.0, 1.0])
end

@testset "zad2" begin 
    fx1 = ilorazyRoznicowe(x1, y1)
    @test warNewton(x1, fx1, -2.0) == -25.0
    @test warNewton(x1, fx1, -1.0) == 3.0
    @test warNewton(x1, fx1, 0.0)  == 1.0
    @test warNewton(x1, fx1, 1.0)  == -1.0
    @test warNewton(x1, fx1, 2.0)  == 27.0
    @test warNewton(x1, fx1, 3.0)  == 235.0
end



end