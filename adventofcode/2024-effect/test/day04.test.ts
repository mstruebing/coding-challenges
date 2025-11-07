import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import {
  deserializePosition,
  part1,
  part2,
  serializePosition
} from "../src/days/day04.ts"

const SAMPLE_INPUT = `
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
`

describe("day04", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))

      // expect(result).toBe(18)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      expect(result).toBe(undefined)
    })
  })

  describe("serializePosition", () => {
    it("should correctly serialize", () => {
      expect(serializePosition([0, 0])).toBe("0,0")
      expect(serializePosition([0, 99])).toBe("0,99")
      expect(serializePosition([8, 99])).toBe("8,99")
    })
  })

  describe("deserializePosition", () => {
    it("should correctly deserialize", () => {
      expect(deserializePosition("0,0")).toStrictEqual([0, 0])
      expect(deserializePosition("0,99")).toStrictEqual([0, 99])
      expect(deserializePosition("8,99")).toStrictEqual([8, 99])
    })
  })
})
