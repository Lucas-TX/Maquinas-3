clc
clear 
close all

% declara parâmetros experimentais
Ra = 3.1;
parametros_entrada = [
    33.0 0.67 180 0.26 -305.5;
    33.2 0.70 180 0.27 304;
    63.3 0.88 180 0.27 601.2;
    93.1 1.02 180 0.27 900.8;
    122.2 1.1 180 0.27 1200.1;
    150.7 1.2 180 0.27 1500;
    179.4 1.24 180 0.27 1799.8;
    182.7 1.2 160.3 0.24 1921;
    180.9 1.18 143.3 0.21 2000.3;
    181.2 1.17 129.7 0.19 2102.3;
    ];

parametros_calculados = [];
% calcula parametros para cada linha do DT parametros_entrada
for row=1:size(parametros_entrada,1)

    Va = parametros_entrada(row,1);
    Ia = parametros_entrada(row,2);
    w_rpm = parametros_entrada(row,5);
    Ea = Va-Ra*Ia;
    Pm = Ea*Ia;
    w_SI = (2*pi*w_rpm)/60;
    Tm = Pm/w_SI;
    current_row = [Ea Pm Tm];
    parametros_calculados = [parametros_calculados;current_row];
end

tabela_completa = [parametros_entrada parametros_calculados];
tensao_Va = tabela_completa(:,1);
corrente_Ia = tabela_completa(:,2);
tensao_Vf = tabela_completa(:,3);
corrente_If = tabela_completa(:,4);
velocidade = tabela_completa(:,5);
tensao_armadura = tabela_completa(:,6);
potencia_mecanica = tabela_completa(:,7);
torque = tabela_completa(:,8);

% Gera gráficos e tabela final
figure
subplot (3,2,[1,2]);   
plot(velocidade,torque)
grid on
title ('Velocidade(rpm) x Torque(N.m)');                                                       
ylabel('Torque');     
xlabel('Velocidade');  
subplot (3,2,[3,4]); 
plot(velocidade,potencia_mecanica)
grid on
title ('Velocidade(rpm) x Potência Mecânica(Watts)');                                                       
ylabel('Potência Mecânica');     
xlabel('Velocidade');
subplot (3,2,[5,6]); 
plot(velocidade,tensao_armadura)
grid on
title ('Velocidade(rpm) x Tensão Armadura(Volts)');                                                       
ylabel('Tensão Armadura');     
xlabel('Velocidade');

titulo = ["Va(V)",'Ia(A)','Vf(V)','If(A)','Velocidade(rpm)','Tensão Armadura(V)','Potência Mecânica(W)','Torque(N.m)']; 

T = table( ...
    tensao_Va, ...
    corrente_Ia, ...
    tensao_Vf, ...
    corrente_If, ...
    velocidade, ...
    tensao_armadura, ...
    potencia_mecanica, ...
    torque,'VariableNames',titulo);

uitable(uifigure,'Data',T);




