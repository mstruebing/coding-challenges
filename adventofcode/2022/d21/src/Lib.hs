module Lib
  ( func,
    parseSingle,
    parse,
    solve,
    isRootSolved,
  )
where

import Control.Monad.State
import Data.Either (fromRight, isRight)
import Data.List (foldl')
import qualified Data.Map as Map
import Data.Maybe (fromJust)
import Text.Read (readMaybe)

func :: Int
func = 1

data Operation = Add | Substract | Multiply | Divide
  deriving (Show, Eq)

type Operant = Either String Int

type OpenResult = (Operant, Operation, Operant)

type Result = Either OpenResult Int

type Monkeys = Map.Map String Result

solve :: Monkeys -> Result
solve = fromJust . Map.lookup "root" . until isRootSolved run

run :: Monkeys -> Monkeys
run monkeys = Map.foldlWithKey' runSingle monkeys monkeys

runSingle :: Monkeys -> String -> Result -> Monkeys
runSingle monkeys key result = case result of
  Right _ -> monkeys
  Left (x, o, y) -> do
    let newX = newOperant x monkeys
    let newY = newOperant y monkeys
    if isRight newX && isRight newY
      then Map.insert key (Right $ calc (fromRight 0 newX) o (fromRight 0 newY)) monkeys
      else Map.insert key (Left (newX, o, newY)) monkeys

calc :: Int -> Operation -> Int -> Int
calc x Add y = x + y
calc x Substract y = x - y
calc x Multiply y = x * y
calc x Divide y = div x y

newOperant :: Operant -> Monkeys -> Operant
newOperant operant monkeys = case operant of
  Left name -> do
    let a = fromJust $ Map.lookup name monkeys
    case a of
      Left _ -> operant
      Right value -> Right value
  Right _ -> operant

isRootSolved :: Monkeys -> Bool
isRootSolved monkeys = do
  let result = fromJust $ Map.lookup "root" monkeys
  case result of
    Left _ -> False
    Right _ -> True

--- PARSING

parse :: [String] -> Monkeys
parse = foldl' addMonkey Map.empty

addMonkey :: Monkeys -> String -> Monkeys
addMonkey monkeys input = Map.insert name monkey monkeys
  where
    (name, monkey) = parseSingle input

-- (Name, Result)
parseSingle :: String -> (String, Result)
parseSingle input = (name, if length parts > 2 then Left openResult else Right result)
  where
    openResult = (firstOperant, operation, secondOperant)
    result = read (parts !! 1) :: Int
    parts = words input
    name = init $ head parts
    firstOperant = toOperant $ parts !! 1
    operation = toOperation $ head $ parts !! 2
    secondOperant = toOperant $ parts !! 3

toOperation :: Char -> Operation
toOperation '+' = Add
toOperation '-' = Substract
toOperation '*' = Multiply
toOperation '/' = Divide
toOperation _ = error "unexpeced input"

toOperant :: String -> Operant
toOperant input = case readMaybe input :: Maybe Int of
  Just number -> Right number
  Nothing -> Left input
