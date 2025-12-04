{-
  Currying, Uncurrying, and Sections
-}

-- 1) Reimplement curry and uncurry (illustrates what they do).
curry' :: ((a, b) -> c) -> a -> b -> c
curry' f x y = f (x, y)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (x, y) = f x y

-- Example:
-- > let addPair (x,y) = x + y
-- > (curry' addPair) 2 3    -- 5
-- > uncurry' (+) (2,3)      -- 5

-- 2) Turn a tuple-based function into a curried one and vice versa.
addPair :: (Int, Int) -> Int
addPair (x,y) = x + y

addCurried :: Int -> Int -> Int
addCurried = curry addPair

-- Example:
-- > addCurried 4 5          -- 9
-- > (uncurry addCurried) (4,5) -- 9

-- 3) Using uncurry to work with zip + map: apply a binary op to two lists.
sumPairs :: [Int] -> [Int] -> [Int]
sumPairs xs ys = map (uncurry (+)) (zip xs ys)
-- Example:
-- > sumPairs [1,2,3] [10,20,30]  -- [11,22,33]

-- 4) Returning lambdas (factory) that accept two args (curried style).
makePairOp :: (Int, Int -> Int) -> (Int -> Int)
makePairOp (a, f) = \b -> f b + a
-- Example:
-- > let g = makePairOp (3, \x -> x * 2)
-- > g 4                     -- 11    (2*4 + 3)

-- 5) Use uncurry to integrate with fold over list of pairs.
sumPairList :: [(Int,Int)] -> Int
sumPairList = foldr (\p acc -> uncurry (+) p + acc) 0
-- Example:
-- > sumPairList [(1,2),(3,4)] -- 10

-- 6) Combining curry/uncurry with higher-order functions:
-- applyPairwise applies a tuple-based op to zipped lists (without explicit map).
applyPairwise :: ((a,b) -> c) -> [a] -> [b] -> [c]
applyPairwise op xs ys = zipWith (curry op) xs ys
-- Example:
-- > applyPairwise (\(x,y) -> show x ++ ":" ++ show y) [1,2] [3,4]
-- ["1:3","2:4"]

-- 7) Use uncurry to adapt binary functions for APIs expecting a single tuple arg.
-- e.g., sort key extractors or fold functions that produce pairs.
-- small helper: turn a binary predicate into a predicate on pairs
pairPred :: (a -> a -> Bool) -> (a,a) -> Bool
pairPred p = uncurry p
-- Example:
-- > pairPred (<) (2,3)   -- True

-- 8) A section like (+1) is shorthand for \x -> x + 1
plusOne :: Num a => a -> a
plusOne = (+1)
-- > plusOne 5   -- 6
-- > map (+1) [1,2,3] -- [2,3,4]

-- A left section (1+) is shorthand for \x -> 1 + x
onePlus :: Num a => a -> a
onePlus = (1+)
-- > onePlus 5   -- 6

-- 9) Subtraction examples: (10 -) is \x -> 10 - x
minusFrom10 :: Num a => a -> a
minusFrom10 = (10 -)
-- > minusFrom10 3  -- 7

-- To get \x -> x - 1 use `subtract 1` (note: (-1) is a numeric literal, not a section)
subtractOne :: Num a => a -> a
subtractOne = subtract 1
-- > subtractOne 5  -- 4

-- 10) Division sections: (/2) is \x -> x / 2 ; (2/) is \x -> 2 / x
divideBy2 :: Fractional a => a -> a
divideBy2 = (/2)
-- > divideBy2 8    -- 4.0

twoDividedBy :: Fractional a => a -> a
twoDividedBy = (2/)
-- > twoDividedBy 4       -- 0.5  (2 / 4)

-- 11) Combine sections with composition for concise pipelines
incrementAndDouble :: [Int] -> [Int]
incrementAndDouble = map (*2) . map (+1)
-- > incrementAndDouble [1,2,3] -- [4,6,8]