pythagoranTriplet :: Int -> Int
pythagoranTriplet x = foldl (*) 1 $ head [[a, b, c] | a <- [1..x], b <- [1..x], c <- [1..x], a < b, b < c, a + b + c == 1000, a*a + b*b == c*c]


-- faster solution I have coded some time ago
run :: IO ()
run = print $ (\(a,b,c) -> a*b*c) special

special :: (Int, Int, Int)
special = head $ filter (\(a,b,c) -> a*a+b*b == c*c) triples

triples :: [(Int, Int, Int)]
triples = [(h, k, 1000 - h - k) | h <- [1..500], k <- [1..h]]
