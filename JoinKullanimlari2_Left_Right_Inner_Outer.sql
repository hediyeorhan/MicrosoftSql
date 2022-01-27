-- inner join
-- outer join
-- musteri(musid, adsoyad, adres)
-- urun(urunid, ad, fiyat)
-- siparis(sipid, musid, urunid, miktar, tarih)

create database vizeOncesiLab
use vizeOncesiLab

create table musteri(musid int primary key,
adsoyad varchar(40), adres varchar(40));

create table urun(urunid int primary key, ad varchar(15), fiyat int);

create table siparis(sipid int primary key, musid int, urunid int, miktar int);

alter table siparis add constraint fk_siparis_musteri foreign key(musid) references musteri(musid);

alter table siparis add constraint fk_siparis_urun foreign key(urunid) references urun(urunid);

insert into musteri values(10, 'Ali Alioðlu', 'KONYA');
insert into musteri values(11, 'Ali Velioðlu', 'ANAKRA');
insert into musteri values(12, 'Veli Alioðlu', 'ANKARA');
insert into musteri values(13, 'Veli Aðaoðlu', 'ÝSTANBUL');
insert into musteri values(14, 'Ali Ataoðlu', 'KONYA');
insert into musteri values(15, 'Mehmet Ali Alioðlu', 'ANTALYA');


insert into urun values(100, 'Tel', 20);
insert into urun values(101, 'Bel', 60);
insert into urun values(102, 'Terlik', 30);
insert into urun values(103, 'Telefon', 100);
insert into urun values(104, 'Telgraf', 1000);
insert into urun values(105, 'Tela', 20);
insert into urun values(106, 'Top', 5);



insert into siparis values(1, 10, 100, 2);
insert into siparis values(2, 10, 101, 2);
insert into siparis values(3, 12, 101, 20);
insert into siparis values(4, 12, 102, 12);
insert into siparis values(5, 13, 102, 6);
insert into siparis values(6, 14, 104, 4);
insert into siparis values(7, 14, 104, 21);


-- 12' den fazla urun alan musterilerin adsoyad bilgisi
select adsoyad from musteri where musid in(select musid from siparis where miktar>12);


-- inner join -- (Join ile birlikte on kullanýlýr.)!! -- kesiþim hemm id tutanlarý hem sipariþi olanlarý aldýk.
-- !! Ýki tabloyu birbirlerine baðlayarak listeledik..
select * from musteri join siparis on musteri.musid=siparis.musid;

select * from siparis; 
select * from musteri;

--outer join -- birleþim gibi sipariþi olmayan musterileri de getirir.
select * from musteri left outer join siparis on musteri.musid=siparis.musid; -- sipariþi olmayanlar da geldi.
select * from musteri right outer join siparis on musteri.musid=siparis.musid; -- musteriid olmayan musteri geldi sipariþi olmayan gelmedi

select * from musteri full outer join siparis on musteri.musid=siparis.musid; -- Her ikisi de gelir(left and right) ful kesiþim diyebiliriz.

insert into siparis(sipid, urunid, miktar) values(17, 100, 2);
insert into siparis(sipid, urunid, miktar) values(18, 120, 2); -- Böyle bir ürün tanýmlý olmadýðý için sipariþ ekleyemiyoruz.

select * from musteri full join siparis on musteri.musid = siparis.musid 
full join
urun on siparis.urunid = urun.urunid; -- Tüm tablolar birleþti.
