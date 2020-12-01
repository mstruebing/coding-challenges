import Test.Hspec
import Test.QuickCheck

import Lib

main :: IO ()
main = hspec $ do   
    describe "Lib.getValues" $ do
        it "Get correct values" $
            Lib.getValues [100, 2000, 20, 50] `shouldBe` [2000, 20]
    describe "Lib.getValues2" $ do
        it "Get correct values" $
            Lib.getValues2 [1721, 979, 366, 299, 675, 1456] `shouldBe` [979, 366, 675]
    describe "Lib.mulitplyList" $ do
        it "mulitply correctly" $
            Lib.mulitplyList [2000, 20] `shouldBe` 40000
