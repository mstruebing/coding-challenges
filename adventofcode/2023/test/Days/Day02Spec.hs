module Days.Day02Spec (spec) where

import Day02
import Test.Hspec

-- input :: String
-- input = "1abc2\n\
--       \pqr3stu8vwx\n\
--       \a1b2c3d4e5f\n\
--       \treb7uchet\n"

input :: String
input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green\n\
    \Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue\n\
    \Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red\n\
    \Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red\n\
    \Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"


spec :: Spec
spec = do
  describe "Day02" $ do
    it "parseGame example 1" $
      parseGame "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green" `shouldBe` (1, (4, 2, 6))
    it "parseGame example 2" $
      parseGame "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue" `shouldBe` (2, (1, 3, 4))
    it "parseGame example 3" $
      parseGame "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red" `shouldBe` (3, (20, 13, 6))
    it "parseGame example 4" $
      parseGame "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red" `shouldBe` (4, (14, 3, 15))
    it "parseGame example 5" $
      parseGame "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green" `shouldBe` (5, (6, 3, 2))
    it "part 1" $
      part1 input `shouldBe` "8"
    it "part 2" $
      part2 input `shouldBe` "2286"
