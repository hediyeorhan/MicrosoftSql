-- create database neu :  veritaban� olu�turma
-- use neu : olu�turdu�umuz veritab�n�n� kullanma

create database geneltekrar
use geneltekrar

create table ogrenci(
    ogrencino int not null,
	adsoyad varchar(20),
	telefon int,
	sinif int,
	bolum varchar(20));


create table personel(
    sicilno int not null,
	adsoyad varchar(40) not null,
	telefon int,
	departman varchar(20) not null,
	maas int not null);

--ALTER : De�i�iklik yap�yor tabloda

alter table ogrenci add ortalama int;
-- alter table ogrenci modify bolum varchar(40); -- bolumun kapasitesini artt�rmak

alter table ogrenci drop column ortalama;

alter table ogrenci add constraint pk_ogrenci primary key(ogrencino); -- add constraint  : Tabloya k�s�t ekleme. ,  drop constraint : K�s�t kald�rma

-- Tabloya Eleman Ekleme

insert into ogrenci values(100, 'Hasan Can', 555555, 3, 'Bilgisayar');

insert into ogrenci values(102, 'Cemil �ahin Orhan', 4657768, 2, 'Bilgisayar');
insert into ogrenci values(103, 'Cemil �ahin Orhan', 456767, 2, 'Makine');

insert into ogrenci(ogrencino, adsoyad, bolum, sinif) values (101, 'Elif Orhan', 'Mekatronik', 1);

select * from ogrenci;

select adsoyad, bolum, sinif from ogrenci;

select * from ogrenci where sinif=3; -- where : select'in �art ko�ulu.

select * from ogrenci where ogrencino>10;

select * from ogrenci where adsoyad like('E%an'); -- ad� e ile ba�layan an ile biten.
select * from ogrenci where adsoyad <'Cano'; -- s�zl�kte cano dan �nce gelenleri al�yr
select * from ogrenci where adsoyad <'Zeynep';  -- ikisi de zeynepten �nce

-- distinct  : Farkl� olanlar� al�yor.

select distinct bolum from ogrenci;
select distinct sinif from ogrenci;

select * from ogrenci where sinif in(2,3);
-- ikinci yol
select * from ogrenci where sinif =2 or sinif=3;

select * from ogrenci where telefon is not null;

select * from ogrenci where telefon is null;

select * from ogrenci where bolum='Bilgisayar' order by sinif desc; -- default order by asc artarak s�ralar , desc : azalarak s�ralar b�y�kten k����e.


select * from ogrenci order by adsoyad asc , ogrencino desc; -- ilk �nce adsoyada g�re s�ralad� sonra ad soyad ayn� olan� numaraya g�re ald�. -- k���kten b�y��e.
-- asc :   a'dan z'ye 
-- desc :  z'den a'ya

alter table ogrenci add dtarihi varchar(10);
alter table ogrenci alter column dtarihi DATE; -- S�tunun de�i�ken t�r�n� de�i�tiriyoruz.

alter table ogrenci alter column adsoyad nvarchar(30);



-- otomatik id artt�rma
create table dersler(
      id int primary key identity(1,1), -- (ka� ile ba�las�n, ka�ar arts�n)
	  dersadi varchar(20));


GO
insert into dersler values('Matematik');
GO 5

select* from dersler; -- id otomatik artt� GO ile 5 kez d�ng� �al��t�

update dersler set dersadi='Veri Yap�lar�' where id = 3;

update dersler set dersadi='G�m�l� Sistemler'; -- UPDATE :  Tablodan veri bilgisi g�ncellemesi yap�yor

delete top(2) from dersler; -- en �stten 2 de�eri sil dedik.
-- DROP s�tun siler tablodan yani tabloda de�i�iklik.
-- DELETE : Tablodan veri siler.

delete  dersler; --verileri sildik --> Bu �ekilde de varolan tablodaki t�m verileri silmi� olduk..
drop table dersler; -- tabloyu sildik.

truncate table dersler; -- varolan tablodaki t�m verileri siler.
-- <> e�it de�il demek != bu da kullan�labilir.

use VTDERS21EKIM;

select * from uyeler where cinsiyet = 'E' and (soyisim = 'Ayd�n' or soyisim = 'Zafer');


select top 2 * from uyeler; -- en �stten iki �yeyi ald�k.

-- like '_a_' : 3 harfli olacak ama ortada a olacak.

select * from PERSONEL where yas between 20 and 26;

select isim as ad, soyisim as soyad from uyeler;


-- Table ad�na takma isim verme : 
select u.isim, u.soyisim from uyeler u where u.cinsiyet='K';

select * from personel where isim like('_____') order by maas desc;

select * from personel where len(isim)=5 order by maas desc;

select * from personel where isim like '%[eaf]%' order by soyisim;


select isim, yas, maas+maas*0.1 as ZamliMaas from personel where maas > yas*100;

select count(maas) as countmaas from PERSONEL;

select count(distinct ulke) as ulkeSayisi from PERSONEL;

select max(yas) as MaxYas, min(yas) as MinYas from personel;

select isim, yas as MaxYas from personel where yas = (select max(yas) from personel);
select isim, yas as MinYas from personel where yas = (select min(yas) from personel);

-- SUM : S�tundaki t�m de�erleri toplar.

select ulke from PERSONEL group by ulke;

select ulke, AVG(maas) as ulkereGoreOrtMaas from personel group by ulke;

select ulke, kent from personel group by ulke, kent; --�nce �lkeye g�re sonra kente g�re ay�r�r.

select count(*) as CalisanSayisi, ulke, kent from personel group by ulke, kent;

select kent, count(*) from PERSONEL group by kent having count(*) = 1;

select avg(maas) as ortMaas, ulke, cinsiyet from personel where cinsiyet='E' group by ulke, CINSIYET having avg(maas) > 3000;

select top(1) ulke, avg(maas) as ORTMAAS from personel group by ulke order by avg(maas) desc;

-- ikinci yol

select max(OrtalamaMaas) as MaxOrtalamaMaas from (select ulke, avg(maas) as OrtalamaMaas from personel group by ulke) as MAAS;
