use VT_ALISVERIS3

select * from TblUrunler
select * from TblUrunKategori

insert into TblUrunler values('Yo�urt', -12.5, '1234', 2)  -- Hata verir. K�s�tlad�k
--Tables -> TblUrunler -> Constraints -> General k�sm�nda t�kl�yoruz Fiyat > 0 diyoruz ve ctrl+s unutmuyoruz.

delete from TblUrunler where id= 6

--Yukar�daki k�s�t� sorgu ile ekleme
Alter table TblUrunler add constraint CK_TblUrunler_fiyatKontrol check(fiyat>0)

--K�s�t� silme sorgu ile
Alter table TblUrunler drop constraint [CK_TblUrunler_fiyatKontrol]
--------------------------------------------------------------------

-- Varsay�lan K�s�t Olu�turma (Default Constraint Olu�turma)

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

--default k�s�t ekledik.
Alter table TblMusteriler add constraint DF_TblMusteriler_cinsID default 3 for cinsID

select * from TblMusteriler

-- varsay�lan de�eri almas� i�in hi�bir de�er almamas� gerekir. null yazsak bile null de�eri al�r. varsay�lan� yazmaz

alter table TblMusteriler drop constraint DF_TblMusteriler_cinsID

-----------------------------------------------------------------------

-- Basamakl� Constraint 

delete from TblCinsiyet where id = 1 --mssql buna izin vermez!  Foreign key ks�t�ndan dolay�.
-- �stteki sorguyu �al��t�rd���m�zda musteriler tablosunda cinsID de�eri 3 olur yani default de�ere �eker.

--foreign key'e cascade �zelli�i id'si 3 olan cinsiyet silinirse ona ba�l� olan 3 id'li veriler de silinir.


select * from TblMusteriler
select * from TblCinsiyet


