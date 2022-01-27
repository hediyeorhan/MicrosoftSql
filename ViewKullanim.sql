use VTDERS21EKIM

--SORU1 : Personel tablosunda VIEW_AD_SOYAD view olu�tur. ayn� soruyu isminde sorguyu gizleyecek �ekilde  GIZLI_VIEW_AD_SOYAD isminde view olu�tural�m.
-- view i�eri�ini g�sterelim.

create view VIEW_AD_SOYAD
as
(select personel.isim, personel.soyisim from personel);

select * from VIEW_AD_SOYAD

-- Gizli view olu�turma
create view GIZLI_VIEW_AD_SOYAD with encryption
as
(select personel.isim, personel.soyisim from personel);

select * from GIZLI_VIEW_AD_SOYAD; -- i�ine m�dahale edilemeyen de�i�tirilemeyen view olu�turduk.


-- SORU 2 : view_maas_rapor �eklinde view min, max, ort, toplam maa�� g�stersin

create view view_maas_rapor
as
(select min(maas) as MinMaas, max(maas) as MaxMaas, avg(maas) as OrtMaas, sum(maas) as ToplamMaas from personel);

select * from view_maas_rapor


-- SORU 3 : view_maas_rapor view'�na yeni  bir  alan ekleme. De�i�iklik yapma alter view --viewadi--

alter view view_maas_rapor
as 
(select count(*) as ToplamKisiSayisi, min(maas) as MinMaas, max(maas) as MaxMaas, avg(maas) as OrtMaas, sum(maas) as ToplamMaas from personel);
select * from view_maas_rapor


-- SORU 4 : Kitap ad�nda Q olanlar� g�sterelim view'da
create view view_kitap_yazar
as
(select isim from kitaplar where isim like ('%Q%'));


select * from view_kitap_yazar;
-- Hocan�n yapt��� farkl� soru san�r�m Q eklemeden yazd�.
create view view_kitap_yazar2
as
(select yazarlar.isim as YazarIsim, YAZARLAR.soyisim as YazarSoyisim, kitaplar.isim as KitapIsim from kitaplar, yazarlar, kyazarlar
where kitaplar.no = kyazarlar.no and
yazarlar.yazar_no = kyazarlar.NO and
kitaplar.isim like ('%Q%'));


select * from view_kitap_yazar2;

----
create view view_kitap_yazar3
as
(select yazarlar.isim as YazarIsim, YAZARLAR.soyisim as YazarSoyisim, kitaplar.isim as KitapIsim from kitaplar, yazarlar, kyazarlar
where kitaplar.no = kyazarlar.no and
yazarlar.yazar_no = kyazarlar.NO );


select * from view_kitap_yazar3 v where v.KitapIsim like ('%Q%');

-- SORU 5 : genel maas view'� ile personelin ortalama ma��n� bulal�m

create view view_genel_maas
as
(select avg(maas) as OrtMaas from personel);

select * from view_genel_maas

select * from personel where maas>(select * from view_genel_maas);
-- OR 
select * from personel p, view_genel_maas v where maas>v.OrtMaas order by maas asc;

-- TOP : Ortalamadan d���k en y�ksek maa�
select top 1 * from personel p, view_genel_maas v where maas<v.OrtMaas order by maas asc;

-- TOP : Ortalamadan y�ksek en d���k maa�
select top 1 * from personel p, view_genel_maas v where maas<v.OrtMaas order by maas asc;


-- SORU 6 : �lkesindeki ort maa�tan daha y�ksek maa� alan personel
create view view_ulke_maas
as
select ulke, avg(maas) as OrtMaas from personel group by ulke;

select * from view_ulke_maas;

select * from personel p, view_ulke_maas v where p.maas>v.OrtMaas
and p.ulke=v.ulke