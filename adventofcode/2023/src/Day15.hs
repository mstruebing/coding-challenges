module Day15 (solve, part1, part2, hash) where

import Data.Char (ord)
import Data.List.Split (splitOn)

solve :: String -> IO ()
solve input = putStrLn "--- Day 15 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 = show . sum . map hash . head .  map  (splitOn ",") . lines

part2 :: String -> String
part2 _ = "Not implemented"

hash :: String -> Int
hash = foldl hashHelper 0

hashHelper :: Int -> Char -> Int
hashHelper currentHash char = mod ((currentHash + ord char)  * 17)  256
