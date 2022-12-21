module Main (main) where

import qualified Lib

main :: IO ()
main = do
  print "sample: "
  sample
  print "part1: "
  part1
  print "part2: "
  part2

sample :: IO ()
sample = print . Lib.solve . Lib.parse . lines =<< readFile "sample.txt"

part1 :: IO ()
part1 = print . Lib.solve . Lib.parse . lines =<< readFile "input.txt"

part2 :: IO ()
part2 = print "2"
