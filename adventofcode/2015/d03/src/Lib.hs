module Lib
  ( getInput,
    run,
    parse,
  )
where

import Data.List (nub)

getInput :: IO String
getInput = readFile "input.txt"

data Direction = Up | Down | Left | Right | NoOp
  deriving (Eq, Ord, Show)

type Coordinates = (Int, Int)

parse :: String -> [Direction]
parse = map parseSingle

parseSingle :: Char -> Direction
parseSingle input = case input of
  '^' -> Lib.Up
  '>' -> Lib.Right
  'v' -> Lib.Down
  '<' -> Lib.Left
  _ -> NoOp

run :: [Direction] -> Int
run = length . nub . foldl (\acc curr -> acc ++ [nextCoordinates (last acc) curr]) [(0, 0)]

nextCoordinates :: Coordinates -> Direction -> Coordinates
nextCoordinates (x, y) direction = case direction of
  Lib.Up -> (x, y + 1)
  Lib.Right -> (x + 1, y)
  Lib.Down -> (x, y - 1)
  Lib.Left -> (x -1, y)
  Lib.NoOp -> (x, y)
