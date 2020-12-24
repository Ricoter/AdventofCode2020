using DelimitedFiles
function read_matrix(infile, dlm="")
    """
        Reads any 2D text file into a Matrix (2D Array)
        Similar as readdlm() with 2 added functionalities
        1. also an empty string can be used as delimiter
        2. includes functionality of replace()
        Returns a 2D Matrix
    """
    if dlm == ""
        lines = map(collect, readlines(infile))
        grid = permutedims(hcat(lines...))
    else
        grid = readdlm(infile, dlm)
    end
end

function read_matrix(infile, dlm, replacements)
    """
        Reads any 2D text file into a Matrix (2D Array)
        Similar as readdlm() with 2 added functionalities
        1. also an empty string can be used as delimiter
        2. includes functionality of replace()
        Returns a 2D Matrix
    """
    if dlm == ""
        lines = map(collect, readlines(infile))
        grid = permutedims(hcat(lines...))
    else
        # using DelimitedFiles
        grid = readdlm(infile, dlm)
    end

    swap = Dict(replacements)
    data = [split(line, dlm) for line in readlines(infile)]
    data = [[swap[x] for x in line] for line in data]
    data = permutedims(hcat(data...))
    
    return data
end

# read_matrix("input/17", "", ("#" => 1, "." => 0))
# read_matrix("input/17")