import Test.Hspec
import Test.QuickCheck

import Lib

main :: IO ()
main = hspec $ do   
    describe "Lib.neededFuelForMass" $ do
        it "12 should be 2" $
            Lib.neededFuelForMass 12 `shouldBe` 2
        it "14 should be 2" $
            Lib.neededFuelForMass 14 `shouldBe` 2
        it "1969 should be 654" $
            Lib.neededFuelForMass 1969 `shouldBe` 654
        it "100756 should be 33583" $
            Lib.neededFuelForMass 100756 `shouldBe` 33583
    describe "Lib.neededFuelForMass2nd" $ do
        it "14 shouldBe 2" $
            Lib.neededFuelForMass2nd 14 `shouldBe` 2
        it "1969 shouldBe 966" $
            Lib.neededFuelForMass2nd 1969 `shouldBe` 966
        it "100756 shouldBe 50346" $
            Lib.neededFuelForMass2nd 100756 `shouldBe` 50346
