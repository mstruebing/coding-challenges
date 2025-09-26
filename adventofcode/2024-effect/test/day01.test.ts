import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import { part1, part2 } from "../src/days/day01.ts"

const SAMPLE_INPUT = `
3   4
4   3
2   5
1   3
3   9
3   3
`

describe("day1", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))

      expect(result).toBe(11)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      expect(result).toBe(31)
    })
  })
})
