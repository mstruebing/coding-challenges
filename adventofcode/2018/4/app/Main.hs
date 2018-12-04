module Main where

import Data.List
import qualified Data.Map as Map

import Lib

main :: IO ()
main = do
    file <- readFile "input.txt"
    let guardData = initGuardData Map.empty 0 $ sort $ lines file
    let mostSleepingGuard = findMostSleepingGuard guardData
    print $ fst mostSleepingGuard * findMostAsleepMinute mostSleepingGuard
