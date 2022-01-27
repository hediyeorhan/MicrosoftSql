select * from kitap;
select * from yazar;

select kitapid, kitapad, yazarid, yazarad, sayfa, renk
from kitap inner join yazar
on kitap.yazarid=yazar.yazar_id;  -- id'si uyan de�erleri listeledik.


create view kitapyazar -- sorguyu kitapyazar ad�nda kaydettik. tablo de�il g�r�nt� olarak veritaban�nda tutuyoruz.
as 
select kitapid, kitapad, yazarad from kitap inner join yazar on kitap.yazarid = yazar.yazarid;


--View kullan�m : 
select * from kitapyazar;

insert into kitapyazar values(9, 'Kumarbaz', 'Dostoyevski'); -- Buna bu �ekilde ekleme yapamay�z. ��nk� iki tablo ba�l� 
-- AMA tek tablo olursa insert into yapabiliriz. Ba�l� olmayan tabloda olur..

--Tek tablodan olu�an viewlar �zerinde insert delete i�lemleri yapabiliyoruz.

--VIEW : Tablo gibi olu�turabiliriz.

--Olu�turulan view'� veritaban�ndan silme
drop view kitapyazar;

create view kitapRenkleri
as
select renk, count(*) kitapSayisi from kitap group by renk;

insert into kitapRenkleri values('Turuncu', 1); --KitapSayisi de�eri bizim t�retti�imiz, t�retilmi� bir de�er oldu�u i�in insert yapam�yoruz 1 diye

--Tablo g�ncellenirse view de g�ncellenir.

select kitapid, kitapad, yazarad, kitapsayisi
from kitap left join yazar on kitap.yazarid = yazar.yazar_id;


create view kitapGoster
as
select kitapid, kitapad, yazarad, kitapsayisi
from kitap left join yazar on kitap.yazarid = yazar.yazar_id;


select * from kitapGoster



-- STORED PROCEDURE

create procedure toplama kitapGetir -- ya da create proc �eklinde de olur.
as
begin
select * from kitap 
end


-- kullan�m� 1: 
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
print @kitapsayisi -- normal ��kt� olarak yazar .
select @kitapsayisi -- tablo ��kt�s� olarak yazar.

create procedure topla (@sayi1 int, @sayi2 int, @sonuc int output)
as
begin                                        -- sonnuc de�erine i�lemin sonucunu atad�k ve d�nd�rd�  procedure
set @sonuc = @sayi1 + @sayi2
end

declare @toplam int;
exec topla 4, 7, @toplam output -- 4 ve 7 sayi1 ve sayi2 ��kan sonucu toplam de�i�kenine atad�k.
select @toplam;


create procedure sayikitapgetir (@sayfasayisi int)
as
begin
select * from kitap where sayfa>=@sayfasayisi
end

exec sayikitapgetir 150 -- sayfa say�s� 150'den b�y�k olan kitaplar� getir tablodan dedik.


-- Sayfa ba��na d��en maliyet de�erinden bir kitab�n maliyetini hesaplayan procedur
create procedure kitapmaliyet @sayfabasimaliyet int
as 
begin
select kitapid, kitapad, yazarid, sayfa, renk, sayfa*@sayfabasimaliyet as Maliyet from kitap
end

exec kitapmaliyet 2;


--.. Rengindeki kitaplar�n toplam maliyetini hesaplas�n

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