module Lib
  ( executeRound,
    runFirst,
    runSecond,
  )
where

data Kind = Rock | Paper | Scissors

data Outcome = Win | Loss | Draw

type Points = Int

type Round = (Kind, Kind)

charToKind :: Char -> Kind
charToKind c
  | c == 'A' = Rock
  | c == 'B' = Paper
  | c == 'C' = Scissors
  | c == 'X' = Rock
  | c == 'Y' = Paper
  | c == 'Z' = Scissors
  | otherwise = undefined

kindToPoints :: Kind -> Points
kindToPoints Rock = 1
kindToPoints Paper = 2
kindToPoints Scissors = 3

outcomeToPoints :: Outcome -> Points
outcomeToPoints Win = 6
outcomeToPoints Draw = 3
outcomeToPoints Loss = 0

calculateOutcome :: Kind -> Kind -> Outcome
calculateOutcome Rock Paper = Win
calculateOutcome Paper Scissors = Win
calculateOutcome Scissors Rock = Win
calculateOutcome Rock Rock = Draw
calculateOutcome Paper Paper = Draw
calculateOutcome Scissors Scissors = Draw
calculateOutcome Rock Scissors = Loss
calculateOutcome Paper Rock = Loss
calculateOutcome Scissors Paper = Loss

executeRound :: Round -> Points
executeRound (opponent, self) = outcomePoints + selfKindPoints
  where
    outcomePoints = outcomeToPoints outcome
    outcome = calculateOutcome opponent self
    selfKindPoints = kindToPoints self

parseLine :: String -> Round
parseLine (x : _ : z : _) = (charToKind x, charToKind z)
parseLine _ = error "unexpcted input"

runFirst :: [String] -> Points
runFirst input = sum $ map (executeRound . parseLine) input

----------------------------------
-- Part 2
----------------------------------

getAction :: (Kind, Outcome) -> Kind
getAction (Rock, Win) = Paper
getAction (Rock, Loss) = Scissors
getAction (Rock, Draw) = Rock
getAction (Paper, Win) = Scissors
getAction (Paper, Loss) = Rock
getAction (Paper, Draw) = Paper
getAction (Scissors, Win) = Rock
getAction (Scissors, Loss) = Paper
getAction (Scissors, Draw) = Scissors

charToOutcome :: Char -> Outcome
charToOutcome c
  | c == 'X' = Loss
  | c == 'Y' = Draw
  | c == 'Z' = Win
  | otherwise = undefined

parseLine' :: String -> (Kind, Outcome)
parseLine' (x : _ : z : _) = (charToKind x, charToOutcome z)
parseLine' _ = error "unexpcted input"

executeRound' :: (Kind, Outcome) -> Points
executeRound' (kind, result) = outcomePoints + selfKindPoints
  where
    selfKindPoints = kindToPoints action
    action = getAction (kind, result)
    outcomePoints = outcomeToPoints result

runSecond :: [String] -> Points
runSecond input = sum $ map (executeRound' . parseLine') input
