import { Effect } from "effect"

export const run = (input: string) =>
  Effect.gen(function* () {
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (_input: string): Effect.Effect<void, string> => {
  return Effect.succeed(undefined)
}

export const part2 = (_input: string): Effect.Effect<void, string> => {
  return Effect.succeed(undefined)
}
