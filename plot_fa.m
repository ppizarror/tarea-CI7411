function plt = plot_fa(fa, wmax, famax, plot_title, plot_T, NPOINTS, plot_color)
%PLOT_FA Grafica la funcion del factor de amplificacion.
%
%   plot := plot_fa(fa,wmax,famax)
%
% Parametros:
%   fa              Funcion factor de amplificacion
%   wmax            Frecuencia maxima de evaluacion, eje x
%   famax           Valor maximo de FA en el eje y
%   plot_title      Titulo del grafico
%   plot_T          Grafica el periodo en vez de la frecuencia
%   NPOINTS         Numero de puntos de evaluacion, por defecto es 100
%   plot_color      Color del grafico

%% Inicia variables
if ~exist('plot_T', 'var')
    plot_T = false;
end
if ~exist('NPOINTS', 'var')
    NPOINTS = 100;
end
if ~exist('plot_color', 'var')
    plot_color = 'k';
end

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', plot_title);

%% Crea las variables
w = linspace(0, wmax, NPOINTS);
faw = zeros(NPOINTS, 1);
for i = 1:NPOINTS
    faw(i) = fa(w(i));
end

%% Grafica
plot(w, faw, plot_color);
grid on;
title(plot_title);
if ~plot_T
    xlabel('$\omega$', 'interpreter', 'latex');
    ylabel('FA($\omega$)', 'interpreter', 'latex');
else
    xlabel('T');
    ylabel('FA(T)');
end
ylim([-famax, famax]);

end