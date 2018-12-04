module Lib
    ( initGuardData
    , findMostSleepingGuard
    , findMostAsleepMinute
    ) where

import qualified Data.Map as Map
import Data.List

type GuardData = Map.Map Int [(Int, Int)]
type SingleGuard = (Int, [(Int, Int)])

fallsAsleepString :: String
fallsAsleepString = "falls asleep"

wakesUpString :: String
wakesUpString = "wakes up"

beginsShiftString :: String
beginsShiftString = "begins shift"

findMostAsleepMinute :: SingleGuard -> Int
findMostAsleepMinute = fst . foldr (\curr acc -> if snd curr > snd acc then curr else acc) (0, 0) . reverse . map (\i -> (head i, length i)) . group .sort . concat . map (\i -> [fst i .. snd i - 1]) . snd

findMostSleepingGuard :: GuardData -> SingleGuard
findMostSleepingGuard guardData = head $ filter (\guard -> fst guard == mostSleepingGuardNr) $ Map.toList guardData
    where
        mostSleepingGuardNr = fst $ head $ filter (\i -> snd i == maximumMinutesOfSleep ) totalAmountOfGuardSleeping
        maximumMinutesOfSleep = maximum $ map (\i -> snd i) totalAmountOfGuardSleeping
        totalAmountOfGuardSleeping = map (\guard -> (fst guard, sum $ map (\i -> snd i - fst i) $ snd guard)) $ Map.toList guardData

initGuardData :: GuardData -> Int -> [String] -> GuardData
initGuardData guardData lastGuard [] = guardData
initGuardData guardData lastGuard (x:xs)
  | isInfixOf fallsAsleepString x = initGuardData (Map.insertWith (++) lastGuard [(sleepStart, sleepEnd)] guardData) lastGuard (tail $ xs) 
  | isInfixOf beginsShiftString x = initGuardData (Map.insertWith (++) guardNr [] guardData) guardNr xs
  | otherwise = initGuardData guardData lastGuard xs
    where
        sleepStart = parseMinute x
        sleepEnd = parseMinute $ head xs
        guardNr = parseGuardNr x

parseGuardNr :: String -> Int
parseGuardNr = read . takeWhile (/= ' ') . tail . dropWhile (/= '#') 

parseMinute :: String -> Int
parseMinute = read . takeWhile (/= ']') . tail . dropWhile (/= ':')
