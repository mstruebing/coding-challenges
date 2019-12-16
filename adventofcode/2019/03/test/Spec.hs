import Test.Hspec
import Test.QuickCheck

import Lib

main :: IO ()
main = hspec $ do   
    -- describe "Lib.move" $ do
    --     it "Should move up correctly one step from origin" $
    --         Lib.move (0, 0) (Movement Lib.Up 1)  `shouldBe` (0, 1)
    --     it "Should move up correctly 4 step from positive point" $
    --         Lib.move (2, 2) (Movement Lib.Up 4)  `shouldBe` (2, 6)
    --     it "Should move up correctly 4 step from negative point" $
    --         Lib.move (10, -10) (Movement Lib.Up 4)  `shouldBe` (10, -6)
    --     it "Should move right correctly one step from origin" $
    --         Lib.move (0, 0) (Movement Lib.Right 1)  `shouldBe` (1, 0)
    --     it "Should move right correctly 4 step from positive point" $
    --         Lib.move (2, 0) (Movement Lib.Right 4)  `shouldBe` (6, 0)
    --     it "Should move right correctly 4 step from negative point" $
    --         Lib.move (-10, 0) (Movement Lib.Right 4)  `shouldBe` (-6, 0)
    --     it "Should move down correctly one step from origin" $
    --         Lib.move (0, 0) (Movement Lib.Down 1)  `shouldBe` (0, -1)
    --     it "Should move down correctly 4 step from positive point" $
    --         Lib.move (2, 2) (Movement Lib.Down 4)  `shouldBe` (2, -2)
    --     it "Should move down correctly 4 step from negative point" $
    --         Lib.move (10, -10) (Movement Lib.Down 4)  `shouldBe` (10, -14)
    --     it "Should move left correctly one step from origin" $
    --         Lib.move (0, 0) (Movement Lib.Left 1)  `shouldBe` (-1, 0)
    --     it "Should move left correctly 4 step from positive point" $
    --         Lib.move (2, 0) (Movement Lib.Left 4)  `shouldBe` (-2, 0)
    --     it "Should move left correctly 4 step from negative point" $
    --         Lib.move (-10, 0) (Movement Lib.Left 4)  `shouldBe` (-14, 0)
    -- describe "Lib.run" $ do
    --     it "Should move correctly" $
    --         Lib.run [Movement Lib.Up 1, Movement Lib.Left 1]  `shouldBe` (-1, 1)
    --     it "Should move correctly" $
    --         Lib.run [Movement Lib.Up 1, Movement Lib.Left 1, Movement Lib.Right 3, Movement Lib.Down 20]  `shouldBe` (2, -19)
    -- describe "Lib.distance" $ do
    --     it "Should calculate the distance correctly" $
    --         Lib.distance [(1,1), (5,4)]  `shouldBe` 7
