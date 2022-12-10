module Lib
  ( someFunc,
    parseInstruction,
    parse,
    sample,
    cycles,
    execute,
    sumOfSignals,
    addCycles,
    Instruction (..),
    createCRT,
    shouldDraw,
  )
where

import Data.List (foldl')
import Data.Matrix (Matrix, fromList)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Register at given cycle
type State = [Int]

initialState :: State
initialState = [1]

interestingCycles :: [Int]
interestingCycles = [20, 60, 100, 140, 180, 220]

data Instruction = NoOp | AddX !Int
  deriving (Show, Eq)

sumOfSignals :: State -> Int
sumOfSignals state = sum $ map (\i -> (state !! (i - 1)) * i) interestingCycles

createCRT :: State -> Matrix Char
createCRT state = fromList 6 40 $ map (\i -> if shouldDraw (state !! i) (mod i 40) then '#' else '.') [0 .. length state -1]

shouldDraw :: Int -> Int -> Bool
shouldDraw register crtPos = crtPos `elem` [register -1, register, register + 1]

execute :: [Instruction] -> State
execute = foldl' addCycles initialState

addCycles :: State -> Instruction -> State
addCycles state instruction =
  case instruction of
    NoOp -> state ++ [lastState]
    AddX amount -> state ++ [lastState] ++ [lastState + amount]
  where
    lastState = last state

cycles :: Instruction -> Int
cycles instruction = case instruction of
  NoOp -> 1
  AddX _ -> 2

parse :: [String] -> [Instruction]
parse = map parseInstruction

parseInstruction :: String -> Instruction
parseInstruction "noop" = NoOp
parseInstruction ('a' : 'd' : 'd' : 'x' : amount) = AddX $ read amount
parseInstruction _ = error "unexpected input"

sample :: [String]
sample =
  [ "addx 15",
    "addx -11",
    "addx 6",
    "addx -3",
    "addx 5",
    "addx -1",
    "addx -8",
    "addx 13",
    "addx 4",
    "noop",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx -35",
    "addx 1",
    "addx 24",
    "addx -19",
    "addx 1",
    "addx 16",
    "addx -11",
    "noop",
    "noop",
    "addx 21",
    "addx -15",
    "noop",
    "noop",
    "addx -3",
    "addx 9",
    "addx 1",
    "addx -3",
    "addx 8",
    "addx 1",
    "addx 5",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx -36",
    "noop",
    "addx 1",
    "addx 7",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "addx 6",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx 7",
    "addx 1",
    "noop",
    "addx -13",
    "addx 13",
    "addx 7",
    "noop",
    "addx 1",
    "addx -33",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "noop",
    "noop",
    "noop",
    "addx 8",
    "noop",
    "addx -1",
    "addx 2",
    "addx 1",
    "noop",
    "addx 17",
    "addx -9",
    "addx 1",
    "addx 1",
    "addx -3",
    "addx 11",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx -13",
    "addx -19",
    "addx 1",
    "addx 3",
    "addx 26",
    "addx -30",
    "addx 12",
    "addx -1",
    "addx 3",
    "addx 1",
    "noop",
    "noop",
    "noop",
    "addx -9",
    "addx 18",
    "addx 1",
    "addx 2",
    "noop",
    "noop",
    "addx 9",
    "noop",
    "noop",
    "noop",
    "addx -1",
    "addx 2",
    "addx -37",
    "addx 1",
    "addx 3",
    "noop",
    "addx 15",
    "addx -21",
    "addx 22",
    "addx -6",
    "addx 1",
    "noop",
    "addx 2",
    "addx 1",
    "noop",
    "addx -10",
    "noop",
    "noop",
    "addx 20",
    "addx 1",
    "addx 2",
    "addx 2",
    "addx -6",
    "addx -11",
    "noop",
    "noop",
    "noop"
  ]
