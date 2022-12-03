module Main (main) where

import Lib

main :: IO ()
main = do
  print "part1: "
  part1

part1 :: IO ()
part1 = print . Lib.first . lines =<< readFile "input.txt"
