module Main where

import Data.Tree
import Data.List (elemIndex)
import Data.Maybe (fromJust)
import Data.List.Split (splitOn)

import Lib

tree_origin :: Tree String
tree_origin = Node "COM" []

main :: IO ()
main = print 
    .calc
    . levels 
    . createTree 
    . parse 
      =<< readFile "input.txt"

calc :: [[String]] -> Int
calc input = sum $ map (\(x,y) -> x * y) $ map (\x -> (fromJust $ elemIndex x input , length x)) input

createTree :: [(String, String)] -> Tree String
createTree input = 
    unfoldTree 
    (\x -> let xs = map snd . filter ((== x) . fst) $ input in (x, xs)) 
    "COM"

parse :: String -> [(String, String)]
parse = 
    map (\x -> (head x, head $ tail x)) 
    . map (splitOn (")")) 
    . filter (/= "") 
    . splitOn "\n" 
