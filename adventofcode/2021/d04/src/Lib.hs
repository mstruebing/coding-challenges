module Lib
  ( getInput,
    Board,
    set,
    hasWon,
    getScore,
    getUnmarkedSum,
    parse,
    parseRow,
    parseBoards,
    play,
  )
where

import Data.List.Split

type Instructions = [Int]

type Field = (Int, Bool)

type Row = [Field]

type Board = [Row]

getInput :: IO String
getInput = readFile "input.txt"

-- TODO: Implement
-- for every instruction calculate the new boards, check if one has won
-- if won, get unmarked sum and multiply by last used instruction
-- else continute with next construction
play :: Instructions -> [Board] -> Int
play instructions boards = if hasWinningBoard > 0 then getUnmarkedSum (head getWinningBoard) * instruction else play (tail instructions) newBoards
  where
    hasWinningBoard = length getWinningBoard
    getWinningBoard = filter hasWon newBoards
    newBoards = map (\board -> set board instruction) boards
    instruction = head instructions

parse :: [String] -> (Instructions, [Board])
parse input = (instructions, parseBoards input)
  where
    -- convert ',' to ' ' to be able to use words
    instructions = map (\x -> read x :: Int) $ words $ map (\x -> if x == ',' then ' ' else x) (head input)

parseBoards :: [String] -> [Board]
parseBoards input = chunksOf 5 $ map parseRow $ concat $ filter (\x -> x /= [] && x /= [""]) $ splitOn [] $ tail input

parseRow :: String -> Row
parseRow = map (\x -> (read x :: Int, False)) . words

getScore :: Board -> Int -> Int
getScore board lastNumber = lastNumber * getUnmarkedSum board

getUnmarkedSum :: Board -> Int
getUnmarkedSum = foldl (\currentSum row -> currentSum + sum (map getFieldValue row)) 0

getFieldValue :: Field -> Int
getFieldValue (number, picked) = if picked then 0 else number

set :: Board -> Int -> Board
set board number =
  map
    ( map
        ( \(num, picked) ->
            if num == number
              then (num, True)
              else (num, picked)
        )
    )
    board

hasWon :: Board -> Bool
hasWon board = hasWinningRow || hasWinningColumn
  where
    hasWinningRow = any isWinningRow board
    hasWinningColumn = any isWinningRow columns
    columns = map (convertColumnToRow board) [0 .. length board - 1]

isWinningRow :: Row -> Bool
isWinningRow = all snd

-- To be able to use row functions on columns
convertColumnToRow :: Board -> Int -> Row
convertColumnToRow board index = map (!! index) board
