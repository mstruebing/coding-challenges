#!/usr/bin/env node

import { Command, FileSystem } from "@effect/platform"
import { NodeContext, NodeRuntime } from "@effect/platform-node"
import Commander from "commander"
import { Effect, pipe } from "effect"

// TODO: Use @effect/cli
const program = new Commander.Command()

program
  .option("-d, --day <number>", "specify the day as a number")
  .option("-n --new", "create an empty day")
  .option("-f, --force", "force creation even if files exist")
  .option("--test", "run the tests")

program.parse(process.argv)

const options = program.opts()

const TEMAPLTE_PATH = "src/.template"

const getDay = (opts: typeof options): Effect.Effect<string, Error> => {
  if (opts.day) {
    const day = parseInt(opts.day, 10)
    if (isNaN(day) || day < 1 || day > 25) {
      return Effect.fail(
        new Error(
          "Invalid day provided. Please provide a valid number between 1 and 25."
        )
      )
    } else {
      return Effect.succeed(day.toString().padStart(2, "0"))
    }
  } else {
    return Effect.fail(new Error("No day provided."))
  }
}

const cliApp = Effect.gen(function* () {
  const fs = yield* FileSystem.FileSystem
  const day = yield* getDay(options)

  if (options.new) {
    const dayPath = `src/days/day${day}.ts`
    const testPath = `test/day${day}.test.ts`
    const inputsPath = `inputs/day${day}.txt`

    const dayExists = yield* fs.exists(dayPath)
    const testExists = yield* fs.exists(testPath)
    const inputExists = yield* fs.exists(inputsPath)

    if (!options.force && (dayExists || testExists || inputExists)) {
      return yield* Effect.fail(
        new Error(
          `src, test or input for day ${day} already exists. Choose a different day or cleanup manually.`
        )
      )
    }

    dayExists && options.force && (yield* fs.remove(dayPath))
    testExists && options.force && (yield* fs.remove(testPath))
    inputExists && options.force && (yield* fs.remove(inputsPath))

    yield* copyFile(`${TEMAPLTE_PATH}/day.ts`, dayPath)
    yield* copyFile(`${TEMAPLTE_PATH}/test.ts`, testPath)
    yield* replaceInFile(testPath, "<DAY>", `day${day}`)
    yield* createFile(inputsPath)

    return yield* Effect.succeed(0)
  }

  if (options.test) {
    const exitCode = yield* Command.make(
      "npm",
      "run",
      "test",
      `day${day.toString()}`
    ).pipe(
      Command.stdout("inherit"),
      Command.stderr("inherit"),
      Command.exitCode
    )

    if (exitCode !== 0) {
      return yield* Effect.fail(
        new Error(`Tests failed with exit code ${exitCode}`)
      )
    }
    return yield* Effect.succeed(exitCode)
  }

  const input = yield* fs.readFile(`inputs/day${day}.txt`)

  const program = yield* Effect.tryPromise(() => import(`./days/day${day}.ts`))
  yield* Effect.runFork(program.run(input.toString()))
})

NodeRuntime.runMain(
  Effect.scoped(cliApp).pipe(Effect.provide(NodeContext.layer))
)

const copyFile = (
  src: string,
  dest: string
): Effect.Effect<void, Error, FileSystem.FileSystem> => {
  return pipe(
    FileSystem.FileSystem,
    Effect.flatMap((fs) => fs.copy(src, dest))
  )
}

const replaceInFile = (file: string, from: string, to: string) => {
  return pipe(
    FileSystem.FileSystem,
    Effect.flatMap((fs) =>
      Effect.gen(function* () {
        const content = yield* fs.readFileString(file)
        const updatedContent = content.replace(new RegExp(from, "g"), to)
        yield* fs.writeFile(file, Buffer.from(updatedContent))
      })
    )
  )
}

const createFile = (path: string) => {
  return pipe(
    FileSystem.FileSystem,
    Effect.flatMap((fs) => fs.writeFile(path, Buffer.from("")))
  )
}
