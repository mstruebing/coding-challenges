import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import Lib

main :: IO ()
main = hspec $ do 
    describe "Lib.reduceOppositePolarityOfSameType" $ do
        it "" $
            reduceOppositePolarityOfSameType "aA" `shouldBe` ""
        it "" $
            reduceOppositePolarityOfSameType "abBA" `shouldBe` ""
        it "" $
            reduceOppositePolarityOfSameType "abAB" `shouldBe` "abAB"
        it "" $
            reduceOppositePolarityOfSameType "aabAAB" `shouldBe` "aabAAB"
        it "" $
            reduceOppositePolarityOfSameType "dabAcCaCBAcCcaDA" `shouldBe` "dabCBAcaDA"
