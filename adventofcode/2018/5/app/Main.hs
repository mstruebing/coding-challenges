module Main where

import Lib

main :: IO ()
main = readFile "input.txt" >>= print . length . reduceOppositePolarityOfSameType
