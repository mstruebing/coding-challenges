module Lib
  ( getInput,
    countOccurences,
    run,
    run2,
  )
where

import Data.List (elemIndex)

getInput :: IO String
getInput = readFile "input.txt"

run :: [Char] -> Int
run input = up - down
  where
    up = countOccurences '(' input
    down = countOccurences ')' input

countOccurences :: Char -> [Char] -> Int
countOccurences char = length . filter (== char)

run2 :: [Char] -> Maybe Int
run2 = findIndex

findIndex :: [Char] -> Maybe Int
findIndex input = elemIndex (-1) $ foldl (\acc floorChange -> acc ++ [last acc + floorChange]) [0] list
  where
    list = map (\x -> if x == '(' then 1 else -1) input
