import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import {
  part1,
  part2,
  allIncreasing,
  allDecreasing,
  isValidDifference
} from "../src/days/day02.ts"

const SAMPLE_INPUT = `
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
`

const PARSED_SAMPLE_INPUT = SAMPLE_INPUT.trim()
  .split("\n")
  .map((line) =>
    line
      .trim()
      .split(" ")
      .filter((i) => i.length > 0)
      .map(Number)
  )

describe("day02", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))
      expect(result).toBe(2)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      expect(result).toBe(undefined)
    })
  })

  describe("allIncreasing", () => {
    it("should return true for increasing sequences", () => {
      expect(allIncreasing(PARSED_SAMPLE_INPUT[0])).toBe(false)
      expect(allIncreasing(PARSED_SAMPLE_INPUT[1])).toBe(true)
      expect(allIncreasing(PARSED_SAMPLE_INPUT[2])).toBe(false)
      expect(allIncreasing(PARSED_SAMPLE_INPUT[3])).toBe(false)
      expect(allIncreasing(PARSED_SAMPLE_INPUT[4])).toBe(false)
      expect(allIncreasing(PARSED_SAMPLE_INPUT[5])).toBe(true)
    })
  })

  describe("allDecreasing", () => {
    it("should return true for decreasing sequences", () => {
      expect(allDecreasing(PARSED_SAMPLE_INPUT[0])).toBe(true)
      expect(allDecreasing(PARSED_SAMPLE_INPUT[1])).toBe(false)
      expect(allDecreasing(PARSED_SAMPLE_INPUT[2])).toBe(true)
      expect(allDecreasing(PARSED_SAMPLE_INPUT[3])).toBe(false)
      expect(allDecreasing(PARSED_SAMPLE_INPUT[4])).toBe(false)
      expect(allDecreasing(PARSED_SAMPLE_INPUT[5])).toBe(false)
    })
  })

  describe("isValidDifference", () => {
    it("should return true for valid sequences", () => {
      expect(isValidDifference(PARSED_SAMPLE_INPUT[0])).toBe(true)
      expect(isValidDifference(PARSED_SAMPLE_INPUT[1])).toBe(false)
      expect(isValidDifference(PARSED_SAMPLE_INPUT[2])).toBe(false)
      expect(isValidDifference(PARSED_SAMPLE_INPUT[3])).toBe(true)
      expect(isValidDifference(PARSED_SAMPLE_INPUT[4])).toBe(false)
      expect(isValidDifference(PARSED_SAMPLE_INPUT[5])).toBe(true)
    })
  })
})
