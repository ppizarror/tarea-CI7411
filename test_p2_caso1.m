%% TEST P2
% 4 capas sobre semiespacio (roca), fuerte contraste de impedancias

%% Testeo multicapa 4 capas y semiespacio (roca)
Vs = [100, 700, 750, 900, 1500]; % Velocidad onda de corte (m/s)
rho = [15, 17, 17, 20, 27]; % Densidad kN/m3
D = [0.01, 0.03, 0.02, 0.01, 0.005]; % Amortiguamiento (%)
H = [10, 5, 15, 10]; % Altura de cada estrato (m)
E1 = 1;
T = 0.3;

% Vs = [180, 180, 180, 180, 200];
% rho = [15, 15, 15, 15, 27];
% D = [0.03, 0.03, 0.03, 0.03, 0.005];


%% Muestra e,f
[e,f] = calc_ef(rho, Vs, D, H, E1, T);
disp(e);
disp(f);

dh = 0.2;
dt = 0.002;

%% Crea el grafico del factor de amplificacion
u = u_velt(rho,Vs,D,H,E1,T);
fa = fa_velt_sb(rho,Vs,D,H,E1);
fa(1)
plot_fa(fa, 0, 100, -25, 25, 'Factor Amplificacion');
fprintf('Freq. %f', 2*pi/T);

%% Genera el grafico
quake_velt(rho, Vs, D, H, E1, T, dh, dt);

%% Borra las variables
clear rho Vs D H E1 T dh dt;