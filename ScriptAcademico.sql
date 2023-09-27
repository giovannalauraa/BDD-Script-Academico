
/* laboratório 3*/
/*Nome: Giovanna Laura Cravo e Silva -- Prontuário: BP3039391*/
create database if not exists academico_2023;
use academico_2023;

create table if not exists curso
(idCurso        char(3)      not null,
 nome           varchar(30)  not null,
 coordenador    Varchar(20)  not null,
 primary key(idCurso));


create table if not exists aluno
(prontuario     char(8)      not null,
 nome           varchar(30)  not null,
 endereco       Varchar(30)  not null,
 RG             char(11)     not null,
 idCurso        char(3)      not null,
 primary key(prontuario),
 foreign key (idCurso) references curso(idCurso));


create table if not exists disciplina
(idDisciplina   integer      not null,
 idCurso        char(3)      not null,
 nomeDis        varchar(30)  not null,
 numCreditos    integer      not null,
 primary key(idDisciplina),
 foreign key (idCurso) references curso(idCurso));

create table if not exists boletim
(idDisciplina   integer      not null,
 prontuario     char(8)      not null,
 nota           decimal(4,2)  not null,
 primary key (idDisciplina,prontuario),
 foreign key(idDisciplina) references disciplina(idDisciplina),
 foreign key(prontuario) references aluno(prontuario));
 
insert into CURSO
values ('ADS', 'Analise de Sistemas','Antonio'),
       ('MSI','Informatica','Rubens');

/* inserir dados na tabela aluno*/
insert into ALUNO
values ('12345678','Maria das Dores','Rua das Flores,100','010101','ADS'),
       ('12345677','Joao do Pulo','Rua das Flores,200','02020202','MSI'),
       ('12345688','Almerinda de Jesus','Rua das Orquideas,500','303030','ADS');

/* inserir dados na tabela disciplina*/
insert into DISCIPLINA
values (1,'ADS','Banco de Dados',5),
       (2,'ADS','Lógica de Programação',5),
       (3,'ADS','Informática',3),
       (4,'ADS','Engenharia de Software',5);

/* inserir dados na tabela boletim*/
insert into BOLETIM
values (1,'12345678',6.0),
       (1,'12345677',8.0),
       (1,'12345688',2.3),
       (2,'12345678',5.0),
       (2,'12345677',10.0),
       (3,'12345688',2.3);
       
       
# 1. Listar todos os alunos cadastrados na tabela ALUNO.
SELECT * FROM ALUNO;

# 2. Listar da tabela CURSO, o idCurso e o nome.
SELECT idCurso, nome FROM CURSO;

# 3. Selecionar todos os alunos com prontuário diferente de 12345678. 
SELECT * FROM ALUNO WHERE prontuario <> 12345678; # <> SIGNIFICA DIFERENTE

# 4. Selecionar todos os alunos com nota>6 da disciplina banco de dados.  
SELECT * FROM BOLETIM, aluno WHERE nota>6 AND IDDISCIPLINA=1;

/*5. Verificar o que acontece se tentar inserir um aluno com os seguintes dados. O que
deve ser feito para efetivar esta inclusão.
• Prontuario = 232323
• Nome= Marcos Santos
• RG=66666
• Endereço =null
*/

insert into ALUNO 
values(232323, 'Marcos Santos', null,'66666', 'msi');

DELETE FROM ALUNO WHERE PRONTUARIO=232323;  #DELETAR O ALUNO INSERIDO ANTES

alter table aluno
modify endereco varchar(30) null;


# correção do 5
/*insert into ALUNO
values(232323, 'Marcos Santos', 'Rua Das Flores,1020', '666666', 'ADS');*/

# 6. Selecionar os alunos cujo nomes comecem com “M”.
SELECT * FROM ALUNO WHERE NOME LIKE "M%";

/* 7. Inserir dados no boletim para o aluno Marcos Santos sendo:
 	• Para a disciplina banco de dados = 8.5
	• Para a disciplina lógica =7.3
*/
insert into BOLETIM 
values(1, 232323, 8.5),
	  (2, 232323, 7.3);

DELETE FROM BOLETIM WHERE IDDISCIPLINA=1;

# 8. Mostrar os alunos cujas notas sejam maiores que 4 e menores que 6.
SELECT * FROM BOLETIM, aluno WHERE nota>4 AND nota<6;

# 9. Selecionar os alunos cujos nomes não comecem com M
SELECT * FROM ALUNO WHERE NOME NOT LIKE "M%";

# 10. Exibir os alunos com endereço nulo.
SELECT * FROM ALUNO WHERE endereco is null;

/* 11. Calcular a média das notas de todos os alunos que frequentaram a disciplina de   
Lógica. Exibir o título da coluna como ‘média notas’ e usar a nota com 1 casa
decimal. */

SELECT FORMAT(AVG(NOTA),1) AS 'média notas' FROM BOLETIM WHERE IDDISCIPLINA=2;

# 12. Contar quantos alunos estão cadastrados.
SELECT COUNT(*) FROM ALUNO;

# -----------------AGRUPAMENTO----------------

# 13. Exibir a nota média por disciplina;
SELECT IDDISCIPLINA, AVG(NOTA) FROM BOLETIM GROUP BY IDDISCIPLINA;
    
# 14. Exibir a nota média por prontuário de aluno;
SELECT PRONTUARIO, AVG(NOTA) FROM BOLETIM GROUP BY PRONTUARIO;

# 15. Mostrar quantos alunos tem nota maior que 6.
SELECT PRONTUARIO, COUNT(PRONTUARIO) FROM BOLETIM GROUP BY PRONTUARIO HAVING COUNT(NOTA)>6;
    
/*16. Mostrar por disciplina cuja média seja maior que 6 ( Visualizar iddisciplina, média da
nota).*/
SELECT IDDISCIPLINA, AVG(NOTA) AS 'média da nota' FROM BOLETIM GROUP BY IDDISCIPLINA HAVING AVG(NOTA)>6;

/*17. Para cada prontuário mostrar somente os dados cujas médias sejam maiores que 7
(Exibir prontuário, média da nota). Exibir por ordem decrescente de nota.*/
SELECT PRONTUARIO, AVG(NOTA) AS 'média da nota' FROM BOLETIM GROUP BY PRONTUARIO HAVING AVG(NOTA)>7;

# 18. Exibir a maior nota registrada no boletim.
SELECT PRONTUARIO, MAX(NOTA) AS 'maior nota' FROM BOLETIM GROUP BY PRONTUARIO HAVING MAX(NOTA);

/*19. Exibir o prontuário, a identificação da disciplina e a nota para a menor nota
registrada no boletim.*/

/* 20. Exibir o prontuário, a identificação da disciplina e a nota das 2 maiores notas
registradas no boletim.*/

/*21. Analisar o erro da inserção do seguinte registro na tabela aluno. O que deveria ser
feito para corrigir.*/

