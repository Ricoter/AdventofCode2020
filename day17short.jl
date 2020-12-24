"""day17 short version"""
data = permutedims(hcat(map(collect, readlines("input/17"))...)) .== '#' # 2D BitArray
cycles = 6
l = size(data)[1]
xmax = l + 2cycles# init

function play(n)
    grid = falses([xmax for _=1:n]...)              # init n dimensions with zeros
    grid[7:6+L,7:6+L, [10 for _=1:n-2]...] = data   # place data in the centre
    r(i) = max(1, i-1):min(i+1, xmax)               # neighbors
    neighbors(x) = sum(grid[r.(x)...]) - grid[x...] # active neightbors

    for _ in 1:cycles
        M = copy(grid)
        M[grid .== 1] = map(x -> x ∈ [2,3], neighbors.(Tuple.(findall(grid .== 1))))
        M[grid .== 0] = neighbors.(Tuple.(findall(grid .== 0))) .== 3
        grid = M
    end
    
    return sum(grid)
end
@time play.([3,4])


    # function cycle(M, i)
    #     M[grid .== 1] = map(x -> x ∈ [2,3], neighbors.(Tuple.(findall(grid .== 1))))
    #     M[grid .== 0] = neighbors.(Tuple.(findall(grid .== 0))) .== 3
    #     return i < 1 ? cycle(grid=copy(M), 1), M
    # end

    # return sum([(grid = cycle(copy(grid), 6)) for _=1:6][end])