import           Data.List

main :: IO ()
main = do 
    content <- readFile ("input.txt")
    let linesOfFile = lines content
    print $ howManyAreValid linesOfFile


howManyAreValid :: [String] -> Int 
howManyAreValid linesOfFile =
    foldr (\line acc -> if isUnique $ words line then acc + 1 else acc) 0 linesOfFile


isUnique :: [String] -> Bool 
isUnique line =  do
    let uniqueLine = makeUnique line
    uniqueLine == line


makeUnique = reverse . nub . reverse
