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
  describe "Lib.findPacketMarker" $ do
    it "1" $
      findPacketMarker "bvwbjplbgvbhsrlpgdmjqwftvncz" `shouldBe` 5
    it "2" $
      findPacketMarker "nppdvjthqldpwncqszvftbrmjlhg" `shouldBe` 6
    it "3" $
      findPacketMarker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" `shouldBe` 10
    it "4" $
      findPacketMarker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" `shouldBe` 11
  describe "Lib.findStartOfMessageMarker" $ do
    it "1" $
      findStartOfMessageMarker "mjqjpqmgbljsphdztnvjfqwrcgsmlb" `shouldBe` 19
    it "2" $
      findStartOfMessageMarker "bvwbjplbgvbhsrlpgdmjqwftvncz" `shouldBe` 23
    it "3" $
      findStartOfMessageMarker "nppdvjthqldpwncqszvftbrmjlhg" `shouldBe` 23
    it "4" $
      findStartOfMessageMarker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" `shouldBe` 29
    it "5" $
      findStartOfMessageMarker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" `shouldBe` 26
