module Lib
  ( getInput,
    calc,
    getIndexBits,
    getSingleIndexBits,
    getMostCommonBit,
    getLeastCommonBit,
    binaryIntListToDigit,
  )
where

type GammaRate = Int

type EpsilonRate = Int

type DiagnosticReport = [String]

getInput :: IO String
getInput = readFile "input.txt"

calc :: DiagnosticReport -> Int
calc report = binaryIntListToDigit (map getMostCommonBit indexedReport) * binaryIntListToDigit (map getLeastCommonBit indexedReport)
  where
    indexedReport = getIndexBits report

getIndexBits :: DiagnosticReport -> [[Int]]
getIndexBits report = map (getSingleIndexBits report) indexes
  where
    indexes = [0 .. length (head report) - 1]

getSingleIndexBits :: DiagnosticReport -> Int -> [Int]
getSingleIndexBits report index = map (\x -> read [x !! index] :: Int) report

getMostCommonBit :: [Int] -> Int
getMostCommonBit xs = if amountOfOne xs > amountOfZero xs then 1 else 0

getLeastCommonBit :: [Int] -> Int
getLeastCommonBit xs = if amountOfOne xs < amountOfZero xs then 1 else 0

amountOfOne :: [Int] -> Int
amountOfOne = length . filter (== 1)

amountOfZero :: [Int] -> Int
amountOfZero = length . filter (== 0)

-- Don't know what I'm doing here :D - this can be done a lot easier probably
binaryIntListToDigit :: [Int] -> Int
binaryIntListToDigit =
  fst
    . foldr
      (\digit acc -> (fst acc + (digit * 2 ^ (snd acc + 1)), snd acc + 1))
      (0, -1)
