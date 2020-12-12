module AdventOfCode2020

using Chain

# Following the structure in https://github.com/goggle/AdventOfCode2019.jl

export readStrings, readNumbers

"""readStrings(path)
    Read in a file at path of one column and return as a String vector
"""
function readStrings(path::String; delim="\n")
    open(path, "r") do file
        s = read(file, String)
        split(strip(s), delim)  # Turn each line into a string row
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

# include dayNN/dayNN.jl
using Printf

for day in 1:25
    dayS = @sprintf("day%02d", day)
    path = joinpath(@__DIR__, "$dayS/$dayS.jl")
    isfile(path) && include(path)
end

# TODO automated benchmarks

end # module
