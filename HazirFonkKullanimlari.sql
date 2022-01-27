use VTDERS21EKIM

-- AS komutu k�saltmalar i�in takma ad gibi kullan�l�r.

-- ROUND : Yuvarlama yap�yor.
-- CEILING : S�rekli �st de�ere yuvarlar.Tam say� k�sm�n�n �st�ne.
-- FLOOR : A�a�� yuvarlar.

select ROUND(5,576,1) as ROUND1,
	   ROUND(5,576,2) as ROUND1,
       CEILING(5.576) as CEILING1,
       FLOOR(5.576) as FLOOR1;

select count(MAAS) as COUNTMAAS from personel; -- Ka� tane maa� de�eri oldu�unu yaz�yor.

select count(*) as COUNTMAAS from personel; --  Toplam sat�r say�s� ka� tane ise onu getirir. bo� sat�rlar� getirmez AMA null de�erleri de sayar.

select count(maas) as maassayisi from personel where ulke='ABD'; -- �lkesi abd olan ka� ki�inin maa�� var?
select count(distinct ULKE) as ULKESAYISI from personel; -- Ka� tane farkl� �lke oldu�unu yaz�yor.

select max(yas) as enyasli, min(yas) as engenc from personel; -- En gen� ve en ya�l� ki�ilerin ya��.

-- En gen� ve en ya�l� ki�ilerin ya��n� ve ismini yazd�rmak istersek : 
select isim, yas as enyasli from personel where yas = (select max(yas) from personel); -- Bu �ekilde yazd�r�yoruz.
select isim, yas as engenc from personel where yas = (select min(yas) from personel);

-- SUM : S�tundaki de�erleri toplar.
select sum(maas) as toplamMaas from personel;

-- AVG  : Ortalama hesaplar.
-- GROUP BY : Sonu� k�mesini elde ettikten sonra bir veya birden fazla s�tuna g�re grupland�rma yapmam�z� sa�lar.

select ulke from personel group by ulke; --ulkelere g�re s�n�fland�rma yapt�k. -- Datay� en son tekrar etti�i noktada tabloya yerle�tiriyor. 
-- T�rkiye son s�rada oldu�u i�in en son tabloda en sona att�.

select AVG(maas) as UlkelereGoreOrtalamaMaas from personel group by ulke; -- �lkelere g�re ortalama maas

-- �lke ismini de ekleme 
select ulke, AVG(maas) as UlkelereGoreOrtalamaMaas from personel group by ulke;

--Cinsiyete g�re ortalama maas

select cinsiyet, AVG(maas) as CinsiyeteGoreOrtalamaMaas from personel group by cinsiyet;

-- Group by ile birden fazla alan kullan�m�

select ulke, kent from personel group by ulke, kent; -- �nce �lke, sonra kent alan�na g�re gruplama yapt�k.

-- Her bir gruba ait ka� �al��an oldu�unu g�rmek i�in :  COUNT
select count(*) as CalisanSayisi, ulke, kent from personel group by ulke, kent;

select count(*) as CalisanSayisi, kent, ulke from personel group by kent, ulke; -- Hangi s�ralamay� yazd���m�z �nemli !!


select ulke, cinsiyet, AVG(yas), COUNT(*) from personel group by ulke, cinsiyet;

-- Yukar�daki sorguya maas� 2000'den b�y�k olanlar� getirmek istersek

select ulke, cinsiyet, AVG(yas), COUNT(*) from personel where maas > 20000 group by ulke, cinsiyet; -- Maa�� 2000'den b�y�k olan veriler i�in gruplama ,i�lemi ger�ekle�ecek.


-- HAVING :  where ifadesine �ok benziyor. Ancak k�meleme fonksiyonlar� ile where ifadesi kullan�lamad���ndan HAVING ifadesine ihtiya� vard�r.

select kent, count(*) from personel group by kent having count(*) = 1; -- 1 tane olan kentleri getir

-- Maa� ortalamas� 3000'den fazla olan �lkelerdeki erkek personellerin maa� ortalamas�.

select AVG(maas) as OrtalamaMaas, ulke, cinsiyet from personel group by ulke, cinsiyet having cinsiyet='E' and AVG(maas)>3000; -- Having ile �art belirtiyoruz.

select AVG(maas) as OrtalamaMaas, ulke, cinsiyet from personel where cinsiyet='E' group by ulke, cinsiyet having AVG(maas)>3000; -- Ayn� ��kt�y� veriyor.Hoca b�yle yazd�.

-- Maa�� 2000' e e�it olan veya fazla olan personelleri �lkelerine g�re  gruplayan ve grubun ya� ortalamas� 25  ya��na e�it olan veya daha b�y�kse 
-- bu gruplar�n �lke, ortalama ya�, ortalama maa� ve ki�i say�s� bilgilerini getiren sorguyu yaz�n�z.

-- ***** Personellerin dedi�i i�in bireysel bak�yoruyz ve where kullan�l�y�r. ** �lkeler deseydi genel olaca�� i�in having kullanmam�z gerekirdi.

select count(*) as KisiSayisi, ulke, AVG(yas) as OrtalamaYas, AVG(maas) as OrtalamaMaas from personel where maas>=2000  group by ulke having AVG(yas)>=25;

-- �lke, ortalama i�in having , personel i�in bireysel oldu�u i�in where.. 


-- Personelleri �lkelerine g�re gruplayarak ortalama maa�� en b�y�k olan �lkenin maa� ortalamas�n� getiren sorguyu yaz�n�z.

select top(1) ulke, avg(maas) as OrtalamaMaas from personel group by ulke order by avg(maas) desc; -- 1.YOL

-- 2. YOL
select max(OrtalamaMaas) as MaxOrtalamaMaas from (select ulke, AVG(maas) as OrtalamaMaas from personel group by ulke) as MAAS;
-- as maas yazmam�z�n nedeni ara sorguya takma bir ad verme zorunlulu�u


-- VIEW : Sanal tablo k�sm�.