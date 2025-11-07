import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import { part1, part2 } from "../src/days/day09.ts"

const SAMPLE_INPUT = `
2333133121414131402
`

describe("day09", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))

      expect(result).toBe(1928)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      // expect(result).toBe(2858)
      expect(result).toBe(undefined)
    })
  })
})
