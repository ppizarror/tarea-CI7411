% TEST P2
% 4 capas sobre semiespacio (roca)

%% Testeo multicapa 4 capas y semiespacio (roca)
Vs = [100, 220, 700, 250, 1500]; % Velocidad onda de corte (m/s)
rho = [15, 16.5, 17, 15, 27]; % Densidad kN/m3
D = [0.01, 0.03, 0.02, 0.01, 0.005]; % Amortiguamiento (%)
H = [10, 5, 15, 10]; % Altura de cada estrato (m)
E1 = 1;
T = 0.3;

% Vs = [180, 180, 180, 180, 200];
% rho = [15, 15, 15, 15, 27];
% D = [0.03, 0.03, 0.03, 0.03, 0.005];

dh = 0.2;
dt = 0.002;

%% Genera el grafico
quake_velt(rho, Vs, D, H, E1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt;