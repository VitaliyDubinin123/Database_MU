/*
              КУРСОВОЙ ПРОЕКТ ПО КУРСУ "Основы реляционных баз данных. MySQL"
                            Преподаватель: Кирилл Иванов
                              Студент: Виталий Дубинин

                            Требования к курсовому проекту:
1. составить общее текстовое описание БД и решаемых ею задач;
2. минимальное количество таблиц - 10;
3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
4. создать ERDiagram для БД;
5. скрипты наполнения БД данными;
6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
7. представления (минимум 2);
8. хранимые процедуры / триггеры.

Задание 1: составить общее текстовое описание БД и решаемых ею задач.

	Курсовой проект представляет собой базу данных, созданную в приложении для управления базами данных DBEaver 21.2.1.
Данная работа представляет собой структуру футбольного клуба Английской Премьер - Лиги "Манчестер Юнайтед". База данным представляет собой 17 таблиц
по 10 записей в каждой и отражает состав футбольного клуба, основную информацию об игроках клуба (из тактико-технические характеристики, номинальные
и фактические позиции на футбольном поле, статистика и часть биография игроков). Таблицы данной базы связаны между собой первичным и внешними ключами,
заданы индексы. Также создана ER диаграмма (модель данных, представляющая собой описание концептуальной схемы данной области). Также представлены
запросы данных с помощью группировок, JOIN - соединения, вложенные таблицы. Созданы представления, хранимые процедуры и триггеры.
    Скрипты по созданию базы данных выполнены с помощью DDL (Data Definition Language), скрипты по внесению данных и по запросам выполнены с помощью
DMN (Data Manipulation Language).
	База данных позволит любому человеку (даже особо не интересующимся футболом) получить полную информацию о структуре футбольного клуба и об
игроках.
    Информация, содержащаяся в базе данных, является информативной и может не являть собой действительную картину футбольного мира (так как все
характеристики игроков являются статистическими усредненными данными). */


/* Задания 2 и 3: создание таблиц минимальное количество таблиц - 10 (по факту 17),
скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами). */

drop database if exists manunited;

create database manunited;

use manunited;

-- Создание главной таблицы с номинальными позициями игроков в клубе "Манчестер Юнайтед".

drop table if exists playposition;

CREATE TABLE playposition(id TINYINT UNSIGNED NOT NULL auto_increment PRIMARY KEY COMMENT 'Код номинальной футбольной позиции',
			 first_position VARCHAR(25) COMMENT 'Номинальная позиция игроков на поле',
	         second_position VARCHAR(25) COMMENT 'Зона позиции игроков',
	         third_position VARCHAR(25) COMMENT 'Отношение игрока ко флангам футбольного поля'
	         );

describe playposition;

/* Создание таблицы с информацией о номинальных позициях и их потенциале в данном клубе
(с учетом предпочтений главного тренера и выбираемой игровой схемы). */

drop table if exists infopositions;

CREATE TABLE infopositions(id_position TINYINT UNSIGNED NOT NULL COMMENT 'Код номинальной футбольной позиции',
			 english_code VARCHAR(10) COMMENT 'Аббревиатура футбольной позиции на английском языке',
	         russian_code VARCHAR(10) COMMENT 'Аббревиатура футбольной позиции на русском языке',
	         potential_position VARCHAR(35) COMMENT 'Потенциал позиции - защитный, защитный и атакующий, атакующий, комбинированный',
	         rotation_potential VARCHAR(25) COMMENT 'Ротация игроков клуба на данной номинальной позиции - низкая, средняя или высокая',
	         foreign key(id_position) references playposition(id)
	         );

describe infopositions;

-- Создание таблицы с основной информацией об игроках - первая часть.

drop table if exists players1;

CREATE TABLE players1(number_of_player1 TINYINT UNSIGNED NOT null primary key COMMENT 'Номер игрока в клубе',
	         name1 VARCHAR(20) COMMENT 'Имя игрока',
	         patronymic1 VARCHAR(20) COMMENT 'Отчество игрока/второе имя',
	         surname1 VARCHAR(20) COMMENT 'Фамилия игрока',
	         nickname1 VARCHAR(45) COMMENT 'Прозвище (ник) игрока',
	         rating_of_player1 TINYINT UNSIGNED NOT NULL COMMENT 'Условный международный рейтинг игрока',
	         player_nominal_position1 VARCHAR(20) COMMENT 'Главная позиция игрока',
	         player_nominal_id1 TINYINT UNSIGNED NOT NULL COMMENT 'Номинальная позиция конкретного игрока на поле',
	         foreign key(player_nominal_id1) references playposition(id),
	         INDEX players1_full_name_idx(name1, patronymic1, surname1, nickname1)
	         );

describe players1;

-- Создание таблицы с основной информацией об игроках - вторая часть.

drop table if exists players2;

CREATE TABLE players2(number_of_player2 TINYINT UNSIGNED NOT NULL primary key COMMENT 'Номер игрока в клубе',
	         name2 VARCHAR(20) COMMENT 'Имя игрока',
	         patronymic2 VARCHAR(20) COMMENT 'Отчество игрока/второе имя',
	         surname2 VARCHAR(20) COMMENT 'Фамилия игрока',
	         nickname2 VARCHAR(45) COMMENT 'Прозвище (ник) игрока',
	         rating_of_player2 TINYINT UNSIGNED NOT NULL COMMENT 'Условный международный рейтинг игрока',
	         player_nominal_position2 VARCHAR(20) COMMENT 'Главная позиция игрока',
	         player_nominal_id2 TINYINT UNSIGNED NOT NULL COMMENT 'Номинальная позиция конкретного игрока на поле',
	         foreign key(player_nominal_id2) references playposition(id),
             INDEX players2_full_name_idx(name2, patronymic2, surname2, nickname2)
             );

describe players2;

-- Создание таблицы с основной информацией об игроках - третья часть.

drop table if exists players3;

CREATE TABLE players3(number_of_player3 TINYINT UNSIGNED NOT NULL primary key COMMENT 'Номер игрока в клубе',
	         name3 VARCHAR(20) COMMENT 'Имя игрока',
	         patronymic3 VARCHAR(20) COMMENT 'Отчество игрока/второе имя',
	         surname3 VARCHAR(20) COMMENT 'Фамилия игрока',
	         nickname3 VARCHAR(45) COMMENT 'Прозвище (ник) игрока',
	         rating_of_player3 TINYINT UNSIGNED NOT NULL COMMENT 'Условный международный рейтинг игрока',
	         player_nominal_position3 VARCHAR(20) COMMENT 'Главная позиция игрока',
	         player_nominal_id3 TINYINT UNSIGNED NOT NULL COMMENT 'Номинальная позиция конкретного игрока на поле',
	         foreign key(player_nominal_id3) references playposition(id),
             INDEX players3_full_name_idx(name3, patronymic3, surname3, nickname3)
             );

