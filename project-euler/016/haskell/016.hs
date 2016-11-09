import Data.Char

sumOfPowerOfTwo :: Int -> Int
sumOfPowerOfTwo x = sum [digitToInt y | y <- show (2^x)]
