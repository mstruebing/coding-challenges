module Lib
    ( convertStringListToIntList
    , removeEmptyLines
    , removePlus
    ) where

convertStringListToIntList :: [String] -> [Int]
convertStringListToIntList = map (read :: String -> Int)

removePlus :: String -> String
removePlus string = [char | char <- string, char /= '+']

removeEmptyLines :: [String] -> [String]
removeEmptyLines = filter (\line -> length line > 0)
