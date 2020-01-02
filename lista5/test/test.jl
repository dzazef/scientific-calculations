include("../matrix_gen/matrixgen.jl")
include("../zad/blocksys.jl")
using .matrixgen:blockmat
using .blocksys
using Plots

function testGauss(n, l, ck, path, result_path) 
    blockmat(n, l, ck, path)
    (A, l, n) = parseMatrix(path)
    b = calculateB(A, l, n)
    x = mdfGaussElim(A, b, l, n)
    saveVector(x, result_path)
end

function testGaussPP(n, l, ck, path, result_path)
    blockmat(n, l, ck, path)
    (A, l, n) = parseMatrix(path)
    b = calculateB(A, l, n)
    x = mdfGaussElimPP(A, b, l, n)
    saveVector(x, result_path)
end

function testLU(n, l, ck, path, result_path)
    blockmat(n, l, ck, path)
    (A, l, n) = parseMatrix(path)
    b = calculateB(A, l, n)
    mdfLU(A, b, l, n)
    x = solveLU(A, b, l, n)
    saveVector(x, result_path)
end

function testLUPP(n, l, ck, path, result_path)
    blockmat(n, l, ck, path)
    (A, l, n) = parseMatrix(path)
    b = calculateB(A, l, n)
    (A, p) = mdfLUPP(A, b, l, n)
    x = solveLUPP(A, b, p, l, n)
    saveVector(x, result_path)
end

function runTests()
    testGauss(2000, 4, 2.0, "../test_data/other/a1.txt", "../test_data/other/r1.txt")
    testGaussPP(2000, 4, 2.0, "../test_data/other/a2.txt", "../test_data/other/r2.txt")
    testLU(2000, 4, 2.0, "../test_data/other/a3.txt", "../test_data/other/r3.txt")
    testLUPP(2000, 4, 2.0, "../test_data/other/a4.txt", "../test_data/other/r4.txt")
end

function measureTimeGauss(method, num_min, num_max, step, l, ck)
    (path, result_path) = ("../test_data/other/a5.txt", "../test_data/other/r5.txt")
    size_a = Array{Int}(undef, 0)
    time_a = Array{Float64}(undef, 0)
    bytes_a = Array{Float64}(undef, 0)
    ops_a = Array{Int}(undef, 0)
    for i = num_min:step:num_max
        blockmat(i, l, ck, path)
        (A, l, n) = parseMatrix(path)
        b = calculateB(A, l, n)
        t_val, t_time, t_bytes, t_gctime, t_memallocs = @timed begin
            if (method == "gauss")
                (_, ops) = mdfGaussElim(A, b, l, n)
            elseif (method == "gausspp")
                (_, ops) = mdfGaussElimPP(A, b, l, n)
            elseif (method == "lu")
                (_, ops1) = mdfLU(A, b, l, n)
                (_, ops2) = solveLU(A, b, l, n)
                ops = ops1 + ops2
            elseif (method == "lupp")
                (A, p, ops1) = mdfLUPP(A, b, l, n)
                (_, ops2) = solveLUPP(A, b, p, l, n)
                ops = ops1 + ops2
            else
                error("Wrong method used")
            end
        end
        append!(size_a, i)
        append!(time_a, t_time)
        append!(bytes_a, t_bytes)
        append!(ops_a, ops)
        println(method, ": ", i, "/", num_max)
    end
    return size_a, time_a, bytes_a, ops_a
end

function runBenchmark(id, num_min, num_max, step, l, ck)
    (s0, t0, b0, o0) = measureTimeGauss("gauss", num_min, num_max, step, l, ck)
    (s1, t1, b1, o1) = measureTimeGauss("gausspp", num_min, num_max, step, l, ck)
    (s2, t2, b2, o2) = measureTimeGauss("lu", num_min, num_max, step, l, ck)
    (s3, t3, b3, o3) = measureTimeGauss("lupp", num_min, num_max, step, l, ck)
    plot(s0, t0, label="gauss")
    plot!(s1, t1, label="gauss_pp")
    plot!(s2, t2, label="lu")
    plot!(s3, t3, label="lu_pp")
    savefig("plot$(id)_time.png")
    plot(s0, o0, label="gauss")
    plot!(s1, o1, label="gauss_pp")
    plot!(s2, o2, label="lu")
    plot!(s3, o3, label="lu_pp")
    savefig("plot$(id)_ops.png")
    plot(s0, b0, label="gauss")
    plot!(s1, b1, label="gauss_pp")
    plot!(s2, b2, label="lu")
    plot!(s3, b3, label="lu_pp")
    savefig("plot$(id)_mem.png")
end

runBenchmark(2, 100, 50000, 50, 5, 20.0)