#=
Advent of Code 2020, Day 9
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/9")

# println(data[1:3])
global data = [parse(Int, x) for x in data]

function notsum(idx)
    e = idx - 1
    b = e - 24
    for i in data[b:e], j in data[b:e]
        if j != i && (j + i == data[idx])
            return false
        end
    end
    return true
end

nnotsum = [notsum(x) for x in 26:length(data)]
n = findfirst(nnotsum) + 25
println("Part one: ", data[n])


function findmagiccombination(magicnumber)
    lo, hi = 1, 2
    while hi < length(data)
        if sum(data[lo:hi]) == magicnumber
            println("found!!")
            return minimum(data[lo:hi]) + maximum(data[lo:hi])
        end
        if sum(data[lo:hi]) < magicnumber
            hi += 1
        end
        if sum(data[lo:hi]) > magicnumber
            lo += 1
        end
        if lo > hi
            println("error")
            break
        end
    end
end

# using Combinatorics
combi = findmagiccombination(data[n])
println("Part two: $combi")
# println("Part two: ", minimum(combi) + maximum(combi))
