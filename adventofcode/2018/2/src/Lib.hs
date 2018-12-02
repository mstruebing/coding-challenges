module Lib
    ( someFunc
    , lettersOccurTwoTimes
    , lettersOccurThreeTimes
    , lettersOccurNTimes
    , getMultiplesOfBoxIds
    , getMultiplesOfBoxIdsHelper
    ) where

import Data.List

someFunc :: [String] -> Int
someFunc boxIds = twoOccurences * threeOccurences
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

-- Just for historical reasons :)
-- lettersOccurNTimes emerged from them
lettersOccurTwoTimes :: String -> Bool
lettersOccurTwoTimes boxId = any (== True) [ countLetters boxId c == 2 | c <- boxId ]

lettersOccurThreeTimes :: String -> Bool
lettersOccurThreeTimes boxId = any (== True) [ countLetters boxId c == 3 | c <- boxId ]