describe players3;

-- Создание таблицы со статистикой игроков и дополнительная информация - первая часть.

drop table if exists info_player_1;

CREATE TABLE info_player_1(number_ability_1 TINYINT UNSIGNED NOT null COMMENT 'Номер игрока в клубе',
	         position_ability_1 tinyint unsigned not NULL COMMENT 'Главная позиция игрока',
	         player_nation1 VARCHAR(20) COMMENT 'Гражданство',
	         number_of_matches1 SMALLINT UNSIGNED NOT NULL COMMENT 'Количество сыгранным игроком матчей за данный клуб',
	         number_of_goals1 TINYINT UNSIGNED NOT NULL COMMENT 'Количество забитых игроком голов',
	         number_of_assists1 TINYINT UNSIGNED NOT NULL COMMENT 'Количество голевых пасов (в т.ч. и для вратарей)',
	         number_of_minus_goals1 SMALLINT UNSIGNED NOT NULL NULL COMMENT 'Количество пропущенных голов (для вратарей)',
	         FOREIGN KEY (number_ability_1) REFERENCES players1(number_of_player1),
	         foreign key (position_ability_1) references playposition(id)
	         );

describe info_player_1;

-- Создание таблицы со статистикой игроков и дополнительная информация - вторая часть.

drop table if exists info_player_2;

CREATE TABLE info_player_2(number_ability_2 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока в клубе',
	         position_ability_2 TINYINT UNSIGNED NOT NULL COMMENT 'Главная позиция игрока',
	         player_nation2 VARCHAR(20) COMMENT 'Гражданство',
	         number_of_matches2 SMALLINT UNSIGNED NOT NULL COMMENT 'Количество сыгранным игроком матчей за данный клуб',
	         number_of_goals2 TINYINT UNSIGNED NOT NULL COMMENT 'Количество забитых игроком голов',
	         number_of_assists2 TINYINT UNSIGNED NOT NULL COMMENT 'Количество голевых пасов (в т.ч. и для вратарей)',
	         number_of_minus_goals2 SMALLINT UNSIGNED NOT NULL COMMENT 'Количество пропущенных голов (для вратарей)',
	         FOREIGN KEY (number_ability_2) REFERENCES players2(number_of_player2),
	         foreign key (position_ability_2) references playposition(id)
	         );

describe info_player_2;

-- Создание таблицы со статистикой игроков и дополнительная информация - третья часть.

drop table if exists info_player_3;

CREATE TABLE info_player_3(number_ability_3 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока в клубе',
	         position_ability_3 TINYINT UNSIGNED NOT NULL COMMENT 'Главная позиция игрока',
	         player_nation3 VARCHAR(20) COMMENT 'Гражданство',
	         number_of_matches3 SMALLINT UNSIGNED NOT NULL COMMENT 'Количество сыгранным игроком матчей за данный клуб',
	         number_of_goals3 TINYINT UNSIGNED NOT NULL COMMENT 'Количество забитых игроком голов',
	         number_of_assists3 TINYINT UNSIGNED NOT NULL COMMENT 'Количество голевых пасов (в т.ч. и для вратарей)',
	         number_of_minus_goals3 SMALLINT UNSIGNED NOT NULL COMMENT 'Количество пропущенных голов (для вратарей)',
	         FOREIGN KEY (number_ability_3) REFERENCES players3(number_of_player3),
	         foreign key (position_ability_3) references playposition(id)
	         );

describe info_player_3;

/* Создание таблицы с позициями, который может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - первая часть. */

drop table if exists alternativepositions1;

CREATE TABLE alternativepositions1(number_player_alternative1 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока в клубе',
	         potencial_player_position1 VARCHAR(150) COMMENT 'Номинальные позиции, которые игрок может фактически занимать',
	         english_code_position1 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на английском языке',
	         russian_code_position1 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на русском языке',
	         FOREIGN KEY (number_player_alternative1) REFERENCES players1(number_of_player1)
	         );

describe alternativepositions1;

/* Создание таблицы с позициями, который может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - вторая часть. */

drop table if exists alternativepositions2;

CREATE TABLE alternativepositions2(number_player_alternative2 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока в клубе',
	         potencial_player_position2 VARCHAR(150) COMMENT 'Номинальные позиции, которые игрок может фактически занимать',
	         english_code_position2 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на английском языке',
	         russian_code_position2 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на русском языке',
	         FOREIGN KEY (number_player_alternative2) REFERENCES players2(number_of_player2)
	         );

describe alternativepositions2;

/* Создание таблицы с позициями, который может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - третья часть. */

drop table if exists alternativepositions3;

CREATE TABLE alternativepositions3(number_player_alternative3 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока в клубе',
	         potencial_player_position3 VARCHAR(150) COMMENT 'Номинальные позиции, которые игрок может фактически занимать',
	         english_code_position3 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на английском языке',
	         russian_code_position3 VARCHAR(30) COMMENT 'Аббревиатуры футбольной позиции на русском языке',
	         FOREIGN KEY (number_player_alternative3) REFERENCES players3(number_of_player3)
	         );

describe alternativepositions3;

/* Создание таблицы с информацией с тактико-техническими характеристиками игроков - первая часть. */

drop table if exists tactics1;

CREATE TABLE tactics1(t_shirt_name1 VARCHAR(20) COMMENT 'Фамилия игрока на футболке',
	         club_number1 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока на футболке',
	         attack1 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в атаке (от 1 до 100 баллов)',
	         defence1 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в защите (от 1 до 100 баллов)',
	         stamina1 TINYINT UNSIGNED NOT NULL COMMENT 'Выносливость игрока (от 1 до 10 баллов)',
	         speed1 TINYINT UNSIGNED NOT NULL COMMENT 'Скорость игрока (от 1 до 100 баллов)',
	         pass_technique1 TINYINT UNSIGNED NOT NULL COMMENT 'Техника пасов игрока (от 1 до 100 баллов)',
	         technique1 TINYINT UNSIGNED NOT NULL COMMENT 'Техника дриблинга и навык обращения с мячом игрока (от 1 до 100 баллов)',
	         team_work1 TINYINT UNSIGNED NOT NULL COMMENT 'Способность игрока к командной игре (от 1 до 100 баллов)',
	         shots_technique1 TINYINT UNSIGNED NOT NULL COMMENT 'Техника ударов (от 1 до 10 баллов)',
	         header1 TINYINT UNSIGNED NOT NULL COMMENT 'Навык игры головой игроком (от 1 до 10 баллов)',
	         injury1 VARCHAR(3) COMMENT 'Травмируемость игрока (A,B,C - градация, в порядке возрастания травмируемости)',
	         FOREIGN KEY (club_number1) REFERENCES players1(number_of_player1)
	         );

describe tactics1;

/* Создание таблицы с информацией с тактико-техническими характеристиками игроков - вторая часть. */

