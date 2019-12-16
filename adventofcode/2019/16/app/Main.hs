module Main where

import Lib

main :: IO ()
main = do
    -- partOne
    partTwo

partTwo :: IO ()
partTwo = print . parse . repeatInput 1000 =<< getInput

partOne :: IO ()
partOne = print . take 8 . Lib.calcPhases 100 . read =<< getInput

getInput :: IO String
getInput = readFile "input.txt"

repeatInput :: Int -> String -> String
repeatInput repeat input = take (repeat * length trimmedInput) (cycle trimmedInput)
    where
        trimmedInput  = filter (/= '\n') input

parse :: String -> Integer
parse = read
