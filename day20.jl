#=
Advent of Code 2020, Day 19
Julia v1.5.3
Rico van Midde
=#

data = readlines("input/20")
datacuts = [[1]; findall(data .== "") .+ 1]

# Array{Array} -> BitArray
to_BitArray(x) = permutedims(hcat(map(collect, x)...)) .== '#'
clockwise_edges(x) = [x[1,1:10], x[1:10,10], reverse(x[10,1:10]), reverse(x[1:10,1])]
multiply_corners(tiles) = prod([key for (key, value) in tiles if length(value) == 2])

function data2dict(data)
    dict = Dict()
    for i in datacuts
        header = data[i]
        tile_number = header[6:9]
        tile_number = parse(Int, tile_number)
        grid = data[i+1:i+10]
        grid = to_BitArray(grid)    
        grid = Array(grid)          # 10x10 Array{Bool,2}
        dict[tile_number] = clockwise_edges(grid)
    end
    return dict
end

function remove_matches(tiles)
    for x in values(tiles), y in values(tiles)
        for i in x, j in y
            if x ≠ y && (i == j || i == reverse(j)) # del matching edges
                filter!(e->e≠i,x)
                filter!(e->e≠j,y)
            end
        end 
    end
    return tiles
end

# Part One
data |> data2dict |> remove_matches |> multiply_corners