drop table if exists tactics2;

CREATE TABLE tactics2(t_shirt_name2 VARCHAR(20) COMMENT 'Фамилия игрока на футболке',
	         club_number2 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока на футболке',
	         attack2 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в атаке (от 1 до 100 баллов)',
	         defence2 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в защите (от 1 до 100 баллов)',
	         stamina2 TINYINT UNSIGNED NOT NULL COMMENT 'Выносливость игрока (от 1 до 10 баллов)',
	         speed2 TINYINT UNSIGNED NOT NULL COMMENT 'Скорость игрока (от 1 до 100 баллов)',
	         pass_technique2 TINYINT UNSIGNED NOT NULL COMMENT 'Техника пасов игрока (от 1 до 100 баллов)',
	         technique2 TINYINT UNSIGNED NOT NULL COMMENT 'Техника дриблинга и навык обращения с мячом игрока (от 1 до 100 баллов)',
	         team_work2 TINYINT UNSIGNED NOT NULL COMMENT 'Способность игрока к командной игре (от 1 до 100 баллов)',
	         shots_technique2 TINYINT UNSIGNED NOT NULL COMMENT 'Техника ударов (от 1 до 10 баллов)',
	         header2 TINYINT UNSIGNED NOT NULL COMMENT 'Навык игры головой игроком (от 1 до 10 баллов)',
	         injury2 VARCHAR(3) COMMENT 'Травмируемость игрока (A,B,C - градация, в порядке возрастания травмируемости)',
             FOREIGN KEY (club_number2) REFERENCES players2(number_of_player2)
	         );

describe tactics2;

/* Создание таблицы с информацией с тактико-техническими характеристиками игроков - третья часть. */

drop table if exists tactics3;

CREATE TABLE tactics3(t_shirt_name3 VARCHAR(20) COMMENT 'Фамилия игрока на футболке',
	         club_number3 TINYINT UNSIGNED NOT NULL COMMENT 'Номер игрока на футболке',
	         attack3 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в атаке (от 1 до 100 баллов)',
	         defence3 TINYINT UNSIGNED NOT NULL COMMENT 'Навыки атаки игрока в защите (от 1 до 100 баллов)',
	         stamina3 TINYINT UNSIGNED NOT NULL COMMENT 'Выносливость игрока (от 1 до 10 баллов)',
	         speed3 TINYINT UNSIGNED NOT NULL COMMENT 'Скорость игрока (от 1 до 100 баллов)',
	         pass_technique3 TINYINT UNSIGNED NOT NULL COMMENT 'Техника пасов игрока (от 1 до 100 баллов)',
	         technique3 TINYINT UNSIGNED NOT NULL COMMENT 'Техника дриблинга и навык обращения с мячом игрока (от 1 до 100 баллов)',
	         team_work3 TINYINT UNSIGNED NOT NULL COMMENT 'Способность игрока к командной игре (от 1 до 100 баллов)',
	         shots_technique3 TINYINT UNSIGNED NOT NULL COMMENT 'Техника ударов (от 1 до 10 баллов)',
	         header3 TINYINT UNSIGNED NOT NULL COMMENT 'Навык игры головой игроком (от 1 до 10 баллов)',
	         injury3 VARCHAR(3) COMMENT 'Травмируемость игрока (A,B,C - градация, в порядке возрастания травмируемости)',
	         FOREIGN KEY (club_number3) REFERENCES players3(number_of_player3)
	         );

describe tactics3;

/* Создание таблицы с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - первая часть.*/

drop table if exists playercard1;

CREATE TABLE playercard1(id_player1 TINYINT UNSIGNED NOT NULL COMMENT 'Код номинальной футбольной позиции',
		     name_of_card1 VARCHAR(25) COMMENT 'Фамилия игрока',
	         date_of_birth1 DATE COMMENT 'Дата рождения игрока',
	         contract_term1 TINYINT UNSIGNED COMMENT 'Срок действия контракта игрока, лет',
	         national_team1 VARCHAR(50) COMMENT 'Принадлежность игрока к национальной сборной',
	         FOREIGN KEY (id_player1) REFERENCES playposition(id)
	         );

describe playercard1;

/* Создание таблицы с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - вторая часть. */

drop table if exists playercard2;

CREATE TABLE playercard2(id_player2 TINYINT UNSIGNED NOT NULL COMMENT 'Код номинальной футбольной позиции',
	         name_of_card2 VARCHAR(25) COMMENT 'Фамилия игрока',
	         date_of_birth2 DATE COMMENT 'Дата рождения игрока',
	         contract_term2 TINYINT UNSIGNED COMMENT 'Срок действия контракта игрока, лет',
	         national_team2 VARCHAR(50) COMMENT 'Принадлежность игрока к национальной сборной',
	         FOREIGN KEY (id_player2) REFERENCES playposition(id)
	         );

describe playercard2;

/* Создание таблицы с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - третья часть. */

drop table if exists playercard3;

CREATE TABLE playercard3(id_player3 TINYINT UNSIGNED NOT NULL COMMENT 'Код номинальной футбольной позиции',
             name_of_card3 VARCHAR(25) COMMENT 'Фамилия игрока',
	         date_of_birth3 DATE COMMENT 'Дата рождения игрока',
	         contract_term3 TINYINT UNSIGNED COMMENT 'Срок действия контракта игрока, лет',
	         national_team3 VARCHAR(50) COMMENT 'Принадлежность игрока к национальной сборной',
	         FOREIGN KEY (id_player3) REFERENCES playposition(id)
	         );

describe playercard3;


-- Задание 4: создать ERDiagram для БД (диаграмма создана, отправится в отдельном виде).


-- Задание 5: скрипты наполнения БД данными.

-- Заполнение главной таблицы данными с номинальными позициями игроков в клубе "Манчестер Юнайтед".

INSERT INTO playposition(first_position, second_position, third_position)
VALUES ('Вратарь', NULL, NULL),
	   ('Защитник', 'центральный', 'правый'),
	   ('Защитник', 'центральный', 'левый'),
	   ('Защитник', 'фланговый', 'правый'),
	   ('Защитник', 'фланговый', 'левый'),
	   ('Полузащитник', 'центральный', 'правый'),
	   ('Полузащитник', 'центральный', 'левый'),
	   ('Полузащитник', 'фланговый', 'правый'),
	   ('Полузащитник', 'фланговый', 'левый'),
	   ('Нападающий', 'центральный', 'правый/левый/основной');

select *
from playposition;

/* Заполнение таблицы данными информацией о номинальных позициях и их потенциале в данном клубе
(с учетом предпочтений главного тренера и выбираемой игровой схемы). */

