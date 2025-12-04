{-
    Lab 15
     
    This module defines a binary tree data structure and implements
    various functions to manipulate and query the tree, including
    height calculation, summation of elements, membership testing,
    insertion into a binary search tree, mapping functions over the tree,
    and polymorphic trees.
-}

-- 1. Recursive type: define a binary tree that stores Int values.
data BinaryTree
  = NilT
  | Node Int BinaryTree BinaryTree
  deriving (Show)

-- 2. Build the following tree:
--         42
--        /  \
--      13    19
--             \
--             12
myTree :: BinaryTree
myTree =
  Node 42
    (Node 13 NilT NilT)
    (Node 19 NilT (Node 12 NilT NilT))

-- 3. Function: compute the height of a binary tree.
height :: BinaryTree -> Int
height NilT = 0
height (Node _ l r) = 1 + max (height l) (height r)

-- 4. Function: compute the sum of all elements.
sumTree :: BinaryTree -> Int
sumTree NilT = 0
sumTree (Node n l r) = n + sumTree l + sumTree r

-- 5. Function: check if a value is in the tree.
inTree :: BinaryTree -> Int -> Bool
inTree NilT _ = False
inTree (Node x l r) y
  | x == y    = True
  | otherwise = inTree l y || inTree r y

-- 6. Insert a new value into a binary search tree.
addNode :: BinaryTree -> Int -> BinaryTree
addNode NilT x = Node x NilT NilT
addNode (Node n l r) x
  | x > n     = Node n l (addNode r x)
  | otherwise = Node n (addNode l x) r

-- 7. Build a BST from a list of Ints.
listToSearchTree :: [Int] -> BinaryTree -> BinaryTree
listToSearchTree [] t     = t
listToSearchTree (x:xs) t = listToSearchTree xs (addNode t x)

-- 8. Higher-order: map a function over every element in the tree.
treeMap :: (Int -> Int) -> BinaryTree -> BinaryTree
treeMap _ NilT = NilT
treeMap f (Node x l r) = Node (f x) (treeMap f l) (treeMap f r)
