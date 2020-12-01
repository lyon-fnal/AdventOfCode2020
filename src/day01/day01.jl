module Day01

using AdventOfCode2020

#= Day 01 Puzzle...

Part 1: Given the input file of numbers, find two numbers in the list that sum to 2020. Return the product of those
two numbers.

Part 2: Same as above, but use three numbers.
=#


""" dumbLoops

    Solve day 1 with loops
"""
function withLoops(in::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))

    l = length(in)
    product1 = 0

    for i=1:l-1, j=i+1:l
        if in[i] + in[j] == 2020
            product1 = in[i] * in[j]
            @debug "Found in[$i]=$(in[i]), in[$j]=$(in[j])"
            break
        end
    end

    product2 = 0
    for i=1:l-2, j=i+1:l-1, k=j+1:l
        if in[i] + in[j] + in[k] == 2020
            product2 = in[i] * in[j] * in[k]
            @debug "Found in[$i]=$(in[i]), in[$j]=$(in[j]), in[$k]=$(in[k])"
            break
        end
    end

    return product1, product2
end

#-------------------------

using Combinatorics

""" withCombinatorics

    Solve day 1 by using the combinatorics package
"""
function withCombinatorics(in::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))
    doubles = combinations(in,2) |> collect
    triples = combinations(in,3) |> collect

    isSum2020(r) = sum(r) == 2020
    sum2 = filter(isSum2020, doubles)
    sum3 = filter(isSum2020, triples)

    @debug "sum2 = $sum2; sum3 = $sum3"

    return(prod(sum2[1]), prod(sum3[1]))
end

end  # module