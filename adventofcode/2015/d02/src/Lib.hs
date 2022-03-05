module Lib
  ( getInput,
    parse,
    parseSingle,
    calculateSingle,
    calculate,
    calculate2,
    calculateSingle2,
  )
where

import Data.List (elemIndex, sort)

getInput :: IO String
getInput = readFile "input.txt"

type Dimensions = (Int, Int, Int)

parse :: [String] -> [Dimensions]
parse = map parseSingle

parseSingle :: String -> Dimensions
parseSingle input = (read first, read second, read third)
  where
    first = takeWhile (/= 'x') input
    second = takeWhile (/= 'x') $ tail $ dropWhile (/= 'x') input
    third = tail $ dropWhile (/= 'x') $ tail $ dropWhile (/= 'x') input

calculate :: [Dimensions] -> Int
calculate = sum . map calculateSingle

calculateSingle :: Dimensions -> Int
calculateSingle (l, w, h) = 2 * a + 2 * b + 2 * c + smallest
  where
    a = l * w
    b = w * h
    c = h * l
    smallest = minimum [a, b, c]

--

calculate2 :: [Dimensions] -> Int
calculate2 = sum . map calculateSingle2

calculateSingle2 :: Dimensions -> Int
calculateSingle2 (a, b, c) = stuff + stuff2
  where
    rest = init $ sort [a, b, c]
    stuff = sum $ map (* 2) rest
    stuff2 = product [a, b, c]
