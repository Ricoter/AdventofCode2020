#=
Advent of Code 2020, Day 25     🎄
Julia v1.5.3
Rico van Midde
=#

public = [13316116, 13651422]
# public = [5764801, 17807724] #test

function transform(loopsize, value=1, subject_number=7)
    for i in 1:loopsize
        value *= subject_number
        value %= 20201227   # remainder
    end
    return value
end

function crack(public, value=1)
    loopsize = 0
    while value != public
        value = transform(1, value)
        loopsize += 1
    end
    return loopsize 
end

private = crack.(public)
transform(private[1], 1, public[2])