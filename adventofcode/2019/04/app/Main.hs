module Main where

main :: IO ()
main = do
    print "part one:"
    print . show $ run_part_one
    print "part two:"
    print . show $ run_part_two

-- Split Number into list of single digits
digs :: Integral x => x -> [x]
digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

run_part_one :: Int
run_part_one = length [True | pass <- range, isValidPasswordOne $ digs pass] 
run_part_two :: Int
run_part_two = length [True | pass <- range, isValidPasswordTwo $ digs pass] 

range :: [Int]
range = [254032..789860]

isNeverDecreasing :: [Int] -> Bool
isNeverDecreasing pass = 
    -1 < foldl (\lastNumber number -> if number < lastNumber || lastNumber == -1 then -1 else number) 0 pass

isValidPasswordOne :: [Int] -> Bool
isValidPasswordOne pass = 
    length pass == 6 
    && isNeverDecreasing pass
    && hasDoubleNumberOne pass 

hasDoubleNumberOne :: [Int] -> Bool
hasDoubleNumberOne pass = 
    any (== True) [pass !! x == pass !! (x + 1) | x <- [0 .. length pass -2]]

isValidPasswordTwo :: [Int] -> Bool
isValidPasswordTwo pass = 
    length pass == 6 
    && isNeverDecreasing pass
    && hasDoubleNumberTwo pass 

hasDoubleNumberTwo :: [Int] -> Bool
hasDoubleNumberTwo pass = 
    (first == second && third /= second) 
    || (first /= second && second == third && third /= fourth) 
    || (second /= third && third == fourth && fourth /= fifth) 
    || (third /= fourth && fourth == fifth && fifth /= sixth) 
    || (fourth /= fifth && fifth == sixth)
        where
            first = pass !! 0
            second = pass !! 1
            third = pass !! 2
            fourth = pass !! 3
            fifth = pass !! 4
            sixth = pass !! 5
