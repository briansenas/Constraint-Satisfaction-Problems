% Definición de variables
var int: x;
var int: y;

% Definición de restricciones
constraint x > 0;
constraint y > 0;
constraint x > y;

% Indicamos que es un CSP
solve satisfy;
