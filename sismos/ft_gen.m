function [w, ft] = ft_gen(ew_s, ns_s, z_s, ew_r, ns_r, z_r)
%FT_GEN Genera la curva de funcion de transferencia para dos registros, en
%superficie y roca

%% Genera la FFT para el suelo
data_ew = load(few);
data_ew(1, :) = []; % Elimina la primera linea

data_ns = load(fns);
data_ns(1, :) = []; % Elimina la primera linea

data_z = load(fz);
data_z(1, :) = []; % Elimina la primera linea

% Se guarda en columnas separadas tiempo y registro
ns_acc = data_ns(:, 2);
ew_acc = data_ew(:, 2);
z_acc = data_z(:, 2);

ns_t = data_ns(:, 1);

% Calcula frecuencia y dt
dt = ns_t(2) - ns_t(1);
f = 1 / dt;

% Correccion por linea base
ns_acc = detrend(ns_acc, 0);
ew_acc = detrend(ew_acc, 0);
z_acc = detrend(z_acc, 0);

% Crea base para FFT
t_len = floor(length(ns_t));
t_len_h = floor(t_len/2);

% Tuckey (5%)
tuckey = tukeywin(t_len, 0.05);

% Arreglo frecuencias
freq_arr = 0:f / t_len:f - 1 / t_len;
freq_h = freq_arr(1:t_len_h);

%% Calcula Nakamura, se utiliza todo el espectro, no hay ventanas

% Tuckey window
ns_itr = ns_acc .* tuckey;
ew_itr = ew_acc .* tuckey;
z_itr = z_acc .* tuckey;

% FFT
ns_fft_itr = fft(ns_itr);
ew_fft_itr = fft(ew_itr);
z_fft_itr = fft(z_itr);

% Selecciona mitad de los datos
fft_ns = ns_fft_itr(1:t_len_h);
fft_ew = ew_fft_itr(1:t_len_h);
fft_z = z_fft_itr(1:t_len_h);

fft_ns = medfilt1(abs(fft_ns), filtro);
fft_ew = medfilt1(abs(fft_ew), filtro);
fft_z = medfilt1(abs(fft_z), filtro);

end