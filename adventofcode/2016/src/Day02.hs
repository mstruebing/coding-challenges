module Day02 (solve, part1, part2, parseLine, runLine, Move (..)) where

import Prelude hiding (Left, Right)

-- Position is 1 to 9
type Position = Int

data Move = Up | Right | Down | Left
  deriving (Show, Eq)

solve :: String -> IO ()
solve input = putStrLn "--- Day 02 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 = show . foldl runLine 5 . map parseLine . lines

part2 :: String -> String
part2 _ = "Not implemented"

parseLine :: String -> [Move]
parseLine =
  map
    ( \c -> case c of
        'U' -> Up
        'R' -> Right
        'L' -> Left
        'D' -> Down
        _ -> error "unexpected input"
    )

-- TODO: Last position instead of hardcoded 5
runLine :: Position -> [Move] -> Position
runLine = foldl move

move :: Position -> Move -> Position
move position Up = if position > 3 then position - 3 else position
move position Down = if position < 7 then position + 3 else position
move position Left = if position `mod` 3 /= 1 then position - 1 else position
move position Right = if position `mod` 3 /= 0 then position + 1 else position
