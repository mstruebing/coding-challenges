module Main where

import Lib

import Data.Digits (digits, unDigits)

main :: IO ()
main = do
    -- partOne
    partTwo

partOne :: IO ()
partOne = print . take 8 . Lib.calcPhases 100 . parse =<< getInput

partTwo :: IO ()
partTwo = do
    input <- getInput
    let repeatedInput = parse $ repeatInput 10000 input
    let offset = read (take 7 input)::Int
    let result = Lib.calcPhases 100 repeatedInput
    let final = take 8 $ drop offset result
    putStrLn $ show final


getInput :: IO String
getInput = readFile "input1.txt"

repeatInput :: Int -> String -> String
repeatInput repeat input = take (repeat * length trimmedInput) (cycle trimmedInput)
    where
        trimmedInput  = filter (/= '\n') input

parse :: String -> Integer
parse = read
