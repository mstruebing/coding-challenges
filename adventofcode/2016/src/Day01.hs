module Day01
  ( solve,
    part1,
    run,
    part2,
    parseInstruction,
    parseInstructions,
    Instruction (..),
    Direction (..),
    Turn (..),
    State,
  )
where

import Prelude hiding (Left, Right)

type Coordinates = (Int, Int)

type State = (Coordinates, Direction)

data Turn = Left | Right
  deriving (Eq, Show)

data Direction = North | East | South | West
  deriving (Eq, Show)

data Instruction = Instruction Turn Int
  deriving (Eq, Show)

initialState :: State
initialState = ((0, 0), North)

solve :: String -> IO ()
solve input = putStrLn "--- Day 01 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 input = show $ abs x + abs y
  where
    ((x, y), _) = run $ parseInstructions input

part2 :: String -> String
part2 _ = "Not implemented"

parseInstructions :: String -> [Instruction]
parseInstructions = map parseInstruction . words . filter (/= ',')

parseInstruction :: String -> Instruction
parseInstruction ('R' : n) = Instruction Right (read n :: Int)
parseInstruction ('L' : n) = Instruction Left (read n :: Int)
parseInstruction _ = error "unexpected input"

run :: [Instruction] -> State
run = foldl step initialState

step :: State -> Instruction -> State
step ((x, y), direction) instruction = case dir of
  North -> ((x, y + amount), North)
  East -> ((x + amount, y), East)
  South -> ((x, y - amount), South)
  West -> ((x - amount, y), West)
  where
    dir = newDirection direction turn
    turn = getTurn instruction
    amount = getAmount instruction
    getTurn (Instruction a _) = a
    getAmount (Instruction _ a) = a

newDirection :: Direction -> Turn -> Direction
newDirection North Left = West
newDirection North Right = East
newDirection East Left = North
newDirection East Right = South
newDirection South Left = East
newDirection South Right = West
newDirection West Left = South
newDirection West Right = North
