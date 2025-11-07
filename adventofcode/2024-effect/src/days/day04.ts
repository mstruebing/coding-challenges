import { Effect } from "effect"

type Position = [number, number]

type Matrix = Map<string, string>

export const run = (input: string) =>
  Effect.gen(function* () {
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (input: string): Effect.Effect<number, string> => {
  const matrix = parse(input)
  const amount = getXmasAmounts(matrix)

  return Effect.succeed(amount)
}

export const part2 = (_input: string): Effect.Effect<void, string> => {
  return Effect.succeed(undefined)
}

function parse(input: string): Matrix {
  const matrix: Matrix = new Map()

  input.split("\n").forEach((line, row) => {
    line.split("").forEach((char, column) => {
      matrix.set(serializePosition([row - 1, column]), char)
    })
  })

  return matrix
}

function getXPositions(matrix: Matrix): Position[] {
  const positions: Position[] = []

  for (const [position, char] of matrix.entries()) {
    if (char === "X") {
      positions.push(deserializePosition(position))
    }
  }

  return positions
}

function getXmasAmounts(matrix: Matrix): number {
  const xPositions = getXPositions(matrix)
  const validSurroundings = checkSurroundings(matrix, xPositions)

  // TODO: Needs to keep track of the direction
  // currently it ignores the direction the word is written in

  return validSurroundings
}

function checkSurroundings(matrix: Matrix, xPositions: Position[]): number {
  const results = xPositions.reduce((acc, [x, y]) => {
    const possibleSurroundings: Position[] = [
      [x + 1, y],
      [x - 1, y],
      [x, y + 1],
      [x, y - 1],
      [x + 1, y + 1],
      [x + 1, y - 1],
      [x - 1, y + 1],
      [x - 1, y - 1]
    ]

    const withM = possibleSurroundings.filter((pos) => {
      return matrix.get(serializePosition(pos)) === "M"
    })

    console.error("withM:", withM)

    const withA = withM.filter((pos) => {
      return matrix.get(serializePosition(pos)) === "A"
    })
    console.error("withA:", withA)

    const withS = withA.filter((pos) => {
      return matrix.get(serializePosition(pos)) === "S"
    })
    console.error("withS:", withS)

    return acc + withS.length
  }, 0)

  return results
}

export function serializePosition(pos: Position): string {
  const [x, y] = pos
  return `${x},${y}`
}

export function deserializePosition(raw: string): Position {
  const [x, y, ..._rest] = raw.split(",")
  return [parseInt(x), parseInt(y)]
}

function removeDuplicates(positions: Position[]): Position[] {
  return Array.from(new Set(positions.map(serializePosition))).map(
    deserializePosition
  )
}

function getPossibleSurroundings([x, y]: Position): Position[] {
  const possibleSurroundings: Position[] = [
    [x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1],
    [x + 1, y + 1],
    [x + 1, y - 1],
    [x - 1, y + 1],
    [x - 1, y - 1]
  ]

  return possibleSurroundings
}
