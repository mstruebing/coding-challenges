import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import { part1, part2, solveEquation } from "../src/days/day07.ts"

const SAMPLE_INPUT = `
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
`

describe("day07", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))

      expect(result).toBe(3749)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      expect(result).toBe(undefined)
    })
  })

  describe("solveEquation", () => {
    it("should return true if equation can be solved", () => {
      expect(
        solveEquation({
          result: 190,
          operands: [10, 19]
        })
      ).toBeTruthy()

      expect(
        solveEquation({
          result: 3267,
          operands: [81, 40, 27]
        })
      ).toBeTruthy()

      expect(
        solveEquation({
          result: 292,
          operands: [11, 6, 16, 20]
        })
      ).toBeTruthy()
    })

    it("should return false if equation can't be solved", () => {
      expect(
        solveEquation({
          result: 82,
          operands: [17, 5]
        })
      ).toBeFalsy()

      expect(
        solveEquation({
          result: 156,
          operands: [15, 6]
        })
      ).toBeFalsy()
    })
  })
})
