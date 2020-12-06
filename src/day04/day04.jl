module Day04

using AdventOfCode2020

#= Day 4 puzzle...

We need to evaluate "passports", in a file. A passport is a group of lines with codes:value pairs.
These pairs my be arranged in any way over lines in the group.
Passports are separated by a blank line.

There are eight codes, seven of which are required...
byr (birth year)
iyr (issue year)
eyr (expiration year)
hgt (height with units)
hcl (hair color in rgb)
ecl (eye color)
pid (passport id)
cid (country id) -- OPTIONAL

Part 1: Count the number of valid passports in the input file

Part 2: We now have to validate the values for the codes
byr (Birth Year) - four digits; at least 1920 and at most 2002.
iyr (Issue Year) - four digits; at least 2010 and at most 2020.
eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
hgt (Height) - a number followed by either cm or in:
If cm, the number must be at least 150 and at most 193.
If in, the number must be at least 59 and at most 76.
hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
pid (Passport ID) - a nine-digit number, including leading zeroes.
cid (Country ID) - ignored, missing or not.

This one stymied me for awhile ... turns out I needed to add ^ and $
    to the regex for the hcl and pid checks.

end # Day04
=#

# We're going to use regexes to match and capture
const requiredCodes = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
const optionalCodes = ["cid"]

function checkHeight(v)
    # Strip off the last two characters
    if length(v) <= 2
        return false
    end

    units = last(v, 2)
    val = parse(Int, v[1:end-2])

    if units == "cm"
        good = 150 <= val <= 193
    elseif units == "in"
        good = 59 <= val <= 76
    else
        good = false
    end

    return good
end

checks = Dict()
checks["byr"] = v -> length(v) == 4 && 1920 <= parse(Int, v) <= 2002
checks["iyr"] = v -> length(v) == 4 && 2010 <= parse(Int, v) <= 2020
checks["eyr"] = v -> length(v) == 4 && 2020 <= parse(Int, v) <= 2030
checks["hgt"] = v -> checkHeight(v)
checks["hcl"] = v -> !isnothing( match(r"^#[0-9a-f]{6}$", v))
checks["ecl"] = v -> v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
checks["pid"] = v -> !isnothing( match(r"^[0-9]{9}$", v) )

"""withLoops

    Solve day 4 with loops
"""
function withLoops(s=readStrings(joinpath(@__DIR__, "input.txt")))

    # Build regexes for the required codes
    # Note that r"$c:" doesn't work because r"" does not do interpolation
    # \S is non-whitespace
    rgxs = [ Regex("$(c):(\\S+)") for c in requiredCodes ]
    rgxsS = [r.pattern for r in rgxs]  # Will need this later
    sort!(rgxsS)

    # Let's put in a blank line at the end of the string vector if it doesn't have one
    # This will trigger end of a passport block for the last one
    if s[end] != ""
        push!(s, "")
    end

    # Loop over the lines of the input and process
    # Perhaps being extra careful - I could just count the number of matches per line,
    # but if a code is repeated on separate lines, then that will count as an extra match
    # and I'll get a false valid passport. [Turns out this doesn't matter]
    #
    # Need to check that the right codes are indeed present.
    #
    d = Dict()  # Keep track of what matched
    nValidPart1 = 0  # Just check that required codes are there
    nValidPart2 = 0  # Check values
    nSeen = 0
    for l in s
        if l != ""
            # Match what we can on this line
            matches = match.(rgxs, l)
            foreach(m -> isnothing(m) ? nothing : d[m.regex.pattern] = m, matches)
        else
            # Blank line - so we have a new passport
            nSeen += 1

            # The keys in d need to match the required regexes
            if sort( [k for k in keys(d)] ) == rgxsS
                nValidPart1 += 1

                # Check the contents
                # Do we have repeats? This will not find repeat on a different line
                @assert all( [ length(v.captures) == 1 for (k,v) in d] )

                contentsValid = [ checks[ first(k, 3) ](v.captures[1]) for (k,v) in d ]
                @assert length(contentsValid) == 7
                ( all(contentsValid) ) && (nValidPart2 += 1)

            end
            d = Dict()
        end
    end

    return nValidPart1, nValidPart2
end

# Try a test case
testCase1 = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

using Test
@test withLoops(split(testCase1, "\n")) == (2,2)

# TODO  Try this with Automa.jl  - See https://julialang.zulipchat.com/#narrow/stream/265470-advent-of-code/topic/Solutions.20day.2004/near/218814830

end # Day04