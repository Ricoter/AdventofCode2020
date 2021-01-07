#=                                        ___
Advent of Code 2020, Day 24              / ? \
Julia v1.5.3                             \_-_/ 
Rico van Midde                                      
=#
using Plots

function to_hardzero(c::Complex)
    """Hard zero to prevent doubles in Dict"""
    c = round(c, digits=3)                       # round for machine epsilon deviation
    Re = real(c) === -0.0 ? 0.0 : real(c)
    Im = imag(c) === -0.0 ? 0.0 : imag(c)
    return Re + Im*im
end

adj(x) = to_hardzero.(exp.(im*2pi/6*(0:5)) .+ x) # using the complex unit circle in 6 equal pieces 
n_blacks(d) = count(values(d) .== 1)             # 1's are black tiles, -1 is white

data = readlines("input/24")
REF = 0+0im                                      # reference point 
moves = Dict(["e", "ne", "nw", "w", "sw", "se"] .=> adj(REF))

function PartOne()
    """Read data without dilimiters and flip tiles"""
    tiles = Dict()
    for line in data
        
        # read line without delimiters
        x, dir = REF, ""            # position, direction
        for char in line
            dir *= char             # add chars till valid direction
            if dir in keys(moves)
                x += moves[dir]     # move 1 tile
                dir = ""
            end
        end

        # flip tiles
        x = to_hardzero(x)
        x in keys(tiles) ? tiles[x] *= -1 : tiles[x] = 1  # flip/add tile
    end
    return tiles
end

function fill(d::Dict)
    """Fill the hex-grid"""
    r = maximum(abs.(keys(tiles)))  # radius
    r = round(Int, r + 50)          # padding
    diag = 2r+1                     # diagonal

    # upperhalf
    for v in 0:r                    # vertical
        x = r .+ v * moves["nw"]
        for _ in 1:diag-v           # horizontal
            x = to_hardzero(x)
            if x ∉ keys(tiles)
                tiles[x] = -1       # init white
            end
            x += moves["w"]
        end
    end

    # lower half
    for x in conj.(keys(d))         # complex conjugate
        x = to_hardzero(x)
        if x ∉ keys(tiles)
            tiles[x] = -1           # init white
        end
    end
    return tiles
end

function add_gridplot(x)
    scatter(
        x,
        xlim = [-55, 55],
        ylim = [-55, 55],
        title = "Living Art Exhibit at the Lobby",
        marker = (0.5, :hex, 2.5),
        label = false,
        bg = RGB(0.2, 0.2, 0.2)
        )
end

function update(N_sweeps, tiles)
    anim = @animate for i in 1:N_sweeps
        flips = []
        for key in keys(tiles)                                  # keys
            a = []
            for x in adj(key)                                   # adjacents
                x = to_hardzero(x)
                x ∈ keys(tiles) ? append!(a, tiles[x]) : nothing
            end
            blacks = count(a .== 1)
            if tiles[key] == -1
                if blacks == 2
                    append!(flips, [key])
                end
            elseif blacks == 0 || blacks > 2
                append!(flips, [key])
            end
        end
        for x in flips
            tiles[x] *= -1
        end

        blacks = [k for (k,v) in tiles if v == 1]
        println("$i: $(length(blacks))")
        add_gridplot(blacks)
    end every 1
    gif(anim, "day24_TileArt.gif", fps=15)
    return tiles
end

# part 1
tiles = PartOne()
println("Part One: $(n_blacks(tiles))")

# part 2
tiles = fill(tiles)
tiles = update(100, tiles)
println("Part Two: $(n_blacks(tiles))")