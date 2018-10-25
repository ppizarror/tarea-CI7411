function [f, hv_ns, hv_ew] = hv_cargaf(registro, regmod, filtro)
% Carga los archivos de un determinado registro

[f, hv_ns, hv_ew] = hv_gen(strcat(registro, strcat('/', strcat(registro, strcat(regmod, '-ew.txt')))), ...
    strcat(registro, strcat('/', strcat(registro, strcat(regmod, '-ns.txt')))), ...
    strcat(registro, strcat('/', strcat(registro, strcat(regmod, '-z.txt')))), ...
    filtro);

end