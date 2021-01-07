#=
Advent of Code 2020, Day 21
Julia v1.5.3
Rico van Midde
=#

data = readlines("input/21")
data = split.(data, r" \(contains |, |\)", keepempty=false)

el = []
d = Dict()
for line in data
    crypt = split(line[begin])
    for x in line[2:end]
        d[x] = x ∉ keys(d) ? [crypt] : [d[x]; [crypt]] 
    end
    append!(el, crypt)
end

matches(x) = [e for e in x[1] if all(e .∈ [x;])]

x = matches.(collect(values(d))) # possible matches per allegens
x = [(x...)...] # to splatted array
non_allegences = filter(e -> e ∉ x, el)
println("Part One: $(length(non_allegences))")

allergens = matches.(collect(values(d))) # possible matches per allegens

while !all(length.(allergens) .== 1)
    for (i, x) in enumerate(allergens), (j, y) in enumerate(allergens)
        if i !== j && length(x) == 1 && length(y) > 1
            filter!(e -> e != x[1], y)
        end
    end
end
pairs = [(collect(keys(d))[i], allergens[i][1]) for i=1:length(d)]
# str = join(sort(pairs))
# reg = replace(str, r"(|\\|\"| |)" => "")
x = [x[2] for x in sort!(pairs)]
println("Part Two: ", join(x, ","))