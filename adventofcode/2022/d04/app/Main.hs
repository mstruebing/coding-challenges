module Main (main) where

import Lib

main :: IO ()
main = do
  print "part1: "
  part1
  print "part2: "
  part2

part1 :: IO ()
part1 = print . Lib.first . parse . lines =<< readFile "input.txt"

part2 :: IO ()
part2 = print 1
