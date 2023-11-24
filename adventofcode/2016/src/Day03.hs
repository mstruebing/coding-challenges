module Day03 (solve, part1, part2, possible, parseLine) where

import Data.List (sort)

type Triangle = (Int, Int, Int)

solve :: String -> IO ()
solve input = putStrLn "--- Day 03 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1  = show . length . filter id .  map (possible . parseLine) . lines

part2 :: String -> String
part2 _ = "Not implemented"


possible :: Triangle -> Bool
possible (x,y,z) = x + y > z

parseLine :: String -> Triangle
parseLine  =  (\[x, y,z] -> (x,y,z)) . sort . map read . words 
