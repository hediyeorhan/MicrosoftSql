-- TETIKLEYICILER (TRIGGERLAR) -> Bizden baðýmsýz olarak veri eklendiðinde tetiklenir. Biz eklemeyiz veriyi insert into  ile farký budur.
use VT_ALISVERIS

select * from TblUrunler
select * from TblUrunKategori

create TRIGGER trg_TblUrunler_forInsert
ON TblUrunler
FOR insert 
as
begin
   select * from inserted -- "inserted" gerçekte var olmayan triggerýn gövdesinde yer alan özelleþmiþ bir tablodur.
end

-- Hangi tablonun altýnda oluþturmuþsak triggerý trigger adýnda bir klasör var ve orayaa ekleniyor.


insert into TblUrunler values('Dondurma', 5.25, 111, 3) -- trigger tetiklendi ve select * from inserted sorgusu çalýþtý. Ekrana o geldi.
-- Bu inserted sorgusunu kendimiz çalýþtýramayýz hata verir trigger içinde çalýþan sanal bir tablo.
-- Trigger dýþýnda çalýþamaz !!.


-- Eklenen ürünleri ayrý bir tabloda tutma

-- Audit : denetim denetleme anlamýna gelmektedir.
create table TblUrunlerAudit 
(
     id int primary key identity(1,1),
	 AuditData nvarchar(100) -- deðiþiklik yapýlan datayý gösterecek -> güncelleme, silme, ekleme
)

--oluþturup deðiþiklik yaptýk create -> alter oldu.
alter trigger trg_TblUrunler_forInsert2
On TblUrunler
for insert
as
begin
    Declare @id int
	select @id = id from inserted -- inserted tablosunda yer alan TblUrunlere eklediðimiz ürünün id'sini döndürüyor.

	insert into TblUrunlerAudit
	values(CAST(@id as nvarchar(3)) + ' id deðerine sahip yeni bir ürün' + CAST(GETDATE() as nvarchar(35)) + 'tarihinde eklendi.')
end

-- CAST fonk ile @id deðiþkenini nvarchar'a çevireceðimizi söyledik.

select GETDATE()

insert into TblUrunler values('Pasta', 35.25, 112, 3)

select * from TblUrunlerAudit;


create trigger trg_TblUrunler_forDelete
On TblUrunler
for delete
as
begin
    Declare @id int
	select @id = id from deleted -- inserted tablosunda yer alan TblUrunlere eklediðimiz ürünün id'sini döndürüyor.

	insert into TblUrunlerAudit values(CAST(@id as nvarchar(3)) + ' id deðerine sahip yeni bir ürün' + CAST(GETDATE() as nvarchar(35)) + 'tarihinde silindi.')
end

delete from TblUrunler where id=3;

select * from TblUrunlerAudit;


--------------------------------------------------------------

-- Transaction SQL (T-SQL) --> Mssql

-- Oracle (PL-SQL)

-- Döngüler ve logic iþlemler için t-sql, p-sql kullanýlýyor.

select * from TblUrunler

Declare @sayi int
select @sayi=count(*) from TblUrunler

if @sayi > 1
    BEGIN --diðer programlama dillerindeki süslü parantez.
	  print 'Tabloda kayýtlar vardýr.'
	END
else
    BEGIN
	   print 'Tabloda kayýt bulunmamaktadýr.'
	END

Declare @sayi int
select @sayi=count(*) from TblUrunler

while @sayi >= 1
BEGIN
   print @sayi
   set @sayi = @sayi-1
END


if MONTH(GETDATE()) in (9)
begin
   print 'Eylül ayýndayýz'
end
else
begin
   print 'Eylül ayýnda deðiliz.'
end


--Kaynakça : sqlservereðitimleri, javapoint.com