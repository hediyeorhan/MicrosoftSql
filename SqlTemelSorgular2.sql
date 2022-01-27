use VTDERS21EKIM -- üzerinde çalýþacaðýn veritabanýný ekle.
select * from Kisiler

select ad, soyad from Kisiler

select distinct sehir from Kisiler -- farklý þehirleri aldýk.
select distinct cinsiyet from Uyeler
select * from Kisiler where sehir = 'Ankara' -- sql'de " kullanýlmýyor. Select sorgusuna where ile þart ekledik.
select * from yazarlar where DOGUM_YILI>1825 -- doðum yýlý 1825'den büyük olanlarý getir dedik.

select * from yazarlar
select * from yazarlar where OLUM_YILI<>1910 -- Null olanlarý sorguya dahil etmedi.
select * from yazarlar where isim > 'Ali'
select * from yazarlar where DOGUM_YILI>1825 and DOGUM_YILI<1943

select * from yazarlar where OLUM_YILI between 1850 and 1900
select * from uyeler where isim = 'Deniz' and cinsiyet = 'K'
select * from uyeler where isim = 'Deniz' or cinsiyet = 'K'

--  AND OR birlikte kullanýmý

select * from uyeler where cinsiyet = 'E' AND (soyisim='Aydýn' OR soyisim='Zafer')

select * from personel where isim = 'Ahmet' and isim = 'Mehmet' -- Adý Ahmet ve Mehmet olanlar ayný zamanda ahmet ve mehmet olanlar.
-- Hem ahmet hem mehmet olanlar deseydi OR

select * from personel where (cinsiyet='E' and yas>30) OR (cinsiyet='K' and yas<25)

select * from personel where (yas>30 OR kent='Ankara') AND (maas > 2500 OR cinsiyet='K')

select isim, soyisim from uyeler order by isim -- A'dan Z'ye doðru sýrala

select isim, soyisim from uyeler order by soyisim desc -- Z'den A'ya doðru sýralaar soyisimlerine göre

select * from personel where cinsiyet = 'E' and ulke='Türkiye' order by maas -- artan þekilde sýraladý erkek ve türkiyede olanlarýn maaþlarýný artan þekilde sýralama.

-- TOP :  Sonuç kümesinde en üstten kaç tanesini almak istediðimizi belirten sorgu.
select top 2 * from uyeler -- Hangi sütunlarý alacaðýmýzý belirttik. En üstten 2 kaydý

-- LIKE : Doðrudan eþitlik aramýyorsak. Ýsmi A ile baþlayanlar soyismi M ile baþlayanlar gibi opsiyonel sorgularda kullanýlýr.,
select  * from uyeler where soyisim like 'z%' --  soyadi z ile baþlayan uyeleri aldýk.
select * from uyeler where isim like '%t' -- adi t ile biten uyeleri aldýk.
select * from uyeler where soyisim like '%er%' -- içinde er geçen soyisimleri al.
select * from uyeler where soyisim not like '%er%' -- soyisminde er geçmeyen kayýtlar.
select * from uyeler where isim like 'M%m' 
select * from uyeler where UYE_ADI LIKE 'h_zafer' -- _ tüm karakterlere karþýlýk gelebilir.

-- LIKE '_a_' : 3 harfli olacak ama ortada a olacak demek oluyor.
 -- LIKE 'c[ai]n' : can ve cin kelimelerini kapsar.

 select * from uyeler where uye_adi like '^[EK]%' -- Adý E ve K ile baþlamayanlar.
 -- IN Ýþleci
 select * from personel where yas IN (22, 23, 25, 26) -- Böyle yazmasaydýk yas = .. OR þeklinde uzardý.

 -- BETWEEN : Ýki deðer aralýðý arasýndaki ifadeleri sorgulamak istediðimizzde. int ,varchar, char, date gibi deðiþkenlerde kullanabiliriz.
  select isim, soyisim, yas from personel where yas between 20 and 26

 -- AS : kýsaltýlmýþ þekilde gösterip kullanmamýzý  saðlýyor sütun adlarýný.
select ISIM AS ad ,SOYISIM AS soyad from uyeler -- sütun baþlýklarýný deðiþtirdik.

-- Table adýna takma isim verme
SELECT u.isim, u.soyisim from uyeler u where u.cinsiyet='K' and u.isim='Derya'


