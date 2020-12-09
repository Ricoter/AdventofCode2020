#=
Advent of Code 2020, Day 6
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/6")

# combine answers of individuals in group
groups = [[]]
for line in data
    (line == "") ? push!(groups, []) : union!(groups[end], line)
end

# count unique answers (chars)
nQuestions = [length(x) for x in groups]
println("Part one: ", sum(nQuestions))



# combine answers of individuals in group
groups = [[]]
for line in data
    (line == "") ? push!(groups, []) : append!(groups[end], split(line))
end


function check_group(group)
    """Count number of questions q which are same same for all in group"""
    n_same = 0
    for q in group[begin]
        n = [1 for x in group if q ∈ x]
        if length(n) == length(group)
            n_same += 1
        end
    end
    return n_same
end

nQuestions = [check_group(x) for x in groups]
println(sum(nQuestions))