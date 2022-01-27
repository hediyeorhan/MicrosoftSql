create table kitap(
      kitap_id int primary key identity(100, 1),
	  kitap_ad varchar(30) not null,
	  yazar_id int,
	  yayinevi_id int,
	  sayfa_sayisi int);

create table yazar(
      y_id int primary key identity(10, 10),
	  y_ad varchar(30),
	  y_yas int);


create table yayinevi(
      yevi_id int primary key identity(1 ,1),
	  yevi_ad varchar(30),
	  yevi_adres varchar(20));

alter table kitap add constraint fk_yazar_kitap foreign key(yazar_id) references yazar(y_id);

alter table kitap add fiyat int;

alter table kitap add constraint fk_yayinevi_id foreign key(yayinevi_id) references yayinevi(yevi_id);

insert into yazar values('Tolstoy', 60);
select * from yazar;

insert into yazar values('Dostoyevski', 55);
insert into yazar values('Ahmet Hamdi Tanpýnar', 40),
                        ('Necip Fazýl Kýsakürek', 70);


insert into yayinevi values('Ýþ Bankasý', 'Ýstanbul'),
                           ('Epsilon', 'Ankara'),
						   ('Can', 'Ýstanbul'),
						   ('Kültür', 'Konya');
						 
select * from yayinevi;

insert into kitap values('Ýnsan Ne ile Yaþar', 10, 1, 120, 45);
select * from kitap;

insert into kitap values('Suç ve Ceza', 20, 2, 1000, 120),
                        ('Çile', 40, 4, 300, 50),
						('Savaþ ve Barýþ',10, 1, 1200, 200),
						('Ölüm Manifestosu', 10, 1, 40, 20);

select kitap_id, kitap_ad from kitap where yazar_id=10;

select sum(fiyat) ToplamFiyat, count(*) KitapSayisi from kitap group by yazar_id;

select kitap_ad, y_ad from kitap, yazar; -- Anlamsýz bir tablo oluyor..

select kitap_ad, y_ad from kitap, yazar where kitap.yazar_id=yazar.y_id;  -- böyle de olur ama daha kolayý join kullanmak.

-- ayný sorguyu join ile yazalým
select kitap_ad, y_ad from kitap inner join yazar on kitap.yazar_id=yazar.y_id;

--outer join
select y_ad, sum(fiyat) Fiyat, count(kitap_ad) KitapSayisi from kitap right join yazar on kitap.yazar_id=yazar.y_id group by y_ad;

--outer join
select y_ad, sum(fiyat) Fiyat, count(kitap_ad) KitapSayisi from kitap left join yazar on kitap.yazar_id=yazar.y_id group by y_ad;

select kitap_id, kitap_ad, yazar_id, yayinevi_id, sayfa_sayisi, fiyat, yevi_ad, yevi_adres from kitap inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id;


select kitap_id, kitap_ad, yazar_id, yayinevi_id, sayfa_sayisi, fiyat, yevi_ad, yevi_adres from kitap inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id order by yevi_ad;

select yevi_ad, count(kitap_id) YayinevindekiKitapSayisi from kitap inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id group by yevi_ad;

-- yayinevine ait kitaplarý listeledik yayýnevi solda olduðu için left kullandýk
select yevi_ad, kitap_ad from yayinevi left join kitap on yayinevi.yevi_id=kitap.yayinevi_id;


select * from kitap inner join yazar on kitap.yazar_id=yazar.y_id inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id;


select yevi_ad, sum(distinct y_yas) from kitap inner join yazar on kitap.yazar_id = yazar.y_id inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id group by yevi_ad;


select * from kitap left join yazar on kitap.yazar_id = yazar.y_id inner join yayinevi on kitap.yayinevi_id = yayinevi.yevi_id;

-- cross join, self join : Tabloyu kendi kendisiyle join etme. --> Çok fazla kullanýlmazlar.

select * from kitap;
select * from yazar;
select * from yayinevi;

insert into kitap(kitap_ad, yayinevi_id, sayfa_sayisi, fiyat) values('Cesaret Hikayeleri', 2, 200, 32),
                                                                    ('Hayat Hikayeleri', 1, 100, 10),
																	('Cesaret', 1, 300, 60);

insert into kitap(kitap_ad, yazar_id, sayfa_sayisi, fiyat) values('Konak', 20, 200, 30),
                                                                    ('Bahçeli Konak', 10, 100, 12),
																	('Avlulu Konak', 1, 400, 70),
																	('Konaklamak', 20, 90, 5);

select kitap_ad, y_ad from kitap inner join yazar on kitap.yazar_id=yazar.y_id;

select kitap_ad, y_ad from kitap left join yazar on kitap.yazar_id=yazar.y_id;

select kitap_ad, y_ad, fiyat from kitap right join yazar on kitap.yazar_id=yazar.y_id;

select kitap_ad, y_ad, fiyat from kitap full join yazar on kitap.yazar_id=yazar.y_id;

select kitap_ad, y_ad, yevi_ad from kitap full join yazar on kitap.yazar_id=yazar.y_id inner join yayinevi on kitap.yayinevi_id=yayinevi.yevi_id;


select kitap_ad, yevi_ad from kitap right join yayinevi on kitap.yayinevi_id = yayinevi.yevi_id right join yazar on kitap.yazar_id=yazar.y_id;