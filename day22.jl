#=
Advent of Code 2020, Day 22
Julia v1.5.3
Rico van Midde
=#

data = readlines("input/22")
p1, p2 = data[2:26], data[29:53]
p1, p2 = map.(x -> parse(Int, x), [p1,p2])

score(x) = sum(x .* collect(length(x):-1:1))


"""Part One"""

while length(p1) > 0 && length(p2) > 0
    if p1[1] > p2[1]
        p1 = [circshift(p1, -1); popfirst!(p2)]
    else
        p2 = [circshift(p2, -1); popfirst!(p1)]
    end
end

# weights = collect(50:-1:1)
# win = sum(weights .* (length(p1) == 0 ? p2 : p1))
println("Part One: ", sum(score.([p1, p2])))

p1, p2 = data[2:26], data[29:53]
p1, p2 = map.(x -> parse(Int, x), [p1,p2])

# testinput
# p1, p2 = [43, 19], [2, 29, 14]
# p1, p2 = [9, 2, 6, 3, 1], [5, 8, 4, 7, 10] # 291

function game(p1, p2)
    prev_hash = []
    while true
        # return winner
        if length(p1) == 0
            return (2, copy(p2))
        elseif length(p2) == 0
            return (1, copy(p1))
        end

        # Inf game prevention rule
        (h =hash([p1,p2])) ∉ prev_hash ? append!(prev_hash, h) : (return (1, copy(p1)))

        # play round
        if p1[1] <= length(p1)-1 && p2[1] <= length(p2)-1 # recursive game
            if game(p1[2:p1[1]+1], p2[2:p2[1]+1])[1] == 1
                p1 = [circshift(p1, -1); popfirst!(p2)]
            else
                p2 = [circshift(p2, -1); popfirst!(p1)]            
            end
        elseif p1[1] > p2[1]                              # normal game
            p1 = [circshift(p1, -1); popfirst!(p2)]
        else
            p2 = [circshift(p2, -1); popfirst!(p1)]
        end
    end
end

# Part two 9404 < ans
score(game(p1, p2)[2])
