import { Effect } from "effect"

const BLINKS_PART_ONE = 25
const BLINKS_PART_TWO = 75

type BlinkOperation = (arg0: string) => string | string[]

interface BlinkOperationMapping {
  0: BlinkOperation
  evenLength: BlinkOperation
  fallback: BlinkOperation
}

const blinkOperationMapping: BlinkOperationMapping = {
  0: (_stone: string) => "1",
  evenLength: (stone: string) => {
    const half = Math.floor(stone.length / 2)
    const firstHalf = stone.slice(0, half)
    const secondHalf = stone.slice(half, stone.length)
    try {
      return [firstHalf, parseInt(secondHalf, 10).toString()]
    } catch (e) {
      console.log("half:", half)
      console.log("firstHalf:", firstHalf)
      console.log("secondHalf:", secondHalf)
      throw new Error(e)
    }
  },
  fallback: (stone: string) => (parseInt(stone, 10) * 2024).toString()
}

export const run = (input: string) =>
  Effect.gen(function* () {
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (input: string): Effect.Effect<void, string> => {
  let stones = parse(input)

  for (let i = 0; i < BLINKS_PART_ONE; i++) {
    stones = stones.flatMap((s) => getBlinkOperation(s)(s))
  }

  return Effect.succeed(stones.length)
}

export const part2 = (input: string): Effect.Effect<void, string> => {
  let stones = parse(input)

  for (let i = 0; i < BLINKS_PART_TWO; i++) {
    stones = stones.flatMap((s) => getBlinkOperation(s)(s))
    console.log("stones.length:", stones.length)
  }

  return Effect.succeed(stones.length)
}

const parse = (input: string): string[] => {
  return input.trim().split(" ")
}

function getBlinkOperation(stone: string): BlinkOperation {
  if (stone === "0") {
    return blinkOperationMapping[0]
  }

  if (stone.length % 2 === 0) {
    return blinkOperationMapping["evenLength"]
  }

  return blinkOperationMapping["fallback"]
}
