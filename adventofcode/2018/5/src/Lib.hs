module Lib
    ( reduceOppositePolarityOfSameType
    ) where

import Data.Char

reduceOppositePolarityOfSameType :: String -> String
reduceOppositePolarityOfSameType = foldr (\curr acc -> react $ [(curr)] ++ acc) ""

react :: String -> String
react [] = []
react (x:xs) 
  | x == '\n' = []
  | xs == [] = [x]
  | isLower x = if head xs == toUpper x then tail xs else x:xs
  | isUpper x = if head xs == toLower x then tail xs else x:xs
