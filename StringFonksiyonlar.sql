-- STRING FONKSIYONLAR (Hazir fonk.)
use VTDERS21EKIM
select 'Merhaba' as string --s�tun adi verdim.

select ascii('A') as ASCII_DEGER

select char(65) as CHAR_DEGER

-- T-SQL (Transaction SQL)

-- A'dan Z'ye T�m Karakterleri Yazma      **** D�ng� halinde yazd�rd�k ****
declare @start int
set @start = 65
while (@start<=90)
begin
    print(char(@start))
	set @start += 1
end

----------------------------------
--a'dan z'ye
declare @start int
set @start = 97
while(@start<=122)
begin
    print(char(@start))
	set @start += @start
end


-- LTRIM(Sol bo�lu�u siler) ve RTRIM(Sa� bo�lu�u siler) FONKSIYONLARI

select 'Merhaba'
select '                Merhaba'
select ltrim('                Merhaba') --Bo�lu�u yazmaz b�ylece bellekte bo�a yer kaplamaz.

select ad, soyad from Kisiler
select ltrim(ad), ltrim(soyad) from Kisiler
select ad + soyad as ISIM_SOYISIM from Kisiler

select ltrim(ad) +' ' + ltrim(soyad) as IsimSoyisim from Kisiler


select rtrim(ltrim(ad)) +' ' + rtrim(ltrim(soyad)) as IsimSoyisim from Kisiler

-- LOWER ve UPPER FONKSIYONU
select 'Merhaba'
select UPPER('Merhaba') -- T�m karakterler b�y�k
select LOWER('Merhaba') -- T�m karakterler k���k

select lower(rtrim(ltrim(ad))) +' ' + lower(rtrim(ltrim(soyad))) as IsimSoyisim from Kisiler

-- LEN FONKSIYONU
select len('Merhaba')
select len('Merhaba     ') -- bo�luk karakterini saym�yor! sondaki
select len('         Merhaba') --Ba�lang��taki bo�luklar� al�yor.

-----------------------------------------------

-- LEFT ve RIGT FONKSIYONLARI
select left('NECMETTIN ERBAKAN UNIVERSITESI', 5) -- soldan ba�lar ve ilk 5 karakteri getirir.
select right('NECMETTIN ERBAKAN UNIVERSITESI', 8) -- sa�dan ba�lar ve 8 karakteri al�r.
-----------------------------------------------

-- CHARINDEX FONKSIYONU
select charindex('a','alikaya@gmail.com') -- hangi ifadenin i�inde hangi karakteri arad���m�z� belirtiyoruz ve indexini veriyor. Yoksa 0


-- SUBSTRING FONK.
select substring('alikaya@gmail.com', 3, 4) -- 3. indisten ba�la 4.karakteri getir.

select * from Kisiler


-- �rnek : T�m kay�tlar�n domain-name bilgilerini getir. Mail i�in yapt� hoca. ben de veritaban�nda mail yok.
-- a harfinden sonras�n� buldu ve yazd� a dan ba�lad� adres uzunlu�u kadar gitti
select substring(adres, charindex('a', adres), len(adres)) from Kisiler

-------------------------------------------
-- Hangi domain name in ka� defa tekrar etti�ini getiren sorguyu yaz�n.
select  substring(mail, charindex('@', mail)+1, len(mail)), count(*) as ToplamSayi from Kisiler -- veya count(mail)
group by substring(mail, charindex('@', mail)+1, len(mail))


-- Ka� farkl� domanin-name oldu�unu getiren sorgu
select count(distinct(substring(mail, charindex('@', mail)+1, len(mail)))) from Kisiler

select replace('Hediye ORHAN', 'R', 'r')