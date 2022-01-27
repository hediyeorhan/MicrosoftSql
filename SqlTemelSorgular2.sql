use VTDERS21EKIM -- �zerinde �al��aca��n veritaban�n� ekle.
select * from Kisiler

select ad, soyad from Kisiler

select distinct sehir from Kisiler -- farkl� �ehirleri ald�k.
select distinct cinsiyet from Uyeler
select * from Kisiler where sehir = 'Ankara' -- sql'de " kullan�lm�yor. Select sorgusuna where ile �art ekledik.
select * from yazarlar where DOGUM_YILI>1825 -- do�um y�l� 1825'den b�y�k olanlar� getir dedik.

select * from yazarlar
select * from yazarlar where OLUM_YILI<>1910 -- Null olanlar� sorguya dahil etmedi.
select * from yazarlar where isim > 'Ali'
select * from yazarlar where DOGUM_YILI>1825 and DOGUM_YILI<1943

select * from yazarlar where OLUM_YILI between 1850 and 1900
select * from uyeler where isim = 'Deniz' and cinsiyet = 'K'
select * from uyeler where isim = 'Deniz' or cinsiyet = 'K'

--  AND OR birlikte kullan�m�

select * from uyeler where cinsiyet = 'E' AND (soyisim='Ayd�n' OR soyisim='Zafer')

select * from personel where isim = 'Ahmet' and isim = 'Mehmet' -- Ad� Ahmet ve Mehmet olanlar ayn� zamanda ahmet ve mehmet olanlar.
-- Hem ahmet hem mehmet olanlar deseydi OR

select * from personel where (cinsiyet='E' and yas>30) OR (cinsiyet='K' and yas<25)

select * from personel where (yas>30 OR kent='Ankara') AND (maas > 2500 OR cinsiyet='K')

select isim, soyisim from uyeler order by isim -- A'dan Z'ye do�ru s�rala

select isim, soyisim from uyeler order by soyisim desc -- Z'den A'ya do�ru s�ralaar soyisimlerine g�re

select * from personel where cinsiyet = 'E' and ulke='T�rkiye' order by maas -- artan �ekilde s�ralad� erkek ve t�rkiyede olanlar�n maa�lar�n� artan �ekilde s�ralama.

-- TOP :  Sonu� k�mesinde en �stten ka� tanesini almak istedi�imizi belirten sorgu.
select top 2 * from uyeler -- Hangi s�tunlar� alaca��m�z� belirttik. En �stten 2 kayd�

-- LIKE : Do�rudan e�itlik aram�yorsak. �smi A ile ba�layanlar soyismi M ile ba�layanlar gibi opsiyonel sorgularda kullan�l�r.,
select  * from uyeler where soyisim like 'z%' --  soyadi z ile ba�layan uyeleri ald�k.
select * from uyeler where isim like '%t' -- adi t ile biten uyeleri ald�k.
select * from uyeler where soyisim like '%er%' -- i�inde er ge�en soyisimleri al.
select * from uyeler where soyisim not like '%er%' -- soyisminde er ge�meyen kay�tlar.
select * from uyeler where isim like 'M%m' 
select * from uyeler where UYE_ADI LIKE 'h_zafer' -- _ t�m karakterlere kar��l�k gelebilir.

-- LIKE '_a_' : 3 harfli olacak ama ortada a olacak demek oluyor.
 -- LIKE 'c[ai]n' : can ve cin kelimelerini kapsar.

 select * from uyeler where uye_adi like '^[EK]%' -- Ad� E ve K ile ba�lamayanlar.
 -- IN ��leci
 select * from personel where yas IN (22, 23, 25, 26) -- B�yle yazmasayd�k yas = .. OR �eklinde uzard�.

 -- BETWEEN : �ki de�er aral��� aras�ndaki ifadeleri sorgulamak istedi�imizzde. int ,varchar, char, date gibi de�i�kenlerde kullanabiliriz.
  select isim, soyisim, yas from personel where yas between 20 and 26

 -- AS : k�salt�lm�� �ekilde g�sterip kullanmam�z�  sa�l�yor s�tun adlar�n�.
select ISIM AS ad ,SOYISIM AS soyad from uyeler -- s�tun ba�l�klar�n� de�i�tirdik.

-- Table ad�na takma isim verme
SELECT u.isim, u.soyisim from uyeler u where u.cinsiyet='K' and u.isim='Derya'


