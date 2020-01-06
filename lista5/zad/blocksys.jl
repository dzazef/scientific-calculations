# Autor: Józef Piechaczek
module blocksys
export parseMatrix, parseVector, saveVector, mdfGaussElim, mdfGaussElimPP, mdfLU, mdfLUPP, solveLU, solveLUPP, calculateB

using SparseArrays

# reads matrix from file
# source - path to file
# Returns:
#       A - matrix in SparseMatrixCSC format
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
    return A, l, n
end


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


# saves vector from file
# x - vector to save
# path - file path
function saveVector(x::Vector{Float64}, path::String)
    open(path, "w") do file
        for i = 1:size(x)[1]
            write(file, "$(x[i])\n")
        end
    end
end


# calculates b =  A * x, x = (1, ..., 1)^T
# A - matrix of coefficients
# n - matrix size
# l - block size
# Returns:
#       b - column vector
function calculateB(A::SparseMatrixCSC, l::Int, n::Int)
    minColumn(k::Int, l::Int) = max(1, k - (2 + (k-1)%l))
    maxColumn(k::Int, l::Int, n::Int) = min(n, k+l)
    b::Vector{Float64} = zeros(n)
    for i = 1:n
        for j = minColumn(i, l):maxColumn(i, l, n)
            b[i] += A[i, j]
        end
    end
    return b
end


# calculates max row with non zero element
# k - current row
# l - block size
# n - matrix size
# Returns:
#       x - max row with non zero element
maxRow(k::Int, l::Int, n::Int) = min((k + ((l + 1) - (k + 1) % l)), n)


