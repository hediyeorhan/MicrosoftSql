use VT_ALISVERIS3


select * from TblMusteriler
select * from TblUrunler
select * from TblUrunKategori
select * from TblAliverisKayit
select *  from TblMusteriAlisVerisTarihi

-- �rnek SORU : 1 : M��terinin isim, soyisim(Musteriler), �r�n_ad(Urunler), �r�n sat�� fiyat�(AlisverisKayit) bilgilerini getiren sorguyu yaz�n�z.
-- 3 tablodan sorgu �ekmeliyiz.
-- 3 tane tablo oldu�u i�in de�i�kenleri yazarken tablo ad� ile belirttik. Kar��mamas� i�in !!
-- Neden ilk TblAlisVerisKayit yazdik?

select TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblAliverisKayit.urun_fiyat from TblAliverisKayit
inner join TblMusteriler On TblAliverisKayit.musteri_id=TblMusteriler.id
inner join TblUrunler ON TblAliverisKayit.urun_id = TblUrunler.id

-- from TblAlisVerisKayit hepsiyle ba�lant�l� oldu�u i�in from'dan sonra yazd�k.
-- SORU 2 : Al��veris_id, m��teri isim, soyisim, �r�n_ad, �r�n sat�� fiyat� ve al��veri� tarihi bilgileirini getiren sorguyu yaz�n�z.

select TblAliverisKayit.musteri_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblAliverisKayit.urun_fiyat, TblMusteriAlisVerisTarihi.tarih
from TblAliverisKayit inner join TblMusteriler ON TblAliverisKayit.musteri_id=TblMusteriler.id
inner join TblUrunler ON TblAliverisKayit.urun_id = TblUrunler.id
inner join TblMusteriAlisVerisTarihi ON TblMusteriAlisVerisTarihi.id = TblAliverisKayit.alisveris_id

-- ID'si 2 olan m��terinin al��veri ge�mi�i


-- SORU 3 : T�m m��terilerin yapt��� al��veri� tutar�n� veren sorgu. Inner join'e gerek yok.
select *  from TblAliverisKayit

select sum(TblAlisverisKayit.urun_fiyat * TblAlisverisKayit.adet) as ToplamAlisVerisTutari from TblAliverisKayit


-- SORU 4 : Bir m��terinin yapt��� al��veri� tutar�n�n toplam�n� veren sql sorgusu.

select sum(TblAlisverisKAyit.urun_fiyat * TblAlisverisKayit.adet) as MusterininAlisverisToplami from TblAliverisKayit group by TblAliverisKayit.musteri_id


-- SORU 5 : Her bir m��terinin isim, soyisim bilgisi ve yapt��� al��veri� tutar�n�n toplam�n� veren sorguyu yaz�n�z.
select TblMusteriler.isim, TblMusteriler.soyisim, sum(TblAlisverisKayit.urun_fiyat * TblAlisverisKayit.adet) as MusterininAlisverisToplami
from TblAliverisKayit
inner join TblMusteriler ON TblAliverisKayit.musteri_id=TblMusteriler.id
group by TblMusteriler.isim, TblMusteriler.soyisim


-- SORU 6 : Al��veri� tutar�na g�re �oktan aza do�ru her m��terinin al��veri� bilgisini ekleme.
select TblMusteriler.isim, TblMusteriler.soyisim, sum(TblAlisverisKayit.urun_fiyat * TblAlisverisKayit.adet) as MusterininAlisverisToplami
from TblAliverisKayit
inner join TblMusteriler ON TblAliverisKayit.musteri_id=TblMusteriler.id
group by TblMusteriler.isim, TblMusteriler.soyisim order by MusterininAlisverisToplami desc

-- SORU 7 : En y�ksek al��veri�i yapam m��terinin ad, soyad ve toplam harcada�� fiyat bilgisini veren sorgu.
---------------- Birinci YOL
select top 1 TblMusteriler.isim, TblMusteriler.soyisim, sum(TblAlisverisKayit.urun_fiyat * TblAlisverisKayit.adet) as MusterininAlisverisToplami
from TblAliverisKayit
inner join TblMusteriler ON TblAliverisKayit.musteri_id=TblMusteriler.id
group by TblMusteriler.isim, TblMusteriler.soyisim order by MusterininAlisverisToplami desc

 --------------- Ikinci YOL
create view SONUC_TABLOSU as
begin
select TblMusteriler.isim, TblMusteriler.soyisim, sum(TblAlisverisKayit.urun_fiyat * TblAlisverisKayit.adet) as TOPLAM
from TblAliverisKayit
inner join TblMusteriler ON TblAliverisKayit.musteri_id=TblMusteriler.id
group by TblMusteriler.isim, TblMusteriler.soyisim
end

