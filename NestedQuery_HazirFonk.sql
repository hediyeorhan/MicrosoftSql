-- MIN
-- MAX
-- SUM - TOPLAM
-- AVG - ORTALAMA
-- COUNT

use VTDERS21EKIM

select * from personel;

select avg(maas) OrtalamaMaas from personel;

select sum(yas) as ToplamYas from personel;

select max(yas) as MaxYas from personel;

select min(yas) as MinYas from personel;

select count(per_no) as PersonelNoSayisi from personel;

select count(distinct(maas)) as FarkliMaasSayisi from personel;

-- GROUP BY
select ulke from personel group by ulke order by ulke;

select yas from personel group by yas order by yas;

select ulke, kent , count(per_no) as PersonelSayisi from personel group by ulke, kent order by count(per_no) desc; -- önce ülkeye göre, sonra kente göre gruplandýrma yaptýk.

select ulke, sum(maas) ToplamMaas, count(maas) KacKisiyeOdedikleri from personel where cinsiyet = 'K' group by ulke;
select ulke, sum(maas) ToplamMaas, count(maas) KacKisiyeOdedikleri from personel where cinsiyet = 'E' group by ulke;

update personel set kent='Ýstanbul' where per_no=116; -- Çalýþtýrmadým veritabanýný bozmamak  için
update personel set CINSIYET'E', maas=15000 where per_no=116;

select ulke, cinsiyet, count(*) KisiSayisi from personel group by ulke, cinsiyet order by ulke, cinsiyet;
------------  KARIÞTIRMA !! -----------------
-- ALTER , UPDATE 
-- HAVING , WHERE 
-- DISTINCT , CONSTRAINT --> yazýlýþ þekillerini karýþtýrma.
-- DELETE , DROP

--HAVING

select ulke, cinsiyet, count(*) KisiSayisi from personel group by ulke, cinsiyet having count(*)>=1 order by KisiSayisi;

select ulke, avg(maas) OrtalamaMaas from personel group by ulke having min(maas)>2000;

-- Maaþý 3000'den yüksek olan personellerin ülke ve ortalama maaþ bilgisine göre gruplandýrýlmýþ sorgusunu yazalým.

select ulke, avg(maas) OrtalamaMaas from personel where maas>3000 group by ulke order by avg(maas);

-- WHERE : Sorguyu filtreliyor. Sorgu sonucu kayýtlarý filtreliyor.
-- HAVING : Gruplandýrma sonucu filtrelemeye yarýyor.


------------------------------------------------------- NESTED QUERY --------------------------------------------------------------------
-- min maaþý alan kiþinin bilgilerini getiren sorgu.
select * from personel where maas = (select min(maas) from personel);
select * from personel where maas < (select avg(maas) from personel); -- maaþý ort maaþtan küçük olanlarý getir.
select * from personel where maas > (select avg(maas) from personel); -- ort maaþtan fazla alan personellerin bilgileri.

select sum(maas)-(avg(maas)*count(*)) from personel; -- Fonksiyonlarý bu þekilde de kullanabiliriz.
select * from personel;

select ulke from ulkeler where sehir in (select distinct sehir from personel); -- iç içe select sorgusuna bir örnek verdik..

-- Maaþý ort maaþtan yüksek olan erkekler
select * from personel where cinsiyet='E' and maas > (select avg(maas) from personel); 

