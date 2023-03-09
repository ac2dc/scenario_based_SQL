-- create database new_learning;
-- use new_learning;

drop table if exists defaultmask;
        
create table defaultmask
(
id		       int              identity (1,1) primary key not null
,name varchar(255)	masked with (function = 'default()') null
,birthdate     date		masked with (function = 'default()') not null
,social_security  bigint		masked with (function = 'default()') not null
);

-- insert into defaultmask
-- (
-- name, birthdate, social_security
-- )
-- values 
-- ('james jones',  '1998-06-01', 784562145987),
-- ( 'pat rice',  '1982-08-12', 478925416938),
-- ('george eliot',  '1990-05-07', 794613976431);

select * from defaultmask;


