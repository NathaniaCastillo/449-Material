{-
  Lab 16

  Solutions for Lab 16: AVL Trees

  This module defines an AVL tree data structure with insertion,
  search, and balancing operations. It includes helper functions
  for rotations and balance factor calculations.
-}

-- AVL tree: sum type (Empty | Node) with record fields (product)
data AVL a
  = Empty
  | Node
    { key    :: a
    , left   :: AVL a
    , right  :: AVL a
    , height :: Int
    }
  deriving (Eq, Show)

-- helpers
h :: AVL a -> Int
h Empty            = 0
h (Node _ _ _ ht)  = ht

-- 1. Create a new node with updated height
mkNode :: a -> AVL a -> AVL a -> AVL a
mkNode k l r = Node k l r (1 + max (h l) (h r))

-- 2. Calculate balance factor
balanceFactor :: AVL a -> Int
balanceFactor Empty = 0
balanceFactor (Node _ l r _) = h l - h r

-- 3. Rotations
rotateRight :: AVL a -> AVL a
rotateRight (Node y (Node x ll rl _) r _) =
  mkNode x ll (mkNode y rl r)
rotateRight t = t

rotateLeft :: AVL a -> AVL a
rotateLeft (Node x l (Node y lr rr _) _) =
  mkNode y (mkNode x l lr) rr
rotateLeft t = t

{-
The four cases (guards) — standard AVL rotations:

bf > 1 && balanceFactor l >= 0 — Left‑Left (LL) case
left subtree is heavier and its left child is not right‑heavy.
action: single right rotation: rotateRight t

bf > 1 && balanceFactor l < 0 — Left‑Right (LR) case
left subtree is heavier but its right child is heavy.
action: rotateLeft on left child, then rotateRight on node. The code builds the intermediate node with mkNode k (rotateLeft l) r and then calls rotateRight on that.

bf < -1 && balanceFactor r <= 0 — Right‑Right (RR) case
right subtree is heavier and its right child is not left‑heavy.
action: single left rotation: rotateLeft t

bf < -1 && balanceFactor r > 0 — Right‑Left (RL) case
right subtree is heavier but its left child is heavy.
action: rotateRight on right child, then rotateLeft on node; implemented as rotateLeft (mkNode k l (rotateRight r))
-}


-- 4. Rebalance
rebalance :: Ord a => AVL a -> AVL a
rebalance t@(Node k l r _)
  | bf > 1 && balanceFactor l >= 0  = rotateRight t                            -- LL
  | bf > 1 && balanceFactor l <  0  = rotateRight (mkNode k (rotateLeft l) r)  -- LR
  | bf < -1 && balanceFactor r <= 0 = rotateLeft t                            -- RR
  | bf < -1 && balanceFactor r > 0  = rotateLeft (mkNode k l (rotateRight r)) -- RL
  | otherwise = mkNode k l r
  where bf = balanceFactor t
rebalance t = t

-- 5. Search for a key
search :: Ord a => AVL a -> a -> String
search Empty _ = "Not Found"
search (Node k l r _) x
  | x == k    = "Found"
  | x < k     = search l x
  | otherwise = search r x

-- 6. Insert a key
insert :: Ord a => AVL a -> a -> AVL a
insert Empty x = mkNode x Empty Empty
insert t@(Node k l r _) x
  | x == k = t
  | x < k  = rebalance (mkNode k (insert l x) r)
  | x > k  = rebalance (mkNode k l (insert r x))

-- 7. inOrder traversal
inOrder :: AVL a -> [a]
inOrder Empty = []
inOrder (Node k l r _) = inOrder l ++ [k] ++ inOrder r

-- 8. Build AVL from list
fromList :: Ord a => [a] -> AVL a
fromList = foldl insert Empty

-- 9. Check if AVL tree is balanced
isBalanced :: AVL a -> Bool
isBalanced Empty = True
isBalanced (Node _ l r _) =
  abs (h l - h r) <= 1 && isBalanced l && isBalanced r

example :: AVL Int
example = fromList [10,20,30,40,50,25]

-- Quick GHCi commands:
-- -- basic construction / insert / traversal
-- let t0 = Empty
-- let t1 = insert t0 10
-- let t2 = insert t1 20
-- let t3 = insert t2 5
-- inOrder t3               -- expected: [5,10,20]
-- isBalanced t3            -- expected: True
--
-- -- example tree from file
-- example
-- inOrder example
-- isBalanced example
--
-- -- trigger standard rotation cases
-- let tLL = fromList [30,20,10]    -- causes rotateRight (LL)
-- inOrder tLL ; isBalanced tLL
-- let tRR = fromList [10,20,30]    -- causes rotateLeft (RR)
-- inOrder tRR ; isBalanced tRR
-- let tLR = fromList [30,10,20]    -- causes left-right (LR)
-- inOrder tLR ; isBalanced tLR
-- let tRL = fromList [10,30,20]    -- causes right-left (RL)
-- inOrder tRL ; isBalanced tRL
--
-- -- search
-- search example 25           -- "Found"
-- search example 99           -- "Not Found"
--
-- -- inspect heights and balance factors
-- h example
-- balanceFactor example
--
-- -- test rotateLeft / rotateRight manually on small shapes
-- let a = mkNode 30 (mkNode 20 (mkNode 10 Empty Empty) Empty) (mkNode 40 Empty Empty)
-- rotateRight a               -- should produce a tree rooted at 20
-- let b = mkNode 10 Empty (mkNode 20 Empty (mkNode 30 Empty Empty))
-- rotateLeft b                -- should produce a tree rooted at 20
--
