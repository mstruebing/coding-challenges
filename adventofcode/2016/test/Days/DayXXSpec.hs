module Days.DayXXSpec (spec) where

import DayXX
import Test.Hspec

spec :: Spec
spec = do
  describe "DayXX" $ do
    it "Shoud run the test" $
      1 + 2 `shouldBe` 3
