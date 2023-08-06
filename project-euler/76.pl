:- table ways/3.

ways(0, _, 1) :- !, true.
ways(_, 0, 0) :- !, true.
ways(S, M, X) :- S < M, ways(S, S, X).
ways(S, M, X) :- SmallS is S-M, SmallM is M-1, S >= M,
		 ways(SmallS, M, I), ways(S, SmallM, J), X is I+J.

solution(N, S) :- SmallN is N-1, ways(N, SmallN, S).
