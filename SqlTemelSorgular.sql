create database ilkhafta; -- yeni bir veri taban� olu�turuyoruz.
use ilkhafta; -- veritaban�n� kullan�yoruz.

create table ogrenci(   -- veritaban�m�za yeni bir tablo olu�turuyoruz.
        
		ogrencino int not null, -- bo� ge�ilemez �eklinde tan�mlad�k.
		adsoyad varchar(30),
		telefon int,
		sinif int, 
		bolum varchar(20)		
		); 
create table personel( --yeni bir tablo olu�turuyoruz.
        sicilno int not null, -- bo� ge�ilemez
		adsoyad varchar(40) not null, --bo� ge�ilemez
		telefon int,
		departman varchar(20) not null,
		maas int not null);

---------------   NOT NULL , UNIQUE -> e�siz, PRIMARY KEY : unique + not null -> �rne�in tc olabilir. hem e�siz hem bo� ge�ilemez.  --------------------

-- ALTER : Tabloda de�i�iklik.

alter table ogrenci add ortalama int; -- ortalama ad�nda int tipinde yeni bir de�i�ken ekledik (s�tun)

alter table ogrenci modify bolum varchar(40); -- hata veriyor ama hoca b�yle yazm��. --> varchar(20)'den 40'a y�kseltmek i�in kullanm��t�k. De�i�iklik i�in

alter table ogrenci drop column ortalama;  -- ortalama s�tununu sildik.

------- VER� S�LME ���N DELETE, S�TUN S�LMEK ���N DROP.

alter table ogrenci add CONSTRAINT pk_ogrenci PRIMARY KEY(ogrencino);  -- Tabloya k�s�tlama ekledik. primary key yani bu de�erden tabloda sadece bir tane olabilir.
-- K�s�t kald�rma : DROP CONSTRAINT



------ Tabloya eleman ekleme ------

insert into ogrenci values(100, 'Hediye Orhan', 50761451, 3, 'Bilgisayar'); -- bu komut ile s�ral� �ekilde ekliyoruz.

insert into ogrenci(ogrencino, adsoyad, bolum, sinif) values(55, 'Elif ORHAN', 'Makine', 2); -- bu �ekilde istedi�imiz s�rada ekleme yapabiliriz. Her s�tunu girmeyeceksek de bunu kullan�r�z.

--- TABLO G�R�NT�LEME 
select * from ogrenci;
select ogrencino, adsoyad from ogrenci;

select * from ogrenci where sinif=3; -- selectin �art� -- where -- 

                     --  where ogrencino<110
					 -- where adsoyad like('%an') --> sonu an ile biten     ('Ha%an') -->  Ha ile ba�layan an ile biten 
					 -- where adsoyad<'Cano' --> s�zl�kte Cano ' dan �nce gelenleri al�yor.


select distinct sinif from ogrenci; -- S�n�flar� farkl� olanlar� al�yor. Sadece s�n�flar� yazd�r�yor.

select distinct bolum from ogrenci; -- B�l�mleri farkl� olanlar� al�yor. Sadece b�l�mleri yazd�r�yor.


--- �ART yap�lar�nda and  -  or yap�lar�n� kullanabiliriz

select * from ogrenci where sinif in (3,4);   -- 3 ya da 4. s�n�fa gidenleri al�yor.


-- Telefon numaras� bulunan **null olmayan** ��rencilerin b�l�mleri
select bolum from ogrenci where telefon is not null;


select * from ogrenci where bolum='Bilgisayar'  order by sinif;  -- ORDER BY ile  s�ral� halde gelmesini istedi�imiz s�tunu yaz�yoruz.
-- ORDER BY : Tabloyu s�ralayarak getirir.


select * from ogrenci where bolum='Bilgisayar'  order by adsoyad, ogrencino; --Ayn� ad olanlar� kendi i�inde de no'ya g�re s�ralar.

select * from ogrenci where bolum='Bilgisayar'  order by adsoyad desc, ogrencino desc;
-- DESC : Artarak gidiyor.  --  ASC : Azalan s�ra, Azalarak s�ralan�yor.


-- ************* DERS NOTLARI ************* 



 -- varchar(30) :  isim gibi de�i�kenlerde,    char(11) : tc gibi de�i�kenlerde

 alter table ogrenci add dtarihi varchar(10);

 alter table ogrenci alter column dtarihi DATE;  -- s�tunun veri tipini de�i�tirdik . Kay�tl� s�tun �zerinde de�i�iklik yapt�k..

 alter table ogrenci alter column adsoyad NVARCHAR(50); -- NVARCHAR'da unique deste�i bulunmaktad�r.


 -------------------------------------------------------------------------
 select * from ogrenci;
 -- �ki sorgu aras�ndaki fark tek tek yaz�ld���nda daha h�zl� �al��mas�. * �eklinde yaz�ld���nda sorgu daha yava� �al���r.
 select ogrencino, adsoyad, telefon, sinif, bolum, dtarihi from ogrenci;
  -------------------------------------------------------------------------


insert into ogrenci values(3, 'Veli KAYA', 0562346, 3, 'bilgisayar', '1999'),
                            (35, 'Ahmet AY', 054656, 2, 'elektrik', '1995');

insert into ogrenci values(785, 'Selin KAYA', 0578546, 3, 'mekatronik', '1999-05-15');
insert into ogrenci values(7875, 'Selim SERT', 0578546, 1, 'mekatronik', '2000-08-25');



-- otomatik id artt�rma 

create table dersler
(
id int primary key identity(1, 1),  --  (ka� ile ba�las�n, ka�ar arts�n)
dersadi varchar(20));



-- GO GO KULLANIMI : Ayn� sorguyu d�ng� �eklinde defalarca �al��t�rmay� sa�lar. �ki GO olmak zorunda ve GO komutu sat�rda tek ba��na bulunmal�

GO
insert into dersler values('Matematik');
GO 5 -- bu d�ng� 5 defa d�n�yor.

select * from dersler;


update dersler set dersadi = 'T�rk�e'; -- Matematik �eklinde olan ders adlar�n� t�rk�e yapt�k. update


delete top(2) from dersler; -- tablonun en �zerinde bulunan iki kayd� sil

delete from dersler; -- tablodaki t�m verileri siler. TABLO KALIYOR VER�LER S�L�N�YOR.

drop table dersler; -- Dersler tablosunu komple siliyor. Tabloyu sildik.

------ DELETE : Verileri siler, DROP : Tabloyu siler.


TRUNCATE table dersler; -- Varolan tablodaki t�m verileri siler komple. --> id  0'dan ba�lat�yor.


 


