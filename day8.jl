#=
Advent of Code 2020, Day 8
Julia v1.5.3
Rico van Midde
=#

# read input
data = readlines("input/8")
println(data[1:3])

# [operations, arguments] => instructions
global instructions = [split(line) for line in data]

# globals that instructions can manipulate
global idx = 1
global accValue = 0

# executions
function accumulator(arg)
    """ adds arg to global accumulator """
    global accValue += arg
    global idx += 1
end

function jumps(arg)
    """ jump to next instruction by given arg"""
    global idx += arg
end

function noOperation(arg)
    """ do nothing, go to next instruction"""
    global idx += 1
end

function init_globals()
    global idx = 1
    global accValue = 0
end

# combine execution functions in dict
exe= Dict("acc" => accumulator, "jmp" => jumps, "nop" => noOperation)

# run executions till repetition or end of lines
idxList = []
while idx ∉ idxList && idx <= length(instructions)
    append!(idxList, idx)
    op, arg = instructions[idx]
    # println(instructions[idx], idx)
    if idx == 627
        op = "nop"
    end
    arg = parse(Int, arg)
    exe[op](arg)
end

println("Part one: $accValue")

println(sort(idxList))
println(maximum(idxList))
println(length(instructions))

function runchangesindex(i)
    init_globals()
    opmap = Dict("acc"=>"acc", "nop"=>"jmp", "jmp"=>"nop")

    # run executions till repetition or end of lines
    idxList2 = []
    while idx ∉ idxList2 && idx <= length(instructions)
        append!(idxList2, idx)
        op, arg = instructions[idx]
        # println(instructions[idx], idx)
        if idx == i
            op = opmap[op]
        end
        arg = parse(Int, arg)
        exe[op](arg)
    end
    # return true if succes
    return idx > length(instructions)
endinst

# try all changes for previous index list
for i in idxList
    # if change is succes print accumulator value
    if runchangesindex(i)
        println("Part two: $accValue")
    end
end