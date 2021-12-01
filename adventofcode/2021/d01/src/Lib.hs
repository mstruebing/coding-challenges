module Lib
    ( getInput
    , calc
    , slice
    , sumSlices
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

getInput :: IO String
getInput = readFile "input.txt"

calc :: [Int] -> Int
calc =  fst . foldr (\curr acc -> if curr < snd acc then (fst acc + 1, curr) else (fst acc, curr) ) (0, 0)

slice :: [Int] -> [[Int]]
slice input =  map (\index -> [input !! index, input !! (index + 1), input !! (index + 2)]) [0 .. (length input - 3)] 

sumSlices :: [[Int]] -> [Int]
sumSlices = map sum
