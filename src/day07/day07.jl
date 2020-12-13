module Day07

using AdventOfCode2020

#= Day 07 puzzle

light red bags contain 1 bright white bag, 2 muted yellow bags

Need to parse lines like the above and find all the combinations of bags
that can hold a shiny gold bag
=#

const holderRx = r"^(.+) bags"
const holdeeRx = r"^(\d+) (.+) bag"

struct bag
    style::String  # Style of the bag
    n::Int         # Number of bags it can hold
end

function parseBags(l)

    # Split the holder/holdee at "contain"
    holderHoldeeS = split(l, " contain ")
    holderM = match(holderRx, holderHoldeeS[1])
    holder = holderM.captures[1]

    # Does this bag not hold anything?
    if holderHoldeeS[2] == "no other bags."
        holdeesS = []
    else
        # Split the holdees
        holdeesS = split(holderHoldeeS[2], ", ")
    end

    return holder, holdeesS
end

function parseHoldee(holdeeS)
    holdeeM = match(holdeeRx, holdeeS)
    n = parse(Int, holdeeM.captures[1])
    holdee = holdeeM.captures[2]

    return n, holdee
end

function findHolders(key, d)
    holders = []
    if haskey(d, key)
        # Now look up the holders
        for holder in d[key]
            push!(holders, holder.style)
            append!(holders, findHolders(holder.style, d))
        end
    end
    holders
end

function findHoldees(key, d)
    n = 1
    if haskey(d, key)
        for holdee in d[key]
            n += holdee.n * findHoldees(holdee.style, d)
        end
    end
    return n
end

function day07Part1(s=readStrings(joinpath(@__DIR__, "input.txt")))

    # Need to build a kind of dictionary to say what bags can hold what other bags,
    # and then be able to search backwards.
    # There is metadata too (the # of bags that can be held).

    # Parse the bags
    d = Dict()
    for l in s
        holder, holdeesS = parseBags(l)
        # Loop over the holdees
        for holdeeS in holdeesS
            n, holdee = parseHoldee(holdeeS)

            # Put this in the dictionary
            if haskey(d, holdee)
                push!(d[holdee], bag(holder, n))
            else
                d[holdee] = [bag(holder, n)]
            end
        end
    end

    # Data are loaded into dictionary
    # The key is the holdee. The values are the bags that can hold (the holder) the holdee
    # We need to do a recursive scan through the dictionary and count
    findHolders("shiny gold", d) |> unique |> length
end

function day07Part2(s=readStrings(joinpath(@__DIR__, "input.txt")))

    # Now we keep track of what bags hold
    # Parse the bags
    d = Dict()
    for l in s
        holder, holdeesS = parseBags(l)
        # Loop over the holdees
        for holdeeS in holdeesS
            n, holdee = parseHoldee(holdeeS)

            # Put this in the dictionary
            if haskey(d, holder)
                push!(d[holder], bag(holdee, n))
            else
                d[holder] = [bag(holdee, n)]
            end
        end
    end

    findHoldees("shiny gold", d) - 1

end

end # Day07

# using AdventOfCode2020
# @show pwd()
# AdventOfCode2020.Day07.day07Part2(readStrings("src/day07/testInput.txt"))