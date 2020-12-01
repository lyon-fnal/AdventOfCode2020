using AdventOfCode2020

using Test

@testset "Day 1" begin
    @test AdventOfCode2020.Day01.withLoops() == (538464, 278783190)
    @test AdventOfCode2020.Day01.withCombinatorics() == (538464, 278783190)
end