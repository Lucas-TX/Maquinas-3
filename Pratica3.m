close all; clear;clc

% declara parâmetros experimentais
parametros_entrada = [
    -606.2 80.26   114  ;
    -302.1 70.0    99.0 ;
    0      60.1    85.8 ;
    301.7  50.2    71.0 ;
    607.0  39.94   56.7 ;
    894.3  29.98   42.9 ;
    1204.9 19.84   28.6 ;
    1485.9 10.53   16.2 ;
    1799.1 0       0    ;
    2119.9 -10.31 -17.0 ;
    ];

seq = [
    '3-2-1' 
    '3-2-1' 
    '3-2-1' 
    '3-2-1' 
    '3-2-1' 
    '3-2-1'
    '3-2-1'
    '3-2-1'
    '3-2-1'
    '1-2-3'];

Ws = (120* 60)/4;
Er_s1 = parametros_entrada(3,3);

parametros_calculados = [];
array_modos_operacao = strings([10,1]);
index = 1;
% calcula parametros para cada linha do DT parametros_entrada
for row=1:size(parametros_entrada,1) % for até quantidade de linhas do DT
    % Captura dados
    Wr = parametros_entrada(row,1); % Velocidade do rotor
    fr_m = parametros_entrada(row,2); % frequencia medida do rotor
    Er_m = parametros_entrada(row,3); % Tensão eficaz induzida no rotor
    
    % Calcula parâmetros
    Ws = 1800;
    s = (Ws-Wr)/Ws; % escorregamento    
    fr_c = 60/s; % frequencia calculada do rotor 
    Er_c = Er_s1 *s;
    wgr = (fr_m*120)/4;
    soma = Wr + wgr;

    if Wr < 0
        modo_operacao = "Freio";
    elseif wgr < 0
        modo_operacao = "Gerador";
    else
        modo_operacao = "Motor";
    end

   
    current_row = [Ws s fr_c Er_c wgr soma];
    parametros_calculados = [parametros_calculados;current_row];
    array_modos_operacao(index) = modo_operacao;
    index = index + 1;
end

tabela_completa = [parametros_entrada parametros_calculados];


velocidade_rotor           = tabela_completa(:,1);
frequencia_medida_rotor    = tabela_completa(:,2);
Tensao_medida_rotor        = tabela_completa(:,3);
sequencia_fase             = seq;
velocidade_sincrona        = tabela_completa(:,4);
escorregamento             = tabela_completa(:,5);
frequencia_calculada_rotor = tabela_completa(:,6);
tensao_calculada_rotor     = tabela_completa(:,7);
velocidade_polos_rotor     = tabela_completa(:,8);
soma_velocidades           = tabela_completa(:,9);
modo_de_operacao           = array_modos_operacao;


titulo = [
    "Wr(rpm)",
    'Fr_m(Hz)',
    'Er_m(V)',
    'Seq',
    'Ws(rpm)',
    's',
    'fr_c(Hz)',
    'Er_c(V)',
    'Wgr(rpm)',
    'Wgr + Wr'
    'Modo de operação',
    ]; 

T = table( ...
    velocidade_rotor, ...
    frequencia_medida_rotor, ...
    Tensao_medida_rotor, ...
    sequencia_fase, ...
    velocidade_sincrona, ...
    escorregamento, ...
    frequencia_calculada_rotor, ...
    tensao_calculada_rotor, ...
    velocidade_polos_rotor, ...
    soma_velocidades, ...
    modo_de_operacao, ...
    'VariableNames',titulo);

uitable(uifigure,'Data',T);

figure

subplot(2,1,1)
plot(escorregamento,frequencia_medida_rotor)
grid on
title ('Frequência medida x Escorregamento');  
ylabel('Frequência induzida medida');     
xlabel('Escorregamento'); 
axis tight

subplot(2,1,2)
plot(escorregamento,Tensao_medida_rotor)
grid on
title ('Tensão medida induzida x Escorregamento');  
ylabel('Tensão induzida medida');     
xlabel('Escorregamento'); 
axis tight
