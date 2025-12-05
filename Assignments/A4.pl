/*
Nathania Castillo
UCID:30152619
Dr. Nasri
Dec 5, 2025 

Assignment 4:
*/

% Prob 1 Pet Ownership
% Facts:

pet(fluffy).
pet(max).
pet(bella).
pet(daisy).

person(alice).
person(bob).
person(carol).

owns(alice, fluffy).
owns(alice, max).
owns(bob, bella).
owns(carol, daisy).
owns(carol, max). 

% Rules:

% find out who has a shared pet 
shared_pet(Person1, Person2, Pet):- 
owns(Person1, Pet), owns(Person2, Pet), 
Person1 \= Person2.    % I get an error wityh

% a person has more than one pet
has_multiple_pets(Person):-
owns(Person, Pet1), owns(Person, Pet2),
Pet1 \= Pet2.  

% Prob 2 List Comprehension
/*
- compress(List, Result) - removes consecutive duplicates from List
- compress_helper is called with an accumulator to build the result in reverse order
*/
compress(List, Result):-
    compress_helper(List, [], ResultRev),
    reverse(ResultRev, Result).

/* compress_helper(+List, +Acc, -Result)
- List  = the remaining input list to process
- Acc   = accumulator holding compressed elements in REVERSE ORDER
- Result = final compressed reversed list
*/

% Base case: no more items → the accumulator *is* the result.
compress_helper([], Acc, Acc).  

% Recursive case: process head and tail
compress_helper([H|T], Acc, Result):-

    /*Check if head is the same as the head of the accumulator
    - Acc = [H|_] means the last inserted element in Acc is H and matches
    - if so, skip it
    */

    (Acc = [H|_] ->

    % Skip the head since it's a duplicate

        compress_helper(T, Acc, Result)
    ;
    % Otherwise, keep the head and add it to the accumulator

        compress_helper(T, [H|Acc], Result)
    ).          

% Prob 3 Binary Tree Summation and Properties

% Define the binary tree structure

% empty tree
tree(empty). 

% non-empty tree: tree(Value, LeftSubtree, RightSubtree)
tree(tree(Value, Left, Right)):-
    number(Value),
    tree(Left),
    tree(Right).    

% sum_tree(+Tree, -Sum)
% Base case: empty tree has sum 0
sum_tree(empty, 0).

% Recursive case: sum is Value + sum of left + sum of right
sum_tree(tree(Value, Left, Right), Sum):-
    sum_tree(Left, LeftSum),
    sum_tree(Right, RightSum),
    Sum is Value + LeftSum + RightSum.          

% is_perfect(+Tree)
% Base case: empty tree is full
is_perfect(empty).                                    
% Recursive case: a tree is full if both subtrees are full and either both are empty or both are non-empty
is_perfect(tree(_, Left, Right)):-
    is_perfect(Left),
    is_perfect(Right),
    ( (Left = empty, Right = empty) ;
      (Left \= empty, Right \= empty) ).    


% tree_height(+Tree, Sum)
% Base case: empty tree has height 0
tree_height(empty, 0).
% Recursive case: height is 1 + max height of left and right
tree_height(tree(_, Left, Right), Height):-
    tree_height(Left, LeftHeight),
    tree_height(Right, RightHeight),
    MaxHeight is max(LeftHeight, RightHeight),
    Height is MaxHeight + 1.    








