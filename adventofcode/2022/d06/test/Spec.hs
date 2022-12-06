import Lib
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Lib.allCharsDifferent" $ do
    it "1" $
      allCharsDifferent "abcd" `shouldBe` True
    it "2" $
      allCharsDifferent "abcc" `shouldBe` False
    it "3" $
      allCharsDifferent "xyzz" `shouldBe` False
    it "4" $
      allCharsDifferent "aghk" `shouldBe` True
  describe "Lib.getFourCharsAtIndex" $ do
    it "1" $
      getFourCharsAtIndex "bvwbjplbgvbhsrlpgdmjqwftvncz" 1 `shouldBe` "vwbj"
    it "2" $
      getFourCharsAtIndex "nppdvjthqldpwncqszvftbrmjlhg" 2 `shouldBe` "pdvj"
  describe "Lib.findFirstMarker" $ do
    it "1" $
      findFirstMarker "bvwbjplbgvbhsrlpgdmjqwftvncz" `shouldBe` 5
    it "2" $
      findFirstMarker "nppdvjthqldpwncqszvftbrmjlhg" `shouldBe` 6
    it "3" $
      findFirstMarker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" `shouldBe` 10
    it "4" $
      findFirstMarker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" `shouldBe` 11
