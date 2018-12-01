module Main where

import Data.List
import Lib


main :: IO ()
main = do 
    print "partOne:"
    partOne
    print "partTwo:"
    partTwo


partOne :: IO ()
partOne = readFile ("input.txt") >>= print . sum . convertStringListToIntList . map removePlus . removeEmptyLines . lines

partTwo :: IO ()
partTwo = readFile ("input.txt") >>= print . giveFirstDuplicateFrequency . convertStringListToIntList . map removePlus . removeEmptyLines . lines
