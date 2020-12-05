#=
Advent of Code 2020, Day 1
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/input1.txt")
data = map(x -> parse(Int,x), data)

# A: Find the two entries that sum to 2020; what do you get if you multiply them together?
for j in data, i in data
    if (j + i == 2020)
        println(j*i)
        break
    end
end

# B: What is the product of the three entries that sum to 2020?
for j in data, i in data, k in data
    if (j + i + k == 2020)
        println(j*i*k)
        break
    end
end