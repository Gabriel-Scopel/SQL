-- 1) Insira 5 usuários
insert into users 
(first_name, last_name, email, password_hash) values
("Helena", "A.", "he@email.com", "30_hash"),
("Joana", "B.", "j@email.com", "40_hash"),
("Rosana", "C.", "ro@email.com", "50_hash"),
("JOAQUIM", "D.", "jo@email.com", "60_hash"),
("ALFREDIN", "E.", "al@email.com", "70_hash");
-- 2) Insira 5 perfís para os usuários inseridos
insert into profiles (bio, description, user_id)
select  concat('bio de ', u.first_name), concat('description de', u.first_name), u.id from users as u
-- 3) Insira permissões (roles) para os usuários inseridos
insert into users_roles (user_id , role_id)
select id, (select id from roles order by rand() limit 1) from users;
-- 4) Selecione os últimos 5 usuários por ordem decrescente
select first_name from users order by created_at asc limit 5;
-- 5) Atualize o último usuário inserido
update users set first_name='Elis Regina', last_name='Atualizada' WHERE id = 624;
-- 6) Remova uma permissão de algum usuário
delete from users_roles where user_id = 134;
-- 7) Remova um usuário que tem a permissão "PUT"
delete u from users as u 
inner join users_roles as ur on u.id = ur.user_id
inner join roles as r on r.id = ur.role_id
where r.name = 'put';
-- 8) Selecione usuários com perfís e permissões (obrigatório)
select * from users as u
inner join profiles as p on u.id = p.user_id;
-- 9) Selecione usuários com perfís e permissões (opcional)
select * from users as u
left join profiles as p on u.id = p.user_id;
-- 10) Selecione usuários com perfís e permissões ordenando por salário
select * from users as u
inner join profiles as p on u.id = p.user_id
inner join users_roles as ur on u.id = ur.user_id
order by u.salary asc;