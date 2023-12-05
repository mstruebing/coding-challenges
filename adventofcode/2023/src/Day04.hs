module Day04 (solve, part1, part2) where

import qualified Data.Set as Set
import qualified Data.Map as Map
import Prelude hiding (round)

solve :: String -> IO ()
solve input = putStrLn "--- Day 04 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 input = show $ foldl (\acc curr -> acc + calculateRound curr) 0 (parseGame input)

part2 :: String -> String
part2 input = show $ Map.foldl (+) 0 $ resultingCards (parseGame input)

type Round = (Set.Set Int, Set.Set Int)
type Game = [Round]

-- Part 1

calculateRound :: Round -> Int
calculateRound round = iterate (\ num -> (if num == 0 then 1 else num * 2)) 0 !! winningNumbers round


winningNumbers :: Round -> Int
winningNumbers (winning, player) = length $ Set.intersection winning player


parseGame :: String -> Game
parseGame = map parseRound . lines

parseRound :: String -> Round
parseRound input = (Set.fromList cardNumbers, Set.fromList playerNumbers)
    where
        cardNumbers = map (\x -> read x::Int) $ words $ takeWhile (/= '|') $ tail $ dropWhile (/= ':') input
        playerNumbers = map (\x -> read x::Int) $ words $ tail $ dropWhile (/= '|') input


-- Part 2

winningNumbersPerRound :: Game -> [(Int, Int)]
winningNumbersPerRound game = map (\(cardId, round) -> (cardId, winningNumbers round)) (zip [1..] game)

resultingCards :: Game -> Map.Map Int Int
resultingCards game = foldl updateMap result cards
    where 
        result = Map.fromList ([(x, y) | x <- [1 .. length cards], y <- replicate (length cards) (1 :: Int)])
        cards = winningNumbersPerRound game
    

updateMap :: Map.Map Int Int -> (Int, Int) -> Map.Map Int Int
updateMap m (cardId, winners) = applyN currentValue func m
    where
        func mm = foldl (\acc curr -> Map.insertWith (+) (cardId + curr) 1 acc) mm [1..winners]
        currentValue = Map.findWithDefault 0 cardId m 

applyN :: (Num n, Ord n) => n -> (a -> a) -> a -> a
applyN 1 f x = f x
applyN n f x = f (applyN (n-1) f x)
