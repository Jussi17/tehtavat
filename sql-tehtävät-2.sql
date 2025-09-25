-- SQL-tehtävät, osa 2
-- Vinkki: https://dev.mysql.com/doc/refman/8.4/en/functions.html

-- 1. Hae sukunimen perusteella aakkosjärjestyksessä viimeinen turkulainen,
-- kirjoita vastauksesi alle:
select * from henkilo where kunta = 'TURKU' order by snimi desc limit 1;

-- 2. Montako erilaista tutkintoa on henkilo-taulussa? Laita otsikoksi lkm.
-- kirjoita vastauksesi alle:
select count(distinct tutkinto) as lkm from henkilo;

-- 3. Mistä johtuu ero seuraavissa keskiarvoa laskevissa käskyjen tuloksissa?
-- select avg(tunnit_suun) from proj_henk;
-- select sum(tunnit_suun)/count(*) from proj_henk;
-- kirjoita vastauksesi alle:

-- count(*) laskee myös ne rivit, joissa arvo on NULL.

-- 4. Hae kaikki henkilöt, muodosta palkasta ja etunimestä yksi merkkijono
-- mallia 'Jukka 2.8k'. Ko. luku tarkoittaa Jukan palkkaa kiloeuroina
-- pyöristettynä yhteen desimaaliin. Lajittele palkan mukaan laskevasti,
-- kirjoita vastauksesi alle:
select enimi, concat(enimi, ' ', round(palkka/1000, 1), 'k') as palkkateksti from henkilo order by palkka desc;

-- 5. Tee haku, joka näyttää vuokra-auton lainaushetkeksi tämän päivän
-- haettuna koneen kellosta ja laskee automaattisesti palautusajan kahden
-- vuorokauden päähän.
-- kirjoita vastauksesi alle:
select curdate() as lainaushetki, adddate(curdate(), interval 2 day) as palautusaika;

-- 6. Tee sama haku kuin edellä, mutta tuloksena näytetään lainaus- sekä
-- palautusviikonpäivä suomeksi. Päivä haetaan koneen kellosta.
-- kirjoita vastauksesi alle:
set lc_time_names = 'fi_FI';
select date_format(curdate(), '%W') as lainauspaiva, 
       date_format(date_add(curdate(), interval 2 day), '%W') as palautuspaiva;

-- 7. Laske palkat yhteen kunnittain (hae kunta ja palkkasumma).
-- kirjoita vastauksesi alle:
select kunta, sum(palkka) as palkkasumma from henkilo group by kunta;

-- 8. Montako projektia on kussakin sijaintipaikassa? Hae sijainti ja
-- lukumäärä (otsikoksi lkm).
-- kirjoita vastauksesi alle:
select sijainti, count(*) as lkm from projekti group by sijainti;

-- 9. Laske henkilöiden verot palkan ja veroprosentin avulla. Sarakkeet
-- htun, snimi, enimi, palkka, veropros, vero. Lajittele lasketun veron
-- mukaan laskevaan järjestykseen.
-- kirjoita vastauksesi alle:
select htun, snimi, enimi, palkka, veropros, palkka * veropros / 100 as vero from henkilo order by vero desc;

-- 10. Mikä on minimi- ja maksimipalkan erotus ja montako prosenttia
-- maksimipalkka on suurempi kuin minimipalkka.
-- kirjoita vastauksesi alle:
select max(palkka) as maksimipalkka, min(palkka) as minimipalkka, 
       max(palkka) - min(palkka) as erotus,
       round(((max(palkka) - min(palkka)) / min(palkka)) * 100, 2) as prosenttia_suurempi 
from henkilo;

-- 11. Hae nimet ja palkat niistä henkilöistä, joiden palkka 10% korotettuna
-- olisi yli 3000.
-- kirjoita vastauksesi alle:
select enimi, snimi, palkka from henkilo where palkka * 1.1 > 3000;
