%% PARTE 3.B
% Genera H/V de los registros sísmicos en superficie

% Lista de archivos
archivos = ["00-06-16", "04-09-07a", "04-09-07b", "04-09-08a", "04-09-08b", ...
    "04-09-09", "04-09-10", "98-07-10", "98-10-10", "98-10-16", "99-01-17", ...
    "99-04-04", "99-04-06", "99-06-25a", "99-06-25b", "99-08-03"];

% Total de archivos
n = length(archivos);

finterp = 0.01:0.01:10; % Vector comun
hv = cell(1, n); % Guarda las interpolaciones

for i=1:n
    [fi, hvi] = hv_cargaf(archivos(i), '-sup', 200);
    hvi = interp1(fi(:), hvi(:), finterp(:), 'linear', 'extrap');
    
    % Guarda la interpolacion
    hv{i} = hvi;
end

hvmean = zeros(1, length(hvi));
hvstd = zeros(1, length(hvi));
hvdata = zeros(1, n);
for j=1:length(finterp)
    % Carga los datos para ese i-frecuencia
    for i=1:n
        hvdata(i) = hv{i}(j);
    end
    hvmean(j) = mean(hvdata);
    hvstd(j) = std(hvdata);
end

% Crea el vector aumentado de hv
semilogx(finterp, hvmean, 'k', 'LineWidth', 3.0);
semilogx(finterp, hvmean + hvstd, 'k--', 'LineWidth', 2.0);
semilogx(finterp, hvmean - hvstd, 'k--', 'LineWidth', 2.0);

% Setea titulo
xlabel('f (Hz)', 'interpreter', 'latex');
ylabel('H/V', 'interpreter', 'latex');
title('H/V Registro en Superficie');