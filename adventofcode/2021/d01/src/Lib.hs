module Lib
  ( getInput,
    calc,
    slice,
    sumSlices,
  )
where

getInput :: IO String
getInput = readFile "input.txt"

calc :: [Int] -> Int
calc =
  fst
    . foldr
      ( \currentDepth (increases, previousDepth) ->
          if currentDepth < previousDepth
            then (increases + 1, currentDepth)
            else (increases, currentDepth)
      )
      (0, 0)

slice :: [Int] -> [[Int]]
slice input =
  map
    (\index -> take 3 $ drop index input)
    [0 .. (length input - 3)]

sumSlices :: [[Int]] -> [Int]
sumSlices = map sum
