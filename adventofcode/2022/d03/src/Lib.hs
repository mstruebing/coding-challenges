module Lib
  ( splitInHalf,
    findDuplicate,
    getItemPriority,
    first,
  )
where

import Data.List (elemIndex, nub)
import Data.Maybe (fromJust)

type Rucksack = (String, String)

itemList :: String
itemList = ['a' .. 'z'] ++ ['A' .. 'Z']

getItemPriority :: Char -> Int
getItemPriority item = fromJust (elemIndex item itemList) + 1

splitInHalf :: String -> Rucksack
splitInHalf input = (fst, snd)
  where
    (fst, snd) = splitAt (div (length input) 2) input

findDuplicate :: Rucksack -> Char
findDuplicate (fst, snd) = head $ filter (\x -> length (filter (\y -> y == x) snd') > 0) fst'
  where
    -- remove duplicated for performance
    fst' = nub fst
    snd' = nub snd

first :: [String] -> Int
first input = sum $ map (getItemPriority . findDuplicate . splitInHalf) input
