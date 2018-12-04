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
import qualified Data.Map as Map  

type Coordinates = (Int, Int)
type Board = Map.Map Coordinates Int

boardSize :: Int
boardSize = 1000

constructBoard :: Int -> Board
constructBoard size = Map.fromList [((x, y), 0) | x <- [0..size], y <- [0..size]]

occupyAll :: Board -> [Coordinates] -> Board
occupyAll board (x:xs) 
  | xs == [] = occupy board x
  | otherwise = occupyAll (occupy board x) xs


frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = Map.toList (Map.fromListWith (+) [(x, 1) | x <- xs])

occupyAll' :: Board -> [Coordinates] -> Board
occupyAll' board coordsList = foldr (\c b -> Map.insertWith (+) c 1 b) board coordsList

occupy :: Board -> Coordinates -> Board
occupy board coords = Map.fromList $ map (\i -> if (fst i == coords) then (fst i, snd i + 1) else i) $ Map.toList board

countCoordsOccupiedMoreThanOnce :: Board -> Int
countCoordsOccupiedMoreThanOnce = length . filter (\i -> snd i > 1) . Map.toList

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
