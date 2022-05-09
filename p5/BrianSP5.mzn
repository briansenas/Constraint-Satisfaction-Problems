include "globals.mzn";

% Inicializamos los datos del problema; 
% semilla = 1
int: NUM_NODOS ;
int: NUM_ARISTAS;
array[1..NUM_ARISTAS,1..2] of int: aristas;

% Aquí genero las variables necesarias para el problema: 
set of int: ARISTAS = 1..NUM_ARISTAS;
set of int: NODOS = 1..NUM_NODOS;
%int: max = ceil((NUM_NODOS*(NUM_NODOS-1))/2);
int: max = NUM_NODOS;
set of int: MAX = 0..max;

% Voy a utilizar una matriz de adyacencia para almacenar los colores;
array[NODOS,NODOS] of var MAX: colores;
% Además tendré un vector con el color impuesto para cada arista;
array[ARISTAS] of var 1..max: color;

%solve minimize sum([colores[a,b] | a in NODOS, b in NODOS]);
solve minimize max(color);

% Al haber impuesto que son valores de 0 a MAX, asumiré que 0 es nulo, 
% Como si no hubiera aristantre ese par de nodo;
constraint forall(a in NODOS)
(alldifferent_except_0([colores[a,b]|b in NODOS]));

% Para evitar soluciones simétricas impondré que los colores van en orden creciente;
constraint forall(a in ARISTAS)(value_precede(a,a+1,color));

% Por último como a cada arista le impongo un color, fuerzo a cambiar algunas 
% Posiciones de la matriz colores a un valor distinto de 0 y de todos en fila/columna;
constraint forall(a in ARISTAS)    
( colores[aristas[a,1],aristas[a,2]] = color[a] 
   /\ colores[aristas[a,2],aristas[a,1]] = color[a] );
   
output [" Mínimo número de Colores= \(max([color[a] | a in ARISTAS])) \n"]