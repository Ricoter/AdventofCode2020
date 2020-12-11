#=
Advent of Code 2020, Day 3
Julia v1.5.3
Rico van Midde
=#

# read data
data = readlines("input/4")

# data to array of passports
passports = [[]]
for line in data
    (line == "") ? push!(passports, []) : union!(passports[end], split(line))
end

# Part 1: check valid passports
valid = 0
for p in passports
    if length(p) == 8
        valid += 1
    elseif length(p) == 7
        keys = [x[1:3] for x in p]
        if "cid" ∉ keys
            valid += 1
        end
    end
end
println("Part one: ", valid)

# Part 2: better check
pdicts = []
for passport in passports
    push!(pdicts, Dict())
    for pair in passport
        key, value = split(pair, ":")
        pdicts[end][key] = value
    end
end


# remove all invalid entries and all cis and count whats left

"""Check if string is integer"""
string_is_int(x) = (tryparse(Int, x) !== nothing)

function isfourdigit(x)
    """Check if input is four digit number"""
    # length
    if length(x) != 4
        return false
    end

    # number
    return string_is_int(x)
end


# check functions
function byr_check(str)
    """Validate Birth Year, returns Bool"""
    # chech digit and size
    isfourdigit(str) ? year = parse(Int, str) : return false

    # check interval
    return (1920 <= year <= 2002)
end

function iyr_check(str)
    """Validate Issue Year, returns Bool"""
    # chech digit and size
    isfourdigit(str) ? year = parse(Int, str) : return false

    # check interval
    return (2010 <= year <= 2020)
end

function eyr_check(str)
    """Validate Expiration Year, returns Bool"""
    # chech digit and size
    isfourdigit(str) ? year = parse(Int, str) : return false

    # check interval
    return (2020 <= year <= 2030)
end

function hgt_check(str)
    """Validate Height, returns Bool"""
    # handle strange size
    if 1e5 <= length(str) <= 1
        return false
    end

    # split number and unit info
    n, unit = str[begin:end-2], str[end-1:end]
    
    # check integer
    string_is_int(n) ? n = parse(Int, n) : return false
    # (n = tryparse(Int, n)) !== nothing ? nothing : return false

    # check unit and interval
    if unit == "cm"
        return (150 <= n <= 193)
    elseif unit == "in"
        return (59 <= n <= 76)
    else
        return false
    end
end

function hcl_check(str)
    """Validate Hair Color, returns Bool"""
    # check length
    if length(str) != 7
        return false
    end

    # check start with #
    if str[begin] != '#'
        return false
    end

    # check hexadecimal
    try 
        hex2bytes(str[begin+1:end])
        return true
    catch
        return false 
    end
end

function ecl_check(str)
    """Validate Eye Color, returns Bool"""
    # check for valid color codes
    return (str ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
end

function pid_check(str)
    """
    Validate pid (Passport ID) 
    - a nine-digit number, including leading zeroes.
    
    returns Boolean
    """
    # check length
    if length(str) !== 9
        return false
    end

    # number
    return string_is_int(str)
end

function entries_check(passport::Dict)
    """Use functions to validate passport, return Bool"""
     # remove cid entry
     if "cid" in keys(passport)
        delete!(passport, "cid")
    end

    # count entries
    if length(passport) != 7
        return false
    end

    # do checks
    if !byr_check(passport["byr"]) return false end
    if !iyr_check(passport["iyr"]) return false end
    if !eyr_check(passport["eyr"]) return false end
    if !hgt_check(passport["hgt"]) return false end
    if !hcl_check(passport["hcl"]) return false end
    if !ecl_check(passport["ecl"]) return false end
    if !pid_check(passport["pid"]) return false end

    return true
end

" check passports "
valid = 0
for pass in pdicts
    if entries_check(pass)
        valid += 1
    end
end
println("Part two: ", valid)