# solves system of linear equations using gaussian elimination
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       x - solution vector
function mdfGaussElim(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    maxColumn(k1::Int, l1::Int, n1::Int) = min((k1 + l1), n1)                     # maximum column with nonzero value
    x::Vector{Float64} = zeros(n)
    ops = n

    for i = 1:(n-1)                                                         # iterate over diagonal
        for j = (i + 1):maxRow(i, l, n)                                     # iterate over rows
            z = A[j, i] / A[i, i]                                           # calculate multiplier
            A[j, i] = 0                                                     # zero first considered column in rows
            ops += 2
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[j, k] -= z * A[i, k]                                      # calculate new entry in matrix
                ops += 1
            end
            b[j] -= z * b[i]                                                # calculate new entry in vector
            ops += 1
        end
    end
    x[n] = b[n] / A[n, n]                                                   # back substitution                      
    ops += 1
    for i = (n - 1):-1:1
        sum = 0.0
        ops += 1
        for j = (i + 1):maxColumn(i, l, n)
            sum += A[i, j] * x[j]
            ops += 1
        end
        x[i] = (b[i] - sum) / A[i, i]
        ops += 1
    end
    return x, ops
end



# solves system of linear equations using gaussian elimination using partial pivoting
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       x - solution vector
function mdfGaussElimPP(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    maxColumn(k1::Int, l1::Int, n1::Int) = min((k1 + 2 * l1)+1, n1)         # maximum column with nonzero value
    
    x::Vector{Float64} = zeros(n)
    p = collect(1:n)
    ops = 2 * n
    
    for i = 1:(n-1)                                                         # iterate over diagonal    
        non_zero_rows = maxRow(i, l, n)                                     # find partial pivot
        m_row = i
        m_val = abs(A[i, i])
        ops += 3
        for j = i:non_zero_rows
            if abs(A[p[j], i]) > m_val
                m_val = abs(A[p[j], i])
                m_row = j
                ops += 2
            end
            ops += 1
        end
        p[m_row], p[i] = p[i], p[m_row]
        ops += 2
        
        
        for j = (i + 1):non_zero_rows                                       # iterate over rows
            z = A[p[j], i] / A[p[i], i]                                     # calculate multiplier
            A[p[j], i] = 0                                                  # zero first considered column in rows
            ops += 2
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[p[j], k] -= z * A[p[i], k]                                # calculate new entry in matrix
                ops += 1
            end
            b[p[j]] -= z * b[p[i]]                                          # calculate new entry in vector
            ops += 1
        end
    end
    x[n] = b[p[n]] / A[p[n], n]                                             # back substitution                      
    ops += 1
    for i = (n - 1):-1:1
        sum = 0.0
        ops += 1
        for j = (i + 1):maxColumn(i, l, n) 
            sum += A[p[i], j] * x[j]
            ops += 1
        end
        x[i] = (b[p[i]] - sum) / A[p[i], i]
        ops += 1
    end
    return x, ops
end


# finds LU decomposition of matrix
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       A - LU decomposition
function mdfLU(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    maxColumn(k1::Int, l1::Int, n1::Int) = min((k1 + l1), n1)               # maximum column with nonzero value
    x::Vector{Float64} = zeros(n)

    ops = n
    for i = 1:(n-1)                                                         # iterate over diagonal
        for j = (i + 1):maxRow(i, l, n)                                     # iterate over rows
            z = A[j, i] / A[i, i]                                           # calculate multiplier
            A[j, i] = z                                                     # zero first considered column in rows
            ops += 2
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[j, k] -= z * A[i, k]                                      # calculate new entry in matrix
                ops += 1
            end
        end
    end
    return A, ops
end


# finds LU decomposition of matrix with partial pivoting
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       A - LU decomposition 
#       p - permutation vector
function mdfLUPP(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    maxColumn(k1::Int, l1::Int, n1::Int) = min((k1 + 2 * l1)+1, n1)         # maximum column with nonzero value
    
    x::Vector{Float64} = zeros(n)
    p = collect(1:n)

    ops = 2 * n
    
    for i = 1:(n-1)                                                         # iterate over diagonal    
        non_zero_rows = maxRow(i, l, n)                                     # find partial pivot
        m_row = i
        m_val = abs(A[i, i])
        ops += 3
        for j = i:non_zero_rows
            if abs(A[p[j], i]) > m_val
                m_val = abs(A[p[j], i])
                m_row = j
                ops += 2
            end
            ops += 1
        end
        p[m_row], p[i] = p[i], p[m_row]
        ops += 2

        for j = (i + 1):non_zero_rows                                       # iterate over rows
            z = A[p[j], i] / A[p[i], i]                                     # calculate multiplier
            A[p[j], i] = z                                                  # zero first considered column in rows
            ops += 2
            for k = (i + 1):maxColumn(i, l, n)                              # iterate over columns
                A[p[j], k] -= z * A[p[i], k]                                # calculate new entry in matrix
                ops += 1
            end
        end
    end
    return A, p, ops
end



# solves sysyem of linear equations using LU decomposition
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# Returns:
#       x - solution vector
function solveLU(A::SparseMatrixCSC, b::Vector{Float64}, l::Int, n::Int)
    y::Vector{Float64} = zeros(n)
    maxColumn(i::Int, l::Int, n::Int) = min(n, i+l)
    minColumn(k::Int, l::Int) = max(1, k - (2 + (k-1)%l))

    ops = n
    for i = 1:n
        sum = 0.0
        ops += 1
        for j = minColumn(i, l):(i-1)
            sum += A[i, j] * y[j]
            ops += 1
        end
        y[i] = b[i] - sum
        ops += 1
    end

    ops += n
    x::Vector{Float64} = zeros(n)
    for i = n:-1:1
        sum = 0.0
        ops += 1
        for j = (i+1):maxColumn(i, l, n)
            sum += A[i, j] * x[j]
            ops += 1
        end
        x[i] = (y[i] - sum) / A[i, i]
        ops += 1
    end
    return x, ops
end



# solves system of linear equations using LU decomposition with partial pivoting
# A - matrix of coefficients
# b - column vector
# n - matrix size
# l - block size
# p - permutation vector
# Returns:
#       x - solution vector
function solveLUPP(A::SparseMatrixCSC, b::Vector{Float64}, p::Array{Int}, l::Int, n::Int)
    y::Vector{Float64} = zeros(n)
    maxColumn(i::Int, l::Int, n::Int) = min(n, i+2*l+1)
    minColumn(k::Int, l::Int) = max(1, k - (2 + (k-1)%l))

    ops = n
    for i = 1:n
        sum = 0.0
        ops += 1
        for j = minColumn(i, l):(i-1)
            sum += A[p[i], j] * y[j]
            ops += 1
        end
        y[i] = b[p[i]] - sum
        ops += 1
    end

    ops += n
    x::Vector{Float64} = zeros(n)
    for i = n:-1:1
        sum = 0.0
        ops += 1
        for j = (i+1):maxColumn(i, l, n)
            sum += A[p[i], j] * x[j]
            ops += 1
        end
        x[i] = (y[i] - sum) / A[p[i], i]
        ops += 1
    end
    return x, ops
end

end