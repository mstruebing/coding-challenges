import Lib
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "snafuToDecimal" $ do
    it "1=-0-2" $
      snafuToDecimal "1=-0-2" `shouldBe` 1747
    it "12111" $
      snafuToDecimal "12111" `shouldBe` 906
    it "2=0=" $
      snafuToDecimal "2=0=" `shouldBe` 198
    it "21" $
      snafuToDecimal "21" `shouldBe` 11
    it "2=01" $
      snafuToDecimal "2=01" `shouldBe` 201
    it "111" $
      snafuToDecimal "111" `shouldBe` 31
    it "20012" $
      snafuToDecimal "20012" `shouldBe` 1257
    it "112" $
      snafuToDecimal "112" `shouldBe` 32
    it "1=-1=" $
      snafuToDecimal "1=-1=" `shouldBe` 353
    it "1-12" $
      snafuToDecimal "1-12" `shouldBe` 107
    it "12" $
      snafuToDecimal "12" `shouldBe` 7
    it "1=" $
      snafuToDecimal "1=" `shouldBe` 3
    it "122" $
      snafuToDecimal "122" `shouldBe` 37
