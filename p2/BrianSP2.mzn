include "globals.mzn";

% Inicializamos las variables; 
set of int: horas = 1..6;
set of int: dias = 1..5;
set of int: asign = 1..9; 
array[horas,dias] of var int: timestamp;
array[asign] of int: duration = [4,2,4,4,4,2,2,2,1];
array[asign] of int: bloques = [2,1,2,2,2,1,1,2,1];

% Aquí pongo los conjuntos de asignaturas que pueden tener cada día;
set of int: lunes = {0,1,4,9,2};
set of int: martes = {0,1,4,7,2};
set of int: miercoles = {0,3,6,8,2};
set of int: jueves = {0,3,5,2};
set of int: viernes = {0,5,6,7,2};

% Aquí pongo los conjuntos de asignaturas que pueden tener cada horario;
set of int: primeras = {0,4,5,2,7,8};
set of int: antes_recreo = {0,6,9,2,7,8};
set of int: ultimas = {0,1,3,2,7,8};

% Valores positivos;
constraint forall(f in horas)(forall(c in dias)(timestamp[f,c]>=0));

% En cada día de la semana se puede impartir como máximo un bloque de las asignaturas.
constraint forall(f in asign)(forall(c in dias)(
        (sum(fila in horas)(bool2int(timestamp[fila,c]==f)))<=bloques[f]));
        
% Mínimo de horas semanales:
constraint forall(f in asign)(sum(c in dias)
(sum(fila in horas)(bool2int(timestamp[fila,c]==f)))>=duration[f]
);
        
%Restricción por días para cada conjunto día:
constraint forall(f in horas)(timestamp[f,1] in lunes );
constraint forall(f in horas)(timestamp[f,2] in martes);
constraint forall(f in horas)(timestamp[f,3] in miercoles);
constraint forall(f in horas)(timestamp[f,4] in jueves);
constraint forall(f in horas)(timestamp[f,5] in viernes);

%Restricción por horas para cada conjunto horario:
constraint forall(c in dias)(timestamp[1,c] in primeras /\ timestamp[2,c] in primeras);
constraint forall(c in dias)(timestamp[3,c] in antes_recreo);
constraint forall(c in dias)(timestamp[4,c] == 0);
constraint forall(c in dias)(timestamp[5,c] in ultimas /\ timestamp[6,c] in ultimas);

solve satisfy;