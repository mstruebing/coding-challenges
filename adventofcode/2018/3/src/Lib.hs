module Lib
    ( getSize
    , frequency
    , getStartingPoint
    , boardSize
    , constructBoard
    , occupy
    , getOccupyingCoordinates
    , countCoordsOccupiedMoreThanOnce
    , occupyAll
    , occupyAll'
    ) where

import Data.Maybe
import Data.List
import Data.Map (fromListWith, toList)

type Coordinates = (Int, Int)
type Board = [(Coordinates, Int)]

boardSize :: Int
boardSize = 1000

constructBoard :: Int -> Board
constructBoard size = [ ((x, y), 0) | x <- [0..size], y <- [0..size] ]

occupyAll :: Board -> [Coordinates] -> Board
occupyAll board (x:xs) 
  | xs == [] = board
  | otherwise = occupyAll (occupy board x) xs


frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = toList (fromListWith (+) [(x, 1) | x <- xs])

occupyAll' :: Board -> [Coordinates] -> Board
occupyAll' board coordsList = foldr (\curr acc -> occupy acc curr) board coordsList

occupy :: Board -> Coordinates -> Board
occupy board coords = map (\i -> if (fst i == coords) then (fst i, snd i + 1) else i) board

countCoordsOccupiedMoreThanOnce :: Board -> Int
countCoordsOccupiedMoreThanOnce = length . filter (\i -> snd i > 1) 

getOccupyingCoordinates :: String -> [(Coordinates)]
getOccupyingCoordinates input = [(x, y) | x <- [startX .. startX + width -1], y <- [startY .. startY + height -1] ]
    where
        startX = fst startingPoint
        startY = snd startingPoint
        width = fst size
        height = snd size
        size = getSize input 
        startingPoint = getStartingPoint input

getSize :: String -> Coordinates
getSize input = (first, second)
    where
        first = read (fst stringCoordsTuple) :: Int
        second = read (drop 1 $ snd stringCoordsTuple) :: Int
        stringCoordsTuple = splitAt (fromJust $ elemIndex 'x' stringCoords) stringCoords
        stringCoords = drop 2 $ dropWhile (/= ':') input

getStartingPoint :: String -> Coordinates
getStartingPoint input = (first, second)
    where
        first = read (fst stringCoordsTuple) :: Int
        second = read (drop 1 $ snd stringCoordsTuple) :: Int
        stringCoordsTuple = splitAt (fromJust $ elemIndex ',' stringCoords) stringCoords
        stringCoords = takeWhile (/= ':') $ drop 1 $ dropWhile (/= '@') input
