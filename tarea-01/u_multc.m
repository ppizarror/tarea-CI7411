function u = u_multc(G,rho,Vs,D,H)
% U_MULTC Retorna una funcion que permite obtener el desplazamiento t en
% una profundidad zj de un medio visco-elastico compuesto por varias capas
% 1..j
%
%   u := u_multc([G1,G2..], [rho1,rho2..], [Vs1,Vs2..], [D1,D2..],
%   [H1,H2..])
%   u(zj,t) => u
%
% Parametros:
%   G       vector del modulo de corte de cada capa
%   rho     vector de densidad de cada capa
%   Vs      vector velocidad onda de corte cada capa
%   D       vector de razon de amortiguamiento (1/4pi)

%% Obtiene el numero de capas

end