module Main where

import Lib


main :: IO ()
main = do 
    print "partOne:"
    partOne


partOne :: IO ()
partOne = readFile ("input.txt") >>= print . sum . convertStringListToIntList . map removePlus . removeEmptyLines . lines
