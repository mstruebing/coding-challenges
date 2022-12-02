module Main (main) where

import Lib

main :: IO ()
main = do
  print "part 1"
  run1
  print "part 2"
  run2

run1 :: IO ()
run1 = print . runFirst . lines =<< readFile "input.txt"

run2 :: IO ()
run2 = print . runSecond . lines =<< readFile "input.txt"
