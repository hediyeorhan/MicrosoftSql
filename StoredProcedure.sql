-- STORED PROCEDURE TANIMLAMA --> Yani bir fonksiyon diyebiliriz.

Use VT_ALISVERIS

select * from TblMusteriler

create procedure upMusteriGetir
as
begin
select * from TblMusteriler
end

-- Kullan�m �ekilleri
upMusteriGetir
Execute upMusteriGetir
Exec upMusteriGetir


----------------------------------------
-- PARAMETREL� STORED PROCEDURE
select * from TblMusteriler

create procedure upMusteriGetir_CinsVeYas -- Kullan�c�n�n girdi�i cinsiyet ve ya� bilgisine uyan TblMusteriler tablosundan bilgileir getir.
@cins int,
@yas int
as
begin
select * from TblMusteriler where yas = @yas and cinsiyet = @cins
end

upMusteriGetir_CinsVeYas 2, 30 -- 30 ya��nda cinsiyeti 2 olan ki�iler ***** yukar�da tan�mlanan s�raya g�re yaz�yoruz.
exec upMusteriGetir_CinsVeYas 1, 30


alter procedure upMusteriGetir_CinsVeYas -- Sorguda de�i�iklik yapt�k �nceden olu�mu� bir procedurde ALTER ile
@cins int,
@yas int
as 
begin
select * from TblMusteriler where yas >= @yas and cinsiyet = @cins
end


exec upMusteriGetir_CinsVeYas 1, 35


--SQL Injection : Veritaban�nda bir g�venlik a���� Hoca �rnek olarak anlatt� ekstra
select * from TblMusteriler
where id = 3 OR 1=1 -- bu �ekilde kullan�c� d���ndakiler de eri�ebilir sunucudaki bilgilere g�venlik a����
-- adres �ubu�u + OR + 1=1

------------------------------------------------------------------------------------------------------------------
-- KAYNAK KODLARI G�R�N�R YAPMA
sp_helptext upMusteriGetir_CinsVeYas

sp_helptext sp_alterdiagram -->yukar�daki ile fark� stored procedure yazd���m�zda eri�ebiliyoruz.


drop procedure upMusteriGetir_CinsVeYas --> procedure silme


-- KAYNAK KODUNA ER���LEMEYEN PROCEDURE

create procedure up_MusteriGetir2
@cins int, 
@yas int
WITH ENCRYPTION
as
begin
select * from TblMusteriler where yas = @yas and cinsiyet = @cins order by isim
end


up_MusteriGetir_CinsVeYas 1, 30

----------------------------------
-- GERIYE DEGER DONDUREN PROCEDURE

create proc upCinsiyeteGoreCalisanSayisi
@cins int, -- input
@calisansayisi int output --output
as
begin
select @calisansayisi = count(*) from TblMusteriler where cinsiyet = @cins
end

declare @toplamcalisansayisi int --procedurden d�nen de�eri bu de�i�kene atad�k ve yazd�rd�k
exec upCinsiyeteGoreCalisanSayisi 1, @toplamcalisansayisi output -- exec olmay�nca hata verdi
print @toplamcalisansayisi  --or
select @toplamcalisansayisi

