module Main where

import Data.Tree
import Data.List (elemIndex)
import Data.Maybe (fromJust)
import Data.List.Split (splitOn)

import Lib

tree_origin :: Tree String
tree_origin = Node "COM" []

main :: IO ()
main = do
    part_one
    part_two

part_two :: IO ()
part_two = print 
    . levels 
    . createTree 
    . parse 
      =<< readFile "input2.txt"

part_one :: IO ()
part_one = print 
    . sum
    . calc
    . levels 
    . createTree 
    . parse 
      =<< readFile "input.txt"

calc :: [[String]] -> [Int]
calc input = map (\x -> fst (run x) * snd (run x)) input
    where
        run x = (fromJust $ elemIndex x input , length x)

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
