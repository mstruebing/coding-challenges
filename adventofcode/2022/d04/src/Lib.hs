module Lib
  ( someFunc,
    parseLine,
    parseSingle,
    parse,
    isSubset,
    first,
  )
where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

type Assignment = [Int]

type Assignments = (Assignment, Assignment)

parse :: [String] -> [Assignments]
parse = map parseLine

parseLine :: String -> Assignments
parseLine input = (parseSingle first, parseSingle second)
  where
    first = takeWhile (\x -> x /= ',') input
    second = tail $ dropWhile (\x -> x /= ',') input

parseSingle :: String -> Assignment
parseSingle input = [read first :: Int .. read second :: Int]
  where
    first = takeWhile (\x -> x /= '-') input
    second = tail $ dropWhile (\x -> x /= '-') input

first :: [Assignments] -> Int
first assignments = length $ filter (== True) $ map isSubset assignments

isSubset :: Assignments -> Bool
isSubset (fst, snd) = firstSubsetOfSecond || secondSubsetOfFirst
  where
    firstSubsetOfSecond = firstFirst >= secondFirst && firstLast <= secondLast
    secondSubsetOfFirst = firstFirst <= secondFirst && firstLast >= secondLast
    firstFirst = head fst
    firstLast = last fst
    secondFirst = head snd
    secondLast = last snd
