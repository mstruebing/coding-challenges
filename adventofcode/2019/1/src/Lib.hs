module Lib
    ( neededFuelForMass
    , neededFuelForMass2nd
    ) where

import Data.List

neededFuelForMass :: Int -> Int
neededFuelForMass x = div x 3 - 2

neededFuelForMass2nd :: Int -> Int
neededFuelForMass2nd x = sum $ takeWhile (> 0) $ iterate neededFuelForMass $ neededFuelForMass x
