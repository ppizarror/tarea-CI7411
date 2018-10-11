function u = u_elt(Vs, H, ab, T)
% U_ELT Retorna una funcion que permite obtener el desplazamiento t en una profundidad zj de un medio elastico de una sola capa.
%
%   u := u_multc([G1,G2..], [Vs1,Vs2..], [D1,D2..], [H1,H2..])
%   u(zj,t) => u
%
% Parametros:
%   Vs      Velocidad onda de corte
%   H       Altura del estrato de suelo
%   ab      Amplitud basal
%   T       Periodo de la onda de corte

%% Verifica valores de input
if Vs <= 0
    error('La velocidad de onda de corte debe ser positiva');
end
if H <= 0
    error('La altura del estrato de suelo debe ser mayor a cero');
end
if ab <= 0
    error('La amplitud basal debe ser mayor a cero');
end

%% Calcula propiedades N capas (Kelvin-Voigt)
nVs = Vs .* sqrt(1+2*1i*D); % Velocidad onda de corte compleja (si D!=0)
nG = nVs .* nVs .* rho; %#ok<NASGU> % Modulo de corte complejo (si D!=0)
w = 2 * pi / T; % Frecuencia
k = w ./ nVs; % Numero de onda complejo (si D!=0)

%% Calcula el vector de impedancias
imp = zeros(n-1, 1);
for i = 1:n - 1
    imp(i) = (rho(i) * nVs(i)) / (rho(i+1) * nVs(i+1));
end

%% Calcula los coeficientes E, F
E = zeros(n, 1);
F = zeros(n, 1);
E(1) = E1;
F(1) = E1; % Por condicion de superficie libre
for j = 1:n - 1
    E(j+1) = 0.5 * (E(j) * (1 + imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 - imp(j)) * exp(-1i*k(j)*H(j)));
    F(j+1) = 0.5 * (E(j) * (1 - imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 + imp(j)) * exp(-1i*k(j)*H(j)));
end

%% Calcula las alturas acumuladas
Hacum = zeros(n-1, 1);
Hacum(1) = H(1);
for j = 2:n - 1
    Hacum(i) = Hacum(i-1) + H(i);
end

%% Retorna la funcion de desplazamiento
u = @(z, t) u_zt_nc_velt(z, t, n, Hacum, E, F, k, w);

end

function u = u_zt_nc_velt(z, t, n, Hacum, E, F, k, w)
% U_ZT_NC Funcion local que calcula el desplazamiento u(z,t) en un sistema
% de capas conocido, E,F corresponden a los factores calculados por
% u_multc, n numero de capas.
%
% Parametros
%   z       Valor de zj donde se evalua
%   t       Tiempo de evaluacion
%   n       Numero de capas
%   H       Alturas acumuladas de las n-capas
%   E       Vector Ej de cada n-capa
%   F       Vector Fj de cada n-capa
%   k       Vector de numero de onda complejo para cada n-capa
%   w       Frecuencia de la onda

%% Obtiene el numero de la capa que corresponde a z
nc = n; % Inicialmente es el semiespacio
for j = 1:n - 1
    if (z <= Hacum(j))
        nc = j;
        break;
    end
end

%% z se considera desde el inicio de la capa
if nc > 1
    z = z - Hacum(nc-1);
end

%% Calcula el valor de u(z,t) para la capa seleccionada
u = E(nc) * exp(1i*(w * t + k(nc) * z)) + F(nc) * exp(1i*(w * t - k(nc) * z));

end