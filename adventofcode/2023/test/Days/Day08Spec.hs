module Days.Day08Spec (spec) where

import Day08
import Test.Hspec

sample :: String
sample = "RL\n\
\\n\
\AAA = (BBB, CCC)\n\
\BBB = (DDD, EEE)\n\
\CCC = (ZZZ, GGG)\n\
\DDD = (DDD, DDD)\n\
\EEE = (EEE, EEE)\n\
\GGG = (GGG, GGG)\n\
\ZZZ = (ZZZ, ZZZ)"


spec :: Spec
spec = do
  describe "Day08" $ do
    it "Should calculate part 1 correctly" $
      part1 sample `shouldBe` "2"
