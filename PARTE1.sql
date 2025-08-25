/*
PARTE 1
1.1) SELECIONANDO UM BANCO DE DADOS, MOSTRANDO SUAS TABELAS, DESCREVENDO A TABELA E INSERINDO REGISTROS
1.2) SELECIONANDO UMA COLUNA, USANDO 'WHERE', OPERADORES DE COMPARAÇAO  E OPERADORES LOGICOS
1.3) USO DO 'BETWEEN', USANDO 'WHERE'COM UMA LISTA, USO DO 'LIKE'
1.4) USO DO 'ORDER BY', 'LIMIT' E 'OFFSET'
1.5) OUTRO USO DO SELECT, DELETE, UPDATE
1.6) PRODUTO CARTESIANO, E VINCULO ENTRE TABELAS
*/
-- 1.1)
-- Seleciona a base de dados
use base_de_dados;
-- Mostra as tabelas da base de dadose
show tables;
-- Descreve as colunas da tabela
describe users;
-- Inserir registros na base de dados
insert into users 
(first_name, last_name, email, password_hash) values
("Helena", "A.", "1@email.com", "3_hash"),
("Joana", "B.", "2@email.com", "4_hash"),
("Rosana", "C.", "3@email.com", "5_hash");

-- 1.2)
-- Seleciona colunas específicas
select 
u.email uemail, u.id uid, u.first_name ufirst_name
from users as u;
-- where filtra registros
-- operadores de comparação = < <= > >= <> !=
-- operadores lógicos and e or
select * from users
where 
created_at < '2020-12-15 23:33:41'
and first_name = 'Luiz' 
and password_hash = 'a_hash';

-- 1.3)
-- between: pegando intervalos
select * from users where created_at between '2019-12-29 01:46:33' and '2020-01-21 08:24:40';
-- pegando itens de array
select * from users where id in (10,15,20);
-- pegando registros em que o first_name termina com 'a'
select * from users where first_name like '%a';
-- pegando registros em que o first_name começa com 'he'
select * from users where first_name like 'he%';
-- pegando registros em que o first_name começa com 'he' e termina com 'a'
select * from users where first_name like 'he%a';
-- pegando registros em que o first_name tem 'mo' no meio
select * from users where first_name like '%mo%';
-- pegando registros em que o first_name possui apenas 1 caracter que pode ser qualquer coisa e depois 'a' e depois qualquer coisa independente da qtde
select * from users where first_name like '_a%';

-- 1.4)
select id, first_name, last_name from users order by created_at asc;
-- limitado a 10 registros, pulando os 2 primeiros
select id, first_name, last_name from users order by id asc limit 10 offset 2;
-- mesmo código com offset omitido 
select id, first_name, last_name from users order by id asc limit 2,10;
-- como o select funciona tbm
select 1 as col1, 2 as 'qualquer coisa';
-- insert select
insert into profiles (bio, description, user_id) select 1,2,1;
-- insere valores em uma tabela usando outra
insert into profiles
(bio, description, user_id)
select 
concat('Bio de ', first_name), 
concat('Description de', ' ', first_name), 
id 
from users;
-- delete sem where: apaga toda tabela
-- delete from profiles;
-- Delete apaga registros da tabela
DELETE FROM users where id = 115;
-- Aviso: use SELECT para garantir que está
-- apagando os valores corretos
select * from users where id BETWEEN 110 and 115;
-- Update
UPDATE users set first_name = 'alfredinho', last_name = 'obrabo' where id = 1;

-- 1.6)
-- produto cartesiano entre p e u
select u.id as uid, p.id as pid from users as u, profiles as p;
-- trazendo apenas aqueles que possuem vinculo
select u.id as uid, p.id as pid, p.description, u.first_name
from users as u, profiles as p where u.id = p.user_id;
