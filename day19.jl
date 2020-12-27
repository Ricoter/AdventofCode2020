#=
Advent of Code 2020, Day 19
Julia v1.5.3
Rico van Midde
=#

SpecialChars = ["a", "b", "(", ")", "|"]            # chars for regex
part = 1                                            # keep track of part

data = readlines("input/19")                        # read data
cut = findfirst(data .== "")                        # cut data at empty line

rules = Dict{Any, Any}(x=>x for x in SpecialChars)  # rules
messages = data[cut+1:end]                          # messages

for line in data[begin:cut-1]                       # fill dict with all rules
    n, r = split(line, ": ")
    rules[n] = (r[1] == '"') ? r[2] : [["("] ; split(r) ; [")"]]
end

function codes(key)
    x = rules[string(key)]

    if x ∈ SpecialChars        # return regex chars
        return x

    elseif part==2 && key=="8" # special rules for part two
        return codes(42)*"+"
    elseif part==2 && key=="11"
        return "(?P<g>$(codes(42))(?&g)?$(codes(31)))" # regex recursion with named group g

    else                                   
        return join(codes.(x)) # increase depth
    end
end

function count_matches(p)
    global part = p
    rZero = Regex("^$(codes(0))\$")                 # regex for rule zero (exact match)
    match(x) = length(collect(eachmatch(rZero, x))) # returns 1 if match
    return sum(match.(messages))                    # count 1's
end

count_matches.([1,2])