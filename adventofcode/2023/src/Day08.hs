module Day08 (solve, part1, part2) where

import Prelude hiding (Left, Right)
import qualified Data.Map as M
import Data.Maybe (fromJust)
import Data.Char (isLetter)

solve :: String -> IO ()
solve input = putStrLn "--- Day 08 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 input = show $ (\(dir, m) -> run (cycle dir) m ("AAA", 0)) $ parse input

part2 :: String -> String
part2 _ = "Not implemented"

data Direction = Left | Right
    deriving (Show, Eq)

type Map = M.Map String (String, String)

run :: [Direction] -> Map -> (String, Int) -> Int
run _ _ ("ZZZ", steps) = steps
run (dir:dirs) m (coords, steps) = run dirs m (newCoords, steps +1)
    where
        (left, right) = fromJust $ M.lookup coords m 
        newCoords = case dir of
                        Left ->  left
                        Right -> right
run _ _ _ = error "should never happen"

parse :: String -> ([Direction], Map)
parse input = (directions, theMap)
    where
        directions = parseDirections $ head linedInput
        linedInput = lines input
        theMap = parseMap $ drop 2 linedInput

parseDirections :: String -> [Direction]
parseDirections = map parseDirection

parseDirection :: Char -> Direction
parseDirection 'L' = Left
parseDirection 'R' = Right
parseDirection _ = error "unexpected input"

parseMap :: [String] -> Map
parseMap = foldl (\acc curr -> M.insert (parseCurrent curr) (parseLeft curr, parseRight curr) acc) M.empty

parseCurrent :: String -> String
parseCurrent = filter isLetter . takeWhile (/= ' ')

parseLeft :: String -> String
parseLeft = takeWhile (/= ',') .  tail . dropWhile (/= '(')

parseRight:: String -> String
parseRight = filter isLetter . init . tail . dropWhile (/= ',')
