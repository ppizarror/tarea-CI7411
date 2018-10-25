% TEST P1
% Estrato sobre semiespacio (roca)

%% Testeo quake sistema elastico
T = 1.8; % (s)
H = 20; % (m)
Vs = 40; % (m/s)
ab = 10; % Amplitud basal (m)

% Calcula omega resonante
fprintf('Periodo resonante: %f', 4 * H / Vs);

dh = 0.2;
dt = 0.001;

%% Crea el grafico del factor de amplificacion
fa = fa_elt(Vs, H);
plot_fa(fa, 10, 10, 'Factor Amplificacion', true);

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt;