%permissao para alterar static procedure com 5 parametros
:-dynamic cliente/5.

%cliente(nome,renda_mensal,renda_estavel,poupanca,dependentes)
cliente(anderson,1916,estavel,15000,2).
cliente(andressa,1590,estavel,10000,1).
cliente(bruna,1580,estavel,9999,1).
cliente(camila,1300,estavel,5500,0).
cliente(caroline,1050,estavel,4200,0).
cliente(daiane,2000,estavel,21000,3).
cliente(eduardo,2700,instavel,5245,0).
cliente(guilherme,3320,instavel,10680,2).
cliente(ingrid,6572,instavel,11400,4).
cliente(juliane,1784,estavel,9800,2).
cliente(luana,1500,estavel,11000,1).
cliente(marina,3100,instavel,7000,2).
cliente(otavio,4852,estavel,20000,3).
cliente(rochele,5900,estavel,23200,1).
cliente(samara,940,estavel,5000,1).
cliente(jeferson,0,estavel,0,2).

%---------------------------------------------------------------------------------


%maior_poupanca
maior_poupanca(Cliente,true):-
    cliente(Cliente,_,_,Poupanca,Nro_dep),
    Poupanca > 0,
    Nro_dep > 0,
    Valor is Nro_dep*5000 + 5000,
    Poupanca>=Valor,!. 
maior_poupanca(Cliente,true):-
    cliente(Cliente,_,_,Poupanca,Nro_dep),
    Poupanca > 0,
    Nro_dep == 0,
    Poupanca>=5000,!.
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

%consultor
consultor(Cliente):-
    verifica_poupanca_minima(Cliente,Res_poupanca),
    Res_poupanca == inadequada,
    write("\n Prezado cliente, você não tem quantia poupada. \n Junte esforços para aumentar essa quantia!!"),!.
consultor(Cliente):-
    verifica_poupanca_minima(Cliente,Res_poupanca),
    verifica_renda_minima(Cliente,Res_renda),
    Res_poupanca == adequada,
    Res_renda == adequada,
    write("\n Prezado cliente, você já se esforçou bastante. \n Está na hora de evoluir, invista em ações!!"),!.
consultor(Cliente):-
    verifica_poupanca_minima(Cliente,Res_poupanca),
    verifica_renda_minima(Cliente,Res_renda),
    Res_poupanca == adequada,
    Res_renda == inadequada,
    write("\n Prezado cliente, você percorreu um belo caminho, mas ainda há muito o que fazer. \n Divida os seus investimentos entre a poupança e ações!!"),!.
consultor(Cliente):-
    cliente(Cliente,_,_,_,_),
    write("\n"), write(Cliente), write("Você ainda não é um investidor. \n Está na hora de começar!!"),!.

main(Cliente):-
    cliente(Cliente,_,_,_,_),
    consultor(Cliente),!.
main(Cliente):-
    write("\nCliente desconhecido, deseja cadastrar? s/n "),
    read(Opcao),nl,
    Opcao == s,
    write("Ótimo! Preciso de alguns dados...\nInforme a renda mensal: "),
    read(Renda_mensal),nl,
    write("A renda é estável? estavel/instavel "),
    read(Estabilidade),nl,
    write("Há quanto dinheiro na poupança? "),
    read(Poupanca),nl,
    write("Há quantos dependentes? "),
    read(Nro_dep),nl,
    assertz(cliente(Cliente,Renda_mensal,estavel,Poupanca,Nro_dep)),
    write("Pronto! Irei consultar sua situação financeira..."),nl,nl,
    consultor(Cliente),!.    

iniciar():-
    write("\n\nInforme o nome de um cliente: "),nl,
    read(Cliente),
    main(Cliente),
    iniciar().