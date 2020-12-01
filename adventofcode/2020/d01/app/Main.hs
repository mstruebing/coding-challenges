module Main where

import Lib

main :: IO ()
main = do
    print "problem1: "
    problem1
    print "problem2: "
    problem2


problem1 :: IO ()
problem1 = print . mulitplyList . getValues . map read . lines =<< getInput

problem2 :: IO ()
problem2 = print . mulitplyList . getValues2 . map read . lines =<< getInput
