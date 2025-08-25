/*
PARTE 2
2.1) INNER JOIN, LEFT JOIN
2.2) USO DO 'ROUND', USO DO 'RAND'
2.3) MAIS DE UM INNER JOIN, ATUALIZANDO COM JOINS, DELETANDO COM JOINS
2.4) GROUP BY, FUNCOES AGREGADORAS
*/

-- 2.1)
-- inner join
select u.id as uid, p.id as pid, p.bio, u.first_name from users as u 
inner join profiles p on u.id = p.user_id
where u.first_name like '%a';
-- left join: pegando todos os dados de user(aqueles que dão match em profiles e os que não tbm -> trará como nulo)
select u.id as uid, p.id as pid, p.bio, u.first_name from users as u 
left join profiles p on u.id = p.user_id
where u.first_name like '%a';

-- 2.2)
-- Configura um salário aleatório para TODOS users
update users set salary = round(rand() * 10000, 2);

select salary from users where 
salary BETWEEN 1000 and 1500
order by salary asc;

/*
 estamos selecionando id de users, e selecionando id de roles de forma aleatoria limitada a 1 registro
 o banco gera um número aleatório para cada linha de roles, ordena, pega o primeiro (limit 1) e junta com
 o id de users
 faz esse processo para cada id de users e monta a tabela 
 */
select id, (select id from roles order by rand() limit 1) as qualquer from users;
/*
populando a tabela user_roles
*/
insert into users_roles (user_id, role_id)
select id, (select id from roles order by rand() limit 1) as qualquer from users;

-- 2.3)
-- Mais de um join
select u.id, u.first_name, p.bio, r.name from users as u left join profiles as p on u.id = p.user_id
inner join users_roles ur on u.id = ur.user_id
inner join roles as r on ur.role_id = r.id;
-- Atualiza registros com joins
select u.first_name, p.bio from users u
join profiles as p
on p.user_id = u.id
where u.first_name = 'Katelyn';

update users as u
join profiles as p
on p.user_id = u.id
set p.bio =  CONCAT(p.bio, ' atualizado') 
where u.first_name = 'Katelyn';
-- deletado o registro da tabela p
delete p from users u
left join profiles as p
on p.user_id = u.id
where u.first_name = 'Katelyn';

-- 2.4)
-- Group by - Agrupa valores para transforma-los em uma linha única
SELECT first_name, COUNT(id) as total FROM users
GROUP BY first_name
ORDER BY total DESC;

select u.first_name, COUNT(u.id) as total from users u
left join profiles as p
on p.user_id = u.id
WHERE u.id IN (617, 539, 537, 611)
GROUP BY first_name
ORDER BY total DESC
LIMIT 5;

-- FUNCOES AGREGADORAS
SELECT 
max(salary) as max_salary,
min(salary) as min_salary,
avg(salary) as avg_salary,
sum(salary) as sum_salary,
count(salary) as count_salary
FROM users;

select 
u.first_name,
max(u.salary) as max_salary,
min(u.salary) as min_salary,
avg(u.salary) as avg_salary,
sum(u.salary) as sum_salary,
COUNT(u.id) as total
from users u
left join profiles as p
on p.user_id = u.id
GROUP BY u.first_name
ORDER BY total DESC;