#=
Advent of Code 2020, Day 23
Julia v1.5.3
Rico van Midde
=#

data = [7,1,2,6,4,3,5,8,9]
# data = [3,8,9,1,2,5,4,6,7] # test

function game(x, N)
    """fast insertion game"""
    LEN, MAX = length(x), maximum(x)
    current = first(x)

    # linked list?
    d = Dict(x[i] => x[mod1(i+1, LEN)] for i=1:LEN)

    for _=1:N
        # triple values (copy)
        triple = [d[current], d[d[current]], d[d[d[current]]]]

        # insertion value
        insertion = mod1(current - 1, MAX)
        while insertion ∈ triple
            insertion = mod1(insertion - 1, MAX)
        end

        # update pointers
        d[current] = d[triple[3]]
        d[triple[3]] = d[insertion]
        d[insertion] = triple[1]

        # update current
        current = d[current]
    end
    return d
end

function to_array(d, startvalue, steps)
    x = [d[startvalue]]
    for _ in 1:steps-1
        append!(x, d[x[end]])
    end
    return x
end

# Part One
@time d = game(data, 100)
println(join(to_array(d, 1, 8)))

# Part Two
x = Int32[data; 10:1e6]
@time d = game(x, 1e7)
println(prod(to_array(d, 1, 2)))