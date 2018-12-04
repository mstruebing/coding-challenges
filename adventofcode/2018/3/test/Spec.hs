import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import Data.Map

import Lib

main :: IO ()
main = hspec $ do 
    describe "Lib.getSize" $ do
        it "#123 @ 3,2: 5x4 should be (3, 2)" $
            Lib.getSize "#123 @ 3,2: 5x4" `shouldBe` (5, 4)
    describe "Lib.getStartingPoint" $ do
        it "#123 @ 3,2: 5x4 should be (3, 2)" $
            Lib.getStartingPoint "#123 @ 3,2: 5x4" `shouldBe` (3, 2)
    describe "Lib.constructBoard" $ do
        it "3 should be " $
            Lib.constructBoard 3 `shouldBe` fromList [((0,0),0),((0,1),0),((0,2),0),((0,3),0),((1,0),0),((1,1),0),((1,2),0),((1,3),0),((2,0),0),((2,1),0),((2,2),0),((2,3),0),((3,0),0),((3,1),0),((3,2),0),((3,3),0)]
    describe "Lib.occupy" $ do
        it "" $
            occupy (Lib.constructBoard 3) (0,0) `shouldBe` fromList [((0,0),1),((0,1),0),((0,2),0),((0,3),0),((1,0),0),((1,1),0),((1,2),0),((1,3),0),((2,0),0),((2,1),0),((2,2),0),((2,3),0),((3,0),0),((3,1),0),((3,2),0),((3,3),0)]
    describe "Lib.occupy" $ do
        it "" $
            occupy (Lib.constructBoard 3) (1,0) `shouldBe` fromList [((0,0),0),((0,1),0),((0,2),0),((0,3),0),((1,0),1),((1,1),0),((1,2),0),((1,3),0),((2,0),0),((2,1),0),((2,2),0),((2,3),0),((3,0),0),((3,1),0),((3,2),0),((3,3),0)]
        it "" $
            occupy (occupy (Lib.constructBoard 3) (0,0)) (0,0) `shouldBe` fromList [((0,0),2),((0,1),0),((0,2),0),((0,3),0),((1,0),0),((1,1),0),((1,2),0),((1,3),0),((2,0),0),((2,1),0),((2,2),0),((2,3),0),((3,0),0),((3,1),0),((3,2),0),((3,3),0)]
    describe "Lib.getOccupyingCoordinates" $ do
        it "" $
            getOccupyingCoordinates "#123 @ 0,0: 2x2" `shouldBe` [(0,0),(0,1),(1,0),(1,1)]
        it "" $
            getOccupyingCoordinates "#123 @ 1,1: 2x2" `shouldBe` [(1,1),(1,2),(2,1),(2,2)]
