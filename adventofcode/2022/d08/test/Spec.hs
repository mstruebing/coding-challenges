import Lib
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Lib" $ do
    it "singleDirectionScenicScore.1" $
      Lib.singleDirectionScenicScore 5 [3] `shouldBe` 1
    it "singleDirectionScenicScore.2" $
      Lib.singleDirectionScenicScore 5 [5, 2] `shouldBe` 1
    it "singleDirectionScenicScore.3" $
      Lib.singleDirectionScenicScore 5 [1, 2] `shouldBe` 2
    it "singleDirectionScenicScore.4" $
      Lib.singleDirectionScenicScore 5 [3, 5, 3] `shouldBe` 2
    it "singleDirectionScenicScore.5" $
      Lib.singleDirectionScenicScore 5 [3, 5, 3] `shouldBe` 2
    it "singleDirectionScenicScore.6" $
      Lib.singleDirectionScenicScore 5 [3, 3] `shouldBe` 2
    it "singleDirectionScenicScore.7" $
      Lib.singleDirectionScenicScore 5 [3] `shouldBe` 1
    it "singleDirectionScenicScore.8" $
      Lib.singleDirectionScenicScore 5 [4, 9] `shouldBe` 2
    it "scenicScore.1" $
      Lib.scenicScore (constructMap sample) (3, 2) `shouldBe` 8
    it "scenicScore.2" $
      Lib.scenicScore (constructMap sample) (1, 2) `shouldBe` 4
    it "highestScenicScore" $
      Lib.highestScenicScore (constructMap sample) `shouldBe` 8
