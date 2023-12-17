module Days.Day15Spec (spec) where

import Day15
import Test.Hspec


input :: String
input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

inputWithNewline :: String
inputWithNewline = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7\n"


spec :: Spec
spec = do
  describe "Day15" $ do
    it "should hash \"HASH\" correctly" $
      hash "HASH" `shouldBe` 52
    it "should give the correct result for the example" $
        part1 input `shouldBe` "1320"
    it "should give the correct result for the example with newline" $
        part1 inputWithNewline `shouldBe` "1320"
