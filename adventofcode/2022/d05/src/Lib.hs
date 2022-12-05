module Lib
  ( someFunc,
    move,
    Ship,
    parse,
    parseMove,
    parseShip,
    getFirstCrates,
    first,
    second,
  )
where

import Data.Char
import Data.List (elemIndex, foldl')
import Data.List.Split (chunksOf)
import Data.Map (Map, assocs, findWithDefault, fromList, insert)
import Data.Maybe (fromJust)

type Crate = Char

type Stack = Int

type Move = (Int, Stack, Stack)

-- first element of the Crates list is the top of the Stack
type Ship = Map Stack [Crate]

someFunc :: IO ()
someFunc = putStrLn "someFunc"

first :: (Ship, [Move]) -> String
first (ship, moves) = getFirstCrates $ foldl' move ship moves

move :: Ship -> Move -> Ship
move ship (amount, from, to) = insert from newStackFrom $ insert to newStackTo ship
  where
    newStackTo = reverse (take amount stackFrom) ++ stackTo
    newStackFrom = drop amount stackFrom
    stackFrom = findWithDefault [] from ship
    stackTo = findWithDefault [] to ship

getFirstCrates :: Ship -> [Crate]
getFirstCrates ship = map (\(_, v) -> if length v > 0 then head v else ' ') $ assocs ship

-- parsing could be better
parseMove :: String -> Move
parseMove input = (amount, from, to)
  where
    amount = read (takeWhile (/= ' ') $ untilNextNumber input) :: Int
    from = read (takeWhile (/= ' ') $ untilNextNumber $ untilNextSpace $ untilNextNumber input) :: Int
    to = read (takeWhile (/= ' ') $ untilNextNumber $ untilNextSpace $ untilNextNumber $ untilNextSpace $ untilNextNumber input) :: Int
    untilNextNumber = dropWhile (not . isNumber)
    untilNextSpace = dropWhile (/= ' ')

-- fromList [(1, ['N', 'Z']), (2, ['D', 'C', 'M']), (3, ['P'])]
parseShip :: [String] -> Ship
parseShip input = fromList $ map (\s -> (s, filter (/= ' ') $ map (!! (s - 1)) rows)) stacks
  where
    rows = map (map (!! 1) . chunksOf 4) $ init input
    stacks = map (\x -> digitToInt (x !! 1)) $ chunksOf 4 $ last input

parse :: [String] -> (Ship, [Move])
parse input = (ship, moves)
  where
    ship = parseShip rawShip
    moves = map parseMove rawMoves
    rawShip = take dividerIndex input
    rawMoves = drop (dividerIndex + 1) input
    dividerIndex = fromJust $ elemIndex "" input

------------------------------
-- Part 2
------------------------------

second :: (Ship, [Move]) -> String
second (ship, moves) = getFirstCrates $ foldl' move' ship moves

move' :: Ship -> Move -> Ship
move' ship (amount, from, to) = insert from newStackFrom $ insert to newStackTo ship
  where
    newStackTo = take amount stackFrom ++ stackTo
    newStackFrom = drop amount stackFrom
    stackFrom = findWithDefault [] from ship
    stackTo = findWithDefault [] to ship
