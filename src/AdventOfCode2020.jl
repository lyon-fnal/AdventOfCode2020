module AdventOfCode2020

using Chain

# Following the structure in https://github.com/goggle/AdventOfCode2019.jl

export readStrings, readNumbers

"""readStrings(path)
    Read in a file at path of one column and return as a String vector
"""
function readStrings(path::String)
    open(path, "r") do file
        s = read(file, String)
        split(strip(s), "\n")  # Turn each line into a string row
    end
end

""" readNumbers(T, path)

    Read in a file at path of one column and turn contents into a vector of numbers of type T

    valuesVector = readNumbers(Int, "/path/to/my/input.txt")
"""
function readNumbers(::Type{T}, path::String) where T <: Number
    @chain readStrings(path) begin
        parse.(T, _)
    end
end

# TODO Make the below better
include("Day01/day01.jl")
include("Day02/day02.jl")

# TODO automated benchmarks

end # module
