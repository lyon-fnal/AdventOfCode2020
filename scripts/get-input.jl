# Get the input data
# Following https://github.com/cmcaine/advent2020/blob/main/scripts/get-data.jl

# Run from the main AdventOfCode2020 directory.
# julia scripts/get-input.jl 4   # day04 directory should exist

using HTTP

aoc_cookie = read("scripts/cookie", String) |> strip

function get_data(day)
    println("Getting data for day $day")
    response = HTTP.get("https://adventofcode.com/2020/day/$day/input", cookies = Dict("session" => aoc_cookie))
    response.status != 200 && error(response)
    response.body
end

function download_input(day)
    data = get_data(day)
    length(day) == 1 ? day = "0" * day : nothing
    path = joinpath(dirname(@__DIR__), "src/day$day/input.txt")
    println("Writing to $path")
    write(path, data)
end

if abspath(PROGRAM_FILE) == @__FILE__
    download_input(first(ARGS))
end
