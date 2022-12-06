module Lib
  ( someFunc,
    allCharsDifferent,
    findPacketMarker,
    findStartOfMessageMarker,
  )
where

import Data.List (findIndex)
import Data.Maybe (fromJust)
import Data.Set (fromList, size)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

messageMarkerChars :: Int
messageMarkerChars = 14

packetMarkerChars :: Int
packetMarkerChars = 4

findPacketMarker :: String -> Int
findPacketMarker input = fromJust (findIndex (isPacketMarker input) [0 .. length input - 1]) + packetMarkerChars

isPacketMarker :: String -> Int -> Bool
isPacketMarker input index = allCharsDifferent $ getChars index
  where
    getChars = getCharsAtIndex packetMarkerChars input

findStartOfMessageMarker :: String -> Int
findStartOfMessageMarker input = fromJust (findIndex (isStartOfMessageMarker input) [0 .. length input - 1]) + messageMarkerChars

isStartOfMessageMarker :: String -> Int -> Bool
isStartOfMessageMarker input index = allCharsDifferent $ getChars index
  where
    getChars = getCharsAtIndex messageMarkerChars input

getCharsAtIndex :: Int -> String -> Int -> String
getCharsAtIndex amount input index = take amount $ drop index input

allCharsDifferent :: String -> Bool
allCharsDifferent input = length input == size (fromList input)
