#=
Advent of Code 2020, Day 5
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/5")

# mapping function
codemap = Dict('B' => '1', 'F' => '0', 'R' => '1', 'L' => '0')
to_binary(x) = codemap[x]
to_int(x) = parse(Int, map(to_binary, x), base = 2)

# find sead ID's
seat_ID = []
for line in data
    rowcode = line[begin:begin+6]
    colcode = line[end-2:end]
    row, col = to_int(rowcode), to_int(colcode)
    push!(seat_ID, row * 8 + col)
end
println("Part one: ", maximum(seat_ID))


sort!(seat_ID)

# find missing number
lo = minimum(seat_ID)
hi = maximum(seat_ID)
all_seats = lo : hi
my_seat = [x for x in all_seats if x ∉ seat_ID] 
println("Part two: ", my_seat)
