% Genera la curva de factor de transferencia empirica

clear all; %#ok<CLALL> % Limpia las variables
close all;

% Lista de archivos
archivos = ["00-06-16", "04-09-07a", "04-09-07b", "04-09-08a", "04-09-08b", ...
    "04-09-09", "04-09-10", "98-07-10", "98-10-10", "98-10-16", "99-01-17", ...
    "99-04-04", "99-04-06", "99-06-25a", "99-06-25b", "99-08-03"];

% Total de archivos
n = length(archivos);

winterp = 0.01:0.01:25; % Vector comun
ft = cell(1, n); % Guarda las interpolaciones

% Recorre cada archivo
for i=1:n
    [wi, fti] = ft_carga(archivos(i), 300);
    fti = interp1(wi(:), fti(:), winterp(:), 'linear', 'extrap');
    
    % Guarda la interpolacion
    ft{i} = fti;
end

ftmean = zeros(1, length(fti));
ftstd = zeros(1, length(fti));
ftdata = zeros(1, n);
for j=1:length(winterp)
    % Carga los datos para ese i-frecuencia
    for i=1:n
        ftdata(i) = ft{i}(j);
    end
    ftmean(j) = mean(ftdata);
    ftstd(j) = std(ftdata);
end

% Crea el vector aumentado de ft
plot(winterp, ftmean, 'k', 'LineWidth', 3.0);
plot(winterp, ftmean + ftstd, 'k--', 'LineWidth', 2.0);
plot(winterp, ftmean - ftstd, 'k--', 'LineWidth', 2.0);

% Limita los ejes
xlim([0, 24]);
ylim([0, 35]);

% Frecuencia
xlabel('$\omega$', 'interpreter', 'latex');
ylabel('FT($\omega$)', 'interpreter', 'latex');
title('Funcion de transferencia empirica');