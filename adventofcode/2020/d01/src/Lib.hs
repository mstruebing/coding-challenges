module Lib
    ( getInput
    , mulitplyList
    , getValues
    , getValues2
    ) where

import Data.List (nub)

getInput :: IO String
getInput = readFile "input1.txt"

getValues :: [Int] -> [Int]
getValues xs = [ x | x <- xs , y <- xs, x + y == 2020 ]

getValues2 :: [Int] -> [Int]
getValues2 xs =   nub $ [ x | x <- xs , y <- xs, z <- xs, x + y + z == 2020 ]

mulitplyList :: [Int] -> Int
mulitplyList = foldl (\x y -> x * y) 1

