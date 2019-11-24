module Bisection
export mbisekcji

debug = true
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    f_a = f(a)
    f_b = f(b)
    if (sign(f_a) == sign(f_b))
        res = ("undef", "undef", "undef", 1)
        if debug println("DEBUG1a: $(res)") end
        return res
    end
    it = 0
    e = b-a
    while (e > epsilon)
        it += 1
        e = e/2
        r = a+e
        v = f(r)
        if (abs(e) < delta || abs(v) < epsilon)
            res = (r, v, it, 0)
            if debug println("DEBUG1b: $(res)") end
            return res
        end
        if (sign(v) != sign(f_a))
            b = r
            f_b = v
        else
            a = r
            f_a = v
        end
    end
end

end