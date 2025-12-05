{-|
  CPSC 449 — Lab 1 Tutorial
  ----------------------------------------------
  Goal:
    Make sure everyone can run Haskell on their computer or lab machine.
    Try out very simple functions and see how to call them in GHCi.

-}

module Lab1_VeryBasic where

-- 1) Write a function that takes a name and returns "Hello, <name>!"
message :: String -> String
message name = "Hello " ++ name ++ "!"

-- 2) Write a function that doubles a number
double :: Int -> Int
double n = 2*n


-- 3) Write a function that squares a number
square :: Int -> Int
square n = n*n
