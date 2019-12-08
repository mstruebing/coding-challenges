module Main where

import Data.List.Split (chunksOf)
import Data.Char (isDigit, digitToInt)
import Data.List (elemIndex)
import Data.Maybe (fromJust)

type Image = [[Int]]
type Layer = [Int]

imageWidth :: Int
imageWidth = 25

imageHeight :: Int
imageHeight = 6

imageFile :: String
imageFile = "input.txt"

main :: IO ()
main = 
    print 
    . multiplyNumbersOfLayer 1 2
    . getLayerWithLeastNumbers 0 
    . parse 
      =<< readFile imageFile 

parse :: String -> Image
parse = 
    (chunksOf $ imageWidth * imageHeight) . map digitToInt . filter (isDigit)

numbersOnLayer :: Int -> Layer -> Int
numbersOnLayer number = 
    length . filter (== number) 

getLayerWithLeastNumbers :: Int -> Image -> Layer
getLayerWithLeastNumbers number image = image !! index
    where
        layers = map (numbersOnLayer number) image
        index = fromJust $ elemIndex (minimum layers) layers

multiplyNumbersOfLayer :: Int -> Int -> Layer -> Int
multiplyNumbersOfLayer number_one number_two layer = 
    (numbersOnLayer number_one layer) * (numbersOnLayer number_two layer)
