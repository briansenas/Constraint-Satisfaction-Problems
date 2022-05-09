include "globals.mzn";

int : n ;
array [1..n] of var 1..n: reinas;

constraint alldifferent(reinas);
constraint alldifferent([reinas[i]-i | i in 1..n]);
constraint alldifferent([reinas[i]+i | i in 1..n]);

solve satisfy;
output [ if fix(reinas[j]) == i then "Q" else "." endif ++
         if j == n then "\n" else "" endif | i,j in 1..n];
