module Lib
    ( neededFuelForMass
    , neededFuelForMass2nd
    , parseAsInt
    ) where

import Data.List

neededFuelForMass :: Int -> Int
neededFuelForMass x = div x 3 - 2

neededFuelForMass2nd :: Int -> Int
neededFuelForMass2nd x = sum $ 
    unfoldr (\y -> 
        if neededFuelForMass y <= 0 
           then Nothing 
           else Just (neededFuelForMass y, neededFuelForMass y)
        ) x
