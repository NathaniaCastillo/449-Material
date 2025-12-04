% -------------------
% Why Does Prolog Wait for Results?
% -------------------
% Prolog uses a mechanism called "backtracking" to explore all possible solutions to a query.
% By default, Prolog does not stop after finding the first solution; instead, it waits for your input to decide the next action:
%
% - If you press Enter, Prolog accepts the current result and terminates the search.
% - If you press ; Prolog backtracks to search for additional solutions.
%
% How Backtracking Works:
% 1. Prolog searches through the rules and facts in the knowledge base to find solutions.
% 2. If a solution is found, Prolog returns it but keeps track of alternative paths (if any exist).
% 3. If Prolog finds no further solutions, it outputs `false`, indicating no other answers satisfy the query.
%
% Example:
% ?- member(X, [1, 2, 3]).
% Output:
% X = 1 ;
% X = 2 ;
% X = 3 ;
% false.
% - Prolog iterates through the list `[1, 2, 3]` and finds all possible values for `X`.
% - After `X = 3`, no other solutions exist, so Prolog outputs `false`.
%
% Stopping Prolog from Waiting:
% 1. Cut operator (`!`): Add a "cut" to terminate the search once a solution is found. For example:
%    first_member(X, List) :- member(X, List), !.
%    Query:
%    ?- first_member(X, [1, 2, 3]).
%    Output:
%    X = 1.
%    Explanation: Prolog stops after finding the first solution.
%
% 2. Press Enter: When Prolog finds a solution and waits, pressing **Enter** terminates the search.
%
% 3. Use constraints: Define rules with conditions that make other solutions impossible.
%
% Debugging Infinite Waits:
% If Prolog appears to wait indefinitely, it may be stuck in an infinite recursive loop.
% To debug, use tracing (`trace.`) to see how Prolog evaluates the query.

% -------------------
% Basic List Operations
% -------------------

% Example 1: Check if a list is empty.
is_empty([]). % A list is empty if it has no elements.

% Usage:
% ?- is_empty([]).
% true.
% Explanation: This succeeds because the input is an empty list.

% Example 2: Find the head and tail of a list.
head_tail([Head|Tail], Head, Tail).
% Usage:
% ?- head_tail([1, 2, 3], Head, Tail).
% Head = 1, Tail = [2, 3].
% Explanation:
% - Prolog splits the list into its first element (`Head`) and the rest (`Tail`) using the `|` operator.
% - In this case, `1` is the head, and `[2, 3]` is the tail.

% Example 3: Append two lists.
append_list([], List, List). % Base case: Appending an empty list to another list returns the second list.
append_list([Head|Tail], List, [Head|Result]) :- append_list(Tail, List, Result).
% Usage:
% ?- append_list([1, 2], [3, 4], Result).
% Result = [1, 2, 3, 4].
% Explanation:
% 1. First call: `append_list([1, 2], [3, 4], Result)`, where `Head = 1` and `Tail = [2]`.
% 2. Recursive call: `append_list([2], [3, 4], Result1)`.
% 3. Recursive call: `append_list([], [3, 4], Result2)` (base case returns `[3, 4]`).
% 4. Unwinding: `[2|[3, 4]] -> [1|[2, 3, 4]]`.

% Example 4: Reverse a list using recursion.
reverse_list([], []). % Base case: Reversing an empty list returns an empty list.
reverse_list([Head|Tail], Reversed) :-
    reverse_list(Tail, ReversedTail), % Recursive step: Reverse the tail.
    append_list(ReversedTail, [Head], Reversed). % Add the head to the reversed tail.
% Usage:
% ?- reverse_list([1, 2, 3], Result).
% Result = [3, 2, 1].
% Explanation:
% 1. First call: `reverse_list([1, 2, 3], Result)`, where `Head = 1` and `Tail = [2, 3]`.
% 2. Recursive call: `reverse_list([2, 3], Result1)`.
% 3. Recursive call: `reverse_list([3], Result2)`.
% 4. Recursive call: `reverse_list([], Result3)` (base case returns `[]`).
% 5. Unwinding: `append_list([3, 2], [1]) -> [3, 2, 1]`.

% Example 5: Check if a list is a palindrome.
is_palindrome(List) :- reverse_list(List, List).
% Usage:
% ?- is_palindrome([1, 2, 1]).
% true.
% Explanation:
% - The list is reversed and compared with the original. If they are equal, it is a palindrome.

% Example 6: Find the nth element of a list.
nth_element(1, [Head|_], Head). % Base case: If N = 1, the head is the desired element.
nth_element(N, [_|Tail], Element) :-
    N > 1, % Ensure N is valid.
    N1 is N - 1, % Decrement N.
    nth_element(N1, Tail, Element). % Recursive call with the tail.
% Usage:
% ?- nth_element(2, [a, b, c], Element).
% Element = b.
% Explanation:
% - For `nth_element(2, [a, b, c], Element)`:
%   1. `N = 2`: Recursive call with `N = 1` and `Tail = [b, c]`.
%   2. Base case: Returns the head of `[b, c]`, which is `b`.

% Example 7: Remove duplicates from a list.
remove_duplicates([], []). % Base case: An empty list has no duplicates.
remove_duplicates([Head|Tail], Result) :-
    member(Head, Tail), % If the head is in the tail, skip it.
    remove_duplicates(Tail, Result).
remove_duplicates([Head|Tail], [Head|Result]) :-
    \+ member(Head, Tail), % If the head is not in the tail, include it.
    remove_duplicates(Tail, Result).
% Usage:
% ?- remove_duplicates([1, 2, 2, 3, 1], Result).
% Result = [3, 2, 1].
% Explanation:
% 1. Process each element and check if it already exists in the rest of the list.
% 2. Skip duplicates and recursively build the result.

% Example 8: Flatten a nested list.
flatten_list([], []). % Base case: An empty list is already flat.
flatten_list([Head|Tail], Flattened) :-
    is_list(Head), % If the head is a list,
    flatten_list(Head, FlatHead), % Flatten it.
    flatten_list(Tail, FlatTail), % Flatten the tail.
    append_list(FlatHead, FlatTail, Flattened). % Append the results.
flatten_list([Head|Tail], [Head|FlatTail]) :-
    \+ is_list(Head), % If the head is not a list,
    flatten_list(Tail, FlatTail). % Continue with the tail.
% Usage:
% ?- flatten_list([1, [2, [3, 4]], 5], Result).
% Result = [1, 2, 3, 4, 5].
% Explanation:
% - Flatten each nested sublist recursively, appending the results together.