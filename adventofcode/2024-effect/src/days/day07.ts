import { Effect } from "effect"

interface Equation {
  result: number
  operands: number[]
}

type Operator = "*" | "+"

const Operator = {
  "+": "+" as const,
  "*": "*" as const,
  "||": "||" as const
}

export const run = (input: string) =>
  Effect.gen(function* () {
    // normalize lodash at runtime (see top of file)
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (input: string): Effect.Effect<number, string> => {
  const equations = parse(input).filter(solveEquation)
  const result = equations.reduce((acc, curr) => {
    return acc + curr.result
  }, 0)
  return Effect.succeed(result)
}

export const part2 = (_input: string): Effect.Effect<void, string> => {
  return Effect.succeed(undefined)
}

function parse(input: string): Equation[] {
  const lines = input.split("\n").filter((i) => i.length > 0)

  const equations: Equation[] = lines.map((line) => {
    const [result, operands, ..._rest] = line.split(":")

    return {
      result: parseInt(result),
      operands: operands
        .split(" ")
        .filter((i) => i.length > 0)
        .map((i) => parseInt(i))
    }
  })

  return equations
}

export function solveEquation({ result, operands }: Equation): boolean {
  const operatorCombinations = getAllOperatorCombinations(operands.length)

  return operatorCombinations.some((ops) => {
    return calc(operands, ops) === result
  })
}

function getAllOperatorCombinations(operands: number): Operator[][] {
  const positions = Math.max(0, operands - 1)
  const total = 1 << positions
  const result: Operator[][] = []

  for (let mask = 0; mask < total; mask++) {
    const ops: Operator[] = []
    for (let i = 0; i < positions; i++) {
      ops.push(mask & (1 << i) ? Operator["*"] : Operator["+"])
    }
    result.push(ops)
  }

  return result
}

function calc(operands: Equation["operands"], operators: Operator[]): number {
  let result: number = 0

  operands.forEach((o, index) => {
    if (index === 0) {
      result = o
      return
    }

    switch (operators[index - 1]) {
      case Operator["+"]: {
        result = result + o
        break
      }
      case Operator["*"]: {
        result = result * o
        break
      }
    }
  })

  return result
}
