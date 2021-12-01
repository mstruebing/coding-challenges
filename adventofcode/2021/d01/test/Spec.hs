import Test.Hspec
import Test.QuickCheck

import Lib

input :: [Int]
input = [199 ,200 ,208 ,210 ,200 ,207 ,240 ,269 ,260 ,263]

sliceOutput :: [[Int]]
sliceOutput = [[199, 200, 208], [200, 208, 210], [208, 210, 200], [210, 200, 207], [200, 207, 240], [207, 240, 269], [240, 269, 260], [269, 260, 263]]

input2 :: [Int]
input2 = [607, 618, 618, 617, 647, 716, 769, 792] 

main :: IO ()
main = hspec $ do   
    describe "Part 1" $ do
        it "Calcs the correct values" $
            Lib.calc input `shouldBe` 7
    describe " Part 2" $ do
        it "Slices the list correct" $
            Lib.slice input `shouldBe` sliceOutput
        it "Sums the slices correct" $
            Lib.sumSlices sliceOutput `shouldBe` [607, 618, 618, 617, 647, 716, 769, 792]
        it "Calcs the correct values" $
            Lib.calc input2 `shouldBe` 5
