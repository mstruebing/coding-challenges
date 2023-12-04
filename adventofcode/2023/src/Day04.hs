module Day04 (solve, part1, part2, parseGame) where

import qualified Data.Set as Set

solve :: String -> IO ()
solve input = putStrLn "--- Day 04 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 input = show $ foldl (\acc curr -> acc + calculateRound curr) 0 (parseGame input)

part2 :: String -> String
part2 _ = "Not implemented"

type Round = (Set.Set Int, Set.Set Int)
type Game = [Round]

-- Part 1

calculateRound :: Round -> Int
calculateRound (winning, player) = iterate (\ num -> (if num == 0 then 1 else num * 2)) 0 !! correctNumbers
    where
        correctNumbers = length $ Set.intersection winning player

parseGame :: String -> Game
parseGame = map parseRound . lines

parseRound :: String -> Round
parseRound input = (Set.fromList winningNumbers, Set.fromList playerNumbers)
    where
        winningNumbers = map (\x -> read x::Int) $ words $ takeWhile (/= '|') $ tail $ dropWhile (/= ':') input
        playerNumbers = map (\x -> read x::Int) $ words $ tail $ dropWhile (/= '|') input
