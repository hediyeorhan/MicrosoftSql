-- create database neu :  veritabaný oluþturma
-- use neu : oluþturduðumuz veritabýnýný kullanma

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

--ALTER : Deðiþiklik yapýyor tabloda

alter table ogrenci add ortalama int;
-- alter table ogrenci modify bolum varchar(40); -- bolumun kapasitesini arttýrmak

alter table ogrenci drop column ortalama;

alter table ogrenci add constraint pk_ogrenci primary key(ogrencino); -- add constraint  : Tabloya kýsýt ekleme. ,  drop constraint : Kýsýt kaldýrma

-- Tabloya Eleman Ekleme

insert into ogrenci values(100, 'Hasan Can', 555555, 3, 'Bilgisayar');

insert into ogrenci values(102, 'Cemil Þahin Orhan', 4657768, 2, 'Bilgisayar');
insert into ogrenci values(103, 'Cemil Þahin Orhan', 456767, 2, 'Makine');

insert into ogrenci(ogrencino, adsoyad, bolum, sinif) values (101, 'Elif Orhan', 'Mekatronik', 1);

select * from ogrenci;

select adsoyad, bolum, sinif from ogrenci;

select * from ogrenci where sinif=3; -- where : select'in þart koþulu.

select * from ogrenci where ogrencino>10;

select * from ogrenci where adsoyad like('E%an'); -- adý e ile baþlayan an ile biten.
select * from ogrenci where adsoyad <'Cano'; -- sözlükte cano dan önce gelenleri alýyr
select * from ogrenci where adsoyad <'Zeynep';  -- ikisi de zeynepten önce

-- distinct  : Farklý olanlarý alýyor.

select distinct bolum from ogrenci;
select distinct sinif from ogrenci;

select * from ogrenci where sinif in(2,3);
-- ikinci yol
select * from ogrenci where sinif =2 or sinif=3;

select * from ogrenci where telefon is not null;

select * from ogrenci where telefon is null;

select * from ogrenci where bolum='Bilgisayar' order by sinif desc; -- default order by asc artarak sýralar , desc : azalarak sýralar büyükten küçüðe.


select * from ogrenci order by adsoyad asc , ogrencino desc; -- ilk önce adsoyada göre sýraladý sonra ad soyad ayný olaný numaraya göre aldý. -- küçükten büyüðe.
-- asc :   a'dan z'ye 
-- desc :  z'den a'ya

alter table ogrenci add dtarihi varchar(10);
alter table ogrenci alter column dtarihi DATE; -- Sütunun deðiþken türünü deðiþtiriyoruz.

alter table ogrenci alter column adsoyad nvarchar(30);



-- otomatik id arttýrma
create table dersler(
      id int primary key identity(1,1), -- (kaç ile baþlasýn, kaçar artsýn)
	  dersadi varchar(20));


GO
insert into dersler values('Matematik');
GO 5

select* from dersler; -- id otomatik arttý GO ile 5 kez döngü çalýþtý

update dersler set dersadi='Veri Yapýlarý' where id = 3;

update dersler set dersadi='Gömülü Sistemler'; -- UPDATE :  Tablodan veri bilgisi güncellemesi yapýyor

delete top(2) from dersler; -- en üstten 2 deðeri sil dedik.
-- DROP sütun siler tablodan yani tabloda deðiþiklik.
-- DELETE : Tablodan veri siler.

delete  dersler; --verileri sildik --> Bu þekilde de varolan tablodaki tüm verileri silmiþ olduk..
drop table dersler; -- tabloyu sildik.

truncate table dersler; -- varolan tablodaki tüm verileri siler.
-- <> eþit deðil demek != bu da kullanýlabilir.

use VTDERS21EKIM;

select * from uyeler where cinsiyet = 'E' and (soyisim = 'Aydýn' or soyisim = 'Zafer');


select top 2 * from uyeler; -- en üstten iki üyeyi aldýk.

-- like '_a_' : 3 harfli olacak ama ortada a olacak.

select * from PERSONEL where yas between 20 and 26;

select isim as ad, soyisim as soyad from uyeler;


-- Table adýna takma isim verme : 
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

-- SUM : Sütundaki tüm deðerleri toplar.

select ulke from PERSONEL group by ulke;

select ulke, AVG(maas) as ulkereGoreOrtMaas from personel group by ulke;

select ulke, kent from personel group by ulke, kent; --önce ülkeye göre sonra kente göre ayýrýr.

select count(*) as CalisanSayisi, ulke, kent from personel group by ulke, kent;

select kent, count(*) from PERSONEL group by kent having count(*) = 1;

select avg(maas) as ortMaas, ulke, cinsiyet from personel where cinsiyet='E' group by ulke, CINSIYET having avg(maas) > 3000;

select top(1) ulke, avg(maas) as ORTMAAS from personel group by ulke order by avg(maas) desc;

-- ikinci yol

select max(OrtalamaMaas) as MaxOrtalamaMaas from (select ulke, avg(maas) as OrtalamaMaas from personel group by ulke) as MAAS;
