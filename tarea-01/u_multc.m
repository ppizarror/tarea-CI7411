function u = u_multc(G, rho, Vs, D, H, E1, T)
% U_MULTC Retorna una funcion que permite obtener el desplazamiento t en
% una profundidad zj de un medio visco-elastico compuesto por varias capas
% 1..j
%
%   u := u_multc([G1,G2..], [rho1,rho2..], [Vs1,Vs2..], [D1,D2..],
%   [H1,H2..])
%   u(zj,t) => u
%
% Parametros:
%   G       vector del modulo de corte de cada capa, (n)
%   rho     vector de densidad de cada capa, (n)
%   Vs      vector velocidad onda de corte cada capa, (n)
%   D       vector de razon de amortiguamiento (1/4pi), (n)
%   H       vector de altura cada capa, sin considerar semiespacio (n-1)
%   E1      primer valor de Ej, Fj
%   T       periodo de la onda

%% Obtiene el numero de capas y verifica compatibilidad de datos
n = length(G);
if (length(rho) ~= n || length(Vs) ~= n || length(D) ~= n)
    error('Vectores G,rho,Vs,D deben tener igual dimension (numero de capas)');
end
if (length(H) ~= n - 1)
    error('Vector H de altura de capas no debe considerar semiespacio');
end

%% Verifica valores de input
for i = 1:n
    if (G(i) <= 0)
        error('Todas las componentes del vector de modulo de corte (G) deben ser mayores a 0');
    end
end

for i = 1:n
    if (rho(i) <= 0)
        error('Todas las componentes del vector de densidad de capa (rho) deben ser mayores a 0');
    end
end

for i = 1:n
    if (Vs(i) <= 0)
        error('Todas las componentes del vector de velocidad de onda de corte (Vs) deben ser mayores a 0');
    end
end

for i = 1:n
    if (D(i) > 1 || D(i) < 0)
        error('Todas las componentes del vector de amortiguamiento (D) deben ser mayores o iguales a cero y menores que 1');
    end
end

for i = 1:n - 1
    if (H(i) <= 0)
        error('Todas las componentes del vector de alturas de capa (H) deben ser mayores a cero');
    end
end

%% Calcula propiedades N capas (Kelvin-Voigt)
nG = G .* (1 + 2 * i * D); % Modulo de corte complejo (si D!=0)
nVs = Vs .* sqrt(1+2*i*D); % Velocidad onda de corte compleja (si D!=0)
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
    E(j+1) = 0.5 * (E(j) * (1 + imp(j)) * exp(i*k(j)*H(j)) + F(j) * (1 - imp(j)) * exp(-i*k(j)*H(j)));
    F(j+1) = 0.5 * (E(j) * (1 - imp(j)) * exp(i*k(j)*H(j)) + F(j) * (1 + imp(j)) * exp(-i*k(j)*H(j)));
end

%% Calcula las alturas acumuladas
Hacum = zeros(n-1, 1);
Hacum(1) = H(1);
for j = 2:n - 1
    Hacum(i) = Hacum(i-1) + H(i);
end

%% Retorna la funcion de desplazamiento
u = @(z, t) u_zt_nc(z, t, n, Hacum, E, F, k);

end

function u = u_zt_nc(z, t, n, H, E, F, k)
% U_ZT_NC Funcion local que calcula el desplazamiento u(z,t) en un sistema
% de capas conocido, E,F corresponden a los factores calculados por
% u_multc, n numero de capas

%% Obtiene el numero de la capa que corresponde a z
nc = n; % Inicialmente es el semiespacio
for j = 1:n-1
    if (z <= H(j))
        nc = j;
        break;
    end
end

%% Calcula el valor de u(z,t) para la capa seleccionada
u = 

end