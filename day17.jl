#=
Advent of Code 2020, Day 17
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/17")

# initialize
cycles = 6
xmax = length(data) + 2cycles
ymax = length(data) + 2cycles
zmax = 1 + 2cycles
wmax = 1 + 2cycles
active, inactive = 1, 0

# fill 3d grid
grid = zeros(Int8, xmax, ymax, zmax)
for (i, line) in enumerate(data)
    for (j, char) in enumerate(line)
        grid[cycles + i, cycles + j, cycles + 1] = (char == '#') ? 1 : 0
    end
end


function active_neighbors(grid, x, y, z)
    """Count active neighbors 3D"""
    xrange = max(1, x-1) : min(x+1, xmax)
    yrange = max(1, y-1) : min(y+1, ymax)
    zrange = max(1, z-1) : min(z+1, zmax)
    return count(grid[xrange, yrange, zrange] .== 1) - grid[x, y, z]
end

function active_neighbors(grid, x, y, z, w)
    """Count active neighbors 4D"""
    xrange = max(1, x-1) : min(x+1, xmax)
    yrange = max(1, y-1) : min(y+1, ymax)
    zrange = max(1, z-1) : min(z+1, zmax)
    wrange = max(1, w-1) : min(w+1, wmax)
    return count(grid[xrange, yrange, zrange, wrange] .== 1) - grid[x, y, z, w]
end

# run cycles
for _ in 1:cycles
    tmp = copy(grid)
    for x in 1:xmax, y in 1:ymax, z in 1:zmax # check every posi
        if grid[x,y,z] == active && active_neighbors(grid, x, y, z) ∉ [2,3]
            tmp[x,y,z] = inactive
        elseif grid[x,y,z] == inactive && active_neighbors(grid, x, y, z) == 3
            tmp[x,y,z] = active
        end
    end
    grid = tmp
end
println("Part One: $(count(grid .== 1))")


# fill 4D grid
grid = zeros(Int8, xmax, ymax, zmax, wmax)
for (i, line) in enumerate(data)
    for (j, char) in enumerate(line)
        grid[cycles + i, cycles + j, cycles + 1, cycles + 1] = (char == '#') ? 1 : 0
    end
end

# run cycles 4D
@time for _ ∈ 1:cycles
    tmp = copy(grid)
    for x ∈ 1:xmax, y ∈ 1:ymax, z ∈ 1:zmax, w ∈ 1:wmax
        if grid[x,y,z,w] == active && active_neighbors(grid, x, y, z, w) ∉ [2,3]
            tmp[x,y,z,w] = inactive
        elseif grid[x,y,z,w] == inactive && active_neighbors(grid, x, y, z, w) == 3
            tmp[x,y,z,w] = active
        end
    end
    grid = tmp
end
println("Part Two: $(count(grid .== 1))")
