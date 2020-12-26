#=
Advent of Code 2020, Day 18
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/18")

# show some data
println(data[1])

# https://discourse.julialang.org/t/on-adjoints-and-custom-postfix-and-infix-operators/12863/35
# change + to other Unicode symbol with the same precedence (11) as *
⦾(a,b) = +(a,b)

x = 0
for line in data
    line = split(line, "")
    replace!(line, "+" => "⦾")
    line = join(line)
    x += eval(Meta.parse(line)) # evaluate string
end
println("Part One: $x")

# change * to other Unicode symbol with the same precedence (12) as +
⋓(a,b) = *(a,b)

x = 0
for line in data
    line = split(line, "")
    replace!(line, "+" => "⦾", "*" => "⋓")
    line = join(line)
    x += eval(Meta.parse(line))
end
println("Part Two: $x")