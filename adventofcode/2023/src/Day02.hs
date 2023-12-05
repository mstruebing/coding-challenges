module Day02 (solve, part1, part2, parseGame) where
import Data.Char (isDigit)
import Data.List.Split (splitOn)
import Data.List (isInfixOf, find)

solve :: String -> IO ()
solve input = putStrLn "--- Day 02 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

-- Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
-- Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
-- Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
-- Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
-- Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

-- Red, Green, Blue
type Colors = (Int, Int, Int)

type Game = (Int, Colors)

availableRedCubes :: Int
availableRedCubes = 12

availableGreenCubes :: Int
availableGreenCubes = 13

availableBlueCubes :: Int
availableBlueCubes = 14

part1 :: String -> String
part1 input = show $ foldl (\acc curr -> if possible (snd curr) then acc + fst curr else acc) 0 (parse input)

part2 :: String -> String
part2 input = show $ foldl (\acc curr -> acc + multiply (snd curr)) 0 (parse input)
    where
        multiply (r,g,b) = r*g*b

-- part 1

parse :: String -> [Game]
parse = map parseGame . lines

parseGame :: String -> Game
parseGame input = (gameId, colors input)
    where
        gameId = (\x -> read x::Int) $ filter isDigit $ takeWhile (/= ':') input


colors :: String -> Colors
colors input = foldl (\(r,g,b) (nR,nG,nB) -> (max r nR, max g nG, max b nB)) (0,0,0) showCases
    where
        showCases = map getSingleShowCaseColors rawShowCases
        rawShowCases = splitOn (";") . dropWhile (not . isDigit) $ dropWhile (/= ':') input

getSingleShowCaseColors :: String -> Colors
getSingleShowCaseColors input = (red, green, blue)
    where
        red = getSingleColor "red" singleColors
        green = getSingleColor "green" singleColors
        blue = getSingleColor "blue" singleColors
        singleColors = splitOn "," input

getSingleColor :: String -> [String] -> Int
getSingleColor target input = case color of
    Just c -> (\x -> read x :: Int) $ filter isDigit c
    Nothing -> 0
    where
        color = find (isInfixOf target) input

possible :: Colors -> Bool
possible (red, green, blue) = red <= availableRedCubes && green <= availableGreenCubes && blue <= availableBlueCubes
