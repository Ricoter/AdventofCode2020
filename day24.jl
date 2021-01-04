#=
Advent of Code 2020, Day 24
Julia v1.5.3
Rico van Midde
=#

data = readlines("input/24t")

xy(degree) = Float16[cos(degree), sin(degree)]

move = Dict("se"=>xy(-pi/4),"ne"=>xy(pi/4),"sw"=>xy(-3pi/4),"nw"=>xy(3pi/4),"e"=>xy(0),"w"=>xy(2pi))
blackTiles = Dict()
start = [0,0]

for line in data
    
end