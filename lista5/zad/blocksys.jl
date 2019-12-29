module blocksys

using SparseArrays

# reads matrix from file
# source - path to file
# Returns:
#       A - Smatrix in SparseMatrixCSC format
#       n - matrix size
#       l - block size
function parseMatrix(source::String)
    I::Vector{Int} = []
    J::Vector{Int} = []
    V::Vector{Float64} = []
    A::SparseMatrixCSC{Float64} = spzeros(1)
    n::Int = 0
    l::Int = 0
    open(source) do file
        first_line = readline(file)
        split_line = split(first_line, " ")
        n = parse(Int, split_line[1])
        l = parse(Int, split_line[2])
        for ln in eachline(file)
            split_line = split(ln, " ")
            append!(I, parse(Int, split_line[1]))
            append!(J, parse(Int, split_line[2]))
            append!(V, parse(Float64, split_line[3]))
        end
    end
    A = sparse(I, J, V, n, n)
    return A, n, l
end
# println(parseMatrix("../test_data/Dane16_1_1/A.txt"))
# (A, n, l) = parseMatrix("../test_data/Dane16_1_1/A.txt")


# reads vector from file
# source - path to file
# Returns:
#       V - vector
#       n - vector size
function parseVector(source::String)
    V::Vector{Float64} = []
    n::Int = 0
    open(source) do file
        line = readline(file)
        n = parse(Int, line)
        for line in eachline(file)
            append!(V, parse(Float64, line))
        end
    end
    return V, n
end
# println(parseVector("../test_data/Dane50000_1_1/b.txt")[1][2])
# (b, n) = parseVector("../test_data/Dane16_1_1/b.txt")





# calculates min row with non zero element
# k - current row
# l - block size
# n - matrix size
# Returns:
#       x - min row with non zero element
minRow(k::Int, l::Int, n::Int) = min((k + ((l + 1) - (k + 1) % l)), n)


# calculates max column with non zero element
# k - current column
# l - block size
# Returns:
#       x - max column with non zero element
maxColumn(k::Int, l::Int, n::Int) = min((k + l), n)


# calculates index of (i, j) element
# i, j - indices
# n - matrix size
# Returns:
#       x - index of (i, j) element
idx(i::Int, j::Int, n::Int) = (j - 1) * n + i


# solves system of linear equations using gaussian elimination
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       x - solution vector
function mdfGaussElim(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    x::Vector{Float64} = zeros(n)
    for i = 1:(n-1)                                                         # iterate over diagonal
        for j = (i + 1):minRow(i, l, n)                                     # iterate over rows
            z = A[idx(j, i, n)] / A[idx(i, i, n)]                           # calculate multiplier
            A[idx(j, i, n)] = 0                                             # zero first considered column in rows
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[idx(j, k, n)] = A[idx(j, k, n)] - z * A[idx(i, k, n)]     # calculate new entry in matrix
            end
            b[j] = b[j] - z * b[i]                                          # calculate new entry in vector
        end
    end
    x[n] = b[n] / A[idx(n, n, n)]
    for i = (n - 1):-1:1
        sum = 0.0
        for j = (i + 1):maxColumn(i, l, n)
            sum += A[idx(i, j, n)] * x[j]
        end
        x[i] = (b[i] - sum) / A[idx(i, i, n)]
    end
    return x
end
# x = mdfGaussElim(A, b, l, n)


# solves system of linear equations using gaussian elimination with partial pivoting
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       x - solution vector
function mdfGaussElimPartPivot(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    x::Vector{Float64} = zeros(n)
    for i = 1:(n-1)                                                         # iterate over diagonal
        for j = (i + 1):minRow(i, l, n)                                     # iterate over rows
            z = A[idx(j, i, n)] / A[idx(i, i, n)]                           # calculate multiplier
            A[idx(j, i, n)] = 0                                             # zero first considered column in rows
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[idx(j, k, n)] = A[idx(j, k, n)] - z * A[idx(i, k, n)]     # calculate new entry in matrix
            end
            b[j] = b[j] - z * b[i]                                          # calculate new entry in vector
        end
    end
    x[n] = b[n] / A[idx(n, n, n)]
    for i = (n - 1):-1:1
        sum = 0.0
        for j = (i + 1):maxColumn(i, l, n)
            sum += A[idx(i, j, n)] * x[j]
        end
        x[i] = (b[i] - sum) / A[idx(i, i, n)]
    end
    return x
end
# x = mdfGaussElim(A, b, l, n)


(A, n, l) = parseMatrix("../test_data/Dane16_1_1/A.txt")
(b, n) = parseVector("../test_data/Dane16_1_1/b.txt")
x = mdfGaussElim(A, b, l, n)
println(x)

# (A, n, l) = parseMatrix("../test_data/Dane10000_1_1/A.txt")
# (b, n) = parseVector("../test_data/Dane10000_1_1/b.txt")
# x = mdfGaussElim(A, b, l, n)
# println(x)

# (A, n, l) = parseMatrix("../test_data/Dane50000_1_1/A.txt")
# (b, n) = parseVector("../test_data/Dane50000_1_1/b.txt")
# x = mdfGaussElim(A, b, l, n)
# println(x)

end