INSERT INTO infopositions(id_position, english_code, russian_code, potential_position, rotation_potential)
VALUES ('1', 'GK', 'ВР', 'Защитный', 'Низкая'),
	   ('2', 'DCR', 'ЗЦП', 'Защитный', 'Низкая'),
	   ('3', 'DCL', 'ЗЦЛ', 'Защитный', 'Низкая'),
	   ('4', 'DWR', 'ЗФП', 'Защитный и атакующий', 'Средняя'),
	   ('5', 'DWL', 'ЗФЛ', 'Защитный и атакующий', 'Средняя'),
	   ('6', 'MCR', 'ПЦП', 'Кобинированный', 'Средняя'),
	   ('7', 'MCL', 'ПЦЛ', 'Комбинированный', 'Высокая'),
	   ('8', 'MWR', 'ПФП', 'Атакующий и комбинированный', 'Высокая'),
	   ('9', 'MWL', 'ПФЛ', 'Атакующий и комбинированный', 'Средняя'),
	   ('10', 'CF', 'НЦ', 'Атакующий', 'Высокая');

select *
from infopositions;

-- Заполнение таблицы данными основной информацией об игроках - первая часть.

INSERT INTO players1(player_nominal_id1, number_of_player1, name1, patronymic1, surname1, nickname1, rating_of_player1, player_nominal_position1)
VALUES ('1', '1', 'Давид', 'Кинтана', 'де Хеа', 'Кот (El Gato)', '91', 'ВР'),
	   ('3', '2', 'Виктор', 'Йорген Нильсон', 'Линделёф', 'Человек-лёд (Iceman)', '85', 'ЗЦ'),
	   ('3', '3', 'Эрик', 'Бертран', 'Байи', 'Раздолбай (Goof)', '83', 'ЗЦ'),
	   ('2', '4', 'Фил', 'Энтони', 'Джонс', 'Опасный (Dangerous)', '82', 'ЗЦ'),
	   ('2', '5', 'Гарри', 'Джейкоб', 'Магуайр', 'Волшебник (Harry Potter)', '94', 'ЗЦ'),
	   ('6', '6', 'Поль', 'Лабиль', 'Погба', 'Осьминог Поль (Polpo Paul)', '91', 'ПЦ'),
	   ('10', '7', 'Криштиану', 'душ Сантуш Авейру', 'Роналду', 'CR07, КриРо, Рон (abelhinha)', '97', 'НЦ'),
	   ('9', '8', 'Хуан', 'Гарсия', 'Мата', 'Трудяга (Slogger)', '84', 'ПФ'),
	   ('10', '9', 'Антони', 'Жуан', 'Марсьяль', 'Антон (Anthon)', '83', 'НЦ'),
	   ('10', '10', 'Маркус', 'Джон', 'Рашфорд', 'Русский (Russian)', '88', 'НЦ');

select *
from players1;

-- Заполнение таблицы данными основной информацией об игроках - вторая часть.

INSERT INTO players2(player_nominal_id2, number_of_player2, name2, patronymic2, surname2, nickname2, rating_of_player2, player_nominal_position2)
VALUES ('8', '11', 'Мейсон', 'Уилл Джон', 'Гринвуд', 'Джоник (John)', '84', 'ПФ'),
	   ('1', '13', 'Ли', 'Андерсон', 'Грант', 'Генерал Ли (Генерал Ли)', '81', 'ВР'),
	   ('6', '14', 'Джесси', 'Эллис', 'Лингард', 'Лин (Lean)', '83', 'ПЦ'),
	   ('9', '16', 'Амад', 'Джон', 'Диалло', 'Горщик Спиди (Speed Racer)', '80', 'ПФ'),
	   ('7', '17', 'Фредерико', 'Родригес де Паула', 'Сантос', 'Фред (Fred)', '83', 'ПЦ'),
	   ('7', '18', 'Бруну', 'Мигел Боржес', 'Фернандеш', NULL, '91', 'ПЦ'),
	   ('3', '19', 'Рафаэль', 'Ксавье', 'Варан', 'Рафа (Rafa)', '93', 'ЗЦ'),
	   ('5', '20', 'Диогу', 'Жозэ', 'Дало', 'Ракета (Rocket)', '81', 'ЗФ'),
	   ('10', '21', 'Эдинсон', 'Роберто Гомес', 'Кавани', 'Матадор (El Matador)', '92', 'НЦ'),
	   ('1', '22', 'Том', 'Дэвид', 'Хитон', 'Томми (Tommy)', '82', 'ВР');

select *
from players2;

-- Заполнение таблицы данными основной информацией об игроках - третья часть.

INSERT INTO players3(player_nominal_id3, number_of_player3, name3, patronymic3, surname3, nickname3, rating_of_player3, player_nominal_position3)
VALUES ('5', '23', 'Люк', 'Пол Хор', 'Шоу', 'Люк, я - твой отец', '86', 'ЗФ'),
	   ('9', '25', 'Джейдон', 'Малик', 'Санчо', 'Санчо (Санчо)', '87', 'ПФ'),
	   ('1', '26', 'Дин', 'Брэдли', 'Хендерсон', 'Джеймс Дин (James Dean)', '77', 'ВР'),
	   ('5', '27', 'Алекс', 'Николао', 'Теллес', 'Алекс (Alex)', '80', 'ЗФ'),
	   ('4', '29', 'Эрон', 'Скотт', 'Уан Биссака', 'Runner', '85', 'ЗФ'),
	   ('6', '31', 'Неманья', 'Бранислав', 'Матич', 'Видич (Vidic)', '87', 'ПЦ'),
	   ('7', '34', 'Донни', 'Деннис', 'Ван де Бек', 'One', '88', 'ПЦ'),
	   ('7', '39', 'Скотт', 'Фрэнсис', 'МакТоминэй', 'Ракета (Rocket)', '84', 'ПЦ'),
	   ('3', '43', 'Теден', 'Мэри', 'Менги', 'Silent', '76', 'ЗЦ'),
	   ('10', '47', 'Шола', 'Максуэлл', 'Шоретире', 'Шол (Shol)', '75', 'НЦ');

select *
from players3;

-- Заполнение таблицы данными со статистикой игроков и дополнительная информация - первая часть.

INSERT INTO info_player_1(number_ability_1, position_ability_1, player_nation1, number_of_matches1, number_of_goals1, number_of_assists1, number_of_minus_goals1)
VALUES ('1', '1', 'Испания', '342', '3', '10', '348'),
	   ('2', '3', 'Швеция', '111', '3', '2', '0'),
	   ('3', '3', 'Кот-д-Ивуар', '66', '1', '1', '0'),
	   ('4', '2', 'Англия', '165', '2', '4', '0'),
	   ('5', '2', 'Англия', '75', '3', '3', '0'),
	   ('6', '6', 'Франция', '137', '28', '30', '0'),
	   ('7', '10', 'Португалия', '2', '3', '1', '0'),
	   ('8', '9', 'Испания', '189', '34', '30', '0'),
	   ('9', '10', 'Франция', '170', '55', '20', '0'),
	   ('10', '10', 'Англия', '179', '55', '32', '0');

