module Day05

using AdventOfCode2020

#= Day 5 puzzle...

A plane has 128 rows (numbered 0 -> 127) and 8 columns (0->7).
A boarding pass does binary space partitioning
F = in the lower "half" of rows the plane.
B = in the upper "half" of rows of the plane.
L = in the lower half of columns of the plane.
R = in the upper half of columns of the plane

A Seat ID is row * 8 + column

For example, consider just the first seven characters of FBFBBFFRLR:

Start by considering the whole range, rows 0 through 127.
F means to take the lower half, keeping rows 0 through 63.
B means to take the upper half, keeping rows 32 through 63.
F means to take the lower half, keeping rows 32 through 47.
B means to take the upper half, keeping rows 40 through 47.
B keeps rows 44 through 47.
F keeps rows 44 through 45.
The final F keeps the lower of the two, row 44.

Start by considering the whole range, columns 0 through 7.
R means to take the upper half, keeping columns 4 through 7.
L means to take the lower half, keeping columns 4 through 5.
The final R keeps the upper of the two, column 5.

seat has ID 44 * 8 + 5 = 357.

Some tests...
BFFFBBFRRR: row 70, column 7, seat ID 567.
FFFBBBFRRR: row 14, column 7, seat ID 119.
BBFFBBFRLL: row 102, column 4, seat ID 820.

Part 1: What's the maximum seat ID in the last

Part 2: There's a boarding pass missing. What is it? Note that some seat ids in the very front
and some seat ids at the very back do not exist and will not be in the list. Furthermore, someone
will have the seatId before and after mine

end # Day05
=#

const startRows = 0:127
const startCols = 0:7

function partitionRange(r, lowerPart=true)
    d = last(r) - first(r) + 1
    if lowerPart
        newR = first(r):last(r)-(d÷2)
    else
        # Keep upper part
        newR = first(r)+(d÷2):last(r)
    end
    newR
end

function processBoardingPass(bp)
    rows = startRows
    cols = startCols

    for i in bp  # Loop through the instructions

        if     i == 'F'
            rows = partitionRange(rows, true)  # Partition rows keeping lower part
        elseif i == 'B'
            rows = partitionRange(rows, false) # Partition rows keeping upper part
        elseif i == 'L'
            cols = partitionRange(cols, true)  # Partition columns keeping lower part
        elseif i == 'R'
            cols = partitionRange(cols, false) # Partition columns keeping upper part
        else
            @error "Instruction $i is unknown"
        end
    end

    # We shuld be left with rows and columns with one value each
    @assert first(rows) == last(rows) && first(cols) == last(cols)

    # Calculate the seat ID
    seatId = 8*first(rows) + first(cols)
    return seatId
end

"""withBroadcasting

    Solve day 5 with loops
"""
function withBroadcasting(s=readStrings(joinpath(@__DIR__, "input.txt")))

    seatIds = processBoardingPass.(s)
    maxSeatId = maximum(seatIds)  # Part 1

    minSeatId = minimum(seatIds)

    # Not all seats on the plan exist - instead we have  minSeatId:maxSeatId
    plane = minSeatId:maxSeatId

    # Find missing seat (not elegant, but it'll work)
    missingSeat = -1
    for i in plane
        if ! (i in seatIds) && (i-1 in seatIds) && (i+1 in seatIds)
            missingSeat = i
            break
        end
    end
    @assert missingSeat >= minSeatId

    return maxSeatId, missingSeat
end

# --- Kevin has a very clever way to do this, using parse directly with the base option
# --- https://git.sr.ht/~retzkek/aoc20/tree/master/day05.jl
using Chain

function seat(s)
    @chain s begin
        replace(_, "F"=>"0")  # String version of replace only accepts one pattern
        replace(_, "B"=>"1")
        replace(_, "L"=>"0")
        replace(_, "R"=>"1")
        (parse(Int, _[1:7], base=2), parse(Int, _[8:10], base=2))
    end
end

seatId( (r,c) ) = 8r+c

function withParseBase(s=readStrings(joinpath(@__DIR__, "input.txt")))
    plane = falses(128*8)  # Creates a bit array
    largestId = 0
    for bp in s
        id = bp |> seat |> seatId
        largestId = max(largestId, id)
        plane[id+1] = true
    end

    # Now run through the plane looking for a missing seat will filled seats on each side
    missingSeat = -1
    for i in 0:(largestId-3)
        if plane[i+1:i+3] == [1,0,1]
            missingSeat = i+1
        end
    end

    return (largestId, missingSeat)
end

end # Day05