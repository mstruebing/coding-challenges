import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "calcNextDay" $ do
    it "calcNextDay" $
      calcNextDay [3, 4, 3, 1, 2] `shouldBe` [2, 3, 2, 0, 1]
    it "calc" $
      calc 18 [3, 4, 3, 1, 2] `shouldBe` 26
    it "calc2" $
      calc 80 [3, 4, 3, 1, 2] `shouldBe` 5934
    it "calc part two" $
      calc 256 [3, 4, 3, 1, 2] `shouldBe` 26984457539
