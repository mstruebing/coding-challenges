main = putStrLn (show (sumEvenFibsUntil 4000000))

sumEvenFibsUntil :: Int -> Int
sumEvenFibsUntil n = sum [ x | x <- takeWhile (<= n) fibs, even x]
  where
    fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
