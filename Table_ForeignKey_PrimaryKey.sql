create database VT_ALISVERIS3
use VT_ALISVERIS3

create table TblMusteriler(
    id INT PRIMARY KEY IDENTITY(1, 1),
	isim varchar(30) not null,
	soyisim varchar(30) NOT NULL,
	ceptel varchar(11) NOT NULL,
	mail varchar(30) NOT NULL);

create table TblUrunKategori(
    id INT PRIMARY KEY IDENTITY(1, 1),
	kategori varchar(50) not null);

create table TblUrunler(
    id INT PRIMARY KEY IDENTITY(1, 1),
	ad varchar(50) not null,
	fiyat float NOT NULL,
	barkod varchar(30) NOT NULL,
	urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id));


create table TblMusteriAlisVerisTarihi(
    id int primary key identity(1,1),
	tarih datetime default current_timestamp
);

create table TblAliverisKayit(
    alisveris_id INT foreign KEY references TblMusteriAlisVerisTarihi(id),
	musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
	urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
	urun_fiyat float not null,
	adet int not null
);

-- veritabanýnda delete ile sildiðimiz ayný id'yi tekrar ekleyemiyoruz.

insert into TblMusteriler values('Ali', 'KAYA', '055555555', 'alikaya@gmail.com'),
							   ('Veli', 'DAÐLI', '055685655', 'velidagli@gmail.com'),
							   ('Ayþe', 'BÝLÝR', '046265655', 'aysebilir@gmail.com');

insert into TblUrunKategori VALUES('GIDA'), ('SARKÜTERÝ'), ('ÇÝKOLATA'), ('BÝSKÜVÝ'), ('UNLU MAMÜLLER'), ('TEMÝZLÝK ÜRÜNLERÝ');


insert into TblUrunler values('Çay', 29.75, '113', 2),
                             ('Ekmek', 3.4, '114', 5),
							 ('Halley', 1.5, '115', 4),
							 ('Negro', 2.5, '116', 4),
							 ('Deterjan', 35.55, '117', 6);

select * from TblMusteriler;
select * from TblUrunler;


-- 1. Müþteriye 1. Alýþveriþi Ekle
insert into TblMusteriAlisVerisTarihi(tarih) values (current_timestamp);
select * from TblMusteriAlisVerisTarihi;

-- veritabanýnda deðiþken oluþturma
declare @fiyat float set @fiyat = (select fiyat from TblUrunler where id=1);

-- oluþturduðumuz deðiþkeni ekledik veritabanýna.
insert into TblAliverisKayit(alisveris_id, musteri_id, urun_id, urun_fiyat, adet) values(1, 1, 1, @fiyat, 3)

------------------------------------------------------------------------------------
declare @fiyat2 float set @fiyat2 = (select fiyat from TblUrunler where id=2);

-- oluþturduðumuz deðiþkeni ekledik veritabanýna.
insert into TblAliverisKayit(alisveris_id, musteri_id, urun_id, urun_fiyat, adet) values(1, 1, 2, @fiyat2, 3)

select * from TblAliverisKayit

-----------------------------------------------------
-- 1. alýverisime üçüncü ürünü ekliyoruz.

declare @fiyat3 float set @fiyat3 = (select fiyat from TblUrunler where id=3);

-- oluþturduðumuz deðiþkeni ekledik veritabanýna.
insert into TblAliverisKayit(alisveris_id, musteri_id, urun_id, urun_fiyat, adet) values(1, 1, 3, @fiyat3, 3)
select * from TblAliverisKayit
------------------------------------------------------
declare @fiyat4 float set @fiyat4 = (select fiyat from TblUrunler where id=5);

-- oluþturduðumuz deðiþkeni ekledik veritabanýna.
insert into TblAliverisKayit(alisveris_id, musteri_id, urun_id, urun_fiyat, adet) values(1, 1, 4, @fiyat4, 3)
select * from TblAliverisKayit


insert into TblMusteriAlisVerisTarihi(tarih) values (current_timestamp);
select * from TblMusteriAlisVerisTarihi

-- 2. müþterinin 1.alýþveriþini ekledik.

declare @fiyat5 float set @fiyat5 = (select fiyat from TblUrunler where id=2);

-- oluþturduðumuz deðiþkeni ekledik veritabanýna.
insert into TblAliverisKayit(alisveris_id, musteri_id, urun_id, urun_fiyat, adet) values(2, 2, 2, @fiyat5, 3)
select * from TblAliverisKayit


-- select where ile 4 tablodan sorgu çekmek.
select TblAliverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat GUNCELFIYAT, TblAliverisKayit.urun_fiyat ESKIFIYAT,
TblAliverisKayit.adet, TblMusteriAlisVerisTarihi.tarih from TblAliverisKayit, TblMusteriler, TblMusteriAlisVerisTarihi, TblUrunler 
where (TblMusteriler.id=TblAliverisKayit.musteri_id) and (TblUrunler.id=TblAliverisKayit.urun_id) and (TblAliverisKayit.alisveris_id=TblMusteriAlisVerisTarihi.id);

--------------------------------------------------------------------------- FÝYAT GÜNCELLEME
update TblUrunler set fiyat = 17.25 where id=3;



---------------------------------------------------------------------------
-- select inner join ile 4 tablodan sorgu çekmek.
select TblAliverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat GUNCELFIYAT, TblAliverisKayit.urun_fiyat ESKIFIYAT,
TblAliverisKayit.adet, TblMusteriAlisVerisTarihi.tarih from (TblAliverisKayit inner join TblMusteriler on TblAliverisKayit.musteri_id = TblMusteriler.id
inner join TblUrunler on TblAliverisKayit.urun_id=TblUrunler.id
inner join TblMusteriAlisVerisTarihi on TblAliverisKayit.alisveris_id=TblMusteriAlisVerisTarihi.id)


select TblAliverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat GUNCELFIYAT, TblAliverisKayit.urun_fiyat ESKIFIYAT,
TblAliverisKayit.adet, TblMusteriAlisVerisTarihi.tarih from (TblAliverisKayit inner join TblMusteriler on TblAliverisKayit.musteri_id = TblMusteriler.id
inner join TblUrunler on TblAliverisKayit.urun_id=TblUrunler.id
inner join TblMusteriAlisVerisTarihi on TblAliverisKayit.alisveris_id=TblMusteriAlisVerisTarihi.id
inner join TblUrunKategori on TblUrunler.urun_kategori_id=TblUrunKategori.id);



-- eski fiyatlarý eski halleriyle tutmak için bu hafta böyle bir çalýþma yaptýk.
--update ruls