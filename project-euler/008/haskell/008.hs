pythagoranTriplet :: Int -> Int
pythagoranTriplet x = foldl (*) 1 $ head [[a, b, c] | a <- [1..x], b <- [1..x], c <- [1..x], a < b, b < c, a + b + c == 1000, a*a + b*b == c*c]
