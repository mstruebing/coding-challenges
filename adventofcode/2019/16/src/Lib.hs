module Lib
    ( someFunc
    , getPatternForIndex
    , getLastDigit
    , calcSingleRow
    , calcPhase
    , calcPhases
    , basePattern
    ) where

import Data.Digits (digits, unDigits)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

basePattern :: [Integer]
basePattern = [0, 1, 0, -1]

getPatternForIndex :: Integer -> [Integer]
getPatternForIndex index = 
    concat $ map (\x -> replicate ((fromInteger index) + 1) x) basePattern

getLastDigit :: Integer -> Integer
getLastDigit = last . reverse . digits 10
    where
        last [] = 0
        last (x:xs) = x

calcSingleRow :: [Integer] -> [Integer] -> Integer
calcSingleRow input pattern = 
    getLastDigit . abs . sum $ 
    zipWith (*) input offsetPattern
        where
            outputList = zipWith (*) input offsetPattern
            offsetPattern = drop 1 $ cycle pattern

calcPhase :: [Integer] -> [Integer]
calcPhase input =  
    map 
    (\index -> calcSingleRow input (getPatternForIndex $ toInteger index)) 
    [0..length input - 1]

calcPhases :: Integer -> Integer -> [Integer]
calcPhases phases input = 
    foldl (\acc curr -> calcPhase acc) inputList phaseList
    where
        inputList = digits 10 input
        phaseList = [0..(fromInteger phases) - 1]
