module Lib
  ( getInput,
    calc,
    calc2,
    parse,
    Direction (..),
  )
where

-- (x, y)
type Position = (Int, Int)

-- (x, y, aim)
type SubmarineState = (Int, Int, Int)

data Direction = Forward | Down | Up
  deriving (Eq, Ord, Show)

type Instruction = (Direction, Int)

first :: SubmarineState -> Int
first (a, _, _) = a

second :: SubmarineState -> Int
second (_, b, _) = b

third :: SubmarineState -> Int
third (_, _, c) = c

getInput :: IO String
getInput = readFile "input.txt"

parse :: String -> Instruction
parse input = case rawDirection of
  "forward" -> (Forward, value)
  "down" -> (Down, value)
  "up" -> (Up, value)
  _ -> undefined
  where
    rawDirection = takeWhile (/= ' ') input
    value = read $ tail $ dropWhile (/= ' ') input

calc :: Position -> [Instruction] -> Position
calc = foldl getNewPoint

getNewPoint :: Position -> Instruction -> Position
getNewPoint (x, y) instruction =
  case direction of
    Forward -> (x + amount, y)
    Down -> (x, y + amount)
    Up -> (x, y - amount)
  where
    direction = fst instruction
    amount = snd instruction

calc2 :: SubmarineState -> [Instruction] -> SubmarineState
calc2 = foldl getNewPoint2

getNewPoint2 :: SubmarineState -> Instruction -> SubmarineState
getNewPoint2 (x, y, z) instruction =
  case direction of
    Forward -> (x + value, y + z * value, z)
    Down -> (x, y, z + value)
    Up -> (x, y, z - value)
  where
    direction = fst instruction
    value = snd instruction
