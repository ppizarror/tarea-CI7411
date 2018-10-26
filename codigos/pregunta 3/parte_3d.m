%% CASO 3.D
% Genera las curvas FTsb (Funcion de transferencia superficie-roca basal) y
% FTsa (Roca-basal y Afloramiento rocoso)

%% Crea sistema de capas
Vs = [180, 200, 250, 200, 720, 250, 250, 720, 1800]; % Velocidad onda de corte (m/s)
rho = [18, 15, 20, 16, 21, 17, 17, 19, 25]; % Densidad kN/m3
D = [0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.01]; % Amortiguamiento (%)
H = [6, 5, 2, 8, 5, 8, 11, 16]; % Altura de cada estrato (m)

E1 = 1; % Valor cualquiera

%% Genera los factores FTsb, FTsa
ft_sb = fa_velt_sb(rho, Vs, D, H, E1); % ft_sb(w)
ft_sa = fa_velt_sa(rho, Vs, D, H, E1); % ft_sa(w)

%% Grafica los factores
[wftsb, ftsb] = plot_fa(ft_sb, 0.05, 25, 0, 12, 'Funcion Transferencia Superficie / Roca Basal', 'FTsb', false);
[wftsa, ftsa] = plot_fa(ft_sa, 0.05, 25, 0, 8, 'Funcion Transferencia Superficie / Afloramiento Rocoso', 'FTsa', false);
hold on;
dh = 0.2;
dt = 0.002;