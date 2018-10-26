%% CASO 3.F
% Carga los resultados del programa DEEPSOIL y crea la curva
% del factor de transferencia para el metodo lineal equivalente

%% Genera la curva de factor de transferencia empirica
ftsitio = figure;

%% Lista de archivos
archivos = ["00-06-16", "04-09-07a", "04-09-07b", "04-09-08a", "04-09-08b", ...
    "04-09-09", "04-09-10", "98-07-10", "98-10-10", "98-10-16", "99-01-17", ...
    "99-04-04", "99-04-06", "99-06-25a", "99-06-25b", "99-08-03"];

% Total de archivos
n = length(archivos);

winterp = 0.01:0.01:25; % Vector comun
ft = cell(1, n*2); % Guarda las interpolaciones

% Recorre cada archivo EW
for i=1:n
    fdata = load(strcat("sismos/resultados-roca/",strcat(archivos(i), "-ew.txt")));
    wi = fdata(:,1);
    fti = fdata(:, 3);
    
    % Grafica
    plot(wi, fti);
    hold on;
    
    % Guarda la interpolacion
    fti = interp1(wi(:), fti(:), winterp(:), 'linear', 'extrap');
    ft{2*i-1} = fti;
end

% Carga los NS
for i=1:n
    fdata = load(strcat("sismos/resultados-roca/",strcat(archivos(i), "-ns.txt")));
    wi = fdata(:,1);
    fti = fdata(:, 3);
    
    % Grafica
    plot(wi, fti);
    hold on;
    
    % Guarda la interpolacion
    fti = interp1(wi(:), fti(:), winterp(:), 'linear', 'extrap');
    ft{2*i} = fti;
end

%% Genera curva mediana y desviacion estandar
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
plot(winterp, ftmean, 'k', 'LineWidth', 2.0);
plot(winterp, ftmean + ftstd, 'k--', 'LineWidth', 1.0);
plot(winterp, ftmean - ftstd, 'k--', 'LineWidth', 1.0);

% Limita los ejes
xlim([0, 25]);
ylim([0, 12]);
grid on;

% Frecuencia
xlabel('$\omega$', 'interpreter', 'latex');
ylabel('FT($\omega$)', 'interpreter', 'latex');
title('Funcion de transferencia empirica');

%% Crea grafico nuevo comparacion
figure()
hold off;

% Grafica el analitico
ftsbinterp = interp1(wftsb(:), ftsb(:), winterp(:), 'linear', 'extrap');
plot(winterp, ftsbinterp, 'b', 'LineWidth', 1.0);
hold on;
grid on;
plot(winterp, ftmean, 'k', 'LineWidth', 1.0);
xlim([0, 25]);
ylim([0, 12]);

xlabel('$\omega$', 'interpreter', 'latex');
ylabel('FT($\omega$)', 'interpreter', 'latex');
title('Comparacion Funcion Transferencia Empirica / Analitica');
legend({'FT Analitica', 'FT Empirica'}, 'Location', 'northeast')