module Days.Day03Spec (spec) where

import Day03
import Test.Hspec

input :: String
input = "467..114..\n\
\...*......\n\
\..35..633.\n\
\......#...\n\
\617*......\n\
\.....+.58.\n\
\..592.....\n\
\......755.\n\
\...$.*....\n\
\.664.598.."

spec :: Spec
spec = do
  describe "DayXX" $ do
    it "Shoud run the test" $
      1 + 2 `shouldBe` 3
      -- part1 input `shouldBe` "4361"