select *
from info_player_1;

-- Заполнение таблицы данными со статистикой игроков и дополнительная информация - вторая часть.

INSERT INTO info_player_2(number_ability_2, position_ability_2, player_nation2, number_of_matches2, number_of_goals2, number_of_assists2, number_of_minus_goals2)
VALUES ('11', '8', 'Англия', '70', '20', '12', '0'),
	   ('13', '1', 'Англия', '0', '0', '0', '0'),
	   ('14', '6', 'Англия', '136', '20', '27', '0'),
	   ('16', '9', 'Кот-д-Ивуар', '3', '0', '1', '0'),
	   ('17', '7', 'Бразилия', '77', '3', '8', '0'),
	   ('18', '7', 'Португалия', '55', '30', '20', '0'),
	   ('19', '3', 'Франция', '1', '0', '0', '0'),
	   ('20', '5', 'Португалия', '20', '0', '2', '0'),
	   ('21', '10', 'Уругвай', '26', '10', '4', '0'),
	   ('22', '1', 'Англия', '0', '0', '0', '0');

select *
from info_player_2;

-- Заполнение таблицы данными со статистикой игроков и дополнительная информация - третья часть.

INSERT INTO info_player_3(number_ability_3, position_ability_3, player_nation3, number_of_matches3, number_of_goals3, number_of_assists3, number_of_minus_goals3)
VALUES ('23', '5', 'Англия', '129', '2', '15', '0'),
	   ('25', '9', 'Англия', '3', '0', '1', '0'),
	   ('26', '1', 'Англия', '13', '0', '0', '12'),
	   ('27', '5', 'Бразилия, Италия', '9', '0', '1', '0'),
	   ('29', '4', 'Англия, ДР Конго', '70', '2', '8', '0'),
	   ('31', '6', 'Сербия', '105', '2', '10', '0'),
	   ('34', '7', 'Нидерланды', '19', '1', '4', '0'),
	   ('39', '7', 'Шотландия', '91', '10', '10', '0'),
	   ('43', '3', 'Англия', '0', '0', '0', '0'),
	   ('47', '10', 'Англия', '0', '0', '1', '0');

select *
from info_player_3;

/* Заполнение таблицы данными о позициях, которые может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - первая часть. */

