module Main where

import Lib

main :: IO ()
main = do
    partOne
    partTwo

partOne :: IO ()
partOne = readFile "input.txt" >>= print . length . reduceOppositePolarityOfSameType

partTwo :: IO ()
partTwo = readFile "input.txt" >>= print . reduceByRemovingMostBlockingUnit . reduceOppositePolarityOfSameType
