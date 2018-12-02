module Lib
    ( lettersOccurNTimes
    , getMultiplesOfBoxIds
    , getMultiplesOfBoxIdsHelper
    , calcChecksum
    , findPrototypeFabric
    , differByOnlyOneChar
    , getCommonChars
    ) where

import Data.List

-- neded for part one

calcChecksum :: [String] -> Int
calcChecksum boxIds = twoOccurences * threeOccurences
    where
        twoOccurences = fst $ getMultiplesOfBoxIds boxIds
        threeOccurences = snd $ getMultiplesOfBoxIds boxIds

getMultiplesOfBoxIds :: [String] -> (Int, Int)
getMultiplesOfBoxIds = foldr (\boxId currentCount -> getMultiplesOfBoxIdsHelper boxId currentCount) (0, 0)

getMultiplesOfBoxIdsHelper :: String -> (Int, Int) -> (Int, Int)
getMultiplesOfBoxIdsHelper boxId currentCount 
  | lettersOccurNTimes 2 boxId && lettersOccurNTimes 3 boxId = (fst currentCount + 1, snd currentCount + 1)
  | lettersOccurNTimes 2 boxId = (fst currentCount + 1, snd currentCount)
  | lettersOccurNTimes 3 boxId = (fst currentCount , snd currentCount + 1)
  | otherwise = currentCount

lettersOccurNTimes :: Int -> String -> Bool 
lettersOccurNTimes n boxId = any (==True) [ countLetters boxId c == n | c <- boxId ]

countLetters :: String -> Char -> Int
countLetters str c = length $ filter (== c) str

makeUnique :: String -> String
makeUnique = reverse . nub . reverse

-- needed for part two

findPrototypeFabric :: [String] -> String
findPrototypeFabric xs = stuff $ foldr (\curr acc -> acc ++ (filter (\i -> differByOnlyOneChar i curr) xs )) [""] xs
    where
        stuff x = getCommonChars (x !! 1) (x !! 2) ""

getCommonChars :: String -> String -> String -> String
getCommonChars (x:xs) (y:ys) memorized 
  | (x:xs) == [x] || (y:ys) == [y] = if x == y then memorized ++ [x] else memorized
  | x == y = getCommonChars xs ys $ memorized ++ [x]
  | otherwise = getCommonChars xs ys memorized


differByOnlyOneChar :: String -> String -> Bool
differByOnlyOneChar xs ys = 1 == (length $ filter (== False) $ zipWith (==) xs ys)

-- internal

getRemaingList :: [String] -> String -> [String]
getRemaingList xs elem
  | xs == [] = []
  | otherwise = tail $ dropWhile (\x -> x /= elem) xs
