% TEST P1
% Estrato sobre semiespacio (roca)

%% Testeo quake sistema elastico
T = 1.8; % (s)
H = 20; % (m)
Vs = 150; % (m/s)
ab = 10; % Amplitud basal (m)

%% Genera u(z,t)
u = u_elt(Vs, H, ab, T);
ft = fa_elt(Vs, H);
fprintf('P1 Analitico, frecuencia: %.4f\n', 2*pi/T);
fprintf('P1 Analitico, u(0,0): %.4f\n', u(0, 0));
fprintf('P1 Analitico, u(H,0): %.4f\n', u(H, 0));
fprintf('P1 Analitico, u(H/2,5): %.4f\n', u(H/2, 5));
fprintf('P1 Analitico, FT: %f\n', ft(2*pi/T));

% Calcula omega resonante
fprintf('P1 Analitico, periodo resonante: %f\n', 4*H/Vs);

dh = 0.2;
dt = 0.005;

%% Crea el grafico del factor de amplificacion
plot_fa(fa, 45, 10, 'Factor Amplificacion');

%% Genera el grafico
quake_elt(Vs, H, ab, T, dh, dt);

%% Borra las variables
clear T H Vs ab dh dt;