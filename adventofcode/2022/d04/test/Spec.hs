import Lib
import Test.Hspec

input :: [String]
input =
  ["2-4,6-8", "2-3,4-5", "5-7,7-9", "2-8,3-7", "6-6,4-6", "2-6,4-8"]

main :: IO ()
main = hspec $ do
  describe "Lib.parseSingle" $ do
    it "1" $
      Lib.parseSingle "2-4" `shouldBe` [2 .. 4]
    it "2" $
      Lib.parseSingle "6-6" `shouldBe` [6]
  describe "Lib.parseLine" $ do
    it "1" $
      Lib.parseLine (input !! 0) `shouldBe` ([2 .. 4], [6 .. 8])
    it "2" $
      Lib.parseLine (input !! 1) `shouldBe` ([2, 3], [4, 5])
    it "3" $
      Lib.parseLine (input !! 2) `shouldBe` ([5 .. 7], [7 .. 9])
    it "4" $
      Lib.parseLine (input !! 3) `shouldBe` ([2 .. 8], [3 .. 7])
    it "5" $
      Lib.parseLine (input !! 4) `shouldBe` ([6], [4 .. 6])
    it "6" $
      Lib.parseLine (input !! 5) `shouldBe` ([2 .. 6], [4 .. 8])
  describe "Lib.parse" $ do
    it "1" $
      Lib.parse input
        `shouldBe` [ ( [2 .. 4],
                       [6 .. 8]
                     ),
                     ([2, 3], [4, 5]),
                     ([5 .. 7], [7 .. 9]),
                     ([2 .. 8], [3 .. 7]),
                     ([6], [4 .. 6]),
                     ([2 .. 6], [4 .. 8])
                   ]
  describe "Lib.isSubset" $ do
    it "1" $
      Lib.isSubset ([2 .. 4], [6 .. 8]) `shouldBe` False
    it "2" $
      Lib.isSubset ([2, 3], [4, 5]) `shouldBe` False
    it "3" $
      Lib.isSubset ([5 .. 7], [7 .. 9]) `shouldBe` False
    it "4" $
      Lib.isSubset ([2 .. 8], [3 .. 7]) `shouldBe` True
    it "5" $
      Lib.isSubset ([6], [4 .. 6]) `shouldBe` True
    it "6" $
      Lib.isSubset ([2 .. 6], [4 .. 8]) `shouldBe` False
  describe "Lib.first" $ do
    it "1" $
      Lib.first (parse input) `shouldBe` 2
