module Main (main) where

import qualified Lib

main :: IO ()
main = do
  print "part1: "
  part1
  print "part2: "
  part2

part1 :: IO ()
part1 = print . Lib.treesVisibleFromOutside . Lib.constructMap . lines =<< readFile "input.txt"

part2 :: IO ()
part2 = print 1
