# Advent of code 2020 with Julia

See [Advent of code](https://adventofcode.com/2020)

For my solutions, look in the `src` directory and the tests in the `test` directory.

For other solutions, see [Awesome-advent-of-code](https://github.com/Bogdanp/awesome-advent-of-code) ([Julia](https://github.com/Bogdanp/awesome-advent-of-code#julia))

## Benchmarks

```julia
# For example
using BenchmarkTools
@benchmark AdventOfCode2020.Day01.withLoops()
```

| Day | Function | Median time | Memory |
|-----|----------|------------:|-------:|
| 01  | [`withLoops`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day01/day01.jl#L13) | 377 μs | 20 KB |
| 01  | [`withCombinatorics`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day01/day01.jl#L46) | 218 ms | 203 MB |
| 01  | [`withCombinatoricsFaster`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day01/day01.jl#L64) | 27 ms | 73 MB |
| 01  | [`byShaping`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day01/day01.jl#L92) | 32 ms | 123 MB |
| 02  | [`withLoops`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day02/day02.jl#L64) | 1.9 ms | 1.5 MB |
| 02  | [`withDataframe`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day02/day02.jl#L116) | 1.3 ms | 762 MB |
| 02  | [`likeGoogle`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day02/day02.jl#L137) | 773 μs | 539 KB |
| 03  | [`withLoops`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day03/day03.jl#L28) | 374 μs | 176 KB |
| 04  | [`withLoops`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day04/day04.jl#L74) | 3.8 ms | 2.4 MB |
| 04  | [`withCount`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day04/day04.jl#L135) | 857 μs | 100 KB |
| 05  | [`withBroadcasting`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day05/day05.jl#L88) | 421 μs | 129 KB |
| 05  | [`withParseBase`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day05/day05.jl#L116) | 1.6 ms | 1.3 MB |
| 06  | [`day06`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day06/day06.jl#L15) | 2.6 ms | 2.2 MB |
| 07  | [`day07Part1`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day07/day07.jl#L69) | 3.3 ms | 2.1 MB |
| 07  | [`day07Part2`](https://github.com/lyon-fnal/AdventOfCode2020/blob/master/src/day07/day07.jl#L98) | 3.4 ms | 2.0 MB |


Benchmarks performed on

```shell
Julia Version 1.5.3
Platform Info:
  OS: macOS (x86_64-apple-darwin18.7.0)
  CPU: Intel(R) Core(TM) i9-8950HK CPU @ 2.90GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-9.0.1 (ORCJIT, skylake)
  ```
