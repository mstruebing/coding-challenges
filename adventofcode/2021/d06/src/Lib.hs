module Lib
  ( getInput,
    calc,
    calcNextDay,
  )
where

getInput :: IO String
getInput = readFile "input.txt"

calc :: Int -> [Int] -> Int
calc days list = length $ foldl (\acc _ -> calcNextDay acc) list [0 .. days - 1]

calcNextDay :: [Int] -> [Int]
calcNextDay [] = []
calcNextDay (x : xs) = newTimer : end
  where
    end = if x == 0 then 8 : calcNextDay xs else calcNextDay xs
    newTimer = if x == 0 then 6 else x - 1
