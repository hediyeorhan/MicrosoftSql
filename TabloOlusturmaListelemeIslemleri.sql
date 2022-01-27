create database lab3
use lab3

create table personel(
per_no int primary key, -- unique + not null þartlarýný da saðlýyor.
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


-- SORU 1 : Maaþ : 3500, 3600, 3700, 4000 olan kayýtlarý getiren sorguyu yazýnýz.

select * from personel where maas in(3500, 3600, 3700, 4000); -- maas = 3500 or maas = 3600 olarak da yazýlabilir ama uzun olur.

-- SORU 2 : Yaþý 20 ile 30 arasýnda olan erkeklerin isim, soyisim, yaþ deðerlerini ekrana yaz.

select isim, soyisim, yas from personel where cinsiyet = 'E' and (yas >= 20 and yas <= 30); -- uzun yol
select isim, soyisim, yas from personel where cinsiyet = 'E' and (yas between 20 and 30); -- between kýsayol olarak daha mantýklý

-- SORU 3 : Ülke Türkiye olan ismi 'A' ya da 'F' ile baþlayan,  maaþý 1500 tl'den büyük olan kayýtlarý soy isimleri alfabetik olacak þekilde yaz.

select * from personel where maas > 1500 and  (isim  like('A%') or isim like('F%')) and ulke = 'Turkiye'  order by soyisim asc;


-- SORU 4 : Ýsmi 'A' ile baþlayan ya da 's' ile biten erkeklerin isme göre alfabetik sýrala. ya da yerine ve olsaydý -> or yerine and koyardýk.

select * from personel where isim like('A%') or isim like('%s') and (cinsiyet = 'E') order by isim asc; -- default asc zaten yazmaya gerek yok.


-- SORU 5 : Ýsmi 5 harfli olan personelin maaþýný büyükten küçüðe sýralayýn.

select * from personel where isim like '_____' order by maas desc; -- desc  : azalan sýralama.

-- length ile hesaplama
select * from personel;

select * from personel where len(isim)=5;


-- SORU 6 : Personel tablosundan ülkesi Türkiye olmayan maaþý 2000'den büyük olan, isimlerinde 'aef' harfleri bulunan  kiþlerin isim, soyisim ve yaþ bilgilerini 
-- soyisimleri ters sözlük sýralý sorguyu yazdýrýnýz.

select isim, soyisim, maas from personel where ulke <> 'Turkiye' and maas > 2000 and isim like '%[aefAEF]%' order by soyisim desc;

-- SORU 7 : Personel tablosunda ülkesi Almanya olmayan soyismi 3 harften fazla olan veya Y ile baþlayan ismi 4 harften uzun olan
-- yaþý 35'den fazla olan

select *  from personel where ulke <> 'Almanya' and ((len(soyisim)>=3) or (soyisim like 'Y%')) and (len(isim)>=4) and (yas < 35);

-- SORU 8 : maaþý yaþýnýn 100 katýndan fazla olan personelin, isim yaþ ve %10 zamlý maaþýný göster. Maaþa göre sýralý

select isim, yas, maas + maas * 0.1 zamliMaas from personel where maas > yas * 100 order by maas desc; 
-- zamliMaas yazmanýn nedeni zamlý halinin sütun adýný vermek.
