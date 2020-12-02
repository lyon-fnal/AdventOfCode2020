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
| 01  | `withLoops` | 377 μs | 20 KB |
| 01  | `withCombinatorics` | 218 ms | 203 MB |
| 01  | `withCombinatoricsFaster` | 27 ms | 73 MB |
| 01  | `byShaping` | 32 ms | 123 MB |