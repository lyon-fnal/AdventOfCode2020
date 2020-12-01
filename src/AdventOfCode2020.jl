module AdventOfCode2020

using Chain

# Following the structure in https://github.com/goggle/AdventOfCode2019.jl

export readNumbers

""" readNumbers(T, path)

    Read in a file at path of one column and turn contents into a vector of numbers of type T

    valuesVector = readNumbers(Int, "/path/to/my/input.txt")
"""
function readNumbers(::Type{T}, path::String) where T <: Number
    out = open(path, "r") do file
        @chain read(file, String) begin
            split
            parse.(T, _)
        end
    end
    return out
end

# TODO Do this better later
include("Day01/day01.jl")

# TODO Do benchmarks

end # module
