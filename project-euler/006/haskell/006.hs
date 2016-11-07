sumSquareDifference :: Int -> Int
sumSquareDifference x = squareOfSum x - sumOfSquares x

sumOfSquares :: Int -> Int
sumOfSquares x = sum $ map (^2) [1..x]

squareOfSum :: Int -> Int
squareOfSum x = sumUntil ^ 2
    where
        sumUntil = sum [1..x]
