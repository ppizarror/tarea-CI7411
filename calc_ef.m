function [E,F] = calf_ef(rho, Vs, D, H, E1, T)
% CALC_EF Calcula los E,F de cad acapa
%
%   u = u_velt([rho1,rho2..], [Vs1,Vs2..], [D1,D2..], [H1,H2..], E1, T)
%   u(z,t) => u
%
% Parametros:
%   rho     Vector densidad de cada capa, (n)
%   Vs      Vector velocidad onda de corte cada capa, (n)
%   D       Vector de razon de amortiguamiento (1/4pi), (n)
%   H       Vector de altura cada capa, sin considerar semiespacio (n-1)
%   E1      Primer valor de Ej, Fj
%   T       Periodo de la onda

%% Obtiene el numero de capas y verifica compatibilidad de datos
n = length(rho);
if length(Vs) ~= n || length(D) ~= n
    error('Vectores rho,Vs,D deben tener igual dimension (numero de capas)');
end
if length(H) ~= (n - 1)
    error('Vector H de altura de capas no debe considerar semiespacio');
end

%% Verifica valores de input
for i = 1:n
    if rho(i) <= 0
        error('Todas las componentes del vector de densidad de capa (rho) deben ser mayores a 0');
    end
end
for i = 1:n
    if Vs(i) <= 0
        error('Todas las componentes del vector de velocidad de onda de corte (Vs) deben ser mayores a 0');
    end
end
for i = 1:n
    if D(i) > 1 || D(i) < 0
        error('Todas las componentes del vector de amortiguamiento (D) deben ser mayores o iguales a cero y menores que 1');
    end
end
for i = 1:(n - 1)
    if H(i) <= 0
        error('Todas las componentes del vector de alturas de capa (H) deben ser mayores a cero');
    end
end
if E1 <= 0
    error('E1 debe ser mayor a cero');
end
if T <= 0
    error('El periodo de la onda debe ser mayor a cero')
end

%% Calcula propiedades N capas (Kelvin-Voigt)
nVs = Vs .* sqrt(1+2*1i*D); % Velocidad onda de corte compleja (si D!=0)
nG = nVs .* nVs .* rho; %#ok<NASGU> % Modulo de corte complejo (si D!=0)
w = 2 * pi / T; % Frecuencia
k = w ./ nVs; % Numero de onda complejo (si D!=0)

%% Calcula el vector de impedancias
imp = zeros(n-1, 1);
for i = 1:(n - 1)
    imp(i) = (rho(i) * nVs(i)) / (rho(i+1) * nVs(i+1));
end

%% Calcula los coeficientes E, F
E = zeros(n, 1);
F = zeros(n, 1);
E(1) = E1;
F(1) = E1; % Por condicion de superficie libre
for j = 1:(n - 1)
    E(j+1) = 0.5 * (E(j) * (1 + imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 - imp(j)) * exp(-1i*k(j)*H(j)));
    F(j+1) = 0.5 * (E(j) * (1 - imp(j)) * exp(1i*k(j)*H(j)) + F(j) * (1 + imp(j)) * exp(-1i*k(j)*H(j)));
end

end