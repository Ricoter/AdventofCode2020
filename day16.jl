#=
Advent of Code 2020, Day 16
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/16")

# fields
fields = [split(x, r": |-| or ") for x ∈ data[begin:20] if x != ""]
fields = Dict([(x[1], parse.(Int, x[2:end])) for x ∈ fields])

# tickets
my_ticket = parse.(Int, split(data[23], ","))
nearby = [parse.(Int, split(line, ",")) for line ∈ data[26:end]]

valid(x :: Int) = any([ a <= x <= b || c <= x <= d for (a, b, c, d) ∈ values(fields)]) ? true : false
which_valid(x :: Array{Int}) = [key for (key, (a,b,c,d)) ∈ fields if all((a .<= x .<= b) .| (c .<= x .<= d))]
T(A :: Array{Array{Int}}) = [getindex.(A,i) for i=1:length(A[1])] # transpose
remove!(data :: Array{Array{Int}}, target :: Int) = [filter!(e -> e ≠ target, x) for x in data] 

# Part One
println("Part One: ", sum([x for x ∈ vcat(nearby...) if !valid(x)]))

# Part two
valids = [x for x ∈ nearby if all(valid.(x))] # valid tickets
possible_keys = [which_valid(x) for x ∈ T(valids)] # possible keys

for _ in possible_keys
    for (i, x) in enumerate(possible_keys)
        if length(x) == 1
            fields[x[1]] = [my_ticket[i]]
            remove!(possible_keys, x[1])
        end
    end
end

ans2 = prod([value[1] for (key, value) in fields if startswith(key, "departure")])
println("Part Two: $ans2")