module Lib
    ( convertStringListToIntList
    , removeEmptyLines
    , removePlus
    , giveFirstDuplicateFrequency
    ) where

import qualified Data.Set as Set  

convertStringListToIntList :: [String] -> [Int]
convertStringListToIntList = map (read :: String -> Int)

removePlus :: String -> String
removePlus string = [char | char <- string, char /= '+']

removeEmptyLines :: [String] -> [String]
removeEmptyLines = filter (\line -> length line > 0)


-- Part two
giveFirstDuplicateFrequency :: [Int] -> Int
giveFirstDuplicateFrequency frequencyChanges = findFirstDuplicate (scanl (+) 0 $ cycle frequencyChanges) Set.empty

findFirstDuplicate :: [Int] -> Set.Set Int -> Int
findFirstDuplicate (x:xs) s 
  | Set.member x s = x
  | otherwise = findFirstDuplicate xs $ Set.insert x s
