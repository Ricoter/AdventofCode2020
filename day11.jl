#=
Advent of Code 2020, Day 11
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/11")

# show some data
println(data[1:3])

# to 2d array
grid = [split(x, "") for x in data]
grid = reduce(hcat, grid)

X, Y = size(grid)

function neighbours(i,j)

    n = 0
    for di in i-1:i+1, dj in j-1:j+1
        # within limits
        if 0 < di <= X && 0 < dj <= Y
            # count neighbours
            if grid[di, dj] == "#" && (di, dj) != (i, j)
                n += 1
            end
        end
    end
    return n
end

function sweep(grid)
    # copy grid
    newgrid = copy(grid)
    for i in 1:X, j in 1:Y
        if grid[i,j] == "#" && neighbours(i,j) >= 4
            newgrid[i,j] = "L"
        elseif grid[i,j] == "L" && neighbours(i,j) == 0
            newgrid[i,j] = "#"
        end
    end
    if newgrid == grid
        return (true, newgrid)
    end
    return (false, newgrid)
end

function show2d(M)
    a, b = size(M)
    for i in 1:a
        for j in 1:b
            print(M[i,j])
        end
        println("")
    end
    println("")
end

same = false
while same != true
    same, grid = sweep(grid)
    # show2d(grid)
end

println("Part one: ", count(grid .== "#"))



# to 2d array
grid = [split(x, "") for x in data]
grid = reduce(hcat, grid)



function farneighbours(i,j)
    n = 0
    for di in i-1:i+1, dj in j-1:j+1
        # within limits
        if 0 < di <= X && 0 < dj <= Y && (di, dj) != (i, j)
            # skip "."
            vi, vj = di-i, dj-j
            while grid[di,dj] == "." && 0 < di+vi <= X && 0 < dj+vj <= Y
                di += vi
                dj += vj
            end
            # count neighbours
            if (grid[di, dj] == "#") 
                n += 1
            end
        end
    end
    return n
end


function sweep2(grid)
    # copy grid
    newgrid = copy(grid)
    for i in 1:X, j in 1:Y
        if grid[i,j] == "#" && farneighbours(i,j) >= 5
            newgrid[i,j] = "L"
        elseif grid[i,j] == "L" && farneighbours(i,j) == 0
            newgrid[i,j] = "#"
        end
    end
    if newgrid == grid
        return (true, newgrid)
    end
    return (false, newgrid)
end


same = false
while same != true
    same, grid = sweep2(grid)
    # show2d(grid)
end

println("Part two: ", count(grid .== "#"))