INSERT INTO alternativepositions1(number_player_alternative1, potencial_player_position1, english_code_position1, russian_code_position1)
VALUES ('1','Вратарь', 'GK', 'ВР'),
	   ('2', 'Защитник центральный правый, Защитник центральный левый, Защитник фланговый правый, Защитник фланговый левый',
	   'DCR, DCL, DWR, DWL', 'ЗЦП, ЗЦЛ, ЗФП, ЗФЛ'),
	   ('3', 'Защитник центральный левый, Защитник фланговый левый', 'DCL, DWL', 'ЗЦЛ, ЗФЛ'),
	   ('4', 'Защитник центральный правый, Защитник центральный левый, Защитник фланговый правый, Защитник фланговый левый,
	   Полузащитник центральный правый', 'DCR, DCL, DWR, DWL, MCR', 'ЗЦП, ЗЦЛ, ЗФП, ЗФЛ, ПЦП'),
	   ('5', 'Защитник центральный правый, Защитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('6', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('7', 'Нападающий центральный, Полузащитник фланговый правый, Полузащитник фланговый левый', 'CF, MWR, MWL', 'НЦ, ПФП, ПФЛ'),
	   ('8', 'Полузащитник фланговый правый, Полузащитник фланговый левый, Нападающий центральный', 'MWR, MWL ,CF', 'НЦ, ПФП, ПФЛ'),
	   ('9', 'Нападающий центральный, Полузащитник фланговый правый, Полузащитник фланговый левый', 'CF, MWR, MWL', 'ПФП, ПФЛ, НЦ'),
	   ('10', 'Нападающий центральный, Полузащитник фланговый правый, Полузащитник фланговый левый', 'CF, MWR, MWL', 'ПФП, ПФЛ, НЦ');

select *
from alternativepositions1;

/* Заполнение таблицы данными о позициях, которые может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - вторая часть. */

INSERT INTO alternativepositions2(number_player_alternative2, potencial_player_position2, english_code_position2, russian_code_position2)
VALUES ('11', 'Полузащитник фланговый правый, Полузащитник фланговый левый, Нападающий центральный', 'MWR, MWL ,CF', 'НЦ, ПФП, ПФЛ'),
	   ('13', 'Вратарь', 'GK', 'ВР'),
	   ('14', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('16', 'Полузащитник фланговый правый, Полузащитник фланговый левый', 'MWR, MWL', 'ПФП, ПФЛ'),
	   ('17', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('18', 'Полузащитник центральный правый, Полузащитник центральный левый, Нападающий центральный', 'DCR, DCL, CF', 'ЗЦП, ЗЦЛ, НЦ'),
	   ('19', 'Защитник центральный правый, Защитник центральный левый, Защитник фланговый правый, Защитник фланговый левый',
	   'DCR, DCL, DWR, DWL', 'ЗЦП, ЗЦЛ, ЗФП, ЗФЛ'),
	   ('20', 'Защитник фланговый правый, Защитник фланговый левый', 'DWR, DWL', 'ЗФП, ЗФЛ'),
	   ('21', 'Нападающий центральный', 'CF', 'НЦ'),
	   ('22', 'Вратарь', 'GK', 'ВР');

select *
from alternativepositions2;

/* Заполнение таблицы данными о позициях, которые может потенциально занимать конкретный игрок.
(помимо своей главной позиции на поле) - третья часть. */

INSERT INTO alternativepositions3(number_player_alternative3, potencial_player_position3, english_code_position3, russian_code_position3)
VALUES ('23', 'Защитник фланговый правый, Защитник фланговый левый', 'DWR, DWL', 'ЗФП, ЗФЛ'),
	   ('25', 'Полузащитник центральный правый, Полузащитник центральный левый, Нападающий центральный', 'DCR, DCL, CF', 'ЗЦП, ЗЦЛ, НЦ'),
	   ('26', 'Вратарь', 'GK', 'ВР'),
	   ('27', 'Защитник фланговый правый, Защитник фланговый левый', 'DWR, DWL', 'ЗФП, ЗФЛ'),
	   ('29', 'Защитник фланговый правый, Защитник фланговый левый', 'DWR, DWL', 'ЗФП, ЗФЛ'),
	   ('31', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('34', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('39', 'Полузащитник центральный правый, Полузащитник центральный левый', 'DCR, DCL', 'ЗЦП, ЗЦЛ'),
	   ('43', 'Защитник центральный правый, Защитник центральный левый, Защитник фланговый правый, Защитник фланговый левый',
	   'DCR, DCL, DWR, DWL', 'ЗЦП, ЗЦЛ, ЗФП, ЗФЛ'),
	   ('47', 'Нападающий центральный', 'CF', 'НЦ');

select *
from alternativepositions3;

/* Заполнение таблицы данными информацией с тактико-техническими характеристиками игроков - первая часть. */

INSERT INTO tactics1(t_shirt_name1, club_number1, attack1, defence1, stamina1, speed1, pass_technique1,
	        technique1, team_work1, shots_technique1, header1, injury1)
VALUES ('де Хеа', '1', '35', '92', '6', '63', '60', '55', '75', '5', '7', 'A'),
	   ('Линделёф', '2', '62', '87', '7', '75', '76', '76', '80', '7', '8', 'B'),
	   ('Байи', '3', '64', '84', '8', '76', '73', '74', '81', '7', '8', 'В'),
	   ('Джонс', '4', '64', '82', '8', '76', '73', '74', '82', '7', '8', 'С'),
	   ('Магуайр', '5', '62', '94', '8', '79', '80', '82', '82', '7', '8', 'A'),
	   ('Погба', '6', '83', '77', '8', '82', '78', '85', '91', '8', '8', 'B'),
	   ('Роналду', '7','97', '56', '9', '95', '87', '98', '90', '9', '9', 'B'),
	   ('Мата', '8', '83', '56', '8', '87', '80', '87', '81', '8', '8', 'А'),
	   ('Марсьяль', '9', '85', '57', '8', '83', '82', '83', '81', '8', '8', 'В'),
	   ('Рашфорд', '10', '89', '60', '8', '88', '84', '88', '84', '8', '8', 'А');

select *
from tactics1;

/* Заполнение таблицы данными информацией с тактико-техническими характеристиками игроков - вторая часть. */

INSERT INTO tactics2(t_shirt_name2, club_number2, attack2, defence2, stamina2, speed2, pass_technique2,
	        technique2, team_work2, shots_technique2, header2, injury2)
VALUES ('Гринвуд', '11', '82', '51', '8', '86', '81', '82', '80', '8', '8', 'А'),
	   ('Грант', '13', '27', '82', '5', '60', '56', '52', '72', '4', '6', 'В'),
	   ('Лингард', '14', '80', '68', '8', '84', '85', '83', '85', '8', '8', 'B'),
	   ('Диало', '16', '76', '53', '7', '84', '80', '82', '78', '8', '8', 'А'),
	   ('Фред', '17', '75', '72', '8', '78', '87', '82', '85', '7', '7', 'А'),
	   ('Фернандеш', '18', '87', '67', '9', '87', '91', '88', '92', '9', '8', 'А'),
	   ('Варан', '19', '66', '92', '8', '78', '81', '81', '81', '7', '9', 'B'),
	   ('Дало', '20', '72', '64', '7', '85', '80', '80', '77', '8', '9', 'А'),
	   ('Кавани', '21', '93', '57', '7', '97', '85', '98', '90', '9', '9', 'B'),
	   ('Хитон', '22', '81', '51', '8', '86', '81', '82', '80', '8', '8', 'А');

select *
from tactics2;

/* Заполнение таблицы данными информацией с тактико-техническими характеристиками игроков - третья часть. */

INSERT INTO tactics3(t_shirt_name3, club_number3, attack3, defence3, stamina3, speed3, pass_technique3,
	        technique3, team_work3, shots_technique3, header3, injury3)
VALUES ('Шоу', '23', '78', '71', '9', '85', '80', '83', '80', '7', '8', 'С'),
	   ('Санчо', '25', '83', '53', '8', '91', '82', '80', '90', '8', '7', 'А'),
	   ('Хендерсон', '26', '25', '78', '5', '65', '52', '50', '66', '4', '6', 'А'),
	   ('Теллес', '27', '71', '65', '7', '84', '80', '80', '77', '8', '8', 'А'),
	   ('Уан Биссака', '29', '76', '76', '8', '84', '81', '83', '81', '8', '10', 'А'),
	   ('Матич', '31', '76', '76', '9', '80', '91', '84', '90', '8', '10', 'B'),
	   ('Ван де Бек', '34', '78', '75', '7', '82', '87', '86', '88', '9', '7', 'А'),
	   ('МакТоминэй', '39', '75', '72', '7', '81', '83', '83', '84', '7', '7', 'А'),
	   ('Менги', '43', '57', '76', '7', '72', '72', '71', '76', '5', '8', 'А'),
	   ('Шоретире', '47', '76', '55', '7', '80', '74', '79', '73', '8', '8', 'А');

select *
from tactics3;

/* Заполнение таблицы данными с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - первая часть.*/

INSERT INTO playercard1(id_player1, name_of_card1, date_of_birth1, contract_term1, national_team1)
VALUES ('1', 'де Хеа', '1990-11-07', '3', 'Национальная сборная Испании, вице-капитан'),
	   ('3', 'Линделёф', '1994-07-17', '3', 'Национальная сборная Швеции'),
	   ('3', 'Байи', '1994-12-14', '3', 'Национальная сборная Кот-д-Ивуара'),
	   ('2', 'Джонс', '1992-02-21', '3', 'Национальная сборная Англии'),
	   ('2', 'Магуйар', '1993-03-05', '4', 'Национальная сборная Англии'),
	   ('6', 'Погба', '1993-03-15', '3', 'Национальная сборная Франции'),
	   ('10', 'Роналду', '1985-02-05', '3', 'Национальная сборная Португалии, капитан сборной'),
	   ('9', 'Мата', '1988-04-28', '2', 'Завершил выступления в сборной Испании'),
	   ('10', 'Марсьяль', '1995-12-05', '3', 'Национальная сборная Франции'),
	   ('10', 'Рашфорд', '1997-10-31', '5', 'Национальная сборная Англии');

select *
from playercard1;

/* Заполнение таблицы данными с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - вторая часть.*/

INSERT INTO playercard2(id_player2, name_of_card2, date_of_birth2, contract_term2, national_team2)
VALUES ('8', 'Гринвуд', '2001-10-01', '5', 'Национальная сборная Англии (до 21 года)'),
	   ('1', 'Грант', '1983-01-28', '2', 'Не заигран за национальные сборные'),
	   ('6', 'Лингард', '1992-12-15', '4', 'Национальная сборная Англии'),
	   ('9', 'Диалло', '2002-07-11', '3', 'Национальная сборная Кот-д-Ивуара'),
	   ('7', 'Фред', '1994-09-08', '5', 'Национальная сборная Португалии'),
	   ('7', 'Френандеш', '1994-09-08', '5', 'Национальная сборная Португалии'),
	   ('3', 'Варан', '1993-04-25', '4', 'Национальная сборная Франции'),
	   ('5', 'Дало', '1999-03-18', '3', 'Национальная сборная Португалии (до 21 года)'),
	   ('10', 'Кавани', '1987-02-14', '2', 'Национальная сборная Урагвая'),
	   ('1', 'Хитон', '1986-04-15', '2', 'Завершил выступления в сборной Англии');

select *
from playercard2;

/* Заполнение таблицы данными с датой рождения игроков, сроком действия контрактов, принадлежность игрока к
национальным сборным - третья часть.*/

INSERT INTO playercard3(id_player3, name_of_card3, date_of_birth3, contract_term3, national_team3)
VALUES ('5', 'Шоу', '1995-07-12', '3', 'Национальная сборная Англии'),
	   ('9', 'Санчо', '2000-03-25', '5', 'Национальная сборная Англии'),
	   ('1', 'Хендерсон', '1997-03-12', '3', 'Национальная сборная Англии'),
	   ('5', 'Теллес', '1992-12-15', '3', 'Национальная сборная Бразилии'),
	   ('4', 'Уан Биссака', '1997-11-26', '5', 'Не заигран за национальные сборные'),
	   ('6', 'Матич', '1988-08-01', '3', 'Завершил выступления в сборной Сербии'),
	   ('7', 'Ван де Бек', '1997-04-18', '3', 'Национальная сборная Нидерландов, вице-капитан'),
	   ('7', 'МакТоминэй', '1996-12-08', '5', 'Национальная сборная Шотландии'),
	   ('3', 'Менги', '2002-04-30', '3', 'Не заигран за национальные сборные'),
	   ('10', 'Шоретире', '2004-02-02', '2', 'Не заигран за национальные сборные');

select *
from playercard3;


-- Задание 6: скрипты характерных выборок (включающие группировки, JOIN, вложенные таблицы);

-- 1. Скрипты для создания выборок с помощью группировок (4 скрипта):

/* 1). Создание скрипта, с помощью которого создается запрос: вывести информацию об игроках клуба с номерами с 1 по 10
и сгруппировать их по номинальным позициям клуба. Также провести сортировку выборки по убыванию рейтингов футболистов. */

select surname1, number_of_player1, player_nominal_id1, player_nominal_position1, rating_of_player1
from players1
group by player_nominal_id1
order by rating_of_player1 desc;

/* 2). Создание скрипта, с помощью которого создается запрос: вывести информацию об игроках клуба с номерами с 11 по 22
и сгруппировать по номинальных позициям конкретного игрока, выполнить сортировку по рейтингу игрока. */

select surname2, player_nominal_position2, rating_of_player2,number_of_player2, player_nominal_id2
from players2
group by player_nominal_position2
order by rating_of_player2;

/* 3). Создание скрипта, с помощью которого создается запрос: вывести информацию об игроках клуба с номерами с 1 по 10
и сгруппировать по национальной принадлежности игроков, выполнить сортировку по количеству забитых мячей в обратном
порядке. */

select number_ability_1, player_nation1, number_of_goals1, number_of_matches1
from info_player_1
group by player_nation1
order by number_of_goals1 desc;

/* 4). Создание скрипта, с помощью которого создается запрос: вывести информацию об игроках клуба с номерами с 23 по 47
с навыком атаки больше 70 баллов, сгруппировать по категории травмируемости игроков, выполнить сортировку по номеру игрока
по порядку. */

select t_shirt_name3, injury3, attack3, club_number3
from tactics3
where attack3 > '70'
group by injury3
order by club_number3;

-- 2. Скрипты для создания выборок с помощью JOIN-соединений (3 скрипта):

/* 1). Создание скрипта, с помощью которого создается запрос с применением JOIN-соединения: вывести информацию об игроке
клуба с номером 27 - полное имя игрока, прозвище, рейтинг игрока, номинальную позицию на поле,
фактические позиции (которые может занять этоn игрок) */

select number_of_player3, name3, patronymic3, surname3, nickname3, rating_of_player3,
       player_nominal_position3, potencial_player_position3
from players3
join alternativepositions3
on players3.number_of_player3 = alternativepositions3.number_player_alternative3
where players3.number_of_player3 = '27';

/* 2). Создание скрипта, с помощью которого создается запрос с применением JOIN-соединения: вывести информацию об игроке
клуба с номером 7 - фамилия игрока, рейтинг игрока, номинальную позицию на поле,
фактические позиции (которые может занять этоn игрок), аббревиатуры его позиций на русском
языке, категория травмируемости игрока */

select number_of_player1, surname1, rating_of_player1, player_nominal_position1,
       russian_code_position1, attack1, injury1
from players1
join alternativepositions1
on players1.number_of_player1 = alternativepositions1.number_player_alternative1
join tactics1
on players1.number_of_player1 = tactics1.club_number1
where players1.number_of_player1 = '7';

/* 3). Создание скрипта, с помощью которого создается запрос с применением JOIN-соединения: вывести информацию об игроках
клуба с 27 по 47 номер, которые не заиграны за национальные сборные. Результат запроса должен содержать код номинальной
футбольной позиции, имя и фамилия игрока, номинальная позиция игрока, рейтинг игрока, контракт игрока. Результат
запроса должен быть остортирован по рейтингу игроков по убыванию. */

select id, name3, surname3, first_position, rating_of_player3,
       contract_term3, national_team3
from playposition
join playercard3
on playposition.id = playercard3.id_player3
join players3
on playposition.id = players3.player_nominal_id3
where playercard3.national_team3 = 'Не заигран за национальные сборные'
order by rating_of_player3 desc;

-- 3. Скрипты для создания выборок с помощью вложенных таблиц (6 скриптов):

/* 1). Создание скрипта, с помощью которого создается вложенный запрос: вывести информацию об игроке
клуба Эдинсоне Кавани, используя вложенный запрос */

select name2, patronymic2, surname2, nickname2,
              rating_of_player2, player_nominal_position2
from players2
where player_nominal_id2 in
	(select id_position
	from infopositions
	where id_position = '10');

/* 2). Создание скрипта, с помощью которого создается вложенный запрос: вывести информацию об игроках
клуба с номерами с 23 по 47 по возрастающему рейтингу игроков. Использовать вложенный запрос.*/

select name3, patronymic3, surname3, nickname3,
              rating_of_player3, player_nominal_position3
from players3
where player_nominal_id3 in
	(select id_position
	from infopositions
    where rating_of_player3 > '80')
order by rating_of_player3;

/* 3). Создание скрипта, с помощью которого создается вложенный запрос: вывести информацию об игроках
клуба с номерами от 11 до 22 по возрастающему рейтингу игроков, у которых контракт больше 2 лет.
Использовать вложенный запрос.*/

select number_of_player2, name2, patronymic2,
       surname2, rating_of_player2
from players2
where player_nominal_id2 in
      (select id_player2
      from playercard2
      where contract_term2 > '2')
order by rating_of_player2;

/* 4). Создание скрипта, с помощью которого создается вложенный запрос: вывести информацию об игроках
клуба с номерами от 1 до 10 по увеличению номеров футболистов, у которых навык атаки больше 60 и
навык защиты меньше 70. Использовать вложенный запрос.*/

select number_of_player1, name1, patronymic1,
       surname1, rating_of_player1
from players1
where surname1 in
      (select t_shirt_name1
      from tactics1
      where attack1 > '60' and defence1 < '70')
order by number_of_player1;

/* 5). Создание скрипта представления: вывести фамилии игроков клуба с номерами с 1 по 20. */

select surname1
from players1
union
select surname2
from players2;

/* 6). Создание скрипта представления: вывести список национальных сборных,
игроки которых носят футболки с номерами с 11 по 47. */

select national_team2
from playercard2
union all
select national_team3
from playercard3;

-- 7. Скрипты для создания представлений (минимум 2, по факту 6):

/* 1). Создание скрипта представления: вывести информацию нападающих клуба с 1 по 10
номер. */

create view forwards as
select name1, patronymic1, surname1, nickname1,
              rating_of_player1, player_nominal_position1
from players1
where player_nominal_id1 in
	(select id_position
	from infopositions
	where id_position = '10');

select *
from forwards;

/* 2). Создание скрипта представления: вывести информацию об игроках
клуба с 11 по 22 номер, которые выступают за национальную сборную Уругвая по футболу.
Результат запроса должен содержать код номинальной футбольной позиции, имя и фамилия игрока,
номинальная позиция игрока, рейтинг игрока, контракт игрока. Результат
запроса должен быть остортирован по рейтингу игроков по убыванию. */

create view uruguayan as
select id, name2, surname2, first_position, rating_of_player2,
       contract_term2, national_team2
from playposition
join playercard2
on playposition.id = playercard2.id_player2
join players2
on playposition.id = players2.player_nominal_id2
where playercard2.national_team2 = 'Национальная сборная Урагвая'
order by rating_of_player2 desc;

select *
from uruguayan;

/* 3). Создание скрипта представления: вывести информацию об игроках клуба с номерами с 11 по 22
с навыком атаки больше 70 баллов навыком скорости больше 70 баллов по возрастанию атакующих навыков. */

create view attack_and_speed as
select t_shirt_name1, injury1, attack1, speed1, club_number1
from tactics1
where attack1 > '70' and speed1 > '70'
order by attack1;

select *
from attack_and_speed;

/* 4). Создание скрипта представления: вывести информацию об игроках клуба с номерами с 23 по 47
и сгруппировать по национальной принадлежности игроков, выполнить сортировку по количеству
сыгранных матчей в обратном порядке. */

create view national_teams as
select number_ability_3, player_nation3, number_of_matches3
from info_player_3
group by player_nation3
order by number_of_matches3 desc;

select *
from national_teams;

-- Задание 8: хранимые процедуры (3 скрипта) / триггеры (2 скрипта):

-- Хранимые процедуры:

/* 1). Создание скрипта c хранимой процедурой, которая считает количество игроков клуба с номерами от 23 по 47. */

delimiter //

CREATE PROCEDURE cnt1 (OUT counts_players INT)
BEGIN
	SELECT COUNT(*) INTO counts_players FROM info_player_3;
end //

delimiter ;

CALL cnt1(@a);
SELECT @a;

/* 2). Создание скрипта c хранимой процедурой, которая считает суммарное количество сыгранных матчей игроков клуба
с номерами от 23 по 47. */

delimiter //

CREATE PROCEDURE sum1 (OUT sum_mathces INT)
BEGIN
	SELECT sum(number_of_matches3) into sum_matches FROM info_player_3;
end //

delimiter ;

CALL sum1(@b);
SELECT @b;

/* 3). Создание скрипта c хранимой процедурой, которая считает суммарное количество голов, которые забили игроки клуба
с номерами от 23 по 47. */

delimiter //

CREATE PROCEDURE sum2 (OUT sum_goals INT)
BEGIN
SELECT sum(number_of_goals3) into sum_goals FROM info_player_3;
end //

delimiter ;

CALL sum2(@c);
SELECT @c;

-- Триггеры:

/* Задание №1: Создайте таблицу transfers. Сегодня футбольный клуб приобрел двух игроков и даже отвел под них
футболки с номерами 32 и 33. Пусть при данных футбольных трансферах - при каждом создании записи в таблице
playercard3 (таблица с информацией об игроках с номерами 32 и 33, в которую будут занесены их данные) в
в таблицу transfers будут помещается время и дата создания записи (трансферов), также фамилия игрока. */

DROP TABLE IF EXISTS transfers;

create table transfers(
	created_at_0 DATETIME NOT NULL COMMENT 'Дата футбольного трансфера',
	name_transfer VARCHAR(25) NOT NULL COMMENT 'Фамилия игрока'
    );

DROP TRIGGER IF EXISTS club_transfers;

delimiter //
CREATE TRIGGER club_transfers AFTER INSERT ON playercard3
FOR EACH ROW
BEGIN
	INSERT INTO transfers(created_at_0, name_transfer)
	VALUES (NOW(), NEW.name_of_card3);
end //
delimiter ;

INSERT INTO playercard3(id_player3, name_of_card3, date_of_birth3, contract_term3, national_team3)
VALUES ('9', 'Ройс', '1989-05-31', '2', 'Национальная сборная Германии'),
       ('8', 'Бернардески', '1994-02-16', '4', 'Национальная сборная Италии');

select *
from transfers;

select *
from playercard3;

/* Задание №2: Создайте таблицу transfer_goal. Сегодня футбольный клуб приобрел игрока и присвоил ему номер 12.
Игрок молодец - сегодня он забил свой первый гол. Должны быть занесены данные об игроке под номером 12 в
таблицу playercard2 (таблица с информацией об игроках с номерами от 11 до 22, в которую будут занесены данные игрока).
При создании записи в таблицу transfer_goal будут помещается время и дата создания записи (гола),
также фамилия игрока, забившего гол. */

DROP TABLE IF EXISTS transfer_goal;

create table transfer_goal(
	created_at_1 DATETIME NOT NULL COMMENT 'Дата футбольного трансфера',
	name_transfer_goal VARCHAR(25) NOT NULL COMMENT 'Имя забившего игрока'
    );

DROP TRIGGER IF EXISTS player_transfer_goal;

delimiter //
CREATE TRIGGER player_transfer_goal AFTER INSERT ON playercard2
FOR EACH ROW
BEGIN
	INSERT INTO transfer_goal(created_at_1, name_transfer_goal)
	VALUES (NOW(), NEW.name_of_card2);
end //
delimiter ;

INSERT INTO playercard2(id_player2, name_of_card2, date_of_birth2, contract_term2, national_team2)
VALUES ('6', 'Влашич', '1997-10-04', '4', 'Национальная сборная Хорватии');

select *
from transfer_goal;

select *
from playercard2;