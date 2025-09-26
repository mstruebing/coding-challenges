import { describe, expect, it } from "@effect/vitest"
import { Effect } from "effect"

import { part1, part2 } from "../src/days/<DAY>.ts"

const SAMPLE_INPUT = `
`

describe("<DAY>", () => {
  describe("part1", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part1(SAMPLE_INPUT))

      expect(result).toBe(undefined)
    })
  })

  describe("part2", () => {
    it("should return the correct result for sample input", async () => {
      const result = Effect.runSync(part2(SAMPLE_INPUT))

      expect(result).toBe(undefined)
    })
  })
})
