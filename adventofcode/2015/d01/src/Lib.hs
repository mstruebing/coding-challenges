module Lib
  ( getInput,
    countOccurences,
    run,
  )
where

getInput :: IO String
getInput = readFile "input.txt"

run :: [Char] -> Int
run input = up - down
  where
    up = countOccurences '(' input
    down = countOccurences ')' input

countOccurences :: Char -> [Char] -> Int
countOccurences char = length . filter (== char)
