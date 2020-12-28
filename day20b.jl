#=
Advent of Code 2020, Day 19                           # 
Julia v1.5.3                        #    ##    ##    ###
Rico van Midde                       #  #  #  #  #  #   
=#

data = readlines("input/20")
datacuts = [[1]; findall(data .== "") .+ 1]
monster =  permutedims(hcat([split(x,"") for x in readlines("input/20SeaMonster")]...)) .== "#"

to_BitArray(x) = permutedims(hcat(map(collect, x)...)) .== '#'   # '#'?1:0
edges(x) = [x[1,1:10], x[1:10,10], x[10,1:10], x[1:10,1]]        # clockwise

function data2dict(data)
    dict = Dict()
    for i in datacuts
        header = data[i]
        tile_number = header[6:9]
        tile_number = parse(Int, tile_number)
        grid = data[i+1:i+10]
        grid = to_BitArray(grid)    
        grid = Array(grid)          # 10x10 Array{Bool,2}
        dict[tile_number] = grid
    end
    return dict
end
tiles = data2dict(data)

function remove_matches(tiles)
    for x in edges(values(tiles)), y in edges(values(tiles)) #<< does not combine with filter
        for i in x, j in y
            if x ≠ y && (i == j || i == reverse(j)) # del matching edges
                filter!(e->e≠i,x)
                filter!(e->e≠j,y)
            end
        end 
    end
    return tiles
end

opposite(i) = (i+1)%4+1

function find_match(a, b)
    """
        args:
            a - used tile key
            b - unused tile key
        returns coordinate tuple if there is a match else false

        ~compares edges of a with edges of b for a match
        ~while comparing, tile b is rotated and flipped
        ~since b is a pointer its automatically updated in tiles
    """
    pos = [(-1,0), (0,1), (1,0), (0,-1)]        # relative position of tile b to a, NESW    <<<<<<<<<<<<
    for (i, edge) in enumerate(edges(tiles[a]))
        for _ = 1:4                         
            tiles[b] = rotr90(tiles[b])         # 4x rotate
            for _ = 1:2                    
                tiles[b] = transpose(tiles[b])  # 2x flip
                if edge == edges(tiles[b])[opposite(i)]
                    return pos[i]
                end
            end
        end
    end     
    return false
end

function remove_zero_padding(A)
    coordinates = findall(A .!= 0)
    b, e = coordinates[begin], coordinates[end]
    return A[b[1]:e[1],b[2]:e[2]]
end

function puzzle_time(tiles)
    """returns complete puzzle"""
    puzzle = zeros(Int, 30, 30)                         # too large grid
    puzzle[10,10] = collect(tiles)[1][1]                # with random tile in the centre
    while count(puzzle .!= 0) < length(tiles)           # loop till all tiles are used
        used = puzzle[puzzle .!= 0]                     # list used / unused tiles
        unused = filter(e -> e∉used, keys(tiles)) 

        # find element of used in dict also for reversed
        # rotate and reverse inside original tile dict
        # so that all tiles are in correct orientation

        for x in used, y in unused                      # get 2 keys from used and tiles
            relpos = find_match(x,y)
            if relpos != false
                current_pos = Tuple(findall(puzzle .== x)[1]) #+ pos error if findall returns more <<<<<<<<<<<<
                newpos = current_pos .+ relpos
                puzzle[newpos...] = y
                break
            end
        end
    end
    return remove_zero_padding(puzzle)
end

function make_img(puzzle)
    size = 12
    img = falses(8size,8size)
    for i=0:size-1, j=0:size-1
        ID = puzzle[i+1,j+1]
        position = 8i+1:8i+8,8j+1:8j+8
        img[position...] = tiles[ID][2:9,2:9]
    end
    return img
end

function find_monsters(img)
    """sliding window"""
    mimg = falses(size(img))              # img with only monsters
    for _ = 1:4                         
        global monster = rotr90(monster)         # 4x rotate
        for _ = 1:2                    
            monster = transpose(monster)  # 2x flip
            for i=1:size(img)[1]-size(monster)[1],j=1:size(img)[2]-size(monster)[2]
                position = i:i+size(monster)[1]-1,j:j+size(monster)[2]-1
                if all(img[position...][monster])
                    mimg[position...] = monster
                end
            end
        end
    end
    return mimg 
end
# Part One
# data |> data2dict |> remove_matches |> multiply_corners

img = data |> data2dict |> puzzle_time |> make_img 
mimg = find_monsters(img)
println("Part Two: ", count(img) - count(mimg))