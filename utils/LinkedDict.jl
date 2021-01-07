#=
Implementation of an Array with:
- insertion time O(1)
- indexing time O(n)
=#
module DataTypes
    export LinkedDict, to_array

    # Array to FastArray 
    function LinkedDict(x)
        """
            Dict where the elements of the array are keys
            and the value point to the next element (key)
            
            - Circular: last -> first
            - Convertion time Array <-> LinkedDict: O(n)
        """
        d = Dict(x[i] => x[mod1(i+1, length(x))] for i=1:length(x))
        d[begin] = first(x)
        return d
    end

    # to array O(n)
    function to_array(x::fArray)
        array = [x.d[x.first]]
        for _ in 1:length(x)
            append!(array, x.d[array[end]])
        end
        return array
    end

    # indexing O(n)
    # iterator O(1) per 'next'
    # iterate(x::FastArray) = 

end

using .DataTypes

a = collect(1:10)
fa = FastArray(a)
Array(fa)