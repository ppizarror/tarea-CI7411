% TEST P1
% Estrato sobre semiespacio (roca), caso cercano a resonancia

%% Testeo quake sistema elastico
H = 20; % (m)
Vs = 40; % (m/s)
ab = 10; % Amplitud basal (m)

% Calcula omega resonante
T= 4*H/Vs;
fprintf('Periodo resonante: %f', T);

dh = 0.2;
dt = 0.01;

%% Crea el grafico del factor de amplificacion
fa = fa_elt(Vs,H);
plot_fa(fa,10,10,'Factor Amplificacion');

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt;