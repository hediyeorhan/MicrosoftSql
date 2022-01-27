create database lab3
use lab3

create table personel(
per_no int primary key, -- unique + not null �artlar�n� da sa�l�yor.
isim varchar(10),
soyisim varchar(10),
yas int,
cinsiyet char(1),
kent varchar(15),
ulke varchar(15),
maas int);


insert into personel values(1, 'Ahmet', 'Yilmaz', 20, 'E', 'Ankara', 'Turkiye', 2000);
insert into personel values(2, 'Mehmet', 'Efe', 22, 'E', 'Ankara', 'Turkiye', 2000);
insert into personel values(3, 'Ayse', 'Can', 23, 'K', 'Istanbul', 'Turkiye', 2500);
insert into personel values(4, 'Fatma', 'Ak', 35, 'K', 'Istanbul', 'Turkiye', 2000);
insert into personel values(5, 'Ahmet', 'Yalcin', 29, 'E', 'Istanbul', 'Turkiye', 2600);
insert into personel values(6, 'Ellen', 'Seth', 40, 'K', 'New York', 'ABD', 3000);
insert into personel values(7, 'Hans', 'Miller', 39, 'E', 'Paris', 'Fransa', 3700);
insert into personel values(8, 'Frank', 'Casarre', 25, 'E', 'Ankara', 'Turkiye', 2000);
insert into personel values(9, 'Abbas', 'Demir', 25, 'E', 'Adana', 'Turkiye', 1500);


select * from personel


-- SORU 1 : Maa� : 3500, 3600, 3700, 4000 olan kay�tlar� getiren sorguyu yaz�n�z.

select * from personel where maas in(3500, 3600, 3700, 4000); -- maas = 3500 or maas = 3600 olarak da yaz�labilir ama uzun olur.

-- SORU 2 : Ya�� 20 ile 30 aras�nda olan erkeklerin isim, soyisim, ya� de�erlerini ekrana yaz.

select isim, soyisim, yas from personel where cinsiyet = 'E' and (yas >= 20 and yas <= 30); -- uzun yol
select isim, soyisim, yas from personel where cinsiyet = 'E' and (yas between 20 and 30); -- between k�sayol olarak daha mant�kl�

-- SORU 3 : �lke T�rkiye olan ismi 'A' ya da 'F' ile ba�layan,  maa�� 1500 tl'den b�y�k olan kay�tlar� soy isimleri alfabetik olacak �ekilde yaz.

select * from personel where maas > 1500 and  (isim  like('A%') or isim like('F%')) and ulke = 'Turkiye'  order by soyisim asc;


-- SORU 4 : �smi 'A' ile ba�layan ya da 's' ile biten erkeklerin isme g�re alfabetik s�rala. ya da yerine ve olsayd� -> or yerine and koyard�k.

select * from personel where isim like('A%') or isim like('%s') and (cinsiyet = 'E') order by isim asc; -- default asc zaten yazmaya gerek yok.


-- SORU 5 : �smi 5 harfli olan personelin maa��n� b�y�kten k����e s�ralay�n.

select * from personel where isim like '_____' order by maas desc; -- desc  : azalan s�ralama.

-- length ile hesaplama
select * from personel;

select * from personel where len(isim)=5;


-- SORU 6 : Personel tablosundan �lkesi T�rkiye olmayan maa�� 2000'den b�y�k olan, isimlerinde 'aef' harfleri bulunan  ki�lerin isim, soyisim ve ya� bilgilerini 
-- soyisimleri ters s�zl�k s�ral� sorguyu yazd�r�n�z.

select isim, soyisim, maas from personel where ulke <> 'Turkiye' and maas > 2000 and isim like '%[aefAEF]%' order by soyisim desc;

-- SORU 7 : Personel tablosunda �lkesi Almanya olmayan soyismi 3 harften fazla olan veya Y ile ba�layan ismi 4 harften uzun olan
-- ya�� 35'den fazla olan

select *  from personel where ulke <> 'Almanya' and ((len(soyisim)>=3) or (soyisim like 'Y%')) and (len(isim)>=4) and (yas < 35);

-- SORU 8 : maa�� ya��n�n 100 kat�ndan fazla olan personelin, isim ya� ve %10 zaml� maa��n� g�ster. Maa�a g�re s�ral�

select isim, yas, maas + maas * 0.1 zamliMaas from personel where maas > yas * 100 order by maas desc; 
-- zamliMaas yazman�n nedeni zaml� halinin s�tun ad�n� vermek.
