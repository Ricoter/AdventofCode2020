#=
Advent of Code 2020, Day 7
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/7")

# println(data[1:3])

# make dictionary of outer/inner bags
bagsmapping = Dict()
for line in data
    outer, inners = split(line, " bags contain ")
    inners = split(inners, r" bags?(, |\.)", keepempty=false)
    bagsmapping[outer] = [split(x, " ", limit=2) for x in inners]
end

# println(bagsmapping)

function golddigger(key, bagsmapping)
    """Recursively search for shiny gold bags"""

    # check every bag in the given bag
    for x in bagsmapping[key]
        # only return if goldbag is found 
        if x[2] == "other"
            continue
        elseif x[2] == "shiny gold"
            return true 
        elseif golddigger(x[2], bagsmapping)
            return true
        end
    end
    # only return false if all bags are checked without succes
    return false     
end

# check all bags
n = [golddigger(x, bagsmapping) for x in keys(bagsmapping) if x != "shiny gold"]
println("Part one: $(sum(n)) shiny gold bags found")



function nbagsinside(key, bagsmapping, n)
    """Recursively search for number of bags inside given bag"""
    for x in bagsmapping[key]
        if x[2] == "other"
            return n
        else
            n += parse(Int, x[1]) * nbagsinside(x[2], bagsmapping, 1)
        end
    end
    return n
end

totalnbags = nbagsinside("shiny gold", bagsmapping, 0)
println("Part two: $totalnbags")