use VTDERS21EKIM

--SORU1 : Personel tablosunda VIEW_AD_SOYAD view oluþtur. ayný soruyu isminde sorguyu gizleyecek þekilde  GIZLI_VIEW_AD_SOYAD isminde view oluþturalým.
-- view içeriðini gösterelim.

create view VIEW_AD_SOYAD
as
(select personel.isim, personel.soyisim from personel);

select * from VIEW_AD_SOYAD

-- Gizli view oluþturma
create view GIZLI_VIEW_AD_SOYAD with encryption
as
(select personel.isim, personel.soyisim from personel);

select * from GIZLI_VIEW_AD_SOYAD; -- içine müdahale edilemeyen deðiþtirilemeyen view oluþturduk.


-- SORU 2 : view_maas_rapor þeklinde view min, max, ort, toplam maaþý göstersin

create view view_maas_rapor
as
(select min(maas) as MinMaas, max(maas) as MaxMaas, avg(maas) as OrtMaas, sum(maas) as ToplamMaas from personel);

select * from view_maas_rapor


-- SORU 3 : view_maas_rapor view'ýna yeni  bir  alan ekleme. Deðiþiklik yapma alter view --viewadi--

alter view view_maas_rapor
as 
(select count(*) as ToplamKisiSayisi, min(maas) as MinMaas, max(maas) as MaxMaas, avg(maas) as OrtMaas, sum(maas) as ToplamMaas from personel);
select * from view_maas_rapor


-- SORU 4 : Kitap adýnda Q olanlarý gösterelim view'da
create view view_kitap_yazar
as
(select isim from kitaplar where isim like ('%Q%'));


select * from view_kitap_yazar;
-- Hocanýn yaptýðý farklý soru sanýrým Q eklemeden yazdý.
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

-- SORU 5 : genel maas view'ý ile personelin ortalama maþýný bulalým

create view view_genel_maas
as
(select avg(maas) as OrtMaas from personel);

select * from view_genel_maas

select * from personel where maas>(select * from view_genel_maas);
-- OR 
select * from personel p, view_genel_maas v where maas>v.OrtMaas order by maas asc;

-- TOP : Ortalamadan düþük en yüksek maaþ
select top 1 * from personel p, view_genel_maas v where maas<v.OrtMaas order by maas asc;

-- TOP : Ortalamadan yüksek en düþük maaþ
select top 1 * from personel p, view_genel_maas v where maas<v.OrtMaas order by maas asc;


-- SORU 6 : Ülkesindeki ort maaþtan daha yüksek maaþ alan personel
create view view_ulke_maas
as
select ulke, avg(maas) as OrtMaas from personel group by ulke;

select * from view_ulke_maas;

select * from personel p, view_ulke_maas v where p.maas>v.OrtMaas
and p.ulke=v.ulke