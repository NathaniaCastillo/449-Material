-- takes turns making a move in a game of rock-paper-scissors
module RockPaperScissors where

--Program Model
data Move = Rock | Paper | Scissors 
    deriving (Show, Eq)               --making a data type for the previous moves

type Strategy = [Move] -> Move       --gives u a list return the type u chose

--Strategies

copyCat :: Strategy                 -- type defined above 
copyCat [] = Rock                   -- the base if we do not know what to do 
copyCat (latest:_ ) = latest        -- whatever the latest move is just copy it 

cycleS :: Strategy                  -- don't care about other players. if no move we start with rock, then paper, then scissors
cycle moves = case (length moves) `mod` 3 of 
                0 -> Rock
                1 -> Paper
                2 -> Scissors

alwaysRock :: Stratey                --  no matter what move the player will do rock to assert dominance
alwaysRock _ = Rock 

