smallestMultiple :: Integer -> Integer
smallestMultiple x = head [y | y <- [x, x + x..], evenlyDiviseableByMaximum y x]

evenlyDiviseableByMaximum :: Integer -> Integer -> Bool
evenlyDiviseableByMaximum x max = and [evenlyDiviseable x a | a <- [1..max]]

evenlyDiviseable :: Integer -> Integer -> Bool
evenlyDiviseable x y = x == y * (x `div` y)
