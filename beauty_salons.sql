drop database if exists beauty_salons;
create database if not exists beauty_salons;
use beauty_salons;

create table if not exists salons(
id int primary key auto_increment,
название varchar(50) not null,
адрес varchar(50) not null,
график_работы varchar(30) not null
);

create table if not exists masters(
id int primary key auto_increment,
фамилия varchar(50) not null,
имя varchar(50) not null,
телефон varchar(15) not null,
salon_id int,
foreign key(salon_id) references salons(id)
on delete restrict on update cascade
);

create table if not exists equipments(
id int primary key auto_increment,
название varchar(50) not null
);

create table if not exists servise(
id int primary key auto_increment,
вид varchar(50) not null,
цена int unsigned not null
);

create table if not exists users(
id int primary key auto_increment,
фамилия varchar(50) not null,
имя varchar(50) not null,
телефон varchar(15) not null,
дата_рождения date not null
);

create table if not exists comments(
id int primary key auto_increment,
текст varchar(500) not null,
дата_добавления datetime not null,
salon_id int,
master_id int,
user_id int,
foreign key(salon_id) references salons(id),
foreign key(master_id) references masters(id),
foreign key(user_id) references users(id)
on delete restrict on update cascade
);

create table if not exists registrations(
id int primary key auto_increment,
дата_и_время datetime not null,
salon_id int,
master_id int,
user_id int,
foreign key(salon_id) references salons(id),
foreign key(master_id) references masters(id),
foreign key(user_id) references users(id)
on delete restrict on update cascade
);

create table if not exists salons_servise(
salon_id int,
servise_id int,
primary key (salon_id, servise_id),
foreign key(salon_id) references salons(id),
foreign key(servise_id) references servise(id)
on delete restrict on update cascade
);

create table if not exists masters_servise(
master_id int,
servise_id int,
primary key (master_id, servise_id),
foreign key(master_id) references masters(id),
foreign key(servise_id) references servise(id)
on delete restrict on update cascade
);

create table if not exists registrations_servise(
registration_id int,
servise_id int,
primary key (registration_id, servise_id),
foreign key(registration_id) references registrations(id),
foreign key(servise_id) references servise(id)
on delete restrict on update cascade
);

create table if not exists equipments_servise(
equipment_id int,
servise_id int,
primary key (equipment_id, servise_id),
foreign key(equipment_id) references equipments(id),
foreign key(servise_id) references servise(id)
on delete restrict on update cascade
);

show tables; -- показать какие есть таблицы

alter table salons -- поняли, что салонам не хватает номера телефона
add телефон varchar(15) not null after адрес; -- добавили столбик с номерами телефонов после столбика адрес

describe salons; -- посмотрели таблицу салоны, что все в порядке и все добавилось

alter table equipments -- вспомнили, что не хватает ссылки на оборудование салонов
add salon_id int; -- добавили поле для ссылки 

alter table equipments -- добавили саму ссылку 
add foreign key(salon_id) references salons(id)
on delete restrict on update cascade; -- это добавляем, что бы связи не удалялись, но их можно было исправлять