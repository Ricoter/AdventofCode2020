#=
Advent of Code 2020, Day 12
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/12")

# show some data
println(data[1:3])

# globals
part = 1
pos = [0, 0]
N, E, d = 0, 0, ['E','S','W','N']

ops = Dict([
 ('N', x -> global N += x),
 ('E', x -> global E += x),
 ('S', x -> global N -= x),
 ('W', x -> global E -= x),
 ('R', x -> part == 1 ? [global d = circshift(d,-x/90)] : global N, E = circshift([N,E,-N,-E], x/90)[1:2]),
 ('L', x -> part == 1 ? [global d = circshift(d,x/90)] : global N, E = circshift([N,E,-N,-E], -x/90)[1:2]),
 ('F', x -> part == 1 ? [ops[d[1]](x)] : global pos += x*[N,E])
])

# Part one
[ops[x[1]](parse(Int, x[2:end])) for x in data]
println("Part one: $(abs(N)+abs(E))")

# Part two
N, E, part = 1, 10, 2
[ops[x[1]](parse(Int, x[2:end])) for x in data]
println("Part two: $(sum(abs.(pos)))")