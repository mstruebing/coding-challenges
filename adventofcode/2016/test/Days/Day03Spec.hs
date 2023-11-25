module Days.Day03Spec (spec) where

import Test.Hspec
import Day03 (possible, parseLine , parseSecond, Triangle)

input :: [String]
input = ["101 301 501" , "102 302 502" , "103 303 503", "201 401 601" , "202 402 602", "203 403 603"]

expected :: [Triangle]
expected = [(101, 102, 103), (201, 202, 203), (301, 302, 303), (401, 402, 403), (501, 502, 503), (601, 602, 603)]

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
    describe "parseSecond" $ do
      it "should parse correctly" $
        parseSecond input `shouldBe` expected
