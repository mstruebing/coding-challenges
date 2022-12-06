module Lib
  ( someFunc,
    allCharsDifferent,
    findFirstMarker,
    getFourCharsAtIndex,
  )
where

import Data.List (findIndex)
import Data.Maybe (fromJust)
import Data.Set (fromList, size)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

findFirstMarker :: String -> Int
findFirstMarker input = fromJust (findIndex (isMarker input) [0 .. length input - 1]) + 4

isMarker :: String -> Int -> Bool
isMarker input index = allCharsDifferent $ getFourCharsAtIndex input index

getFourCharsAtIndex :: String -> Int -> String
getFourCharsAtIndex input index = take 4 $ drop index input

allCharsDifferent :: String -> Bool
allCharsDifferent input = length input == size (fromList input)
