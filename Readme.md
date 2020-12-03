# Advent of code 2020

See https://adventofcode.com/2020

For my solutions, look in the `src` directory and the tests in the `test` directory.

For other solutions, see https://github.com/Bogdanp/awesome-advent-of-code ([Julia](https://github.com/Bogdanp/awesome-advent-of-code#julia))

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

Benchmarks performed on
```
Julia Version 1.5.3
Platform Info:
  OS: macOS (x86_64-apple-darwin18.7.0)
  CPU: Intel(R) Core(TM) i9-8950HK CPU @ 2.90GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-9.0.1 (ORCJIT, skylake)
  ```