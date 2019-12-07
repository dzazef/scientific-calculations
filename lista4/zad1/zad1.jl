module IlorazyRoznicowe
export ilorazyRoznicowe

debug = false
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x)
    fx::Vector{Float64} = []
    foreach(value -> push!(fx, value), f)
    for j = 2:n             
		for i = n:-1:j
            fx[i] = (fx[i] - fx[i - 1]) / (x[i] - x[i - j + 1])
            if debug println("DEBUG: $(fx) : $(fx[i]) : $(fx[i-1]) : $(x[i]) : $(x[i - j + 1])") end
		end
	end
    return fx
end

end