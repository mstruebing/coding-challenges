module Main where

import Data.List
import qualified Data.Map as Map

import Lib

main :: IO ()
main = do
    putStrLn "firstPart:"
    firstPart
    putStrLn "secondPart:"
    secondPart

firstPart :: IO ()
firstPart = do
    file <- readFile "input.txt"
    let guardData = initGuardData Map.empty 0 $ sort $ lines file
    let mostSleepingGuard = findMostSleepingGuard guardData
    print $ fst mostSleepingGuard * findMostAsleepMinuteForSingleGuard mostSleepingGuard

secondPart :: IO ()
secondPart = do
    -- file <- readFile "smallinput.txt"
    file <- readFile "input.txt"
    let guardData = initGuardData Map.empty 0 $ sort $ lines file
    let calculated = Map.map findMostAsleepMinuteForAllGuards guardData
    let most = foldr (\curr acc -> if (snd $ snd curr) > (snd $ snd acc) then curr else acc) (0, (0, 0)) $ Map.toList calculated
    print ((fst most) * (fst $ snd most))
