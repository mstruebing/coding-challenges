main :: IO ()
main = print largest3DigitPalindrome

largest3DigitPalindrome :: Integer
largest3DigitPalindrome = [a * b | a <- [999, 998..0], b <- [999, 998..0], a * b == (reverseInt (a * b))] !! 0

reverseInt :: Integer -> Integer
reverseInt x
    | x < 0     = 0 - (read . reverse . tail . show $ x)
    | otherwise = read . reverse . show $ x
