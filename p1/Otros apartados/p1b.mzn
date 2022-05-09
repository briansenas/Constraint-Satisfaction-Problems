include "globals.mzn";
float: n;
constraint assert( n > 0.0, "El valor introducido no es válido: " ++
                             "El valor de N tiene que ser positivo definido");
                             
% Inicializamos los valores de las variables;
set of int: S = 1..8;
% Trabajemos mejor sobre enteros: 
var float: a = n*100;
% A_pagar representa la cantidad de monedas, cada posición es una moneda diferente;
array[S] of var int: a_pagar;
array[S] of var float: values = [1,2,5,10,20,50,100,200];
var int: budget; 

% Forzamos a que sean valores positivos; 
constraint forall(col in S)(a_pagar[col] >= 0);
% Queremos que la suma de las cantidades de monedas por su valor sea el precio a pagar;
constraint sum(col in S)(a_pagar[col] * values[col])== a;
% Si el importe es mayor a 1 euro tenemos que utilizar alguna de las monedas grandes
constraint a_pagar[7]>= if a>=100 /\ a<200 then 1 else 0 endif;
constraint a_pagar[8]>= if a>=200 then floor(fix(a)/200) else 0 endif; 
constraint sum(a_pagar) = budget;

solve satisfy;