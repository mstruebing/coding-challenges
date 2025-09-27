import { Effect, Schema } from "effect"

const Location = Schema.Tuple(Schema.Number, Schema.Number)
type Location = Schema.Schema.Type<typeof Location>

const LocationList = Schema.Array(Location)
type LocationList = Schema.Schema.Type<typeof LocationList>

export const part1 = (input: string): Effect.Effect<number, string> => {
  return Effect.map(parseInput(input), (locations) => {
    const leftLocations = locations.map(([x, _]) => x).sort()
    const rightLocations = locations.map(([_, y]) => y).sort()

    const result = leftLocations
      .map((v, i) => {
        const rightValue = rightLocations[i]
        return Math.abs(v - rightValue)
      })
      .reduce((a, b) => a + b, 0)

    return result
  })
}

export const part2 = (input: string): Effect.Effect<number, string> => {
  return Effect.map(parseInput(input), (locations) => {
    const leftLocations = locations.map(([x, _]) => x).sort()
    const rightLocations = locations.map(([_, y]) => y).sort()

    const rightLocationsMap = new Map<number, number>()
    rightLocations.forEach((value) => {
      rightLocationsMap.set(value, (rightLocationsMap.get(value) ?? 0) + 1)
    })

    const result = leftLocations.reduce((acc, leftLocation) => {
      return acc + leftLocation * (rightLocationsMap.get(leftLocation) ?? 0)
    }, 0)

    return result
  })
}

const parseInput = (input: string): Effect.Effect<LocationList, string> => {
  const locations: LocationList = input.trim().split("\n").map(splitNumbers)
  const locationList = Schema.encodeSync(LocationList)(locations)
  return Effect.succeed(locationList)
}

const splitNumbers = (input: string): Location => {
  const [x, y] = input
    .trim()
    .split(" ")
    .filter((i) => i.length > 0)
    .map(Number)
  return [x, y]
}
