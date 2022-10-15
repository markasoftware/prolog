% year, month, date are written like in usual notation.
% Day of week is also 1-indexed

:- table date_day/4. % without this, n^2 because we have to recurse back through the whole date succ tree for every date.

date_day(1900, 1, 1, 1).
date_day(Y,M,Date,Day) :- date_succ(Y2,M2,Date2,Y,M,Date), date_day(Y2,M2,Date2,Day2), Day is 1 + Day2 mod 7.

num_months(12).

month_succ(A,B) :- B is 1 + A mod 12.

year_month_length(_,1,31).
year_month_length(Y,2,29) :- 0 is Y mod 4.
year_month_length(Y,2,28) :- not(0 is Y mod 4).
year_month_length(_,3,31).
year_month_length(_,4,30).
year_month_length(_,5,31).
year_month_length(_,6,30).
year_month_length(_,7,31).
year_month_length(_,8,31).
year_month_length(_,9,30).
year_month_length(_,10,31).
year_month_length(_,11,30).
year_month_length(_,12,31).

date_succ(_, _, _, Y, _, _) :- Y < 1900, !, fail. % safe to cut because only matches when Y is instantiated.
date_succ(Y2,M,D,Y,1,1) :- Y2 is Y - 1, num_months(M), year_month_length(Y,M,D).
date_succ(Y,M,D,Y,M2,1) :- year_month_length(Y,M,D), month_succ(M,M2), M2 > 1.
date_succ(Y,M,D,Y,M,D2) :- D is D2-1, year_month_length(Y,M,L), D2 =< L, D2 > 1.

special_sunday(Y,M) :- between(1901, 2000, Y), date_day(Y,M,1,7).

solve_pe(N) :- findall([Y,M], special_sunday(Y,M), K), length(K, N).
