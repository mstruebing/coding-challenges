module Lib
    ( reduceOppositePolarityOfSameType
    ) where

import Data.Char

reduceOppositePolarityOfSameType :: String -> String
reduceOppositePolarityOfSameType = foldr (\curr acc -> reduceOppositePolarityOfSameTypeOnce $ [curr] ++ acc) ""

reduceOppositePolarityOfSameTypeOnce :: String -> String
reduceOppositePolarityOfSameTypeOnce [] = []
reduceOppositePolarityOfSameTypeOnce (x:xs) 
  | xs == [] = [x]
  | isLower x = if head xs == toUpper x then tail xs else x:xs
  | isUpper x = if head xs == toLower x then tail xs else x:xs
