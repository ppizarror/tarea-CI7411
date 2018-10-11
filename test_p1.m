%% Testeo quake sistema elastico
T = 0.2; % (s)
H = 20; % (m)
Vs = 40; % (m/s)
ab = 10; % Amplitud basal (m)

dh = 0.2;
dt = 0.001;

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt;