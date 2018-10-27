%% CASO 3.H
% Carga los espectros de aceleracion de DEEPSOIL, genera grafico promedio y
% desviacion. Genera ademas el espectro de aceleracion NCH433

%% Genera la curva de factor de transferencia empirica
ftsitio = figure;

%% Lista de archivos
archivos = ["00-06-16", "04-09-07a", "04-09-07b", "04-09-08a", "04-09-08b", ...
    "04-09-09", "04-09-10", "98-07-10", "98-10-10", "98-10-16", "99-01-17", ...
    "99-04-04", "99-04-06", "99-06-25a", "99-06-25b", "99-08-03"];

% Total de archivos
n = length(archivos);

tinterp = 0.01:0.01:10; % Vector comun
sa = cell(1, n*2); % Guarda las interpolaciones

% Recorre cada archivo EW
for i=1:n
    fdata = load(strcat("sismos/resultados-sa/",strcat(archivos(i), "-ew.txt")));
    ti = fdata(:,1);
    sai = fdata(:, 2);
    
    % Grafica
    semilogx(ti, sai);
    hold on;
    
    % Guarda la interpolacion
    sai = interp1(ti(:), sai(:), tinterp(:), 'linear', 'extrap');
    sa{2*i-1} = sai;
end

% Carga los NS
for i=1:n
    fdata = load(strcat("sismos/resultados-sa/",strcat(archivos(i), "-ns.txt")));
    ti = fdata(:,1);
    sai = fdata(:, 2);
    
    % Grafica
    semilogx(ti, sai);
    hold on;
    
    % Guarda la interpolacion
    sai = interp1(ti(:), sai(:), tinterp(:), 'linear', 'extrap');
    sa{2*i} = sai;
end

%% Genera curva mediana y desviacion estandar
samean = zeros(1, length(sai));
sastd = zeros(1, length(sai));
sadata = zeros(1, 2*n);
for j=1:length(tinterp)
    for i=1:2*n % Carga los datos para ese i-frecuencia
        sadata(i) = sa{i}(j);
    end
    samean(j) = mean(sadata);
    sastd(j) = std(sadata);
end

% Crea el vector aumentado de ft
semilogx(tinterp, samean, 'k', 'LineWidth', 2.0);
semilogx(tinterp, samean + sastd, 'k--', 'LineWidth', 1.0);
semilogx(tinterp, samean - sastd, 'k--', 'LineWidth', 1.0);

% Limita los ejes
xlim([0, 10]);
ylim([0, 1.5]);
grid on;
grid minor;

% Frecuencia
xlabel('T (s)', 'interpreter', 'latex');
ylabel('SA (g)', 'interpreter', 'latex');
title('Aceleracion Espectral');