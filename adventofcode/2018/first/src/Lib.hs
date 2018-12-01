module Lib
    ( convertStringListToIntList
    , removeEmptyLines
    , removePlus
    , giveFirstDuplicateFrequency
    , giveFirstDuplicateFrequencyRepeater
    , giveFirstDuplicateFrequencyHelper
    ) where

convertStringListToIntList :: [String] -> [Int]
convertStringListToIntList = map (read :: String -> Int)

removePlus :: String -> String
removePlus string = [char | char <- string, char /= '+']

removeEmptyLines :: [String] -> [String]
removeEmptyLines = filter (\line -> length line > 0)


-- Part two
giveFirstDuplicateFrequency :: [Int] -> Int
giveFirstDuplicateFrequency frequencyChanges = giveFirstDuplicateFrequencyRepeater frequencyChanges 1

giveFirstDuplicateFrequencyRepeater :: [Int] -> Int -> Int
giveFirstDuplicateFrequencyRepeater frequencyChanges run 
  | snd $ calculated = last $ fst  calculated
  | otherwise = giveFirstDuplicateFrequencyRepeater frequencyChanges $ run + 1
    where
        calculated = giveFirstDuplicateFrequencyHelper $ concat $ replicate run frequencyChanges
 
giveFirstDuplicateFrequencyHelper :: [Int] -> ([Int], Bool)
giveFirstDuplicateFrequencyHelper = 
    foldl(\acc curr -> if (snd acc) then 
        acc 
    else if (elem ((last $ fst acc) + curr) $ fst acc) then 
        (fst acc ++ [(last $ fst acc) + curr], True)
    else 
        (fst acc ++ [(last $ fst acc) + curr], False)) 
    ([0], False)
