matching_delimiters(40, 41).
matching_delimiters(91, 93).
matching_delimiters(123, 125).

opening_delimiter(40).
opening_delimiter(91).
opening_delimiter(123).

valid_parenthesis([], []).
valid_parenthesis([X|RS], [Y|RR]) :- matching_delimiters(X, Y), valid_parenthesis(RS, RR).
% The program will work without requiring opening_delimiter. However, it will be much slower; opening_delimiter ensures that we don't go down search trees with closing delimiters in the SoFar argument.
% Another solution is to cut if the next character is not opening.
valid_parenthesis(S, [X|RR]) :- opening_delimiter(X), valid_parenthesis([X|S], RR).

solve_leetcode(X) :- valid_parenthesis([], X).
