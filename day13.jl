#=
Advent of Code 2020, Day 13
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/13")

# show some data
println(data)

# prepare data
target, data = parse(Int, data[1]), split(data[2], ",")


# Part one
bus = [parse(Int, x) for x in data if x != "x"]
t = [x-target%x for x in bus]
println("Part one: $(bus[argmin(t)]*minimum(t))")

# testdata
test = 1
data = split(readlines("input/13t")[test], ",")
bus = [parse(Int, x) for x in data if x != "x"]

# Part two (149814 < ans)
using LinearAlgebra
A = Array(hcat(Diagonal(bus),-ones(length(bus))))
b = [index for (index, value) in enumerate(data) if value != "x"]
type = Int
A, b = map(type, A), map(type, b)

# data = [(bus[i], b[i]) for i in 1:length(bus)]
# using LLLplus
# integerfeasibility(A,b)
# n = 16
# [(x-n%x)==i for (x, i) in data]

# c = A\b
# dot(c,   inv(c))

# Solve set of linear equation with integer coefficients
# x1*b1  = y
# x2*b2 - x1*b1 = c2     
# x3*b3 - x2*b2 = c3 + c2

# x = copy(c)

# [x = x/x[i] for i in 1:9]

# \(Int,A,b)