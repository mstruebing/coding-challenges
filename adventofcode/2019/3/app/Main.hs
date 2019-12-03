module Main where

import Data.List.Split (splitOn)

import Lib

main :: IO ()
main =  do
    partOne
    partTwo


getInput :: IO String
getInput = readFile "input1.txt"

partOne :: IO ()
partOne = print . run_first . parse =<< getInput

partTwo :: IO ()
partTwo = print . run_second . parse =<< getInput

parse :: String -> [[Movement]]
parse = map (\movementList -> foldr (\stringMovement movements -> (parseMovement stringMovement) : movements) [] movementList) . 
    transformIntoTwoLists . filter (\x -> length x /= 0) . splitOn "\n" 

transformIntoTwoLists :: [String] -> [[String]]
transformIntoTwoLists (x:y:[]) = [splitOn "," x, splitOn "," y]

parseMovement :: String -> Movement
parseMovement ('U':xs) = Movement Lib.Up (read xs)
parseMovement ('R':xs) = Movement Lib.Right (read xs)
parseMovement ('D':xs) = Movement Lib.Down (read xs)
parseMovement ('L':xs) = Movement Lib.Left (read xs)
