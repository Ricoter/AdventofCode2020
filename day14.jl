#=
Advent of Code 2020, Day 14
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/14")

# show some data
println(data[begin:3])

bit2int(x) = parse(Int, join(copy(x)), base = 2)
int2bit(x, bits) = split(bitstring(copy(x)), "")[end-copy(bits)+1:end]

# Part One
mem, mask = Dict(), 0
for line in data
    # handle mask
    if startswith(line, "mask")
        mask = split(split(line, "= ")[2], "")
    # handle memory
    else
        key, value = split(line, r"mem\[|\] = ", keepempty=false)
        key = parse(Int, key)
        # to 36-bit
        bitkey = int2bit(parse(Int, value),36)
        # replace all values other than X      
        bitkey[mask .!= "X"] = mask[mask .!= "X"]
        mem[key] = bit2int(bitkey)
    end
end 
println("Part one: $(sum(values(mem)))") 
tmp, tmp2 = [], []

# Part Two
mem = Dict()
for line in data
    
    # handle mask
    if startswith(line, "mask")
        mask = split(split(line, "= ")[2], "")

    # handle memory
    else
        strkey, strvalue = split(line, r"mem\[|\] = ", keepempty=false) # get strings
        intkey, intvalue = parse(Int, strkey), parse(Int, strvalue)     # to int
        bitkey = int2bit(intkey, 36)                                    # to 36-bit
        bitkey[mask .!= "0"] = mask[mask .!= "0"]                       # mask nonzeros

        # loop X combinations
        nbits = count(bitkey .== "X")
        for i in 1:2^nbits
            bitkey[mask .== "X"] = int2bit(i, nbits) # bits to X positions
            mem[bit2int(bitkey)] = intvalue # save
        end
    end
end 
# 1066270758670 < ans < 3186119629059
println("Part Two: $(sum(values(mem)))")