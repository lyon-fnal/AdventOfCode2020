using AdventOfCode2020

using Test

@testset "Day 1" begin
    solution = (538464, 278783190)
    @test AdventOfCode2020.Day01.withLoops() == solution
    @test AdventOfCode2020.Day01.withCombinatorics() == solution
    @test AdventOfCode2020.Day01.withCombinatoricsFaster() == solution
    @test AdventOfCode2020.Day01.byShaping() == solution
end

@testset "Day 2" begin
    solution = (445, 491)
    @test AdventOfCode2020.Day02.withLoops() == solution
    @test AdventOfCode2020.Day02.withDataFrame() == solution
    @test AdventOfCode2020.Day02.likeGoogle() == solution
end

@testset "Day 3" begin
    solution = 3510149120
    @test AdventOfCode2020.Day03.withLoops() == solution
end

@testset "Day 4" begin
    solution = (239, 188)
    @test AdventOfCode2020.Day04.withLoops() == solution
    @test AdventOfCode2020.Day04.withCount() == solution
end

@testset "Day 5" begin
    @test AdventOfCode2020.Day05.processBoardingPass("FBFBBFFRLR") == 357
    @test AdventOfCode2020.Day05.processBoardingPass("BFFFBBFRRR") == 567
    @test AdventOfCode2020.Day05.processBoardingPass("FFFBBBFRRR") == 119
    @test AdventOfCode2020.Day05.processBoardingPass("BBFFBBFRLL") == 820

    solution = (996, 671)
    @test AdventOfCode2020.Day05.withBroadcasting() == solution
    @test AdventOfCode2020.Day05.withParseBase() == solution
end

@testset "Day 6" begin
    solution = (6437, 3229)
    @test AdventOfCode2020.Day06.day06() == solution
end

@testset "Day 7" begin
    solution1 = 144
    solution2 = 5956
    @test AdventOfCode2020.Day07.day07Part1() == solution1
    @test AdventOfCode2020.Day07.day07Part2() == solution2
end
