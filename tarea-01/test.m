% CASO 1
% calculocasos([10, 20, 35], [16.5, 19, 24, 27], [350000, 2200000, 5600000, 24500000], [0.04, 0.02, 0.01]);

% Testeo multicapa 3 capas
u = u_multc([10, 20, 35], [150, 200, 1000], [0.02, 0.04, 0.05], [5, 15], 1, 1);
u(21,1);