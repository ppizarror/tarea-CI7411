function calculocasos(h, rho, g, beta)
% Calcula todos los puntos de cada tarea tomando como vector h, rho, g y
% beta y calcula:
% (a)   Calcular la velocida de la onda S (Vs) para los suelos.
% (b)   Calcular y graficar la FTT del registro en roca superficial.
% (c)   Calcular la razon de impedancia entre los suelos.
% (d)   Calcular y plotear la funcion de transferencia entre la roca superficial
%       y la superficie del suelo para un rango de frecuencia de 0 a 30 hz
%       [ftransferencia.m].
% (e)   Calcular y graficar la FTT del registro en superficie.
% (f)   Calcular y graficar la respuesta en el tiempo del suelo en
%       superficie.
% 
% Parametros
%   h:          Vector de espesor de cada capa
%   rho:        Vector de densidades de cada capa
%   g:          Vector de módulo de cizalle de cada capa
%   beta:       Vector beta de cada capa

%% Definicion de constantes
FS = 200; % Muestreo por segundo

%% (a) Calcular la velocidad de la onda S (Vs) para los suelos
if length(rho) ~= length(g)
    error('Vector g y rho deben tener igual dimension');
else
    d = length(rho); % N�mero de capas
end
if length(beta) ~= (d - 1)
    error('Vector beta debe tener 1 dato menos que vector g y rho');
end
betam = [beta, 0]; % Se modifica beta para la roca
vs = zeros(d, 1);
for z = 1:d
    vs(z) = sqrt((g(z) * (1 + 2 * betam(z) * 1i))/rho(z));
end
fprintf('Velocidad de la onda S (Vs)\n');
imp_vs(abs(vs));

%% (c) Calcular la raz�n de impedancia
alpha = zeros(d-1, 1);
for i = 1:(d - 1)
    alpha(i) = sqrt((rho(i) * g(i) * (1 + 2 * betam(i) * 1i))/(rho(i+1) * g(i+1) * (1 + 2 * betam(i+1) * 1i)));
end
fprintf('Razon de impedancia\n');
imp_alpha(alpha);

%% (d) Calcular y plotear la funcion de transferencia
ftrans = ftransferencia(d, alpha, h, vs);
transf = zeros(length(f), 1);
for i = 1:length(f)
    transf(i) = ftrans(f(i));
end
fig = figure(2);
set(gcf, 'name', 'Funcion de transferencia');
movegui(fig, 'center');
plot(f, transf, 'k');
xlim([0, 30]); % Se plotea la para un rango de frecuencias entre 0 y 30 Hz
xlabel('Frecuencia $(Hz)$', 'Interpreter', 'latex');
ylabel('Funcion de transferencia $(g\cdot s)$', 'Interpreter', 'latex');
title('Funci�n de transferencia');
hold off;

%% (e) Calcular y graficar la FTT del registro en superficie
fft_s = fft_rs .* transf;
fig = figure(3);
set(gcf, 'name', 'FFT Registro en superficie');
movegui(fig, 'center');
plot(f, abs(fft_s), 'k');
xlabel('Frecuencia $(Hz)$', 'Interpreter', 'latex');
ylabel('FFT $(g\cdot s)$', 'Interpreter', 'latex');
title('FFT Registro en superficie');
hold off;

%% (f) Calcular y graficar la respuesta en el tiempo del suelo en superficie
data_s = real(ifft(fft_s, n/2));
data_r = real(ifft(fft_rs, n/2));
fig = figure(4);
set(gcf, 'name', 'Respuesta en el tiempo del suelo en superficie');
movegui(fig, 'center');
plot(tdata, data_s, 'k');
xlim([0, tdata(end)]);
xlabel('Tiempo $(s)$', 'Interpreter', 'latex');
ylabel('Aceleracion $(g)$', 'Interpreter', 'latex');
title('Respuesta en el tiempo del suelo en superficie');
hold off;

fig = figure(5);
set(gcf, 'name', 'Comparacion respuesta en tiempo en superficie');
movegui(fig, 'center');
plot(tdata, data_s, 'r', 'DisplayName', 'Regitro suelo');
hold on;
plot(tdata, data_r, 'b', 'DisplayName', 'Regitro roca');
xlim([0, tdata(end)]);
xlabel('Tiempo $(s)$', 'Interpreter', 'latex');
ylabel('Aceleracion $(g)$', 'Interpreter', 'latex');
title('Respuesta en el tiempo del suelo en superficie');
legend(gca, 'show');
hold off;

end

function imp_vs(props)
% Imprime la velocidad de corte en consola.
for i = 1:length(props)
    fprintf('\tCapa %d: %.3f m/s\n', i, props(i));
end
fprintf('\n');
end

function imp_alpha(props)
% Imprime la razon de impedancia en consola.
for i = 1:length(props)
    fprintf('\tCapa %d/%d: %s\n', i, i+1, num2str(props(i)));
end
fprintf('\n');
end