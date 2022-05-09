% Use this editor as a MiniZinc scratch book
include "globals.mzn"; 

int: horizon = 80;                  % time horizon maxDuration*Tasks
set of int: Time = 0..horizon;      % allowed timeline numbers
set of int: Task = 1..9;            % number of task
set of int: Machine = 1..3;         % number of workers

array[Task,Machine] of int: d = 
                           [| 4, 7 , 10
                            | 3, 5 , 7
                            | 3, 1 , 4
                            | 2, 5 , 8
                            | 4, 2 , 6
                            | 3, 2 , 1
                            | 1, 2 , 3
                            | 1, 3 , 5
                            | 2, 3 , 4 |];
 
int: maxd = max([ d[t,m] | t in Task, m in Machine ]); % max Duration 
int: mind = min([ d[t,m] | t in Task, m in Machine ]); % min Duration

array[Task] of var Time: S;             % start time
array[Task] of var mind..maxd: D;       % duration of the task
array[Task,Machine] of var opt Time: O; % task start matrix

solve minimize max(t in Task)(S[t] + D[t]);

% Task constrains given by the question 
constraint S[2] >= S[1]+D[1];
constraint S[3] >= S[2]+D[2];
constraint S[4] >= S[1]+D[1];
constraint forall(s in 5..7)(S[s]>=S[3]+D[3] \/ S[s]>=S[4]+D[4]);
constraint S[8] >= S[1]+D[1];
constraint S[9] >= S[7]+D[7] \/ S[9] >= S[8]+D[8];

% We require the task s, duration d, spans the task time 
constraint forall(t in Task)(alternative(S[t],D[t],
                 [O[t,m]|m in Machine],[d[t,m]|m in Machine])); 
                 
% Check that we only run one task per machine at a given time 
constraint forall(m in Machine)
                 (disjunctive([O[t,m]|t in Task],[d[t,m]|t in Task]));
                                  
