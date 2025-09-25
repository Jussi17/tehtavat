-- 1. Tee union-kysely tauluun proj_henk. Se näyttää minkä verran henkilöllä
-- on projektille ylitystä tai alitusta toteutuneissa tunneissa verrattuna
-- suunniteltuihin tunteihin. Jos ne ovat samoja, niin näytetään ko. tieto
-- ruksina ok-sarakkeessa. Järjestä projektitunnuksen ja henkilötunnuksen
-- mukaan.
select ptun, htun, 'x' as ok, ' ' as ylitys from proj_henk
where tunnit = tunnit_suun
union
select ptun, htun, ' ' as ok, (tunnit - tunnit_suun) as ylitys from proj_henk
where tunnit != tunnit_suun
order by ptun, htun;

-- 2. Hae liitoskyselyllä projektien nimet, niiden henkilöt (nimellä) ja
-- kunkin henkilön tunnit per projekti (ei siis summia). Lajittele projektin
-- nimen ja henkilön sukunimen mukaan.
select p.pnimi, h.snimi, h.enimi, ph.tunnit from projekti p
join proj_henk ph on p.ptun = ph.ptun
join henkilo h on ph.htun = h.htun
order by p.pnimi, h.snimi;

-- 3. Hae liitoskyselyllä tamperelaisten henkilöiden nimet ja heidän
-- osastojensa nimet
select h.snimi, h.enimi, o.osnimi from henkilo h
join osasto o on h.ostun = o.ostun
where h.kunta = 'TAMPERE';

-- 4. Projekteihin tarvitaan työntekijöitä ja niitä haetaan ensisijaisesti
-- projektin sijaintikunnan asukkaista. Hae liitoskyselyllä projektin
-- tunnus,nimi ja sijainti sekä niiden henkilöiden nimet ja kunta joiden
-- kunta on sama kuin projektin sijaintikunta. Ota mukaan myös ne henkilöt
-- joiden kuntaa ei vastaa yksikään projektin sijainti. Käytä
-- ulkoliitoskyselyä.
select p.ptun, p.pnimi, p.sijainti, h.snimi, h.enimi, h.kunta 
from projekti p left join henkilo h on p.sijainti = h.kunta
union
select NULL as ptun, NULL as pnimi, NULL as sijainti, h.snimi, h.enimi, h.kunta from henkilo h
where h.kunta not in (select distinct sijainti from projekti where sijainti is not null)
order by 1, 4;

-- 5. Hae liitoskyselyllä ne henkilöt, joilla on sama kunta kuin Laura Rannalla.
select h.snimi, h.enimi, h.kunta from henkilo h
join henkilo lr on h.kunta = lr.kunta
where lr.snimi = 'Ranta' and lr.enimi = 'Laura';

-- 6. Hae liitoskyselyllä turkulaisten henkilöiden tunnit (ko. henkilön
-- kaikkien projektien tunnit summataan).
select h.snimi, h.enimi, sum(ph.tunnit) as 'Henkilön kaikki tunnit' from henkilo h
join proj_henk ph on h.htun = ph.htun
where h.kunta = 'TURKU' group by h.snimi, h.enimi;

-- 7. Hae alikyselyllä turkulaisten henkilöiden tunnit eri projekteille.
select ptun, htun, tunnit from proj_henk
where htun in
(select htun from henkilo where kunta = 'TURKU');

-- 8. Hae alikyselyllä Tietohallinto-osaston työntekijät.
select snimi, enimi, ostun from henkilo
where ostun in
(select ostun from osasto where osnimi = 'Tietohallinto');

-- 9. Hae alikyselyllä niiden henkilöiden nimet, joiden projekteissa ainakin
-- yhden sijainti on HELSINKI
select snimi, enimi from henkilo
where htun in (select htun from proj_henk 
    where ptun in (select ptun from projekti where sijainti = 'HELSINKI'));

-- 10. Hae alikyselyllä ne henkilöt, jotka ovat tehneet vähiten tunteja
-- kussakin projektissa.
select ptun, htun, tunnit from proj_henk ph1
where tunnit = (select min(ph2.tunnit) from proj_henk ph2 where ph2.ptun = ph1.ptun);

-- 11. Hae alikyselyllä ne henkilöt, jotka työskentelevät osastolla, jonka
-- koodin pituus merkkeinä on enintään 2. Käytä EXISTS-alikyselyä. Vinkki:
-- pituus merkkeinä saadaan funktiolla char_length().
select snimi, enimi, ostun from henkilo h
where exists (select 1 from osasto o where h.ostun = o.ostun and char_length(o.koodi) <= 2);