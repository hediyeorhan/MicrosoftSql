-- STORED PROCEDURE TANIMLAMA --> Yani bir fonksiyon diyebiliriz.

Use VT_ALISVERIS

select * from TblMusteriler

create procedure upMusteriGetir
as
begin
select * from TblMusteriler
end

-- Kullaným Þekilleri
upMusteriGetir
Execute upMusteriGetir
Exec upMusteriGetir


----------------------------------------
-- PARAMETRELÝ STORED PROCEDURE
select * from TblMusteriler

create procedure upMusteriGetir_CinsVeYas -- Kullanýcýnýn girdiði cinsiyet ve yaþ bilgisine uyan TblMusteriler tablosundan bilgileir getir.
@cins int,
@yas int
as
begin
select * from TblMusteriler where yas = @yas and cinsiyet = @cins
end

upMusteriGetir_CinsVeYas 2, 30 -- 30 yaþýnda cinsiyeti 2 olan kiþiler ***** yukarýda tanýmlanan sýraya göre yazýyoruz.
exec upMusteriGetir_CinsVeYas 1, 30


alter procedure upMusteriGetir_CinsVeYas -- Sorguda deðiþiklik yaptýk önceden oluþmuþ bir procedurde ALTER ile
@cins int,
@yas int
as 
begin
select * from TblMusteriler where yas >= @yas and cinsiyet = @cins
end


exec upMusteriGetir_CinsVeYas 1, 35


--SQL Injection : Veritabanýnda bir güvenlik açýðý Hoca örnek olarak anlattý ekstra
select * from TblMusteriler
where id = 3 OR 1=1 -- bu þekilde kullanýcý dýþýndakiler de eriþebilir sunucudaki bilgilere güvenlik açýðý
-- adres çubuðu + OR + 1=1

------------------------------------------------------------------------------------------------------------------
-- KAYNAK KODLARI GÖRÜNÜR YAPMA
sp_helptext upMusteriGetir_CinsVeYas

sp_helptext sp_alterdiagram -->yukarýdaki ile farký stored procedure yazdýðýmýzda eriþebiliyoruz.


drop procedure upMusteriGetir_CinsVeYas --> procedure silme


-- KAYNAK KODUNA ERÝÞÝLEMEYEN PROCEDURE

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

declare @toplamcalisansayisi int --procedurden dönen deðeri bu deðiþkene atadýk ve yazdýrdýk
exec upCinsiyeteGoreCalisanSayisi 1, @toplamcalisansayisi output -- exec olmayýnca hata verdi
print @toplamcalisansayisi  --or
select @toplamcalisansayisi

