coin_value(1).
coin_value(2).
coin_value(5).
coin_value(10).
coin_value(20).
coin_value(50).
coin_value(100).
coin_value(200).

coin_sum(0, _, []).
coin_sum(X, _, _) :- X =< 0, !, fail.
coin_sum(X, M, [Y|R]) :- coin_value(Y), M =< Y, D is X-Y, coin_sum(D, Y, R).

solve_pe(X, N) :- findall(R, coin_sum(X, 0, R), K), length(K, N).
