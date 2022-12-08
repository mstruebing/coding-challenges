module Lib
  ( someFunc,
    constructMap,
    constructRow,
    sample,
    getBoundaries,
    isTreeVisibile,
    treesVisibleFromOutside,
  )
where

import Data.Char (digitToInt)
import Data.List (foldl')
import qualified Data.Map as Map
import Data.Maybe (fromJust, mapMaybe)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

type Coords = (Int, Int)

treesVisibleFromOutside :: Map.Map Coords Int -> Int
treesVisibleFromOutside forestMap = length $ filter (== True) $ map (\coords -> isTreeVisibile forestMap coords) (Map.keys forestMap)

isTreeVisibile :: Map.Map Coords Int -> Coords -> Bool
isTreeVisibile forestMap (x, y) = all (< size) allLeft || all (< size) allRight || all (< size) allUp || all (< size) allDown
  where
    size = fromJust $ Map.lookup (x, y) forestMap
    (maxX, maxY) = getBoundaries forestMap
    allLeft = mapMaybe (\i -> Map.lookup (x, i) forestMap) [0 .. y - 1]
    allRight = mapMaybe (\i -> Map.lookup (x, i) forestMap) [y + 1 .. maxY]
    allUp = mapMaybe (\i -> Map.lookup (i, y) forestMap) [0 .. x - 1]
    allDown = mapMaybe (\i -> Map.lookup (i, y) forestMap) [x + 1 .. maxX]

constructMap :: [String] -> Map.Map Coords Int
constructMap rows = foldl' (\acc rowIndex -> Map.union acc $ constructRow (rows !! rowIndex) rowIndex) Map.empty [0 .. length rows - 1]

constructRow :: String -> Int -> Map.Map Coords Int
constructRow row rowIndex = Map.fromList $ map (\index -> ((rowIndex, index), digitToInt (row !! index))) [0 .. length row -1]

getBoundaries :: Map.Map Coords Int -> Coords
getBoundaries input = fst $ last $ Map.assocs input

sample :: [String]
sample =
  [ "30373",
    "25512",
    "65332",
    "33549",
    "35390"
  ]
