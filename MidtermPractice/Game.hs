module Game where

import RockPaperScissors

{ -- loop where you get input from player
-- figure out what strat AI plays 
-- print out strategy
-- see who wins
-- loop to play again until player decides to quit
}
 
--defining a function 

playGame : Strategy ->  [Moves] -> IO ()   -- game loop 
playGame strategy moves = 

--main function that will continuosly loop through until input is exit
main :: IO ()
main = playGame alwaysRock []     
        putstrLn "Game over"         