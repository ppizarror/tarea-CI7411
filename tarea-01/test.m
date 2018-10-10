
%% Testeo multicapa 2 capas y semiespacio
G = [10, 20, 35];
Vs = [150, 200, 1000];
D = [0.1, 0.04, 0.05];
H = [500, 55];
E1 = 1;
T = 0.6;

dh = 0.2;
dt = 0.005;

%% Genera el grafico
quake(G, Vs, D, H, E1, T, dh, dt);