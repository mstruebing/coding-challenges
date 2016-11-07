getNthPrim :: Int -> Int
getNthPrim x = [y | y <- [2..], isPrime y] !! (x - 1)

isPrime :: Int -> Bool
isPrime x 
    | x < 2 = False
    | x == 2 = True
    | otherwise = and [x `mod` a /= 0 | a <- [2..x - 1]]
