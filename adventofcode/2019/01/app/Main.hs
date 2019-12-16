module Main where

import Lib

main :: IO ()
main = do 
    print "part one:"
    partOne
    print "part two:"
    partTwo

partOne :: IO ()
partOne = print . sum . map neededFuelForMass . map read . lines =<< readFile "input.txt" 

partTwo :: IO ()
partTwo = print . sum . map neededFuelForMass2nd . map read . lines =<< readFile "input.txt" 
