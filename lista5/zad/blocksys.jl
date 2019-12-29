module blocksys

function parseArray(source::String)
    I::Vector{Int} = []
    J::Vector{Int} = []
    V::Vector{Float64} = []
    open(source) do file
        for ln in eachline(file)
            split_line = split(ln, " ")
            # TODO
        end
    end
end

parseArray("../test_data/Dane16_1_1/A.txt")


end