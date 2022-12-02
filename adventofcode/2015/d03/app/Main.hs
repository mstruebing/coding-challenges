module Main where

import Lib

main :: IO ()
main = do
  print "part 1: "
  part1

-- print "part 2: "
-- part2

part1 :: IO ()
part1 = print . run . parse =<< getInput

-- part2 :: IO ()
-- part2 = print . show . run2 =<< getInput
