function plt = plot_fa(fa, wmax, famax, plot_title, NPOINTS, plot_colorw, show_legend)
%PLOT_FA Grafica la funcion del factor de amplificacion.
%
%   plot = plot_fa(fa, wmax, famax, 'Plot title');
%   plot = plot_fa(fa, wmax, famax, 'Plot title', 1000);
%   plot = plot_fa(fa, wmax, famax, 'Plot title', 100, 'k');
%   plot = plot_fa(fa, wmax, famax, 'Plot title', 100, 'k, false);
%
% Parametros:
%   fa              Funcion factor de amplificacion
%   wmax            Frecuencia maxima de evaluacion, eje x
%   famax           Valor maximo de FA en el eje y
%   plot_title      Titulo del grafico
%   NPOINTS         Numero de puntos de evaluacion, por defecto es 100
%   plot_colorw     Color del grafico FA(w)
%   show_legend     Muestra la leyenda

%% Inicia variables
if ~exist('NPOINTS', 'var')
    NPOINTS = 100;
end
if ~exist('plot_colorw', 'var')
    plot_colorw = 'k';
end
if ~exist('show_legend', 'var')
    show_legend = true;
end

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', plot_title);

%% Crea las variables
w = linspace(0.01, wmax, NPOINTS);
faw = zeros(NPOINTS, 1);
for i = 1:NPOINTS
    faw(i) = fa(w(i));
end

%% Grafica
plot(w, faw, plot_colorw);
grid on;
title(plot_title);
xlabel('$\omega$', 'interpreter', 'latex');
ylabel('FA($\omega$)', 'interpreter', 'latex');
ylim([-famax, famax]);
xlim([0, wmax]);
if show_legend
    legend({'FA(\omega)'}, 'Location', 'northwest')
end

end