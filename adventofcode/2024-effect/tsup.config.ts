import { defineConfig } from "tsup"

export default defineConfig({
  entry: ["src/aoc.ts"],
  clean: true,
  publicDir: true,
  treeshake: "smallest",
  external: ["@parcel/watcher"]
})
