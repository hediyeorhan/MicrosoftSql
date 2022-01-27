use VTDERS21EKIM

-- AS komutu kýsaltmalar için takma ad gibi kullanýlýr.

-- ROUND : Yuvarlama yapýyor.
-- CEILING : Sürekli üst deðere yuvarlar.Tam sayý kýsmýnýn üstüne.
-- FLOOR : Aþaðý yuvarlar.

select ROUND(5,576,1) as ROUND1,
	   ROUND(5,576,2) as ROUND1,
       CEILING(5.576) as CEILING1,
       FLOOR(5.576) as FLOOR1;

select count(MAAS) as COUNTMAAS from personel; -- Kaç tane maaþ deðeri olduðunu yazýyor.

select count(*) as COUNTMAAS from personel; --  Toplam satýr sayýsý kaç tane ise onu getirir. boþ satýrlarý getirmez AMA null deðerleri de sayar.

select count(maas) as maassayisi from personel where ulke='ABD'; -- Ülkesi abd olan kaç kiþinin maaþý var?
select count(distinct ULKE) as ULKESAYISI from personel; -- Kaç tane farklý ülke olduðunu yazýyor.

select max(yas) as enyasli, min(yas) as engenc from personel; -- En genç ve en yaþlý kiþilerin yaþý.

-- En genç ve en yaþlý kiþilerin yaþýný ve ismini yazdýrmak istersek : 
select isim, yas as enyasli from personel where yas = (select max(yas) from personel); -- Bu þekilde yazdýrýyoruz.
select isim, yas as engenc from personel where yas = (select min(yas) from personel);

-- SUM : Sütundaki deðerleri toplar.
select sum(maas) as toplamMaas from personel;

-- AVG  : Ortalama hesaplar.
-- GROUP BY : Sonuç kümesini elde ettikten sonra bir veya birden fazla sütuna göre gruplandýrma yapmamýzý saðlar.

select ulke from personel group by ulke; --ulkelere göre sýnýflandýrma yaptýk. -- Datayý en son tekrar ettiði noktada tabloya yerleþtiriyor. 
-- Türkiye son sýrada olduðu için en son tabloda en sona attý.

select AVG(maas) as UlkelereGoreOrtalamaMaas from personel group by ulke; -- Ülkelere göre ortalama maas

-- ülke ismini de ekleme 
select ulke, AVG(maas) as UlkelereGoreOrtalamaMaas from personel group by ulke;

--Cinsiyete göre ortalama maas

select cinsiyet, AVG(maas) as CinsiyeteGoreOrtalamaMaas from personel group by cinsiyet;

-- Group by ile birden fazla alan kullanýmý

select ulke, kent from personel group by ulke, kent; -- Önce ülke, sonra kent alanýna göre gruplama yaptýk.

-- Her bir gruba ait kaç çalýþan olduðunu görmek için :  COUNT
select count(*) as CalisanSayisi, ulke, kent from personel group by ulke, kent;

select count(*) as CalisanSayisi, kent, ulke from personel group by kent, ulke; -- Hangi sýralamayý yazdýðýmýz önemli !!


select ulke, cinsiyet, AVG(yas), COUNT(*) from personel group by ulke, cinsiyet;

-- Yukarýdaki sorguya maasý 2000'den büyük olanlarý getirmek istersek

select ulke, cinsiyet, AVG(yas), COUNT(*) from personel where maas > 20000 group by ulke, cinsiyet; -- Maaþý 2000'den büyük olan veriler için gruplama ,iþlemi gerçekleþecek.


-- HAVING :  where ifadesine çok benziyor. Ancak kümeleme fonksiyonlarý ile where ifadesi kullanýlamadýðýndan HAVING ifadesine ihtiyaç vardýr.

select kent, count(*) from personel group by kent having count(*) = 1; -- 1 tane olan kentleri getir

-- Maaþ ortalamasý 3000'den fazla olan ülkelerdeki erkek personellerin maaþ ortalamasý.

select AVG(maas) as OrtalamaMaas, ulke, cinsiyet from personel group by ulke, cinsiyet having cinsiyet='E' and AVG(maas)>3000; -- Having ile þart belirtiyoruz.

select AVG(maas) as OrtalamaMaas, ulke, cinsiyet from personel where cinsiyet='E' group by ulke, cinsiyet having AVG(maas)>3000; -- Ayný çýktýyý veriyor.Hoca böyle yazdý.

-- Maaþý 2000' e eþit olan veya fazla olan personelleri ülkelerine göre  gruplayan ve grubun yaþ ortalamasý 25  yaþýna eþit olan veya daha büyükse 
-- bu gruplarýn ülke, ortalama yaþ, ortalama maaþ ve kiþi sayýsý bilgilerini getiren sorguyu yazýnýz.

-- ***** Personellerin dediði için bireysel bakýyoruyz ve where kullanýlýyýr. ** Ülkeler deseydi genel olacaðý için having kullanmamýz gerekirdi.

select count(*) as KisiSayisi, ulke, AVG(yas) as OrtalamaYas, AVG(maas) as OrtalamaMaas from personel where maas>=2000  group by ulke having AVG(yas)>=25;

-- Ülke, ortalama için having , personel için bireysel olduðu için where.. 


-- Personelleri ülkelerine göre gruplayarak ortalama maaþý en büyük olan ülkenin maaþ ortalamasýný getiren sorguyu yazýnýz.

select top(1) ulke, avg(maas) as OrtalamaMaas from personel group by ulke order by avg(maas) desc; -- 1.YOL

-- 2. YOL
select max(OrtalamaMaas) as MaxOrtalamaMaas from (select ulke, AVG(maas) as OrtalamaMaas from personel group by ulke) as MAAS;
-- as maas yazmamýzýn nedeni ara sorguya takma bir ad verme zorunluluðu


-- VIEW : Sanal tablo kýsmý.