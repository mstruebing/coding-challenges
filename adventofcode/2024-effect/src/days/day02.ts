import { Effect, Schema } from "effect"

const Report = Schema.Array(Schema.Number)
type Report = Schema.Schema.Type<typeof Report>

const Reports = Schema.Array(Report)
type Reports = Schema.Schema.Type<typeof Reports>

export const run = (input: string) =>
  Effect.gen(function* () {
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (input: string): Effect.Effect<void, string> => {
  return Effect.map(parseInput(input), (reports) => {
    return reports.filter(
      (report) =>
        (allDecreasing(report) || allIncreasing(report)) &&
        isValidDifference(report)
    ).length
  })
}

export const part2 = (_input: string): Effect.Effect<void, string> => {
  return Effect.succeed(undefined)
}

export const allDecreasing = (report: Report) =>
  report.every((num, i, arr) => (i === 0 ? true : num < arr[i - 1]))

export const allIncreasing = (report: Report) =>
  report.every((num, i, arr) => (i === 0 ? true : num > arr[i - 1]))

export const isValidDifference = (report: Report) => {
  for (let i = 1; i < report.length; i++) {
    const diff = Math.abs(report[i] - report[i - 1])
    if (diff > 3 || diff === 0) {
      return false
    }
  }

  return true
}

export const parseInput = (input: string): Effect.Effect<Reports, string> => {
  const reports: Reports = input
    .trim()
    .split("\n")
    .map((line) =>
      line
        .trim()
        .split(" ")
        .filter((i) => i.length > 0)
        .map(Number)
    )

  const reportList = Schema.encodeSync(Reports)(reports)
  return Effect.succeed(reportList)
}
