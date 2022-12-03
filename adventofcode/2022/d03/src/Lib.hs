module Lib
  ( splitInHalf,
    findDuplicate,
    getItemPriority,
    first,
    splitForEleves,
    findDuplicateBadges,
    second,
  )
where

import Data.List (elemIndex, nub)
import Data.List.Split (chunksOf)
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

------------------------------
-- Part 2
------------------------------

type RucksackWithBadges = (String, String, String)

splitForEleves :: [String] -> [RucksackWithBadges]
splitForEleves input = map (\[x, y, z] -> (x, y, z)) $ chunksOf 3 input

findDuplicateBadges :: RucksackWithBadges -> Char
findDuplicateBadges (fst, snd, trd) = head same
  where
    same = findDuplicate' (sameInFirstAndSecond, third)
    sameInFirstAndSecond = findDuplicate' (first, second)
    first = nub fst
    second = nub snd
    third = nub trd

findDuplicate' :: Rucksack -> [Char]
findDuplicate' (fst, snd) = filter (\x -> length (filter (\y -> y == x) snd') > 0) fst'
  where
    -- remove duplicated for performance
    fst' = nub fst
    snd' = nub snd

second :: [String] -> Int
second input = sum $ map getItemPriority $ map findDuplicateBadges $ splitForEleves input
