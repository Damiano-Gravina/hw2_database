create database string;
use string;

CREATE TABLE USERS(
	Id integer primary key auto_increment,
	Username VARCHAR(50) unique,
	Email VARCHAR(255),
	Nome VARCHAR(20),
	Cognome VARCHAR(20),
	Nposts integer default 0,
	Nfavourites integer default 0,
	VisualizeEmail BOOLEAN default true,
	Negozio BOOLEAN DEFAULT false,
	Password VARCHAR(50)
)Engine = InnoDB;

CREATE TABLE POSTS (
    Id integer primary key auto_increment,
    User integer not null,
    Title VARCHAR(75),
	Text VARCHAR(500),
	Ncomments integer default 0,
	Time timestamp not null default current_timestamp,
    foreign key(User) references USERS(Id) on delete cascade on update cascade
) Engine = InnoDB;

CREATE TABLE FAVOURITES(
	Id integer primary key auto_increment,
	User integer not null,
	Post integer not null,
	UNIQUE(User,Post),
	foreign key(User) references USERS(Id) on delete cascade on update cascade
) Engine = InnoDB;

CREATE TABLE COMMENTS(
	Id integer primary key auto_increment,
	User integer not null,
	Post integer not null,
	Time timestamp not null default current_timestamp,
	Text varchar(255),
	foreign key(User) references USERS(Id) on delete cascade on update cascade
)Engine = InnoDB;

CREATE TABLE PLAYLISTS(
	Id integer primary key auto_increment,
	Name VARCHAR(50) unique,
	PlaylistURL VARCHAR(255)
)Engine = InnoDB;

CREATE TABLE SHOPS(
	Id integer primary key auto_increment,
	User integer not null,
	OrariApertura VARCHAR(255),
	SedeNegozio VARCHAR(255),
	foreign key(User) references USERS(Id) on delete cascade on update cascade
)Engine = InnoDB;


DELIMITER //
CREATE TRIGGER post_trigger_add
AFTER INSERT ON POSTS
FOR EACH ROW
BEGIN
UPDATE USERS 
SET Nposts = Nposts + 1
WHERE id = new.User;          
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER posts_trigger_remove
AFTER DELETE ON POSTS
FOR EACH ROW
BEGIN
UPDATE USERS
SET Nposts = Nposts - 1
WHERE Id = old.User;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER favourite_trigger_add
AFTER INSERT ON FAVOURITES
FOR EACH ROW
BEGIN
UPDATE USERS
SET Nfavourites = Nfavourites + 1
WHERE Id = new.User;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER favourite_trigger_remove
AFTER DELETE ON FAVOURITES
FOR EACH ROW
BEGIN
UPDATE USERS
SET Nfavourites = Nfavourites - 1
WHERE Id = old.User;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER comments_trigger_add
AFTER INSERT ON COMMENTS
FOR EACH ROW
BEGIN
UPDATE POSTS 
SET Ncomments = Ncomments + 1
WHERE Id = new.Post;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER comments_trigger_remove
AFTER DELETE ON COMMENTS
FOR EACH ROW
BEGIN
UPDATE POSTS 
SET Ncomments = Ncomments -1 
WHERE Id = old.Post;
END //
DELIMITER ;






INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Blues','https://www.youtube.com/watch?v=UP2XoGfhJ1Y');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Rock','https://www.youtube.com/watch?v=tAGnKpE4NCI&list=PLZN_exA7d4RVmCQrG5VlWIjMOkMFZVVOc');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Hard Rock','https://www.youtube.com/watch?v=WxnN05vOuSM&list=PLw6p6PA8M2miu0w4K1g6vQ1BHUBeyM4_-');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Metal','https://www.youtube.com/watch?v=xnKhsTXoKCI&list=PLhQCJTkrHOwSX8LUnIMgaTq3chP1tiTut');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Indie','https://www.youtube.com/watch?v=BrRBWU-EfTA');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Pop','https://www.youtube.com/watch?v=OPf0YbXqDm0&list=PLMC9KNkIncKtPzgY-5rmhvj7fax8fdxoj');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Lo-fi','https://www.youtube.com/watch?v=AZals4U6Z_I');
INSERT INTO `playlists`(`Name`, `PlaylistURL`) VALUES ('Hit-Italiane','https://www.youtube.com/playlist?list=PLGl0_ap7UnS8IL7XhVcJEkN5qWJeou65k');



INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`) VALUES ('DamianoGr','damiano00@gmail.com','Damiano','Gravina','Damiano00');

INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`, `VisualizeEmail`) VALUES ('AlessiaGr','alessia00@gmail.com','Alessia','Grasso','Alessia00', '0');

INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`) VALUES ('Chia.Sca','chiara00@gmail.com','Chiara','Scandurra','Chiara00');

INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`, `VisualizeEmail`) VALUES ('MarcoMu','marco00@gmail.com','Marco','Musumeci','Marco00', '0');

INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`, `Negozio`) VALUES ('Music&Co.','music&company@gmail.com','M','C','Music&Co00', '1');

INSERT INTO `users`(`Username`, `Email`, `Nome`, `Cognome`, `Password`, `Negozio`) VALUES ('StrumentiMusilcali','strumentiMusicali@gmail.com','S','M','Strumenti00', '1');

INSERT INTO `shops`( `User`, `OrariApertura`, `SedeNegozio`) VALUES ('5','Dal lunedì al venerdì dalle 10:00 alle 20:00. Sabato dalle 15:00 alle 18:00.', 'Fiumefreddo , Via Marina 18.');

INSERT INTO `shops`( `User`, `OrariApertura`, `SedeNegozio`) VALUES ('6','Dal lunedì al venerdì dalle 9:00 alle 18:00.', 'Gravina di Catania, Via Bianchi 45.');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('3','Vendo Sassofono','Sassofono acquistato un anno fa, praticamente nuovo, era un regalo per mio cugino ma non è stato apprezzato');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('2','Compro Basso elettrico','Vorrei acquistare un basso elettrico economico per iniziare a suonare.');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('1','Vendo chitarra elettrica','Vendo riproduzione di Gibson Les Paul del 1975.');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('1','Vendo batteria','Kit batteria di base, grancassa, tampuri principali e piatti. Attrezzatura è in ottime condizioni, contattatemi per ulteriori informazioni');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('5','Vendita basso','Vendita basso Yamaha. Azienda Music&Co Gravina di Catania, Via Bianchi 45.');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('5','Vendita flauto Traverso','Flauto traverso Yamaha ottimo per novizi che vogliono inziare a suoonare. Azienda Music&Co Gravina di Catania, Via Bianchi 45.');

INSERT INTO `posts`(`User`, `Title`, `Text`) VALUES ('6','Asta strumenti',"Stiamo programmando un'asta di strumenti musicali dagli anni 60 agli 80, non potete perderla. Chitarre, Bassi, Strumenti a fiato e molto altro. L'asta si terrà il 15/09/2022 alle ore 18:00 presso il nostro negozio. StrumentiMusicali Fiumefreddo , Via Marina 18.");

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('1','1','Salve, sarei interessato ad acquistare un sassofono, potrebbe dirmi la marca dello strumento? ');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('3','1','Il sassofono è della Yamaha.');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('1','1','Allora la contatto per email per ulteriori informazioni, grazie.');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('1','7','Parteciperò sicuramente!');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('3','7','Saranno presenti anche degli articoli appartenuti ad artisti famosi? ');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('6','7','Certamente, articoli appartenuti ad artisti di prestigio e strumenti di alto valore. ');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('4','6','Sono interessato al flauto traverso, a che ora potrei venire a vederlo in negozio? ');

INSERT INTO `comments`(`User`, `Post`, `Text`) VALUES ('5','6','Siamo aperti tutti i giorni dal lunedì al venerdì dalle ore 9:00 alle 20:00 orario continuato, la aspettiamo presto. ');