/*
Nathania Castillo
UCID:30152619
Dr. Nasri (T12:Kahbod Aeini)
Dec 5, 2025 

Assignment 4: using prolog to model relationships, lists, trees, and graphs using facts and rules

*/

% Prob 1 Pet Ownership
% a) Facts:

owns(alice, fluffy).
owns(alice, max).
owns(bob, bella).
owns(carol, daisy).
owns(carol, max). 

% b) Rules:

% find out who has a shares pet 
shared_pet(Person1, Person2, Pet):- 
owns(Person1, Pet), owns(Person2, Pet), 
Person1 \= Person2.    

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

    % Skip the head since it is a duplicate

        compress_helper(T, Acc, Result)
    ;
    % Otherwise, keep the head and add it to the accumulator

        compress_helper(T, [H|Acc], Result)
    ).          

% Prob 3 Binary Tree Summation and Properties

/* Define the binary tree structure:
Properties:
- root is the topmost node in a binary tree
- each node has at most two children: left and right
- each node contains a numeric value
- binary tree can be empty or non-empty


Representation:
- empty tree is represented by the 'empty'
- non-empty tree is represented by tree(Value, LeftSubtree, RightSubtree)       
- Value is a number
- LeftSubtree and RightSubtree are binary trees themselves
- Example trees:
  - empty
  - tree(5, empty, empty)
  - tree(10, tree(5, empty, empty), tree(15, empty, empty))

*/

% Defining empty tree
tree(empty). 

% Defining non-empty tree:
tree(tree(Value, Left, Right)):-
    number(Value),
    tree(Left),
    tree(Right).    

% a) tree_sum(Tree, Sum): sum of all values in the binary tree
% Base case: empty tree has sum 0
tree_sum(empty, 0).

% Recursive case: sum is Value + sum of left + sum of right
tree_sum(tree(Value, Left, Right), Sum):-
    tree_sum(Left, LeftSum),
    tree_sum(Right, RightSum),
    Sum is Value + LeftSum + RightSum. 

% b) tree_height(Tree, Height): computes the height of the binary tree
% Base case: empty tree has height 0
tree_height(empty, 0).

% Recursive case: height is 1 + max height of left and right subtrees
tree_height(tree(_, Left, Right), Height):-
    tree_height(Left, LeftHeight),
    tree_height(Right, RightHeight),
    MaxSubHeight is max(LeftHeight, RightHeight),
    Height is MaxSubHeight + 1.     

% c)is_perfect(Tree): checks to see every parent node has two children and all leaves are at the same depth
% Base case: empty tree is full
is_perfect(empty).   

% Recursive case: a tree is full if both subtrees are full and either both are empty or both are non-empty
is_perfect(tree(_, Left, Right)):-
    is_perfect(Left),
    is_perfect(Right),
    ( (Left = empty, Right = empty) ;
      (Left \= empty, Right \= empty) ).    


%Prob 4 Course Prerequisites Expansion
% a) Facts:
% requires(Course, Prereq) - Course has Prereq as a prerequisite

requires(cpsc331, cpsc231).
requires(cpsc355, cpsc331).
requires(cpsc449, cpsc331).
requires(cpsc449, cpsc355).

% b) Rules: returns all direct and inderect prerequisites for a course
% requires_all(Course, AllPrereqs) -> AllPrereqs is a list of all direct and indirect prerequisites for Course

requires_all(Course, AllPrereqs):-
    findall(Prereq, requires_recursive(Course, Prereq), PrereqList),
    sort(PrereqList, AllPrereqs).  % remove duplicates and sort

% Helper predicate to recursively find prerequisites
%direct prerequisite
requires_recursive(Course, Prereq):-
    requires(Course, Prereq).  

% Indirect prerequisite
requires_recursive(Course, Prereq):-
    requires(Course, Intermediate),
    requires_recursive(Intermediate, Prereq). 
      

% c) computes max depth of prerequisite chain for a course
% prereq_depth(Course, Depth): Depth is the maximum depth of prerequisite chain for Course

%course with zero prerequisites has depth 0
prereq_depth(Course, 0):-    
    \+ requires(Course, _).

% Recursive case: take the max depth among all direct prerequisites
prereq_depth(Course, Depth):-
    findall(PrereqDepth, 
               (requires(Course, Prereq),
                prereq_depth(Prereq, PrereqDepth)), 
               Depths),
    max_list(Depths, MaxDepth),
    Depth is MaxDepth + 1.  
  



    






