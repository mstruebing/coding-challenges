module Lib
  ( getInput,
    func,
  )
where

getInput :: IO String
getInput = readFile "input.txt"

func :: [Int] -> [Int]
func input = map (\to -> sum $ map (\from -> abs $ from - to) input) input
