-- SQL-tehtävät, osa 1

-- 1. Hae kaikki projektit; kaikki sarakkeet.
-- kirjoita vastauksesi alle:
select * from projekti;

-- 2. Hae osastojen tunnukset ja nimet
-- kirjoita vastauksesi alle:
select ostun, osnimi from osasto;

-- 3. Tee haku joka näyttää missä eri sijaintipaikoissa on projekteja.
-- kirjoita vastauksesi alle:
select distinct sijainti from projekti;

-- 4. Hae henkilöiden etu- ja sukunimet, kunta ja palkka.
-- Palkka-sarakkeen nimeksi kkpalkka.
-- kirjoita vastauksesi alle:
select enimi, snimi, kunta, palkka as kkpalkka from henkilo;

-- 5. Lajittele edellinen tehtävä kunnan ja sukunimen mukaan
-- kirjoita vastauksesi alle:
select enimi, snimi, kunta, palkka as kkpalkka from henkilo order by kunta, snimi;

-- 6. Hae niiden henkilöiden nimet, joilla on tutkinto Yo
-- kirjoita vastauksesi alle:
select enimi, snimi from henkilo where tutkinto = 'Yo';

-- 7. Keillä henkilöillä on pienempi palkka kuin 2960?
-- sukunimi ja palkka ja lajittele aakkosjärjestykseen.
-- kirjoita vastauksesi alle:
select snimi, palkka from henkilo where palkka < 2960 order by snimi;

-- 8. Ota mukaan myös ne, joiden palkka on 2960.
-- Lajittele palkan mukaan laskevasti.
-- kirjoita vastauksesi alle:
select snimi, palkka from henkilo where palkka <= 2960 order by palkka desc;

-- 9. Hae osaston 3 (ostun=3) henkilöt, jotka ovat Turusta:
-- nimi, kunta ja ostun. Lajittele suku- ja etunimen mukaan.
-- kirjoita vastauksesi alle:
select enimi, snimi, kunta, ostun from henkilo where ostun = 3 and kunta = 'TURKU' order by snimi, enimi;

-- 10. Hae turkulaiset henkilöt sekä ne, joiden palkka on 2800.
-- Htun, sukunimi, etunimi, kunta, palkka
-- kirjoita vastauksesi alle:
select htun, snimi, enimi, kunta, palkka from henkilo where kunta = 'TURKU' or palkka = 2800;

-- 11. Hae kaikki sarakkeet henkilöistä, joiden palkka ei ole 2800
-- kirjoita vastauksesi alle:
select * from henkilo where palkka != 2800;

-- 12. Hae osaston 3 henkilöistä ne, jotka ovat tamperelaisia tai
-- joiden veroprosentti on 22
-- kirjoita vastauksesi alle:
select * from henkilo where ostun = 3 and (kunta = 'TAMPERE' OR veropros = 22);

-- 13. Hae tutkinnon Yo tai FK omaavista ne, joiden palkka on 3100 tai 2800
-- kirjoita vastauksesi alle:
select * from henkilo where (tutkinto = 'Yo' or tutkinto = 'FK') and (palkka = 3100 or palkka = 2800);

-- 14. Hae ne henkilöt, jotka ovat syntyneet (=pvm-sarake) 1994 jälkeen ja
-- eivät asu Turussa; sukunimi, kunta, palkka
-- kirjoita vastauksesi alle:
select snimi, kunta, palkka from henkilo where pvm > '1994-12-31' and kunta != 'TURKU';

-- 15. Hae ne henkilöt, joiden kunta alkaa T-kirjaimella.
-- kirjoita vastauksesi alle:
select * from henkilo where kunta like 'T%';

-- 16. Hae ne projektit, joiden nimessä esiintyy merkkijono LA.
-- kirjoita vastauksesi alle:
select * from projekti where pnimi like '%LA%';

-- 17. Hae henkilöt, joiden nimen toinen kirjain ei ole e.
-- kirjoita vastauksesi alle:
select * from henkilo where enimi not like '_e%';

-- 18. Hae henkilöt, joiden palkka on välillä 2000 - 3000. Käytä BETWEEN-operaattoria.
-- kirjoita vastauksesi alle:
select * from henkilo where palkka between 2000 and 3000;

-- 19. Hae ne henkilöt, joiden palkka on 2600, 2800 tai 3100. Käytä IN-operaattoria.
-- kirjoita vastauksesi alle:
select * from henkilo where palkka in (2600, 2800, 3100);

-- 20. Hae ne projektit, joilla ei ole sijaintipaikkaa.
-- kirjoita vastauksesi alle:
select * from projekti where sijainti is null;