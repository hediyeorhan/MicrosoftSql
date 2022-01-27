select * from kitap;
select * from yazar;

select kitapid, kitapad, yazarid, yazarad, sayfa, renk
from kitap inner join yazar
on kitap.yazarid=yazar.yazar_id;  -- id'si uyan deðerleri listeledik.


create view kitapyazar -- sorguyu kitapyazar adýnda kaydettik. tablo deðil görüntü olarak veritabanýnda tutuyoruz.
as 
select kitapid, kitapad, yazarad from kitap inner join yazar on kitap.yazarid = yazar.yazarid;


--View kullaným : 
select * from kitapyazar;

insert into kitapyazar values(9, 'Kumarbaz', 'Dostoyevski'); -- Buna bu þekilde ekleme yapamayýz. Çünkü iki tablo baðlý 
-- AMA tek tablo olursa insert into yapabiliriz. Baðlý olmayan tabloda olur..

--Tek tablodan oluþan viewlar üzerinde insert delete iþlemleri yapabiliyoruz.

--VIEW : Tablo gibi oluþturabiliriz.

--Oluþturulan view'ý veritabanýndan silme
drop view kitapyazar;

create view kitapRenkleri
as
select renk, count(*) kitapSayisi from kitap group by renk;

insert into kitapRenkleri values('Turuncu', 1); --KitapSayisi deðeri bizim türettiðimiz, türetilmiþ bir deðer olduðu için insert yapamýyoruz 1 diye

--Tablo güncellenirse view de güncellenir.

select kitapid, kitapad, yazarad, kitapsayisi
from kitap left join yazar on kitap.yazarid = yazar.yazar_id;


create view kitapGoster
as
select kitapid, kitapad, yazarad, kitapsayisi
from kitap left join yazar on kitap.yazarid = yazar.yazar_id;


select * from kitapGoster



-- STORED PROCEDURE

create procedure toplama kitapGetir -- ya da create proc þeklinde de olur.
as
begin
select * from kitap 
end


-- kullanýmý 1: 
kitapGetir
-- 2:
execute kitapGetir
-- 3:
exec kitapGetir


-- input parametreli procedure
create procedure rengeGoreKitapGetir (@kitapRenk varchar(10))
as
begin
select * from kitap where renk=@kitapRenk
end


execute rengeGoreKitapGetir 'sari'

-- output parametreli procedure
create procedure kitapsayirenk @kitaprengi varchar(10), @sayi int output
as
begin
select @sayi = count(*) from kitap where renk=@kitaprengi
end


declare @kitapsayisi int;
exec kitapsayirenk 'sari', @kitapsayisi output;
print @kitapsayisi -- normal çýktý olarak yazar .
select @kitapsayisi -- tablo çýktýsý olarak yazar.

create procedure topla (@sayi1 int, @sayi2 int, @sonuc int output)
as
begin                                        -- sonnuc deðerine iþlemin sonucunu atadýk ve döndürdü  procedure
set @sonuc = @sayi1 + @sayi2
end

declare @toplam int;
exec topla 4, 7, @toplam output -- 4 ve 7 sayi1 ve sayi2 çýkan sonucu toplam deðiþkenine atadýk.
select @toplam;


create procedure sayikitapgetir (@sayfasayisi int)
as
begin
select * from kitap where sayfa>=@sayfasayisi
end

exec sayikitapgetir 150 -- sayfa sayýsý 150'den büyük olan kitaplarý getir tablodan dedik.


-- Sayfa baþýna düþen maliyet deðerinden bir kitabýn maliyetini hesaplayan procedur
create procedure kitapmaliyet @sayfabasimaliyet int
as 
begin
select kitapid, kitapad, yazarid, sayfa, renk, sayfa*@sayfabasimaliyet as Maliyet from kitap
end

exec kitapmaliyet 2;


--.. Rengindeki kitaplarýn toplam maliyetini hesaplasýn

create procedure toplamMaliyet @kitaprengi varchar(10), @sayfabasimaliyet int, @toplammaliyet int output
as
begin
select @toplammaliyet = select sum(sayfa*@sayfabasimaliyet) as ToplamMaliyet from kitap where renk=@kitaprengi;
end


declare @toplammaliyet int;
exec toplamMaliyet 'sari', 3, @toplammaliyet output;
select @toplammaliyet;

--Atamada

declare @a int;
set @a = 3;

--veya

declare @a int = 3;