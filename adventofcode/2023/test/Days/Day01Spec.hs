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
    it "getCalibrationValueEnhanced example 1" $
      getCalibrationValueEnhanced "two1nine" `shouldBe` 29
    it "getCalibrationValueEnhanced example 2" $
      getCalibrationValueEnhanced "eightwothree" `shouldBe` 83
    it "getCalibrationValueEnhanced example 3" $
      getCalibrationValueEnhanced "abcone2threexyz" `shouldBe` 13
    it "getCalibrationValueEnhanced example 4" $
      getCalibrationValueEnhanced "xtwone3four" `shouldBe` 24
    it "getCalibrationValueEnhanced example 5" $
      getCalibrationValueEnhanced "4nineeightseven2" `shouldBe` 42
    it "getCalibrationValueEnhanced example 6" $
      getCalibrationValueEnhanced "zoneight234" `shouldBe` 14
    it "getCalibrationValueEnhanced example 7" $
      getCalibrationValueEnhanced "7pqrstsixteen" `shouldBe` 76
