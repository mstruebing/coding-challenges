module Main where

import qualified Data.Map as Map
import Lib

main :: IO ()
main = do
  print "part 1: "
  part1
  print "part 2: "
  part2

part1 :: IO ()
part1 =
  print
    . minimum
    . func
    . map (\x -> read x :: Int)
    . words
    . map (\x -> if x == ',' then ' ' else x)
    . head
    . lines
    =<< getInput

part2 :: IO ()
part2 = print 2
