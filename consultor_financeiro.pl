%cliente(nome,renda_mensal,renda_estavel,poupanca,dependentes)
cliente(anderson,1917,estavel,5700,2).
cliente(andressa,2100,estavel,9740,1).
cliente(bruna,4670,instavel,1450,1).
cliente(camila,3780,estavel,12300,2).
cliente(caroline,5800,instavel,23000,1).
cliente(daiane,4100,estavel,32000,3).
cliente(eduardo,980,instavel,2600,1).
cliente(guilherme,3320,instavel,10680,2).
cliente(ingrid,6572,instavel,11400,4).
cliente(juliane,1784,estavel,9800,2).
cliente(luana,1500,estavel,11000,1).
cliente(marina,3100,instavel,7000,2).
cliente(otavio,4852,instavel,5000,3).
cliente(rochele,5900,estavel,23200,1).
cliente(samara,940,estavel,4850,2).

%---------------------------------------------------------------------------------

%verifica_poupanca_minima(Cliente,Adequacao).
verifica_poupanca_minima(Nome_cliente,adequada):-
    cliente(Nome_cliente,_,_,Poupanca,Num_dependentes),
    Valor is Num_dependentes*5000,
    Poupanca>=Valor,!.

verifica_poupanca_minima(Nome_cliente,inadequada):-
    cliente(Nome_cliente,_,_,Poupanca,Num_dependentes),
    Valor_necessario is Num_dependentes*5000-Poupanca,
    write("O valor em poupança para o cliente "), write(Nome_cliente), write(" esta abaixo do adequado! Necessita de mais R$"), write(Valor_necessario).

%verifica_renda(Cliente)
verifica_renda(Nome_cliente):-
    cliente(Nome_cliente,Renda_mensal,estavel,_,Num_dependentes),
    Renda_anual is Renda_mensal*12,
    Necessario_dependente is Num_dependentes*4000,
    Renda_anual_necessaria is 15000 + Necessario_dependente,
    Renda_anual>=Renda_anual_necessaria,!.

verifica_renda(Nome_cliente):-
    cliente(Nome_cliente,Renda_mensal,_,_,Num_dependentes),
    Renda_anual is Renda_mensal*12,
    Necessario_dependente is Num_dependentes*4000,
    Renda_anual_necessaria is 15000 + Necessario_dependente,
    write("\nA renda anual é inadequada! Necessita de R$"), write(Renda_anual_necessaria), write(" reais anuais"), write(". Possui atualmente R$"), write(Renda_anual), write("/ano").

%verifica_aplicacoes(Cliente, Resposta)
verifica_aplicacoes(Cliente, Resposta):-
    verifica_poupanca_minima(Cliente, Resposta),
    verifica_renda(Cliente),
    write("\nO cliente "), write(Cliente), write(" possui uma conta poupança e renda adequadas! Sugiro um investimento mais arriscado, como o mercado de ações!").








% repetiçoes de variaveis nos predicados?
% verifica_aplicacoes(samara,Resposta).