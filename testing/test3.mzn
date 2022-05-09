set of int: VALUES = 1..20;
var VALUES: x;
var VALUES: y;

constraint x > y;

% Indicamos que es un CSP
solve maximize x+y;
