module Main where

import Lib
import Data.List
import qualified Data.Map as Map  

main :: IO ()
main = do
    putStrLn "partOne:"
    partOne
    putStrLn "partTwo:"
    partTwo

partOne :: IO ()
partOne = do
    input <- readFile "input.txt"
    let inputLines = lines input
    let occupyingCoordinates = concat $ map getOccupyingCoordinates inputLines
    let count = length . filter (\i -> snd i > 1) $ frequency occupyingCoordinates
    print count

partTwo :: IO ()
partTwo = do
    input <- readFile "input.txt"
    let inputLines = lines input

    let board = constructBoard boardSize
    let occupyingCoordinates = map getOccupyingCoordinates inputLines
    let finalBoard = occupyAll' board $ concat occupyingCoordinates
    let stuff = map (\coordsList -> map (\coord -> Map.lookup coord finalBoard) coordsList) occupyingCoordinates
    let moreStuff = map (\s -> all (== Just 1) s) stuff
    let abc = elemIndex True moreStuff
    print abc

