import { Effect } from "effect"

type RawDiskMap = number[]
type DiskMap = Array<number | "empty">

export const run = (input: string) =>
  Effect.gen(function* () {
    const solution1 = yield* Effect.runFork(part1(input))
    console.log("Part 1:", solution1)
    const solution2 = yield* Effect.runFork(part2(input))
    console.log("Part 2:", solution2)
  })

export const part1 = (input: string): Effect.Effect<number, string> => {
  const rawDiskMap = parse(input)
  const diskMap = prepareDiskMak(rawDiskMap)
  const processedDiskMap = processDiskMap(diskMap)
  const checksum = calculateChecksum(processedDiskMap)

  return Effect.succeed(checksum)
}

export const part2 = (input: string): Effect.Effect<void, string> => {
  const rawDiskMap = parse(input)
  const diskMap = prepareDiskMak(rawDiskMap)
  const processedDiskMap = processDiskMap2(diskMap)
  const _checksum = calculateChecksum(processedDiskMap)

  return Effect.succeed(undefined)
}

function parse(input: string): RawDiskMap {
  return input
    .trim()
    .split("")
    .map((c) => parseInt(c, 10))
}

function prepareDiskMak(rawDiskMap: RawDiskMap): DiskMap {
  return rawDiskMap.flatMap((v, index) => {
    if (index % 2 === 0) {
      return new Array(v).fill(index / 2)
    }
    return new Array(v).fill("empty" as const)
  })
}

function processDiskMap(diskMap: DiskMap): DiskMap {
  let firstEmptyIndex = diskMap.findIndex((i) => i === "empty")
  let lastNonEmptyIndex = diskMap.findLastIndex((i) => i !== "empty")

  while (firstEmptyIndex < lastNonEmptyIndex) {
    diskMap[firstEmptyIndex] = diskMap[lastNonEmptyIndex]
    diskMap[lastNonEmptyIndex] = "empty"

    firstEmptyIndex = diskMap.findIndex((i) => i === "empty")
    lastNonEmptyIndex = diskMap.findLastIndex((i) => i !== "empty")
  }

  return diskMap
}

function calculateChecksum(diskMap: DiskMap): number {
  return diskMap.reduce((acc: number, curr, index) => {
    if (curr !== "empty") {
      return acc + curr * index
    }

    return acc
  }, 0)
}

function processDiskMap2(diskMap: DiskMap): DiskMap {
  return diskMap
}
