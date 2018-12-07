module Lib
    ( reduceOppositePolarityOfSameType
    , reduceByRemovingMostBlockingUnit
    ) where

import Data.Char
import Data.List

reduceOppositePolarityOfSameType :: String -> String
reduceOppositePolarityOfSameType = foldr (\curr acc -> react $ [(curr)] ++ acc) ""

react :: String -> String
react [] = []
react (x:xs) 
  | x == '\n' = []
  | xs == [] = [x]
  | isLower x = if head xs == toUpper x then tail xs else x:xs
  | isUpper x = if head xs == toLower x then tail xs else x:xs

reduceByRemovingMostBlockingUnit :: String -> Int
reduceByRemovingMostBlockingUnit xs = minimum [ length $ reduceOppositePolarityOfSameType $ filter (\x -> toLower x /= u) xs | u <- extractUnits xs ]

extractUnits :: String -> String
extractUnits = reverse . nub . reverse . sort . map toLower
