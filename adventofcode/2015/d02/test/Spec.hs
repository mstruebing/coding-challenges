import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "parseSingle" $ do
    it "1x1x1" $
      Lib.parseSingle "1x1x1" `shouldBe` (1, 1, 1)
    it "1x2x3" $
      Lib.parseSingle "1x2x3" `shouldBe` (1, 2, 3)
  describe "parse" $ do
    it "[1x1x1, 1x2x3]" $
      Lib.parse ["1x1x1", "1x2x3"] `shouldBe` [(1, 1, 1), (1, 2, 3)]
  describe "calculateSingle" $ do
    it "(2,3,4)" $
      Lib.calculateSingle (2, 3, 4) `shouldBe` 58
    it "(1,1,10)" $
      Lib.calculateSingle (1, 1, 10) `shouldBe` 43
  describe "calculateSingle2" $ do
    it "(2,3,4)" $
      Lib.calculateSingle2 (2, 3, 4) `shouldBe` 34
    it "(1,1,10)" $
      Lib.calculateSingle2 (1, 1, 10) `shouldBe` 14
