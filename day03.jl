#=
Advent of Code 2020, Day 3
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/3")


# function to count trees for a given slope
function tree_counter(slope, data)

    # initialization
    x, y = [1,1]
    trees = 0
    L = length(data[1])

    # dive till you hit the rocks
    while y <= length(data)

        # check for tree
        line = data[y]
        char = line[mod1.(x, L)]
        if (char == '#')
            trees += 1
        end

        # update
        x += slope[1]
        y += slope[2]
    end

    return trees
end


# Part 1: count #'s in slope 3
println(tree_counter([3,1], data)) # 286


# Part 2: Multiply the result for many slopes
slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]
# trees = [tree_counter(x, data) for x in slopes]
trees = map(x -> tree_counter(x, data), slopes)
println(prod(trees)) # 3638606400