import Test.Hspec
import Test.QuickCheck

import Lib

main :: IO ()
main = hspec $ do
    describe "Lib.getPatternForIndex" $ do 
        it "Should offset for index 0 correctly" $
            Lib.getPatternForIndex 0 `shouldBe` [0, 1, 0, -1]
        it "Should offset for index 1 correctly" $
            Lib.getPatternForIndex 1 `shouldBe` [0, 0, 1, 1, 0, 0, -1, -1]
        it "Should offset for index 2 correctly" $
            Lib.getPatternForIndex 2 `shouldBe` [0, 0, 0, 1, 1, 1, 0, 0, 0, -1, -1, -1]
    describe "Lib.getLastDigit" $ do
        it "Should get last digit correctly for 38" $
            Lib.getLastDigit 38 `shouldBe` 8
        it "Should get last digit correctly for 4555" $
            Lib.getLastDigit 4555 `shouldBe` 5
    describe "Lib.calcSingleRow" $ do
        it "Should be 4" $
            (Lib.calcSingleRow [1,2,3,4,5,6,7,8] $ getPatternForIndex 0) `shouldBe` 4
        it "Should be 8" $
            (Lib.calcSingleRow [1,2,3,4,5,6,7,8] $ getPatternForIndex 1) `shouldBe` 8
        it "Should be 2" $
            (Lib.calcSingleRow [1,2,3,4,5,6,7,8] $ getPatternForIndex 2) `shouldBe` 2    
    describe "Lib.calcPhase" $ do
        it "Should be 48226158" $
            Lib.calcPhase [1,2,3,4,5,6,7,8] `shouldBe` [4,8,2,2,6,1,5,8]
        it "Should be 34040438" $
            Lib.calcPhase [4,8,2,2,6,1,5,8] `shouldBe` [3,4,0,4,0,4,3,8]
        it "Should be 03415518" $
            Lib.calcPhase [3,4,0,4,0,4,3,8] `shouldBe` [0, 3,4,1,5,5,1,8]
        it "Should be 01029498" $
            Lib.calcPhase [0, 3,4,1,5,5,1,8] `shouldBe` [0, 1,0,2,9,4,9,8]
    describe "Lib.calcPhases" $ do 
        it "Should become 01029498" $
            Lib.calcPhases 4 12345678 `shouldBe` [0,1,0,2,9,4,9,8]
        it "Should become 24176176" $
            Lib.calcPhases 100 80871224585914546619083218645595 `shouldBe` [2,4,1,7,6,1,7,6]
        it "Should become 73745418" $
            Lib.calcPhases 100 19617804207202209144916044189917 `shouldBe` [7,3,7,4,5,4,1,8]
        it "Should become 52432133" $
            Lib.calcPhases 100 69317163492948606335995924319873 `shouldBe` [5,2,4,3,2,1,3,3]
