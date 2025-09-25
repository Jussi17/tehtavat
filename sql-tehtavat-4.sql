-- 1. Luo taulu Tuoteryhmä, jossa on sarakkeet: (vastauksena luontilause)
   -- a. trtunnus, pääavain, automaattisesti generoitava
create table Tuoteryhmä (trtunnus integer auto_increment primary key);

   -- b. ryhmanimi, merkkitietoa, pituus maksimissaan 40 merkkiä, pakollinen
alter table Tuoteryhmä add column ryhmanimi varchar(40) not null;

   -- c. kuvaus, merkkitietoa, pituus maksimissaan 40 merkkiä
alter table Tuoteryhmä add column kuvaus varchar(40);

-- 2. Luo taulu Tuote, jossa on sarakkeet: (vastauksena luontilause)
   -- a. tuotenro, pääavain, automaattisesti generoitava
create table Tuote (tuotenro integer auto_increment primary key);

   -- b. tuotenimi, merkkitietoa, pituus maksimissaan 40 merkkiä
alter table Tuote add column tuotenimi varchar(40);

   -- c. kplhinta, desimaaliluku johon voi syöttää hinnan kahden desimaalin tarkkuudella
alter table Tuote add column kplhinta numeric(7,2);

   -- d. luontipvm, kenttä johon voi syöttää päivämäärän jolloin tuote otettiin valikoimiin,
   -- oletusarvona koneen kellosta katsottu syöttöpäivä
alter table Tuote add column luontipvm date default (current_date);

   -- e. ryhmatunnus, vierasavain joka viittaa Tuoteryhmä-taulun pääavaimeen
alter table Tuote  add column ryhmatunnus integer;
alter table Tuote  add constraint fk_tuote_ryhma
foreign key (ryhmatunnus) references Tuoteryhmä(trtunnus);

-- 3. Tee lisäyslause, jolla lisäät kaksi riviä tietoa Tuoteryhmä-tauluun. Keksi itse syötettävät tiedot.
insert into Tuoteryhmä (ryhmanimi, kuvaus) values
('Ruoka', 'Vihannekset'), ('Elektroniikka', 'Pelikonsolit');

-- 4. Tee lisäyslause, jolla lisäät kaksi riviä tietoa Tuote-tauluun. Keksi itse syötettävät tiedot.
insert into Tuote (tuotenimi, kplhinta, ryhmatunnus) values
('Porkkana', 1.28, 1), ('TV', 299.99, 2);

-- 5. Tee näkymä Tuoteraportti, joka hakee molemmista em. tauluista liitoskyselyllä ryhmanimi-, tuotenimi-
-- , kplhinta- ja luontipvm-kentät.
create view Tuoteraportti as select 
tr.ryhmanimi, t.tuotenimi, t.kplhinta, t.luontipvm from Tuote t
join Tuoteryhmä tr on t.ryhmatunnus = tr.trtunnus;

-- 6. Tee Tuoteraportti-näkymään kysely, joka hakee kaikkien tuoteryhmien kaikki tuotteet lajiteltuna
-- ryhmänimen ja tuotenimen mukaan.
select * from Tuoteraportti order by ryhmanimi, tuotenimi;

-- 7. Tee päivityslause, jolla korotat ensimmäisen tuotteen kplhintaa kaksinkertaiseksi (ensimmäisen
-- tuotteen voit hakea valintasi mukaan tuotenumerolla tai tuotenimellä)
update Tuote set kplhinta = kplhinta * 2 where tuotenro = 1;

-- 8. Tee poistolause, joka poistaa kaikki tuotteet joiden luontipvm on tämä päivä
SET SQL_SAFE_UPDATES = 0;
delete from Tuote where luontipvm = curdate();
SET SQL_SAFE_UPDATES = 1;

