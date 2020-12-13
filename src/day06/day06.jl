module Day06

using AdventOfCode2020

#= Day 6 puzzle...

Part1:
A group is seprated by blank lines. Each group has codes for answering questions. Count the
unique questions in each group and sum the counts.

Part2:
Each line is a person in a group. Count the questions that everyone said yes to
=#

""" day06()

Loop over the groups and sum the number of questions answered
"""
function day06(s=readStrings(joinpath(@__DIR__, "input.txt"), delim="\n\n"))
    countQuestions(g) = collect(g) |> unique .|> isletter |> sum
    part1 = countQuestions.(s) |> sum

    function countForAll(g)
        sets = split(g, "\n") |> collect
        ∩(sets...) |> length    # ∩ (\cap) is intersect
    end
    part2 = countForAll.(s) |> sum

    return part1,part2
end

end # Day06