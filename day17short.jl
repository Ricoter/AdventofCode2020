"""day17 short version"""
data = permutedims(hcat(map(collect, readlines("input/17"))...)) .== '#' # 2D BitArray

l = size(data)[1]  # data length
xmax = l + 12      # data length + 2 sweeps

function play(n)
    prev = grid = falses([xmax for _=1:n]...)       # nd BitArray with 0's
    grid[7:6+l,7:6+l, [10 for _=1:n-2]...] = data   # copy data to centre

    r(i) = max(1, i-1):min(i+1, xmax)               # first neighbors within boundary
    neighbors(x) = sum(prev[r.(x)...]) - prev[x...] # active neightbors

    for _ in 1:6            
        prev = copy(grid)
        grid[prev .== 1] = in.(neighbors.(Tuple.(findall(prev .== 1))), [[2,3]]) # update 1's
        grid[prev .== 0] = in.(neighbors.(Tuple.(findall(prev .== 0))), [3])     # update 0's
    end
    
    return sum(grid) # count 1's
end
@time play.([3,4]) # run 3D and 4D