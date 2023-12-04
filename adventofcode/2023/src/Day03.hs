module Day03 (solve, part1, part2, symbols, numbers, testInput) where
import qualified Data.Set
import Data.Char (isDigit, digitToInt)
import Data.Set (fromList)

solve :: String -> IO ()
solve input = putStrLn "--- Day 03 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 _ = "Not implemented"

part2 :: String -> String
part2 _ = "Not implemented"

type Coordinates = (Int, Int)

whatever :: Data.Set.Set Coordinates -> [(Coordinates, Int)] -> [(Coordinates, Int)]
whatever sym num = undefined

numbers :: [String] -> [(Coordinates, Int)]
numbers input = coords
    where
        coords = [((x,y), digitToInt (currentChar x y)) | x <- [0 .. lengthX], y <- lengthY, isDigit $ currentChar x y]
        lengthX = length (head input) - 1
        lengthY = [0 .. length input -1]
        currentChar x y = (input !! x) !! y

symbols :: [String] -> Data.Set.Set Coordinates
symbols input = fromList coords
    where
        coords = [(x,y) | x <- [0 .. lengthX], y <- lengthY, isValidChar $ currentChar x y]
        lengthX = length (head input) - 1
        lengthY = [0 .. length input -1]
        currentChar x y = (input !! x) !! y

isValidChar :: Char -> Bool
isValidChar c = not (isDigit c) && c /= '.'

testInput :: String
testInput = "467..114..\n\
\...*......\n\
\..35..633.\n\
\......#...\n\
\617*......\n\
\.....+.58.\n\
\..592.....\n\
\......755.\n\
\...$.*....\n\
\.664.598.."
