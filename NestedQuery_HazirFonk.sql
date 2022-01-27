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

select ulke, kent , count(per_no) as PersonelSayisi from personel group by ulke, kent order by count(per_no) desc; -- �nce �lkeye g�re, sonra kente g�re grupland�rma yapt�k.

select ulke, sum(maas) ToplamMaas, count(maas) KacKisiyeOdedikleri from personel where cinsiyet = 'K' group by ulke;
select ulke, sum(maas) ToplamMaas, count(maas) KacKisiyeOdedikleri from personel where cinsiyet = 'E' group by ulke;

update personel set kent='�stanbul' where per_no=116; -- �al��t�rmad�m veritaban�n� bozmamak  i�in
update personel set CINSIYET'E', maas=15000 where per_no=116;

select ulke, cinsiyet, count(*) KisiSayisi from personel group by ulke, cinsiyet order by ulke, cinsiyet;
------------  KARI�TIRMA !! -----------------
-- ALTER , UPDATE 
-- HAVING , WHERE 
-- DISTINCT , CONSTRAINT --> yaz�l�� �ekillerini kar��t�rma.
-- DELETE , DROP

--HAVING

select ulke, cinsiyet, count(*) KisiSayisi from personel group by ulke, cinsiyet having count(*)>=1 order by KisiSayisi;

select ulke, avg(maas) OrtalamaMaas from personel group by ulke having min(maas)>2000;

-- Maa�� 3000'den y�ksek olan personellerin �lke ve ortalama maa� bilgisine g�re grupland�r�lm�� sorgusunu yazal�m.

select ulke, avg(maas) OrtalamaMaas from personel where maas>3000 group by ulke order by avg(maas);

-- WHERE : Sorguyu filtreliyor. Sorgu sonucu kay�tlar� filtreliyor.
-- HAVING : Grupland�rma sonucu filtrelemeye yar�yor.


------------------------------------------------------- NESTED QUERY --------------------------------------------------------------------
-- min maa�� alan ki�inin bilgilerini getiren sorgu.
select * from personel where maas = (select min(maas) from personel);
select * from personel where maas < (select avg(maas) from personel); -- maa�� ort maa�tan k���k olanlar� getir.
select * from personel where maas > (select avg(maas) from personel); -- ort maa�tan fazla alan personellerin bilgileri.

select sum(maas)-(avg(maas)*count(*)) from personel; -- Fonksiyonlar� bu �ekilde de kullanabiliriz.
select * from personel;

select ulke from ulkeler where sehir in (select distinct sehir from personel); -- i� i�e select sorgusuna bir �rnek verdik..

-- Maa�� ort maa�tan y�ksek olan erkekler
select * from personel where cinsiyet='E' and maas > (select avg(maas) from personel); 

