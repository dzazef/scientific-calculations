module Newton
export mstycznych

debug = true
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v = f(x0)

    if (abs(v) < epsilon)
        res = (x0, v, 0, 0)
        if debug println("DEBUG2a: $(res)") end
        return res
    end

    if (abs(pf(x0)) < epsilon)
        res = ("undef", "undef", "undef", 2)
        if debug println("DEBUG2b: $(res)") end
        return res
    end

    for it = 1:maxit
        x1 = x0 - v/pf(x0)
        v = f(x1)
        if (abs(x1 - x0) < delta || abs(v) < epsilon)
            res = (x1, v, it, 0)
            if debug println("DEBUG2c: $(res)") end
            return res
        end
        x0 = x1
    end
    res = ("undef", "undef", "undef", 1)
    if debug println("DEBUG2d: $(res)") end
    return res
end

end