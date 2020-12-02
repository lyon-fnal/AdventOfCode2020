module Day01

using AdventOfCode2020

#= Day 01 Puzzle...

Part 1: Given the input file of numbers, find two numbers in the list that sum to 2020. Return the product of those
two numbers.

Part 2: Same as above, but use three numbers.
=#

""" withLoops()

    Solve day 1 with loops
"""
function withLoops(v::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))

    l = length(v)
    product2 = 0

    for i=1:l-1, j=i+1:l
        if v[i] + v[j] == 2020
            product2 = v[i] * v[j]
            @debug "Found v[$i]=$(v[i]), v[$j]=$(v[j])"
            break
        end
    end

    product3 = 0
    for i=1:l-2, j=i+1:l-1, k=j+1:l
        if v[i] + v[j] + v[k] == 2020
            product3 = v[i] * v[j] * v[k]
            @debug "Found v[$i]=$(v[i]), v[$j]=$(v[j]), v[$k]=$(v[k])"
            break
        end
    end

    return product2, product3
end

#-------------------------

using Combinatorics

""" withCombinatorics()

    Solve day 1 by using the combinatorics package
"""
function withCombinatorics(v::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))
    doubles = combinations(v,2) |> collect
    triples = combinations(v,3) |> collect

    isSum2020(r) = sum(r) == 2020
    sum2 = filter(isSum2020, doubles)
    sum3 = filter(isSum2020, triples)

    @debug "sum2 = $sum2; sum3 = $sum3"

    # Filter returns a list (of length 1)
    return(prod(sum2[1]), prod(sum3[1]))
end

""" withCombinatoricsFaster()

    Solve day 1 by using the combinatorics package. This is from https://github.com/racinmat/advent_of_code_2020/
    and is faster since it doesn't go through the whole list
"""
function withCombinatoricsFaster(v::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))

    prod2 = 0
    prod3 = 0

    for e in combinations(v, 2)
        if sum(e) == 2020
            prod2 = prod(e)
            break
        end
    end

    for e in combinations(v, 3)
        if sum(e) == 2020
            prod3 = prod(e)
            break
        end
    end

    return (prod2, prod3)
end

#--------------------------
""" byShaping()

    Kevin (https://git.sr.ht/~retzkek/aoc20) solved by reshaping the vector
    But there's a possibility of false answers
"""
function byShaping(v::Vector{Int} = readNumbers(Int,joinpath(@__DIR__, "input.txt")))

    sums2  = v .+ v'   # v' == transpose(v)
    prods2 = v .* v'

    answer2 = prods2[ sums2 .== 2020 ]

    # We'll get a false answer if a value + itself == 2020
    # Maybe that doesn't happen
    @assert all(2 .* v != 2020)

    sums3  = v .+ v' .+ reshape(v, 1, 1, :)
    prods3 = v .* v' .* reshape(v, 1, 1, :)

    answer3 = prods3[ sums3 .== 2020 ]

    # This has the same problem as above
    @assert all( 3. * v != 2020)

    # There's another false positive if 2*v[i] + v[j] == 2020  (i != j)
    @assert all( (2 .* v) .+ v' != 2020)

    # For one solution, we'll get two entries for answer2 ( v[i] + v[j], v[j] + v[i] )
    @assert length(answer2) == 2

    # ... and 3! = 6 entries for answer3
    @assert length(answer3) == 6

    return (answer2[1], answer3[1])
end

end  # module