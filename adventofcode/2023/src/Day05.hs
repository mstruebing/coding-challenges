{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module Day05 (solve, part1, part2, seeds, seedToSoil, SourceDestinationMap, soilToFertilizer, fertilizerToWater, waterToLight, lightToTemperature, temperatureToHumidity, humidityToLocation, getLocationForMap, getLocation, targetLocation) where
import Data.Char (isDigit)
import qualified Data.Map as Map
import Data.List (isPrefixOf, find)
import Data.Maybe (fromMaybe)

solve :: String -> IO ()
solve input = putStrLn "--- Day 05 ---" >> putStrLn (part1 input) >> putStrLn (part2 input)

part1 :: String -> String
part1 = show . targetLocation

part2 :: String -> String
part2 _ = "Not implemented"

-- destination start - source start - range length
-- <->
-- (source range start, source range end) -> diff
type SourceDestinationMap = Map.Map (Integer, Integer) Integer

seeds :: String -> [Integer]
seeds = map read . words . dropWhile (not . isDigit) . head  . lines

seedToSoil :: String -> SourceDestinationMap
seedToSoil = mapCreationHelper "seed-to-soil"

soilToFertilizer :: String -> SourceDestinationMap
soilToFertilizer = mapCreationHelper "soil-to-fertilizer"

fertilizerToWater :: String -> SourceDestinationMap
fertilizerToWater = mapCreationHelper "fertilizer-to-water"

waterToLight :: String -> SourceDestinationMap
waterToLight = mapCreationHelper "water-to-light"

lightToTemperature :: String -> SourceDestinationMap
lightToTemperature = mapCreationHelper "light-to-temperature"

temperatureToHumidity :: String -> SourceDestinationMap
temperatureToHumidity = mapCreationHelper "temperature-to-humidity"

humidityToLocation :: String -> SourceDestinationMap
humidityToLocation = mapCreationHelper "humidity-to-location"

mapCreationHelper :: String -> String -> SourceDestinationMap
mapCreationHelper mapType = foldl (\m [destStart, sourceStart, range] -> Map.insert (sourceStart, sourceStart + range - 1) (destStart - sourceStart) m) Map.empty
    . map (map (\x -> read x :: Integer) . words)
    . takeWhile (not . null)
    . drop 1
    . dropWhile (\x -> not $ mapType `isPrefixOf` x)
    . lines

getLocationForMap :: SourceDestinationMap -> Integer -> Integer
getLocationForMap m source = source + diff
    where
        diff = fromMaybe 0 $ Map.lookup key m
        key = fromMaybe (-1, -1) $ find (\(rangeStart, rangeEnd) -> source >= rangeStart && source <= rangeEnd) keys
        keys = Map.keys m

getLocation :: [SourceDestinationMap] -> Integer -> Integer
getLocation maps source = foldl (flip getLocationForMap) source maps

targetLocation :: String -> Integer
targetLocation input = minimum $ map (getLocation maps) s
    where
        maps = map (\x -> x input) [seedToSoil, soilToFertilizer, fertilizerToWater, waterToLight, lightToTemperature, temperatureToHumidity, humidityToLocation]
        s = seeds input
