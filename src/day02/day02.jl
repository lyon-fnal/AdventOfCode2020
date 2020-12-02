module Day02

using AdventOfCode2020
using Chain

#= Day 02 Puzzle...

A text file has rules for passwords and the passwords themselves. E.g.

1-5 e: akljeeqe

The first column is the number of allowed instances of the "key letter" in the password (e.g. 1-5 means 1,2,3,4, or 5).
The second column is the key letter. The third is the password itself.

Count the number of rows where the password meets the requirements specified by the first two columns.

The second part is to treat the first column as two positions in the password for which the key letter
    must be in one, and only one, of them. So for the example, e must be in position 1 or 5 of the
    password, but not both.

The painful part of this puzzle is dealing with the annoying data format.
Turning the key letter and password into characters (not strings) gives some convenience.
=#

""" loadInput(path)

    Load the input file at path

    Input string has format,
    Allowed Range, character, password
    e.g.
    1-5 q: abqqjdq

    Turn this into
    allowed range, key character, password (as character array)
    e.g.
    1:5 q abqqjdq

"""
function loadInput(path::String)
    s = readStrings(path)
    words = split.(s)  # now we have an array of arrays

    # Deal with the allowed ranges
    ar = @chain words begin
        first.(_)  # Grab the first entry in each row
        split.(_, "-")
        map(r -> parse(Int, r[1]):parse(Int, r[2]), _)
    end

   keyLetter = @chain words begin
        map(r -> r[2], _)  # Pull out 2nd entry in each row
        replace.(_, ":" => "")  # Remove uneeded character
        collect.(_)             # String -> Char
        only.(_)                # e.g. ['e'] -> 'e'
    end

    return ar, keyLetter, last.(words)
end
# Google at https://github.com/goggle/AdventOfCode2020.jl/blob/master/src/day02/day02.jl
# does the above with regular expressions, which is clearly the better way to do it
# though using chains is more fun

""" withLoops()

    Solve day 2
"""
function withLoops(path::String=joinpath(@__DIR__, "input.txt"))
    withLoops( loadInput(path)... )  # Note the splat
end


""" withLoops()

    Solve day 2 with the three columns as arguments
"""
function withLoops(nAllowed, keyLetter, password)
    @assert length(nAllowed) == length(keyLetter) == length(password)

    # Part 1
    nValid1  = 0
    for i in eachindex(nAllowed)  # Loop through the rows
        n = count(r->(r==keyLetter[i]), collect(password[i]))
        if n in nAllowed[i]
            nValid1 += 1
        end
    end

    # Part 2
    nValid2 = 0
    for i in eachindex(nAllowed)  # Loop through the rows

        # Find the positions of the key letter in the password
        pos = @chain password[i] begin
            findall(==(keyLetter[i]), _)  # Returns array of positions
                                          # Having these as characters is convenient. If they
                                          # were strings, would get ranges of positions (less useful here)
        end

        # Check if any of the found positions match the edges of the allowed range
        isFirst = nAllowed[i][1] in pos
        isLast  = nAllowed[i][end] in pos

        # @debug string(password[i]), string(keyLetter[i]), pos, nAllowed[i], isFirst, isLast
        # Either, but not both, of isFirst and isSecond must be true
        if (isFirst || isLast) && !(isFirst && isLast)
            nValid2 += 1
            # @debug "good"
        end
    end

    (nValid1, nValid2)
end

# TODO Would be interesting and more elegant to try this with data frames

end # module