#=
Advent of Code 2020, Day 13
Julia v1.5.3                    🚐      🚐      🚐
Rico van Midde
=#

# read input
data = readlines("input/13")
N, data = parse(Int, data[1]), split(data[2], ",")
ID_bus = [parse(Int, x) for x in data if x != "x"]

# Part One
t_wait = ID_bus .* ceil.(Int, N ./ ID_bus) .% N
p1 = prod(minimum(zip(t_wait, ID_bus)))
println("Part One: $p1")

# Part Two
ID_bus = [[i,parse(Int, x)] for (i,x) in enumerate(b) if x != "x"]

function firstmatch(b, diff)
    """ 
    Vectorized version of the Chinese remainder theorem based on
        https://en.wikipedia.org/wiki/Chinese_remainder_theorem
        https://rosettacode.org/wiki/Chinese_remainder_theorem
    """
    B = prod(b) # common factor
    remainder = sum(diff .* invmod.(B .÷ b, b) .* (B .÷ b)) % B
    return B - remainder
end

diff, bus = collect(zip(ID_bus...))
println("Part Two: ", firstmatch(bus, diff .- 1))