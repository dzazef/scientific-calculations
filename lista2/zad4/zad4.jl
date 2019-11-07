# Lista 2: zadanie 4
# autor: Józef Piechaczek

using Polynomials, Printf;

p_coeff1=reverse([1, -210.0, 20615.0,-1256850.0,
        53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
        11310276995381.0, -135585182899530.0,
        1307535010540395.0,     -10142299865511450.0,
        63030812099294896.0,     -311333643161390640.0,
        1206647803780373360.0,     -3599979517947607200.0,
        8037811822645051776.0,      -12870931245150988800.0,
        13803759753640704000.0,      -8752948036761600000.0,
        2432902008176640000.0])

p_coeff2=reverse([1, -210.0-2^(-23), 20615.0,-1256850.0,
        53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
        11310276995381.0, -135585182899530.0,
        1307535010540395.0,     -10142299865511450.0,
        63030812099294896.0,     -311333643161390640.0,
        1206647803780373360.0,     -3599979517947607200.0,
        8037811822645051776.0,      -12870931245150988800.0,
        13803759753640704000.0,      -8752948036761600000.0,
        2432902008176640000.0])

function p(x)
    res = 1.0;
    for i = 1:20
        res = res * (x - i)
    end
    res
end

function zad4(p1, p2)
    p1_roots = reverse(Polynomials.roots(p1))
    # println(p1_roots)
    for k = 1:20
        print("$(k)")
        print(" & $(p1_roots[k])")
        print(" & $(abs(Polynomials.polyval(p1, p1_roots[k])))")
        print(" & $(abs(Polynomials.polyval(p2, p1_roots[k])))")
        print(" & $(abs(p1_roots[k] - k))")
        println()

        # for LATEX
        # print(k)
        # @printf(" & %.6e", p1_roots[k])
        # @printf(" & %.6e + %.6ei", real(p1_roots[k]), imag(p1_roots[k]))
        # @printf(" & %.6e", abs(Polynomials.polyval(p1, p1_roots[k])))
        # @printf(" & %.6e", abs(Polynomials.polyval(p2, p1_roots[k])))
        # @printf(" & %.6e", abs(p1_roots[k] - k))
        # println("\\\\\n\\hline")
    end
end

p1 = Polynomials.Poly(p_coeff1)
p2 = Polynomials.poly([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
# println(p1, "\n", p2)
zad4(p1, p2)

p1 = Polynomials.Poly(p_coeff2)
p2 = Polynomials.poly([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
zad4(p1, p2)