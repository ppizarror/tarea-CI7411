function f = ftransferencia(n, alpha, h, vs)
% Calcula la función de impedancia en funci�n de omega.
%
% Parámetros
%   n:      Número de capas
%   alpha:  Vector de impedancias
%   h:      Vector de espesor de cada capa
%   vs:     Velocidad de la onda de corte

function x = ftransferenciaw(w)

    % Se crea el vector k
    k = zeros(n-1, 1);
    for i = 1:n -1
        k(i) = w / vs(i);
    end

    % Se crean los vectores a y b de cada capa
    a = zeros(n, 1);
    b = zeros(n, 1);
    a(1) = 1;
    b(1) = 1;

    % Se crean los valores a_i+1 y b_i+1
    for i = 1:(n - 1)
        a(i+1) = 0.5 * (a(i) * (1 + alpha(i)) * exp(1i*k(i)*h(i)) + b(i) * (1 - alpha(i)) * exp(-1i*k(i)*h(i)));
        b(i+1) = 0.5 * (a(i) * (1 - alpha(i)) * exp(1i*k(i)*h(i)) + b(i) * (1 + alpha(i)) * exp(-1i*k(i)*h(i)));
    end

    % Se retorna el valor
    x = abs(1/a(n));
end

% Retorna una función inline
f = @(w) ftransferenciaw(2*pi*w);

end
