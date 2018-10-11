function quake(rho, Vs, D, H, E1, T, dh, dt, plot_normalize, plot_pause, plot_cp, plot_maxp)
% QUAKE Genera un grafico de u(z,t) en funcion del tiempo.
%
% Parametros:
%   rho             Vector densidad de cada capa, (n)
%   Vs              Vector velocidad onda de corte cada capa, (n)
%   D               Vector de razon de amortiguamiento (1/4pi), (n)
%   H               Vector de altura cada capa, sin considerar semiespacio (n-1)
%   E1              Primer valor de Ej, Fj
%   T               Periodo de la onda
%   dh              Delta paso en profundidad
%   dt              Delta paso en tiempo
%   plot_normalize  Normaliza los resultados
%   plot_pause      Tiempo de pausa
%   plot_cp         Muestra las capas
%   plot_maxp       Muestra los puntos maximos

%% Inicia variables
if ~exist('plot_normalize', 'var')
    plot_normalize = true;
end
if ~exist('plot_pause', 'var')
    plot_pause = 1 / 30;
end
if ~exist('plot_cp', 'var')
    plot_cp = true;
end
if ~exist('plot_maxp', 'var')
    plot_maxp = true;
end

%% Crea la funcion u(z,t)
u = u_multc(rho, Vs, D, H, E1, T);

%% Crea puntos de evaluacion
z = 0:dh:sum(H);
t = 0:dt:(10000 * T);

%% Calcula los maximos deslazamientos
u0 = 0; % Desplazamiento maximo en toda la onda
uh0 = 0; % Desplazamiento maximo en superficie
uhh = 0; % Deslazamiento maximo en profundidad
mt = 0:dt:T;
for i = 1:length(mt)
    for j = 1:length(z)
        u0 = max(u0, max(abs(u(z(j), mt(i)))));
    end
    for j = 1:length(z)
        uh0 = max(uh0, max(abs(u(z(1), mt(i)))));
    end
    for j = 1:length(z)
        uhh = max(uhh, max(abs(u(z(end), mt(i)))));
    end
end
u0=uhh;
z0 = max(z);
if plot_normalize
    uh0 = uh0 / u0;
    uhh = uhh / u0;
end

%% Genera las capas para graficar
ncp = length(H) + 1;
Hcp = zeros(ncp, 1);
for i = 2:ncp
    Hcp(i) = Hcp(i-1) + H(i-1);
end
if plot_normalize
    for i = 1:ncp
        Hcp(i) = Hcp(i) / z0;
    end
end

%% Genera el grafico
plt = figure();

% Modifica la figura
movegui(plt, 'center');
set(gcf, 'name', 'Quake');
set(axes, 'YAxisLocation', 'Right');

% Propiedades del grafico dependiendo si se normaliza o no
uu = 1;
zz = 1;
plot_xlabel = 'u/u0';
plot_ylabel = 'z/h';

if ~plot_normalize
    uu = u0;
    zz = z0;
    u0 = 1;
    z0 = 1;
    plot_xlabel = 'u';
    plot_ylabel = 'z';
end

%% Escribe u(z,t) grafico para cada t
u_ = zeros(length(z), 1);

for i = 1:length(t)
    
    % Si el usuario cierra el plot termina de graficar
    if ~ishandle(plt)
        delete(plt);
        close; % Cierra el grafico
        return;
    end
    
    % Calcula el desplazamiento
    for j = 1:length(z)
        u_(j) = real(u(z(j), t(i)));
    end
    
    % Grafica el desplazamiento
    plot(u_./u0, z./z0, 'b');
    hold on;
    
    % Grafica las capas
    if plot_cp
        for j = 1:ncp
            line([-uu, uu], [Hcp(j), Hcp(j)], 'Color', 'black');
        end
    end
    
    % Grafica los puntos maximos
    if plot_maxp
        plot(uh0, 0, 'sb', 'MarkerFaceColor', 'blue');
        plot(-uh0, 0, 'sb', 'MarkerFaceColor', 'blue');
        plot(uhh, zz, 'sb', 'MarkerFaceColor', 'blue');
        plot(-uhh, zz, 'sb', 'MarkerFaceColor', 'blue');
    end
    
    % Invierte el grafico
    set(gca, 'Ydir', 'reverse');
    xlim([-uu, uu]);
    ylim([0, zz]);
    xlabel(plot_xlabel);
    ylabel(plot_ylabel);
    title('Quake pirata');
    
    % Pausa
    pause(plot_pause);
    hold off;

end

end