hilb = n-> [1/(i+j-1) for i in 1:n, j in 1:n]

function matcond(n, c)
    if (c < 1.0)
        error("Incorrect condition number")
    end
    if (n < 2)
        error("Incorrect matrix size")
    end
    
end

println(hilb(5))