select * from SONUC_TABLOSU where TOPLAM = (select max(TOPLAM) from SONUC_TABLOSU)


-- Alisveris sitesi i�,n 3 ayr� tablo olu�turuldu. M��teri ve �r�n aras�nda �oka-�ok bir ili�ki vard�r. 
-- 3 ayr� tablo ile bu ili�kileri 1-N il�kilere indirgeyelim.

CREATE DATABASE VT_ALISVERIS3
USE VT_ALISVERIS3 -- VT_ALISVERIS isimli vt yi kullan  

CREATE TABLE TblMusteriler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
isim VARCHAR(30) NOT NULL,  
soyisim VARCHAR(30) NOT NULL,
mail VARCHAR(30) NOT NULL   
); 


CREATE TABLE TblUrunKategori(
id INT PRIMARY KEY IDENTITY(1,1),
kategori VARCHAR(50) NOT NULL
);

CREATE TABLE TblUrunler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
ad VARCHAR(50) NOT NULL,  
fiyat FLOAT NOT NULL,
barkod VARCHAR(30) NOT NULL,
urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)   
); 

CREATE TABLE TblMusteriAlisverisTarihi(
id INT PRIMARY KEY IDENTITY(1,1), 
tarih datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TblAlisverisKayit
(  
alisveris_id INT FOREIGN KEY REFERENCES  TblMusteriAlisverisTarihi(id), 
musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
urun_fiyat FLOAT NOT NULL,  
adet INT NOT NULL
); 


--------------------------------------------------------Tablolara veri ekleme------------------------------------------------------
 INSERT INTO TblMusteriler VALUES ('Ali','KAYA', 'ak@com.tr'),
								  ('Hasan','ALAN', 'ha@com.tr'),
								  ('Ay�e','Bilir', 'ab@com.tr')		

					
INSERT INTO TblUrunKategori VALUES 
('GIDA'), ('�ARK�TER�'),('��KOLATA'),('B�SK�V�'),('UNLU MAM�LLER'),('TEM�ZL�K �R�NLER�')
 

INSERT INTO TblUrunler VALUES ('Peynir',15.00, '100', 2),
							  ('Yumurta',23.50, '101', 1),
							  ('�ay', 19.50, '102', 1),
							  ('Halley', 1.5, '103', 4),
							  ('Negro', 2.5, '104', 4),
							  ('Deterjan', 35.55, '105', 6)

------------------------------------------------------------------------
---B�R�NC� M��TER� PEYN�R, YUMURTA, �AY ve Negroyu TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------
-- �ncelikle t�m m��teri ve �r�nleri g�relim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alan� varsay�lan olarak CURRENT_TIMESTAMP �zelli�ine sahip olsa hem id, hem tarih otomatik de�er ald���nda VALUES k�sm� bo� kal�r ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); �eklinde kay�t ger�ekle�tirildi.


--A�a��da @Fiyat de�i�kenine veritaban�ndan �ekilen �r�n fiyat� de�er olarak atanacakt�r. @Fiyat ile ilgili kodlar�n B�RL�KTE �al��t�r�lmas� gerekmektedir.
--1. PEYN�R SATIN ALMA
DECLARE @Fiyat Float   -- fiyat ad�nda bir de�i�ken tan�mland�. De�i�ken isimleri kesinlikle @ ile ba�lamal�d�r.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 2, @Fiyat ,5) 

--3. �ay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 3, @Fiyat ,4) 

--4. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 5, @Fiyat ,7) 													

------------------------------------------------------------------------
---B�R�NC� M��TER� PEYN�R, YUMURTA ve �AYI TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------


-- SELECT-WHERE �LE 4tablodan kay�t �ekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi
WHERE ((TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and (TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id)


-- SELECT-INNER JOIN �LE 4tablodan kay�t �ekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);





------------------------------------------------------------------------
---�K�NC� M��TER� PEYN�R, YUMURTA ve Deterjan� TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alan� varsay�lan olarak CURRENT_TIMESTAMP �zelli�ine sahip olsa hem id, hem tarih otomatik de�er ald���nda VALUES k�sm� bo� kal�r ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); �eklinde kay�t ger�ekle�tirildi.


--A�a��da @Fiyat de�i�kenine veritaban�ndan �ekilen �r�n fiyat� de�er olarak atanacakt�r. @Fiyat ile ilgili kodlar�n B�RL�KTE �al��t�r�lmas� gerekmektedir.
--1. PEYN�R SATIN ALMA
DECLARE @Fiyat Float   -- fiyat ad�nda bir de�i�ken tan�mland�. De�i�ken isimleri kesinlikle @ ile ba�lamal�d�r.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 2, @Fiyat ,5) 
													
