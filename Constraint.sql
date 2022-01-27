use VT_ALISVERIS3

select * from TblUrunler
select * from TblUrunKategori

insert into TblUrunler values('Yoðurt', -12.5, '1234', 2)  -- Hata verir. Kýsýtladýk
--Tables -> TblUrunler -> Constraints -> General kýsmýnda týklýyoruz Fiyat > 0 diyoruz ve ctrl+s unutmuyoruz.

delete from TblUrunler where id= 6

--Yukarýdaki kýsýtý sorgu ile ekleme
Alter table TblUrunler add constraint CK_TblUrunler_fiyatKontrol check(fiyat>0)

--Kýsýtý silme sorgu ile
Alter table TblUrunler drop constraint [CK_TblUrunler_fiyatKontrol]
--------------------------------------------------------------------

-- Varsayýlan Kýsýt Oluþturma (Default Constraint Oluþturma)

select * from TblMusteriler

create table TblCinsiyet(id INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
                         cinsiyet varchar(10) not null
);

insert into TblCinsiyet values('Kadin'),('Erkek'),('Belinmeyen')

select * from TblCinsiyet

alter table TblMusteriler add cinsID int foreign key references TblCinsiyet(id)


select * from TblMusteriler

insert into TblMusteriler (isim, soyisim, ceptel, mail) 
values('Kamil', 'KAYA', 0545456, 'kk@gmail.com')

insert into TblMusteriler
values('Ayten', 'KAYA', 05457856, 'ak@gmail.com', 1)

--default kýsýt ekledik.
Alter table TblMusteriler add constraint DF_TblMusteriler_cinsID default 3 for cinsID

select * from TblMusteriler

-- varsayýlan deðeri almasý için hiçbir deðer almamasý gerekir. null yazsak bile null deðeri alýr. varsayýlaný yazmaz

alter table TblMusteriler drop constraint DF_TblMusteriler_cinsID

-----------------------------------------------------------------------

-- Basamaklý Constraint 

delete from TblCinsiyet where id = 1 --mssql buna izin vermez!  Foreign key ksýtýndan dolayý.
-- üstteki sorguyu çalýþtýrdýðýmýzda musteriler tablosunda cinsID deðeri 3 olur yani default deðere çeker.

--foreign key'e cascade özelliði id'si 3 olan cinsiyet silinirse ona baðlý olan 3 id'li veriler de silinir.


select * from TblMusteriler
select * from TblCinsiyet


