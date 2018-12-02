module Main where

import Lib

main :: IO ()
main = do
    putStrLn "PartOne:"
    partOne
    putStrLn "PartTwo:"
    partTwo


partOne :: IO ()
partOne = readFile ("input.txt") >>= print . calcChecksum . lines

partTwo :: IO ()
partTwo = readFile ("input.txt") >>= print . findPrototypeFabric . lines
