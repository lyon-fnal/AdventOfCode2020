module Day03

using AdventOfCode2020
using Chain

addStep!(pos, step) = ( pos[1] += step[1]; pos[2] += step[2] )
isTree(m, pos) = m[pos[1], pos[2]]

function doRun(aStep, trees)
    nRows, nCols = size(trees)
    pos = [1,1]  # starting position
    run = Bool[]

    for _ in 1:(nRows ÷ aStep[1])-1
        addStep!(pos, aStep)

        # Are we still on the map?
        if pos[2] > nCols
            pos[2] = mod(pos[2], nCols)  # Wrap around
        end

        # Check
        push!(run, isTree(trees, pos))
    end
    sum(run)
end

""" withLoops()

    Solve day 3
"""
function withLoops(s=readStrings(joinpath(@__DIR__, "input.txt")))

    # Turn the map, which is an array of strings, into a matrix with true if there's a tree and false
    # otherwise
    nRows = length(s)
    nCols = first(s) |> length

    trees = @chain s begin
        collect.(_)  # Convert to characters
        vcat(_...)  # Turn into a long column
        _ .== '#'   # Turn into bitmap where the trees are
        reshape(_, nCols, nRows) # Julia fills columns first (!!!)
        _'  # transpose to match the map
    end

    # a step is [down, right]
    theSteps = [ [1,1], [1,3], [1,5], [1,7], [2,1] ]

    # Do the runs
    trees = map(s -> doRun(s, trees), theSteps)

    prod(trees)
end

end # Day03