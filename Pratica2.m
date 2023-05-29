clc;clear;close all;


% declara parâmetros experimentais
Ra = 2.6;
parametros_entrada = [
    178.4 33.6 0.8 1.08 303.7;
    178.3 43.6 0.87 1.15 401;
    178.1 54.2 0.93 1.21 504;
    178.3 63.9 0.98 1.26 605.1;
    178.7 74.1 1.03 1.31 706.3;
    179.3 84.8 1.07 1.35 805.8;
    180.7 94.9 1.11 1.39 906.5;
    182.1 105.2 1.15 1.43 1001.9;
    181.1 114.4 1.17 1.45 1105.1;
    182.0 125.1 1.19 1.48 1209.7;
    181.2 134.0 1.22 1.50 1306.7;
    179.0 143.1 1.22 1.51 1409.5;
    181.7 154.3 1.25 1.52 1515.7;
    180.7 164.6 1.25 1.53 1627.5;
    178.8 170.9 1.26 1.52 1697.5;
    180.7 180.2 1.27 1.54 1796.9;
    181.5 181.3 1.22 1.46 1910.4;
    180.5 180.2 1.19 1.41 2001.0;
    181.0 180.9 1.17 1.37 2112.4;
    ];

parametros_calculados = [];
% calcula parametros para cada linha do DT parametros_entrada
for row=1:size(parametros_entrada,1) % for até quantidade de linhas do DT
    % Captura dados
    Vin = parametros_entrada(row,1);
    Va = parametros_entrada(row,2);
    Ia = parametros_entrada(row,3);
    Iin = parametros_entrada(row,4);
    w_rpm = parametros_entrada(row,5);

    % Calcula parâmetros
    w = (2*pi*w_rpm)/60;
    Ea = Va-Ra*Ia;
    Pm = Ea*Ia;
    Tm = Pm/w;
    If = Iin-Ia;
    Pin = Vin*Iin;
    Rendimento = (Pm/Pin)*100;

    current_row = [w Ea Pm Tm If Pin Rendimento];
    parametros_calculados = [parametros_calculados;current_row];
end

tabela_completa = [parametros_entrada parametros_calculados];
Tensao_Vin = tabela_completa(:,1);
Tensao_Va = tabela_completa(:,2);
corrente_Ia = tabela_completa(:,3);
corrente_Iin = tabela_completa(:,4);
velocidade_rpm = tabela_completa(:,5);
velocidade = tabela_completa(:,6);
Tensao_Ea = tabela_completa(:,7);
Potencia_motor = tabela_completa(:,8);
Torque = tabela_completa(:,9);
corrente_If = tabela_completa(:,10);
Potencia_total = tabela_completa(:,11);
Rendimento = tabela_completa(:,12);

% Gera gráficos e tabela final

subplot (3,1,1); 
plot(velocidade,Torque)
grid on
title ('Torque(N.m) x Velocidade(rad/s)');                                                       
ylabel('Torque');     
xlabel('Velocidade(rad/s)');  
axis tight

subplot (3,1,2); 
plot(velocidade,Potencia_motor)
grid on
title ('Potência Mecânica(Watts) x Velocidade(rad/s)');                                                       
ylabel('Potência Mecânica');     
xlabel('Velocidade(rad/s)'); 
axis tight

subplot (3,1,3); 
plot(velocidade,Rendimento)
grid on
title ('Rendimento(%) x Velocidade(rad/s)');                                                       
ylabel('Rendimento(%)');     
xlabel('Velocidade(rad/s)');
axis ([velocidade(1) velocidade(length(velocidade)) 0 100])

titulo = [
    "Vin(V)",
    'Va(V)',
    'Ia(A)',
    'Iin(A)',
    'Velocidade(rpm)',
    'Velocidade(rad/s)',
    'Ea(V)',
    'Potência Mecânica(W)',
    'Torque(N.m)'
    'If(A)',
    'Potência de entrada(W)',
    'Rendimento(%)',
    ]; 

T = table( ...
    Tensao_Vin, ...
    Tensao_Va, ...
    corrente_Ia, ...
    corrente_Iin, ...
    velocidade_rpm, ...
    velocidade, ...
    Tensao_Ea, ...
    Potencia_motor, ...
    Torque, ...
    corrente_If, ...
    Potencia_total, ...
    Rendimento,'VariableNames',titulo);

uitable(uifigure,'Data',T);

