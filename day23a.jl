#=
Advent of Code 2020, Day 23
Julia v1.5.3
Rico van Midde
=#

data = [7,1,2,6,4,3,5,8,9]
# data = [3,8,9,1,2,5,4,6,7] # test

function game(x, N)
    m, l = max(x...), length(x)
    for _=1:N
        # insertion value
        next = first(x)
        while next ∈ x[1:4]
            next = mod1(next-1, m)
        end

        # insertion
        i = findfirst(isequal(next), x)
        x = [view(x, 5:i); view(x, 2:4); view(x, i+1:l); view(x, 1)]
    end
    return x
end

# rotate to 1 in the end
@time x = game(data, 100)
i = findfirst(isequal(1), x)
x = circshift(x, -i)
println(join(x)[1:end-1])