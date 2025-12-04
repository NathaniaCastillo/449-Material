-- Making Your Own Data Types

{-
So far, we've run into a lot of data types. Bool, Int, Char, etc.
But how do we make our own?

one way is to use the 'data' keyword to define a type.
Let's see how the Bool type is defined in Prelude.

data Bool = False | True

The keyword 'data' means that we're defining a new data type.
The part before the = denotes the type, which in this example is Bool.
The parts after the = are Value Constructors. They specify the different values that this type can have.
The | is read as "or". So we can read this as: the Bool type can have a value of True or False.
Both the type name and the value constructors have to be capital cased.
-}

-- The Bool type is an example of Enumerated type.
-- Enumerated types have a finite list of possible values.
-- Let's do some exercises using enumerated types:

-- Exercises:

-- 1. Suppose that we want to model the Rock-Paper-Scissors game in Haskell. define the data type Move, a move in this game can be either rock, paper or scissors
-- data Move = Rock | Paper | Scissors

-- 2. define two values of type Move
move1 :: Move
move1 = Rock

move2 :: Move
move2 = Paper


-- 3. Make the Move data type a member of the Show typeclass: (comment out the one you defined before)
-- data Move = Rock | Paper | Scissors deriving (Show)

-- if we try to just print out move1 or move2 in the ghci, we'll get an error.
-- That's because Haskell doesn't know how to display our data type as a string (yet).
-- When we try to print a value out in the prompt, Haskell first runs the show function to get the string representation of our value and then it prints that out to the terminal.

-- if we try to compare move1 and move2, we will get an error again
-- run move1 == move2 in ghci
-- Explain why it gives an error?

-- 4. Make the Move data type a member of the Eq typeclass:
data Move = Rock | Paper | Scissors deriving (Show, Eq)

-- Now we can begin to define functions using the Move type.

-- 5. Let's write a function which tells you the move to beat a particular move:
beat :: Move -> Move
beat Rock = Paper
beat Paper = Scissors
beat Scissors = Rock

-- Example usage in GHCi:
-- > beat Rock
-- > beat Paper

-- 6. write a function that gives you the move that will lose against a particular move.
lose :: Move -> Move
lose Rock = Scissors
lose Paper = Rock
lose Scissors = Paper

-- Example usage in GHCi:
-- > lose Rock
-- > lose Scissors

-- 7. Define a data type Result which represents the outcome of a round of Rock-Paper-Scissors, which will either be a win, lose or draw.
data Result = Win | Lose | Draw deriving (Show)

-- 8. Define a function outcome :: Move -> Move -> Result
-- so that this gives the outcome of a round for the first player. For example, we should expect that outcome Rock Scissors should be a win.
outcome :: Move -> Move -> Result
outcome m1 m2
  | m1 == m2 = Draw
  | lose m1 == m2 = Win
  | otherwise = Lose

-- Example usage in GHCi:
-- > outcome Rock Scissors
-- > outcome Paper Rock
-- > outcome Scissors Scissors

-- The Value Constructors in the definition of a data type, can have parameters:
-- 9. Make your own type to represent a shape. A shape can be a circle or a rectangle
-- represent the circle with the coordinates of its center and its radius
-- and the rectangle with the coordinates of its top left and bottom right
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

-- Example usage in GHCi:
-- > let myC = Circle 10 20 5
-- > Rectangle 0 0 10 20

{-
Value constructors are actually functions that ultimately return a value of a data type.
Let's take a look at the type signatures for these two value constructors.

ghci> :t Circle
Circle :: Float -> Float -> Float -> Shape
ghci> :t Rectangle
Rectangle :: Float -> Float -> Float -> Float -> Shape
-}

-- 10. Write a function that takes a shape and returns its surface.
surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = abs (x2 - x1) * abs (y2 - y1)

-- Example usage in GHCi:
-- > surface (Circle 10 20 5)
-- > surface (Rectangle 0 0 10 20)
-- > surface myC

-- The Shape data type is good, although it could be better.
-- Let's make an intermediate data type that defines a point in two-dimensional space.
-- Then we can use that to make our shapes more understandable.

-- 11. Define data type Point and rewrite the Shape data type using Point
data Point = Point Float Float

data Shape' = Circle' Point Float | Rectangle' Point Point

-- Example usage in GHCi:
-- > Point 1 2
-- > myC'Centre = Point 10 20
-- > myC' = Circle' myC'Centre 10
-- > Circle' (Point 1 2) 5
-- > Rectangle' (Point 0 0) (Point 10 20)

-- You can also write your custom show function for your data type by making your data type an instance of Show type class.
-- The Show type class in Haskell includes all types that support the show function, which converts a value to a String.
-- 12. Implement custom show function for Shape and Point data types

instance Show Point where
  show :: Point -> String
  show (Point x y) = "(" ++ show x ++ ", " ++ show y ++ ")"

-- Example usage in GHCi:
-- > show (Point 1 2)
-- > myP = Point 1 2
-- > show myP
-- > show (Circle' (Point 1 2) 5)
-- > show (Rectangle' (Point 0 0) (Point 10 20))

instance Show Shape' where
  show :: Shape' -> String
  show (Circle' p r) = "Circle at " ++ show p ++ " with radius " ++ show r
  show (Rectangle' p1 p2) = "Rectangle from " ++ show p1 ++ " to " ++ show p2

-- Example: Store a Point in a variable and use it to construct a Circle'
-- > let p = Point 1 2
-- > let c = Circle' p 5
-- > c
-- > surface' c


-- 13. rewrite the surface function for Shape'
surface' :: Shape' -> Float
surface' (Circle' _ r) = pi * r ^ 2
surface' (Rectangle' (Point x1 y1) (Point x2 y2)) = abs (x2 - x1) * abs (y2 - y1)

-- Example: Store two Points and use them to construct a Rectangle'
-- > let p1 = Point 0 0
-- > let p2 = Point 10 20
-- > let r = Rectangle' p1 p2
-- > r
-- > surface' r

-- 14. write the function nudge that takes a shape,
-- the amount to move it on the x axis and the amount to move it on the y axis
-- and then returns a new shape that has the same dimensions, only it's located somewhere else.
nudge :: Shape' -> Float -> Float -> Shape'
nudge (Circle' (Point x y) r) a b =
  Circle' (Point (x + a) (y + b)) r
nudge (Rectangle' (Point x1 y1) (Point x2 y2)) a b =
  Rectangle' (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2 + b))

-- Example usage in GHCi:
-- > nudge (Circle' (Point 1 2) 5) 3 4
-- > nudge (Rectangle' (Point 0 0) (Point 10 20)) 5 5

-- Example: Store a Circle' in a variable and nudge it
-- > let c = Circle' (Point 1 2) 5
-- > let c2 = nudge c 3 4
-- > c2
-- > surface' c2

-- Example: Store a Rectangle' in a variable and nudge it
-- > let r = Rectangle' (Point 0 0) (Point 10 20)
-- > let r2 = nudge r 5 5
-- > r2
-- > surface' r2