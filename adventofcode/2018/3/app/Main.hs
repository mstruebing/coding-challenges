module Main where

import Lib

main :: IO ()
main = do
    putStrLn "partOne:"
    partOne

partOne :: IO ()
partOne = do
    input <- readFile "input.txt"
    let inputLines = lines input
    let occupyingCoordinates = concat $ map getOccupyingCoordinates inputLines
    let count = length . filter (\i -> snd i > 1) $ frequency occupyingCoordinates
    print count

-- partTwo :: IO ()
-- partTwo = readFile ("input.txt") >>= print . . lines
