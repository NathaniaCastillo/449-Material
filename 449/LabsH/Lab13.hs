{-
  Currying: functions that take multiple inputs one by one -> like a simple addition
  - takes one input and uses the other inputs in the 
   Uncurrying, takes in a tuple
   
   and Sections
-}

add : Int -> Int -> Int
add x y = x + y
--the actual function that is built in should be this
add x = \y -> x + y
--- or how this is actually handled by the compiler add3 Int ->( Int -> ( Int -> Int))
add3 Int -> Int -> Int -> Int
add3 x = \y -> \z -> x + y + z 

-- add is actually taking one input and gives us a function that takes an input and gives us an output

-- 1) Reimplement curry and uncurry (illustrates what they do).
curry' :: ((a, b) -> c) -> a -> b -> c
curry' f x y = f (x,y)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' g (x, y) = g x y 

-- Example:
-- > let addPair (x,y) = x + y
-- > (curry' addPair) 2 3    -- 5
-- > uncurry' (+) (2,3)      -- 5

-- 2) Turn a tuple-based function into a curried one and vice versa.
addPair :: (Int, Int) -> Int
addPair (x,y) = x + y

addCurried :: Int -> Int -> Int
addCurried x y = x + y

-- Example:
-- > addCurried 4 5          -- 9
-- > (uncurry addCurried) (4,5) -- 9

-- 3) Using uncurry to work with zip + map: apply a binary op to two lists.
sumPairs :: [Int] -> [Int] -> [Int]
sumPairs xs yx = map (\(x,y) -> x + y)(zip xs ys )
sumPairs xs yx = map (uncurry (+)) (zip xs ys )

-- Example:
-- > sumPairs [1,2,3] [10,20,30]  -- [11,22,33]

-- 4) Returning lambdas (factory) that accept two args (curried style).
makePairOp :: (Int, Int -> Int) -> (Int -> Int)
makePairOp = undefined
-- Example:
-- > let g = makePairOp (3, \x -> x * 2)
-- > g 4                     -- 11    (2*4 + 3)

-- 5) Use uncurry to integrate with fold over list of pairs.
sumPairList :: [(Int,Int)] -> Int
sumPairList  = foldr f z 
sumPairList = foldr (\p z -> uncurry (+) p + z) 0 
-- > sumPairList [(1,2),(3,4)] -- 10

-- 6) Combining curry/uncurry with higher-order functions:
-- applyPairwise applies a tuple-based op to zipped lists (without explicit map).
applyPairwise :: ((a,b) -> c) -> [a] -> [b] -> [c]
applyPairwise = undefined
-- Example:
-- > applyPairwise (\(x,y) -> show x ++ ":" ++ show y) [1,2] [3,4]
-- ["1:3","2:4"]

-- 7) Use uncurry to adapt binary functions for APIs expecting a single tuple arg.
-- e.g., sort key extractors or fold functions that produce pairs.
-- small helper: turn a binary predicate into a predicate on pairs
pairPred :: (a -> a -> Bool) -> (a,a) -> Bool
pairPred = undefined
-- Example:
-- > pairPred (<) (2,3)   -- True

-- 8) Addition examples
plusOne :: Num a => a -> a
plusOne = undefined
-- > plusOne 5   -- 6
-- > map (+1) [1,2,3] -- [2,3,4]

onePlus :: Num a => a -> a
onePlus = undefined
-- > onePlus 5   -- 6

-- 9) Subtraction examples
minusFrom10 :: Num a => a -> a
minusFrom10 = undefined
-- > minusFrom10 3  -- 7

subtractOne :: Num a => a -> a
subtractOne = undefined
-- > subtractOne 5  -- 4

-- 10) Division sections
divideBy2 :: Fractional a => a -> a
divideBy2 = undefined
-- > divideBy2 8    -- 4.0

twoDividedBy :: Fractional a => a -> a
twoDividedBy = undefined
-- > twoDividedBy 4       -- 0.5  (2 / 4)

-- 11) Combine sections with composition for concise pipelines
incrementAndDouble :: [Int] -> [Int]
incrementAndDouble = undefined
-- > incrementAndDouble [1,2,3] -- [4,6,8]