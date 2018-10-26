% Genera la curva de factor de transferencia empirica

clear all; %#ok<CLALL> % Limpia las variables
close all;

% Lista de archivos
archivos = ["00-06-16", "04-09-07a", "04-09-07b", "04-09-08a", "04-09-08b", ...
    "04-09-09", "04-09-10", "98-07-10", "98-10-10", "98-10-16", "99-01-17", ...
    "99-04-04", "99-04-06", "99-06-25a", "99-06-25b", "99-08-03"];

% Total de archivos
n = length(archivos);

ft_carga(archivos[1]);