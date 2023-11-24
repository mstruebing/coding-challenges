module Days.Day03Spec (spec) where

import Test.Hspec
import Day03 (possible, parseLine)

spec :: Spec
spec = do
  describe "Day03" $ do
    describe "possible" $ do
      it "should be false" $
        possible (5, 10, 25) `shouldBe` False
      it "should be true" $
        possible (5, 10, 12) `shouldBe` True
    describe "parse" $ do
      it "sample sorted" $
        parseLine "5 10 25" `shouldBe` (5, 10, 25)
      it "sample unsorted" $
        parseLine "5 25 10 " `shouldBe` (5, 10, 25)
