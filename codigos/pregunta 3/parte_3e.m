%% CASO 3.E
% Modelo del problema

% Crea sistema de capas
Vs = [180, 200, 250, 200, 720, 250, 250, 720, 1800]; % Velocidad onda de corte (m/s)
rho = [18, 15, 20, 16, 21, 17, 17, 19, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.01]; % Amortiguamiento (%)
H = [6, 5, 2, 8, 5, 8, 11, 16]; % Altura de cada estrato (m)

E1 = 1; % Valor cualquiera

%% Genera el grafico
dh = 0.2;
dt = 0.002;
quake_velt(rho, Vs, D, H, E1, 1, dh, dt);