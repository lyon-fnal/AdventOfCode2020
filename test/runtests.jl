using AdventOfCode2020

using Test

@testset "Day 1" begin
    solution = (538464, 278783190)
    @test AdventOfCode2020.Day01.withLoops() == solution
    @test AdventOfCode2020.Day01.withCombinatorics() == solution
    @test AdventOfCode2020.Day01.withCombinatoricsFaster() == solution
    @test AdventOfCode2020.Day01.byShaping() == solution
end