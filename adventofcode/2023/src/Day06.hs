module Day06 (solve, part1, part2) where

import Data.List.Split (splitOn)
import Data.Char (isDigit)

solve :: String -> IO ()
solve input = putStrLn "--- Day 06 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 input = show $ product $ map winningCombination $ parse input

part2 :: String -> String
part2 _ = "Not implemented"

-- (Time, Distance)
type Race = (Int, Int)
type Races = [Race]

winningCombination :: Race -> Int
winningCombination (time, distance) =  highest - lowest + 1
    where
        lowest = head [seconds | seconds <- [1..time], seconds * (time - seconds) > distance]
        highest = head [seconds | seconds <- reverse [1..time], seconds * (time - seconds) > distance]

parse :: String -> Races
parse input = zip times distances
    where
        times =  parseLine $ head $ lines input
        distances = parseLine $ head $ tail $ lines input
        parseLine = map read . filter (/= "") . splitOn " " . dropWhile (not . isDigit)

