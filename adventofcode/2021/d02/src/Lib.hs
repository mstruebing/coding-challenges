module Lib
  ( getInput,
    calc,
    parse,
    Direction (..),
  )
where

-- (x, y)
type Position = (Int, Int)

data Direction = Forward | Down | Up
  deriving (Eq, Ord, Show)

type Instruction = (Direction, Int)

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
getNewPoint (x, y) z =
  case fst z of
    Forward -> (x + snd z, y)
    Down -> (x, y + snd z)
    Up -> (x, y - snd z)
