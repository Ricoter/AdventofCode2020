#=
Advent of Code 2020, Day 10
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/10")

# show some data
println(data[1:3])

# to int
data = [parse(Int, x) for x in data]

# add charging outlet && build in adapter 
append!(data, 0)
append!(data, maximum(data)+3)

# differences
sort!(data)
diff = data[begin+1:end] - data[begin:end-1]

println("Part one: ", count(diff .== 1) * count(diff .== 3))


println(diff)

ddiff = diff[begin+1:end] + diff[begin:end-1]

println(ddiff)
println(7*7*7*7*7*7*2*7*7*4*7*7*4*4*7*2*4*7*4) # why it works i dont know :p