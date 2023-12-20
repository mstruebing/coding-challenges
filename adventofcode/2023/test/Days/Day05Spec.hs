module Days.Day05Spec (spec) where

import Day05
import Test.Hspec
import qualified Data.Map as Map

sample :: String
sample = "seeds: 79 14 55 13\n\
\\n\
\seed-to-soil map:\n\
\50 98 2\n\
\52 50 48\n\
\\n\
\soil-to-fertilizer map:\n\
\0 15 37\n\
\37 52 2\n\
\39 0 15\n\
\\n\
\fertilizer-to-water map:\n\
\49 53 8\n\
\0 11 42\n\
\42 0 7\n\
\57 7 4\n\
\\n\
\water-to-light map:\n\
\88 18 7\n\
\18 25 70\n\
\\n\
\light-to-temperature map:\n\
\45 77 23\n\
\81 45 19\n\
\68 64 13\n\
\\n\
\temperature-to-humidity map:\n\
\0 69 1\n\
\1 0 69\n\
\\n\
\humidity-to-location map:\n\
\60 56 37\n\
\56 93 4"

expectedSeedToSoilMap :: SourceDestinationMap
expectedSeedToSoilMap = Map.fromList [((98, 99), -48), ((50, 97), 2)]

expcetedSoilToFertilizerMap :: SourceDestinationMap
expcetedSoilToFertilizerMap = Map.fromList [((15, 15+37-1), -15), ((52, 53), 37-52), ((0, 14), 39)]

expectedFertilizerToWaterMap :: SourceDestinationMap
expectedFertilizerToWaterMap = Map.fromList [((53, 53+8-1), 49-53), ((11, 11+42 -1), -11), ((0, 6), 42), ((7, 10), 50)]

expectedWaterToLightMap :: SourceDestinationMap
expectedWaterToLightMap = Map.fromList [((18, 24), 70), ((25, 94), -7)]

maps :: [SourceDestinationMap]
maps = [seedToSoil sample, soilToFertilizer sample, fertilizerToWater sample, waterToLight sample, lightToTemperature sample, temperatureToHumidity sample, humidityToLocation sample]

spec :: Spec
spec = do
  describe "Day05" $ do
    it "Should parse seeds correctly" $
      seeds sample `shouldBe` [79, 14, 55, 13]
    it "Should parse seedToSoil correctly" $
      seedToSoil sample `shouldBe` expectedSeedToSoilMap
    it "Should parse soilToFertilizer correctly" $
      soilToFertilizer sample `shouldBe` expcetedSoilToFertilizerMap
    it "Should parse fertilizerToWater correctly" $
      fertilizerToWater sample `shouldBe` expectedFertilizerToWaterMap
    it "Should parse waterToLight correctly" $
      waterToLight sample `shouldBe` expectedWaterToLightMap
    it "Should correctly get the destination 1" $
      getLocationForMap (seedToSoil sample) 79 `shouldBe` 81
    it "Should correctly get the destination 2" $
      getLocationForMap (seedToSoil sample) 14 `shouldBe` 14
    it "Should correctly get the destination 3" $
      getLocationForMap (seedToSoil sample) 55 `shouldBe` 57
    it "Should correctly get the destination 4" $
      getLocationForMap (seedToSoil sample) 13 `shouldBe` 13
    it "Should correctly get the location 1" $
      getLocation maps 79  `shouldBe` 82
    it "Should correctly get the location 2" $
      getLocation maps 14  `shouldBe` 43
    it "Should correctly get the location 3" $
      getLocation maps 55  `shouldBe` 86
    it "Should correctly get the location 4" $
      getLocation maps 13  `shouldBe` 35
    it "part 1" $
      part1 sample `shouldBe` "35"
