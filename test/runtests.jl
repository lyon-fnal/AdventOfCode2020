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
end