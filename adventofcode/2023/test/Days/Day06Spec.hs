module Days.Day06Spec (spec) where

import Day06
import Test.Hspec

sample :: String
sample = "Time:      7  15   30\n\
\Distance:  9  40  200"

spec :: Spec
spec = do
  describe "Day06" $ do
    it "Should run the example for part 1" $
      part1 sample `shouldBe` "288"
