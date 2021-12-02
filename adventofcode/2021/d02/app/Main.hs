module Main where

import Lib

main :: IO ()
main = do
  print "part 1: "
  part1

part1 :: IO ()
part1 = print . (\(x, y) -> x * y) . calc (0, 0) . map parse . lines =<< getInput
