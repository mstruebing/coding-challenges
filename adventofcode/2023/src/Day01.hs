module Day01 (solve, part1, part2, getCalibrationValue, getCalibrationValueEnhanced) where

import Data.Char (isDigit, digitToInt)
import Data.List as List (find, isPrefixOf)

solve :: String -> IO ()
solve input = putStrLn "--- Day 01 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 = show . sum . map getCalibrationValue . lines

part2 :: String -> String
part2 = show . sum . map getCalibrationValueEnhanced . lines

-- part 1

getCalibrationValue :: String -> Int
getCalibrationValue input = getFirstDigit input * 10 + getFirstDigit (reverse input)

getFirstDigit :: String -> Int
getFirstDigit input = case List.find isDigit input of
    Just a -> digitToInt a
    Nothing -> error "unexpected"

-- part 2

getCalibrationValueEnhanced :: String -> Int
getCalibrationValueEnhanced input = getFirstDigitEnhanced input * 10  + getLastDigitEnhanced (reverse input)

getFirstDigitEnhanced :: String -> Int
getFirstDigitEnhanced [] = 0
getFirstDigitEnhanced (x:xs)
    | isDigit x = digitToInt x
    | otherwise = if isAnyNumberStringPrefix (x:xs)
            then getNumberFromString (x:xs)
            else getFirstDigitEnhanced xs

getLastDigitEnhanced :: String -> Int
getLastDigitEnhanced [] = 0
getLastDigitEnhanced (x:xs)
    | isDigit x = digitToInt x
    | otherwise = if isAnyNumberStringPrefixReversed (x:xs)
            then getNumberFromStringReversed (x:xs)
            else getLastDigitEnhanced xs


-- I bet there are better ways to do it in reverse
isAnyNumberStringPrefix :: String -> Bool
isAnyNumberStringPrefix input =  any (`isPrefixOf` input) numbers

isAnyNumberStringPrefixReversed :: String -> Bool
isAnyNumberStringPrefixReversed input =  any ((`isPrefixOf` input) . reverse) numbers


getNumberFromString :: String -> Int
getNumberFromString input = head [ mapStringNumberToInt x | x<- numbers, x `isPrefixOf` input]

getNumberFromStringReversed :: String -> Int
getNumberFromStringReversed input = head [ mapStringNumberToInt $ reverse x | x<- map reverse numbers, x `isPrefixOf` input]


mapStringNumberToInt :: String -> Int
mapStringNumberToInt "one" = 1
mapStringNumberToInt "two" = 2
mapStringNumberToInt "three" = 3
mapStringNumberToInt "four" = 4
mapStringNumberToInt "five" = 5
mapStringNumberToInt "six" = 6
mapStringNumberToInt "seven" = 7
mapStringNumberToInt "eight" = 8
mapStringNumberToInt "nine" = 9
mapStringNumberToInt _ = error "undefined input"

numbers :: [String]
numbers =
    [ "one"
    , "two"
    , "three"
    , "four"
    , "five"
    , "six"
    , "seven"
    , "eight"
    , "nine"
    ]
