module Lib
  ( getInput,
    parsePoint,
    parseLine,
    parseInput,
    getMultiplePointAmount,
    onlyStraightLines,
    getPoints,
    Lines (..),
  )
where

import Data.List (nub, sortBy)

type Point = (Int, Int)

type Line = (Point, Point)

type Lines = [Line]

type Area = [[Int]]

getInput :: IO String
getInput = readFile "input.txt"

getMultiplePointAmount :: Lines -> Int
getMultiplePointAmount lines = length $ filter (>= 2) uniquePointAmount
  where
    uniquePointAmount = map (\point -> length $ filter (== point) sortedPoints) uniquePoints
    -- uniquePoints is slow
    uniquePoints = nub sortedPoints
    sortedPoints = sortBy sortPoint allPoints
    allPoints = concatMap getPoints lines

sortPoint (a1, b1) (a2, b2)
  | a1 < a2 = LT
  | a1 > a2 = GT
  | a1 == a2 = compare b1 b2
  | otherwise = EQ

getPoints :: Line -> [Point]
getPoints ((x1, y1), (x2, y2)) = [(x, y) | x <- [xMin .. xMax], y <- [yMin .. yMax]]
  where
    xMin = min x1 x2
    xMax = max x1 x2
    yMin = min y1 y2
    yMax = max y1 y2

onlyStraightLines :: Lines -> Lines
onlyStraightLines = filter (\((x1, y1), (x2, y2)) -> x1 == x2 || y1 == y2)

parseInput :: [String] -> Lines
parseInput = map parseLine

parseLine :: String -> Line
parseLine input = (startingPoint, endingPoint)
  where
    startingPoint = parsePoint $ takeWhile (/= '-') input
    endingPoint = parsePoint $ tail $ dropWhile (/= '>') input

parsePoint :: String -> Point
parsePoint input = (read firstPart :: Int, read lastPart :: Int)
  where
    firstPart = takeWhile (/= ',') input
    lastPart = tail $ dropWhile (/= ',') input
