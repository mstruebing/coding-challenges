module Main where

import Data.List.Split (chunksOf)
import Data.Char (isDigit, digitToInt)
import Data.List (elemIndex, intercalate)
import Data.Maybe (fromJust)

type Image = [[Int]]
type Layer = [Int]
type Color = Int

imageWidth :: Int
imageWidth = 25

imageHeight :: Int
imageHeight = 6

imageFile :: String
imageFile = "input.txt"

black :: Int
black = 0

white :: Int
white = 1

transparent :: Int
transparent = 2

main :: IO ()
main = do
    part_one
    part_two

part_two :: IO ()
part_two = 
    putStrLn
    . intercalate "\n"
    . chunksOf imageWidth
    . convertToAsci
    . getMergedLayer
    . parse 
      =<< readFile imageFile 

convertToAsci :: Layer -> [Char]
convertToAsci = map(\x -> if x == black then ' ' else '#')

getMergedLayer :: Image -> Layer
getMergedLayer layers = 
    foldl (\acc curr -> mergeLayer acc curr) 
    (replicate (length $ layers !! 0) transparent) 
    layers

mergeLayer :: Layer -> Layer -> Layer
mergeLayer layerOne layerTwo = 
    map mergeColor $ zip layerOne layerTwo

mergeColor :: (Color, Color) -> Color
mergeColor x = 
    if fst x == transparent then snd x else fst x

part_one :: IO ()
part_one = 
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
