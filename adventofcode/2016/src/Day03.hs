{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module Day03 (solve, part1, part2, possible, parseLine, parseSecond, Triangle) where

import Data.List (sort)
import Data.List.Split (chunksOf)

type Triangle = (Int, Int, Int)

solve :: String -> IO ()
solve input = putStrLn "--- Day 03 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1  = show . length . filter id .  map (possible . parseLine) . lines

part2 :: String -> String
part2  = show . length . filter id . map possible . parseSecond . lines

possible :: Triangle -> Bool
possible (x,y,z) = x + y > z

parseLine :: String -> Triangle
parseLine  =  (\[x, y,z] -> (x,y,z)) . sort . map read . words

parseSecond :: [String] -> [Triangle]
parseSecond =
    map ((\[x, y, z] -> (x, y, z)) . sort) . 
    chunksOf 3 .
    concat .
    foldl (\[first,second,third] (x,y,z) -> [first ++ [x], second ++ [y], third ++ [z]]) [[], [], []]  .
    map ((\[x, y,z] -> (read x, read y, read z)) . words )

