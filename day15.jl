#=
Advent of Code 2020, Day 15
Julia v1.5.3
Rico van Midde
=#

# initialize starting numbers
numbers = [0,5,4,1,10,14,7]

# 
function arrayGame(numbers, n)
    numbers = copy(numbers)
    while length(numbers) < n
        last, rest = numbers[end], numbers[begin:end-1]
        append!(numbers, last ∈ rest ? length(numbers) - findlast(rest .== last) : 0)
    end
    println(numbers[end])        
end

function fastGame(numbers, n)
    L = length(numbers)
    num = Dict{Int, Int}(zip(numbers[begin:end-1], Array(1:L-1)))
    last, new = numbers[end], nothing
    while L< n
        # New number is age of last 
        if last ∈ keys(num)
            new = L - num[last] # age 
        else
            new = 0   # age
        end 
        num[last] = L # add last to dict with index
        last = new    # new to last
        L += 1        # update
    end
    return new     
end

N = 2020
# @time arrayGame(numbers, N)
println("Part One: $(@time fastGame(numbers, N))")
println("Part One: $(@time fastGame(numbers, 30000000))")