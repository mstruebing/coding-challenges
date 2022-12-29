module Lib
  ( func,
    snafuToDecimal,
    decimalToSnafu,
  )
where

charToDecimal :: Char -> Int
charToDecimal '0' = 0
charToDecimal '1' = 1
charToDecimal '2' = 2
charToDecimal '-' = -1
charToDecimal '=' = -2
charToDecimal _ = error "unexpected input"

decimalToChar :: Int -> Char
decimalToChar 2 = '2'
decimalToChar 1 = '1'
decimalToChar 0 = '0'
decimalToChar (-1) = '-'
decimalToChar (-2) = '='

snafuToDecimal :: String -> Int
snafuToDecimal snafu = sum $ [charToDecimal (reverse snafu !! i) * 5 ^ i | i <- [0 .. length snafu - 1]]

decimalToSnafu :: Int -> String
decimalToSnafu number | number < 3 = [decimalToChar number]
decimalToSnafu number = decimalToSnafu divider ++ [decimalToChar (modulo - 2)]
  where
    (divider, modulo) = (number + 2) `divMod` 5

func :: Int
func = 1
