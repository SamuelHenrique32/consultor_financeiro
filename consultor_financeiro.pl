%cliente(nome,renda_mensal,renda_estavel,poupanca,dependentes)
cliente(anderson,1900,estavel,5700,2).
cliente(andressa,2100,estavel,9740,1).
cliente(bruna,4670,instavel,1450,1).
cliente(camila,3780,estavel,12300,2).
cliente(caroline,2000,instavel,23000,1).
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
cliente(jeferson,0,estavel,0,2).

%---------------------------------------------------------------------------------


%maior_poupanca
maior_poupanca(Cliente,true):-
    cliente(Cliente,_,_,Poupanca,Nro_dep),
    Poupanca > 0,
    Nro_dep > 0,
    Valor is Nro_dep*5000 + 5000,
    Poupanca>=Valor, !. 
maior_poupanca(Cliente,true):-
    cliente(Cliente,_,_,Poupanca,Nro_dep),
    Poupanca > 0,
    Nro_dep == 0,
    Poupanca>=5000, !.
maior_poupanca(_,false).

%verifica_poupanca_minima
verifica_poupanca_minima(Cliente,adequada):-
    maior_poupanca(Cliente,Res),
    Res == true,!.
verifica_poupanca_minima(_,inadequada).

%verifica_renda_minima
verifica_renda_minima(Cliente,adequada):-
    cliente(Cliente,Renda_mensal,Estado,_,Num_dependentes),
    Estado == estavel,
    Renda_anual is Renda_mensal*12,
    Num_dependentes > 0,
    Necessario_dependente is Num_dependentes*4000,
    Renda_anual_necessaria is 15000 + Necessario_dependente,
    Renda_anual>=Renda_anual_necessaria,!.

verifica_renda_minima(Cliente,adequada):-
    cliente(Cliente,Renda_mensal,Estado,_,Num_dependentes),
    Estado == estavel,
    Renda_anual is Renda_mensal*12,
    Num_dependentes == 0,
    Renda_anual>=15000,!.
verifica_renda_minima(_,inadequada).

consultor(Cliente):-
    verifica_poupanca_minima(Cliente,inadequada),
    write("\n Prezado cliente, você não tem quantia poupada. \n Junte esforços para aumentar essa quantia!!"),!.
consultor(Cliente):-
    verifica_poupanca_minima(Cliente,adequada),
    verifica_renda_minima(Cliente,adequada),
    write("\n Prezado cliente, você já se esforçou bastante. \n Está na hora de evoluir, invista em ações!!"),!.
consultor(Cliente):-
    verifica_poupanca_minima(Cliente,adequada),
    verifica_renda_minima(Cliente,inadequada),
    write("\n Prezado cliente, você percorreu um belo caminho, mas ainda há muito o que fazer. \n Divida os seus investimentos entre a poupança e ações!!"),!.
consultor(Cliente):-
    cliente(Cliente,_,_,_,_),
    write("\n"), write(Cliente), write("Você ainda não é um investidor. \n Está na hora de começar!!"),!.

principal(Cliente):-
    cliente(Cliente,_,_,_,_),
    consultor(Cliente),!.
principal(_):-
    write("Cliente desconhecido").