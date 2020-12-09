#=
Advent of Code 2020, Day 2
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/2") 
println(data[1:3])


# Part 1: Find number of valid passwords
valid = 0
for line in data
    # split  line
    a, b, char, password = split(line, r" |-|: ")

    # count char occurence in password
    n = count(x -> (x == char), split(password, ""))
    
    # count valid passwords
    if (parse(Int, a) <= n <= parse(Int, b))
        valid += 1
    end
end
println(valid)
    

# Part 2: Find number of valid passwords
valid = 0
for line in data
    # split line in substrings
    a, b, char, password = split(line, r" |-|: ")

    # change types
    a, b = parse(Int, a), parse(Int, b) # substring to int
    char = char[1] # substring to char

    # count valid passwords
    (char == password[a]) ? match = 1 : match = 0
    (char == password[b]) ? match += 1 : match += 0
    if (match == 1)
        valid += 1
    end
end
println(valid)

