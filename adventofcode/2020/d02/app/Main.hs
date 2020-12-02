module Main where

import Lib

main :: IO ()
main = do
    print "problem1: "
    problem1
    print "problem2: "
    problem2


problem1 :: IO ()
problem1 = print . length . filter (== True) . map isValidPassword . lines =<< getInput

problem2 :: IO ()
problem2 = print . length . filter (== True) . map isValidPassword2 . lines =<< getInput

getInput :: IO String
getInput = readFile "input.txt"
