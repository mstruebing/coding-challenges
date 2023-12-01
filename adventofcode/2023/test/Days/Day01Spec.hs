module Days.Day01Spec (spec) where

import Day01
import Test.Hspec

input :: String
input = "1abc2\n\
      \pqr3stu8vwx\n\
      \a1b2c3d4e5f\n\
      \treb7uchet\n"

spec :: Spec
spec = do
  describe "Day01" $ do
    it "getCalibrationValue example 1" $
      getCalibrationValue "1abc2" `shouldBe` 12
    it "getCalibrationValue example 2" $
      getCalibrationValue "pqr3stu8vwx" `shouldBe` 38
    it "getCalibrationValue example 3" $
      getCalibrationValue "a1b2c3d4e5f" `shouldBe` 15
    it "getCalibrationValue example 4" $
      getCalibrationValue "treb7uchet" `shouldBe` 77
    it "part 1 example" $ 
        part1 input `shouldBe` "142"
