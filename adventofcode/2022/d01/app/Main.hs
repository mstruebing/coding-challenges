module Main (main) where

import Data.List (sort)
import Data.List.Split (splitWhen)

main :: IO ()
main = do
  print "part 1: "
  part1
  print "part 2: "
  part2

part1 :: IO ()
part1 = print . maximum . map (sum . map (\x -> read x :: Int)) . splitWhen (\x -> x == "") . lines =<< getInput

part2 :: IO ()
part2 = print . sum . take 3 . reverse . sort . map (sum . map (\x -> read x :: Int)) . splitWhen (\x -> x == "") . lines =<< getInput

getInput :: IO String
getInput = readFile "input.txt"
