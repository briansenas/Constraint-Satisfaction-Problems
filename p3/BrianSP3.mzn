% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";
   
set of int: S = 1..5;
% Definimos todas las nacionalidades que hay en el enunciado;
var S: vasco; var S: gallego; var S:andaluz; var S: navarro;
var S: catalan;
% Definimos todos los colores;
var S: rojo; var S: blanco; var S: azul; var S: amarillo; 
var int: verde;
% Definimos todos los animales;
var S: zorro;var S: caballo; var S: perro; var S: caracoles; var S: cebra;
% Definimos todas las bebidas; 
var S: te; var S: leche; var S: zumo; var S: cafe;var S: agua;
% Definimos todas las profesiones
var S: medico; var S: diplomatico; var S: escultor; 
var S: violinista; var S: pintor;
% Creamos vectores para cada conjunto 
array[S] of var S: casas = [vasco,gallego,catalan,andaluz, navarro];
array[S] of var S: colores = [rojo,blanco,azul,verde,amarillo];
array[S] of var S: profesiones = [medico,escultor,violinista,pintor,diplomatico];
array[S] of var S: animales = [zorro,caballo,perro,caracoles,cebra];
array[S] of var S: bebidas = [te,leche,zumo,cafe,agua];
% Verificamos que los vectores tienen valores diferentes; 
constraint alldifferent(casas);
constraint alldifferent(colores);
constraint alldifferent(profesiones);
constraint alldifferent(animales);
constraint alldifferent(bebidas);
% Imponemos una a una las restricciones del enunciado; 
constraint vasco = rojo;
constraint catalan = perro;
constraint gallego = pintor;
constraint navarro = te; 
constraint andaluz = 1; 
constraint verde = cafe; 
constraint verde = blanco + 1;
constraint escultor = caracoles;
constraint diplomatico = amarillo;
constraint leche = 3;
constraint andaluz = azul - 1 \/ andaluz = azul + 1; 
constraint violinista = zumo;
constraint zorro = medico - 1 \/ zorro = medico + 1; 
constraint caballo = diplomatico - 1 \/ caballo = diplomatico + 1; 

solve satisfy;