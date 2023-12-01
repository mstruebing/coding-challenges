module Day01 (solve, part1, part2, getCalibrationValue) where

import Data.Char (isDigit, digitToInt)
import Data.List as List (find)

part1 :: String -> String
part1 = show . sum . map getCalibrationValue . lines

part2 :: String -> String
part2 _ = "Not implemented"

solve :: String -> IO ()
solve input = putStrLn "--- Day XX ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

getCalibrationValue :: String -> Int
getCalibrationValue input = (getFirstDigit input * 10) + getFirstDigit (reverse input)

getFirstDigit :: String -> Int
getFirstDigit input = case List.find isDigit input of
    Just a -> digitToInt a
    Nothing -> error "unexpected"
