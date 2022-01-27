create database ilkhafta; -- yeni bir veri tabaný oluþturuyoruz.
use ilkhafta; -- veritabanýný kullanýyoruz.

create table ogrenci(   -- veritabanýmýza yeni bir tablo oluþturuyoruz.
        
		ogrencino int not null, -- boþ geçilemez þeklinde tanýmladýk.
		adsoyad varchar(30),
		telefon int,
		sinif int, 
		bolum varchar(20)		
		); 
create table personel( --yeni bir tablo oluþturuyoruz.
        sicilno int not null, -- boþ geçilemez
		adsoyad varchar(40) not null, --boþ geçilemez
		telefon int,
		departman varchar(20) not null,
		maas int not null);

---------------   NOT NULL , UNIQUE -> eþsiz, PRIMARY KEY : unique + not null -> örneðin tc olabilir. hem eþsiz hem boþ geçilemez.  --------------------

-- ALTER : Tabloda deðiþiklik.

alter table ogrenci add ortalama int; -- ortalama adýnda int tipinde yeni bir deðiþken ekledik (sütun)

alter table ogrenci modify bolum varchar(40); -- hata veriyor ama hoca böyle yazmýþ. --> varchar(20)'den 40'a yükseltmek için kullanmýþtýk. Deðiþiklik için

alter table ogrenci drop column ortalama;  -- ortalama sütununu sildik.

------- VERÝ SÝLME ÝÇÝN DELETE, SÜTUN SÝLMEK ÝÇÝN DROP.

alter table ogrenci add CONSTRAINT pk_ogrenci PRIMARY KEY(ogrencino);  -- Tabloya kýsýtlama ekledik. primary key yani bu deðerden tabloda sadece bir tane olabilir.
-- Kýsýt kaldýrma : DROP CONSTRAINT



------ Tabloya eleman ekleme ------

insert into ogrenci values(100, 'Hediye Orhan', 50761451, 3, 'Bilgisayar'); -- bu komut ile sýralý þekilde ekliyoruz.

insert into ogrenci(ogrencino, adsoyad, bolum, sinif) values(55, 'Elif ORHAN', 'Makine', 2); -- bu þekilde istediðimiz sýrada ekleme yapabiliriz. Her sütunu girmeyeceksek de bunu kullanýrýz.

--- TABLO GÖRÜNTÜLEME 
select * from ogrenci;
select ogrencino, adsoyad from ogrenci;

select * from ogrenci where sinif=3; -- selectin þartý -- where -- 

                     --  where ogrencino<110
					 -- where adsoyad like('%an') --> sonu an ile biten     ('Ha%an') -->  Ha ile baþlayan an ile biten 
					 -- where adsoyad<'Cano' --> sözlükte Cano ' dan önce gelenleri alýyor.


select distinct sinif from ogrenci; -- Sýnýflarý farklý olanlarý alýyor. Sadece sýnýflarý yazdýrýyor.

select distinct bolum from ogrenci; -- Bölümleri farklý olanlarý alýyor. Sadece bölümleri yazdýrýyor.


--- ÞART yapýlarýnda and  -  or yapýlarýný kullanabiliriz

select * from ogrenci where sinif in (3,4);   -- 3 ya da 4. sýnýfa gidenleri alýyor.


-- Telefon numarasý bulunan **null olmayan** öðrencilerin bölümleri
select bolum from ogrenci where telefon is not null;


select * from ogrenci where bolum='Bilgisayar'  order by sinif;  -- ORDER BY ile  sýralý halde gelmesini istediðimiz sütunu yazýyoruz.
-- ORDER BY : Tabloyu sýralayarak getirir.


select * from ogrenci where bolum='Bilgisayar'  order by adsoyad, ogrencino; --Ayný ad olanlarý kendi içinde de no'ya göre sýralar.

select * from ogrenci where bolum='Bilgisayar'  order by adsoyad desc, ogrencino desc;
-- DESC : Artarak gidiyor.  --  ASC : Azalan sýra, Azalarak sýralanýyor.


-- ************* DERS NOTLARI ************* 



 -- varchar(30) :  isim gibi deðiþkenlerde,    char(11) : tc gibi deðiþkenlerde

 alter table ogrenci add dtarihi varchar(10);

 alter table ogrenci alter column dtarihi DATE;  -- sütunun veri tipini deðiþtirdik . Kayýtlý sütun üzerinde deðiþiklik yaptýk..

 alter table ogrenci alter column adsoyad NVARCHAR(50); -- NVARCHAR'da unique desteði bulunmaktadýr.


 -------------------------------------------------------------------------
 select * from ogrenci;
 -- Ýki sorgu arasýndaki fark tek tek yazýldýðýnda daha hýzlý çalýþmasý. * þeklinde yazýldýðýnda sorgu daha yavaþ çalýþýr.
 select ogrencino, adsoyad, telefon, sinif, bolum, dtarihi from ogrenci;
  -------------------------------------------------------------------------


insert into ogrenci values(3, 'Veli KAYA', 0562346, 3, 'bilgisayar', '1999'),
                            (35, 'Ahmet AY', 054656, 2, 'elektrik', '1995');

insert into ogrenci values(785, 'Selin KAYA', 0578546, 3, 'mekatronik', '1999-05-15');
insert into ogrenci values(7875, 'Selim SERT', 0578546, 1, 'mekatronik', '2000-08-25');



-- otomatik id arttýrma 

create table dersler
(
id int primary key identity(1, 1),  --  (kaç ile baþlasýn, kaçar artsýn)
dersadi varchar(20));



-- GO GO KULLANIMI : Ayný sorguyu döngü þeklinde defalarca çalýþtýrmayý saðlar. Ýki GO olmak zorunda ve GO komutu satýrda tek baþýna bulunmalý

GO
insert into dersler values('Matematik');
GO 5 -- bu döngü 5 defa dönüyor.

select * from dersler;


update dersler set dersadi = 'Türkçe'; -- Matematik þeklinde olan ders adlarýný türkçe yaptýk. update


delete top(2) from dersler; -- tablonun en üzerinde bulunan iki kaydý sil

delete from dersler; -- tablodaki tüm verileri siler. TABLO KALIYOR VERÝLER SÝLÝNÝYOR.

drop table dersler; -- Dersler tablosunu komple siliyor. Tabloyu sildik.

------ DELETE : Verileri siler, DROP : Tabloyu siler.


TRUNCATE table dersler; -- Varolan tablodaki tüm verileri siler komple. --> id  0'dan baþlatýyor.


 


