-- TETIKLEYICILER (TRIGGERLAR) -> Bizden ba��ms�z olarak veri eklendi�inde tetiklenir. Biz eklemeyiz veriyi insert into  ile fark� budur.
use VT_ALISVERIS

select * from TblUrunler
select * from TblUrunKategori

create TRIGGER trg_TblUrunler_forInsert
ON TblUrunler
FOR insert 
as
begin
   select * from inserted -- "inserted" ger�ekte var olmayan trigger�n g�vdesinde yer alan �zelle�mi� bir tablodur.
end

-- Hangi tablonun alt�nda olu�turmu�sak trigger� trigger ad�nda bir klas�r var ve orayaa ekleniyor.


insert into TblUrunler values('Dondurma', 5.25, 111, 3) -- trigger tetiklendi ve select * from inserted sorgusu �al��t�. Ekrana o geldi.
-- Bu inserted sorgusunu kendimiz �al��t�ramay�z hata verir trigger i�inde �al��an sanal bir tablo.
-- Trigger d���nda �al��amaz !!.


-- Eklenen �r�nleri ayr� bir tabloda tutma

-- Audit : denetim denetleme anlam�na gelmektedir.
create table TblUrunlerAudit 
(
     id int primary key identity(1,1),
	 AuditData nvarchar(100) -- de�i�iklik yap�lan datay� g�sterecek -> g�ncelleme, silme, ekleme
)

--olu�turup de�i�iklik yapt�k create -> alter oldu.
alter trigger trg_TblUrunler_forInsert2
On TblUrunler
for insert
as
begin
    Declare @id int
	select @id = id from inserted -- inserted tablosunda yer alan TblUrunlere ekledi�imiz �r�n�n id'sini d�nd�r�yor.

	insert into TblUrunlerAudit
	values(CAST(@id as nvarchar(3)) + ' id de�erine sahip yeni bir �r�n' + CAST(GETDATE() as nvarchar(35)) + 'tarihinde eklendi.')
end

-- CAST fonk ile @id de�i�kenini nvarchar'a �evirece�imizi s�yledik.

select GETDATE()

insert into TblUrunler values('Pasta', 35.25, 112, 3)

select * from TblUrunlerAudit;


create trigger trg_TblUrunler_forDelete
On TblUrunler
for delete
as
begin
    Declare @id int
	select @id = id from deleted -- inserted tablosunda yer alan TblUrunlere ekledi�imiz �r�n�n id'sini d�nd�r�yor.

	insert into TblUrunlerAudit values(CAST(@id as nvarchar(3)) + ' id de�erine sahip yeni bir �r�n' + CAST(GETDATE() as nvarchar(35)) + 'tarihinde silindi.')
end

delete from TblUrunler where id=3;

select * from TblUrunlerAudit;


--------------------------------------------------------------

-- Transaction SQL (T-SQL) --> Mssql

-- Oracle (PL-SQL)

-- D�ng�ler ve logic i�lemler i�in t-sql, p-sql kullan�l�yor.

select * from TblUrunler

Declare @sayi int
select @sayi=count(*) from TblUrunler

if @sayi > 1
    BEGIN --di�er programlama dillerindeki s�sl� parantez.
	  print 'Tabloda kay�tlar vard�r.'
	END
else
    BEGIN
	   print 'Tabloda kay�t bulunmamaktad�r.'
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
   print 'Eyl�l ay�nday�z'
end
else
begin
   print 'Eyl�l ay�nda de�iliz.'
end


--Kaynak�a : sqlservere�itimleri, javapoint.com