--3. Deterjan SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 6);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 6, @Fiyat ,5)
------------------------------------------------------------------------
---�K�NC� M��TER� PEYN�R, YUMURTA ve �AYI TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------




------------------------------------------------------------------------
---���NC� M��TER� Halley, Yumurta ve Negroyu TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--A�a��da @Fiyat de�i�kenine veritaban�ndan �ekilen �r�n fiyat� de�er olarak atanacakt�r. @Fiyat ile ilgili kodlar�n B�RL�KTE �al��t�r�lmas� gerekmektedir.
--1. Halley SATIN ALMA
DECLARE @Fiyat Float   -- fiyat ad�nda bir de�i�ken tan�mland�. De�i�ken isimleri kesinlikle @ ile ba�lamal�d�r.
set  @Fiyat = (select fiyat from TblUrunler where id = 4);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 4, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 2, @Fiyat ,10) 
													
--3. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 5, @Fiyat ,8)
------------------------------------------------------------------------
---���NC� M��TER� PEYN�R, YUMURTA ve �AYI TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------





------------------------------------------------------------------------
---B�R�NC� M��TER� Deterjan, Yumurta ve �ay� TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------
-- �ncelikle t�m m��teri ve �r�nleri g�relim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--A�a��da @Fiyat de�i�kenine veritaban�ndan �ekilen �r�n fiyat� de�er olarak atanacakt�r. @Fiyat ile ilgili kodlar�n B�RL�KTE �al��t�r�lmas� gerekmektedir.
--1. Deterjan SATIN ALMA
DECLARE @Fiyat Float   -- fiyat ad�nda bir de�i�ken tan�mland�. De�i�ken isimleri kesinlikle @ ile ba�lamal�d�r.
set  @Fiyat = (select fiyat from TblUrunler where id = 6);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 6, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 2, @Fiyat ,7) 

--3. �ay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 3, @Fiyat ,4) 
------------------------------------------------------------------------
---B�R�NC� M��TER� Deterjan, Yumurta ve �ay� TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------



--PEYN�R F�YATI G�NCELLEND�
select * from TblUrunler
UPDATE TblUrunler SET fiyat = 17.25 where id = 1



------------------------------------------------------------------------
---�K�NC� M��TER� Peynir ve Halleyi TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------
-- �ncelikle t�m m��teri ve �r�nleri g�relim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--A�a��da @Fiyat de�i�kenine veritaban�ndan �ekilen �r�n fiyat� de�er olarak atanacakt�r. @Fiyat ile ilgili kodlar�n B�RL�KTE �al��t�r�lmas� gerekmektedir.
--1. Peynir SATIN ALMA
DECLARE @Fiyat Float   -- fiyat ad�nda bir de�i�ken tan�mland�. De�i�ken isimleri kesinlikle @ ile ba�lamal�d�r.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile de�er g�r�lebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 1, @Fiyat ,4) 


--2. Halley SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 4); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 4, @Fiyat ,7) 

------------------------------------------------------------------------
---�K�NC� M��TER� Peynir ve Halleyi TEK B�R ALI�VER��TE ALIRSA---
------------------------------------------------------------------------





-- SELECT-INNER JOIN �LE 4tablodan kay�t �ekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);




-- SELECT-WHERE �LE 5tablodan kay�t �ekme  (TblMusteriler, TblUrunler, TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi, TblUrunKategori
WHERE (
(TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and 
((TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id) and (TblUrunler.urun_kategori_id=TblUrunKategori.id))


-- SELECT-INNER JOIN �LE 5tablodan kay�t �ekme  (TblMusteriler, TblUrunler,  TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
);




------------------------------ GE�M�� ALI�VER��LERLE �LG�L� GENEL SORGULAR ----------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- id si 1 olan m��terinin al��veri� ge�mi�i
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblMusteriler.id = 1


-- id si 2 olan al��veri�in bilgileri
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = 2


-- En son yap�lan al��veri�e ait bilgileri getir
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YEN�F�YAT, TblAlisverisKayit.urun_fiyat ESK�F�YAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = (Select max(alisveris_id) from TblAlisverisKayit)




select * from TblAlisverisKayit

-- T�m al��veri�lerin toplam fiyat tutar�
SELECT sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit 

-- Her bir m��terinin �u ana kadar yapt��� al��veri�lerin toplam fiyat tutar�
SELECT TblAlisverisKayit.musteri_id, sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit group by TblAlisverisKayit.musteri_id


select * from TblAlisverisKayit