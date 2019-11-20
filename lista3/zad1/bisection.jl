module Bisection
export mbisekcji

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    f_a = f(a)
    f_b = f(b)
    if (sign(f_a) == sign(f_b))
        println("DEBUG1: r: undef, v: undef, it: undef, err: 1")
        return (0, 0, 0, 1)
    end
    it = 0
    e = b-a
    r = a+(e/2)
    v = f(r)
    while (abs(e) > delta && abs(v) > epsilon)
        it += 1
        e = e/2
        r = a+e
        v = f(r)
        if (sign(v) != sign(f_a))
            b = r
            f_b = v
        else
            a = r
            f_a = v
        end
    end
    println("DEBUG1: r: $(r), v: $(v), it: $(it), err: 0")
    return (r, v, it, 0)
end

end