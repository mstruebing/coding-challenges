module Lib
  ( someFunc,
    constructMap,
    constructRow,
    sample,
    getBoundaries,
    isTreeVisibile,
    treesVisibleFromOutside,
    scenicScore,
    highestScenicScore,
    singleDirectionScenicScore,
    allDirections,
  )
where

import Data.Char (digitToInt)
import Data.List (foldl')
import qualified Data.Map as Map
import Data.Maybe (fromJust, mapMaybe)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

type Coords = (Int, Int)

highestScenicScore :: Map.Map Coords Int -> Int
highestScenicScore forest = maximum $ map (\(coords, _) -> scenicScore forest coords) $ Map.assocs forest

scenicScore :: Map.Map Coords Int -> Coords -> Int
scenicScore forest (x, y) = product [f $ reverse left, f right, f $ reverse up, f down]
  where
    size = fromJust $ Map.lookup (x, y) forest
    f = singleDirectionScenicScore size
    (left, right, up, down) = allDirections forest (x, y)

singleDirectionScenicScore :: Int -> [Int] -> Int
singleDirectionScenicScore size direction =
  snd $
    foldl'
      ( \(found, score) currentSize ->
          if found
            then (found, score)
            else (currentSize >= size, score + 1)
      )
      (False, 0)
      direction

treesVisibleFromOutside :: Map.Map Coords Int -> Int
treesVisibleFromOutside forest = length $ filter (== True) $ map (isTreeVisibile forest) (Map.keys forest)

isTreeVisibile :: Map.Map Coords Int -> Coords -> Bool
isTreeVisibile forest (x, y) = all (< size) left || all (< size) right || all (< size) up || all (< size) down
  where
    size = fromJust $ Map.lookup (x, y) forest
    (left, right, up, down) = allDirections forest (x, y)

allDirections :: Map.Map Coords Int -> Coords -> ([Int], [Int], [Int], [Int])
allDirections forest (x, y) = (left, right, up, down)
  where
    left = mapMaybe (\i -> Map.lookup (x, i) forest) [0 .. y - 1]
    right = mapMaybe (\i -> Map.lookup (x, i) forest) [y + 1 .. maxY]
    up = mapMaybe (\i -> Map.lookup (i, y) forest) [0 .. x - 1]
    down = mapMaybe (\i -> Map.lookup (i, y) forest) [x + 1 .. maxX]
    (maxX, maxY) = getBoundaries forest

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
