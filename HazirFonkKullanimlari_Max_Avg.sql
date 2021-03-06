USE VTDERS21EKIM
--AVG fonksiyonu
SELECT AVG(MAAS) ORTALAMA_MAAS FROM PERSONEL
SELECT AVG(MAAS) TURK?YEDEK?_ORTALAMA_MAAS FROM PERSONEL WHERE ULKE='T?rkiye'

SELECT ROUND (5,576,1) as round_1,
       ROUND (5,576,2) as round_2,
	   CEILING (5.576) as CEILING_,
	   FLOOR (5.576) as FLOOR_

SELECT COUNT(MAAS) AS Say? FROM PERSONEL--eger null karakyeri sat?rda olsayd? null sat?r?n? saymayacakt?
SELECT COUNT(*) AS Say? FROM PERSONEL--Null karakterinide say?yor
SELECT COUNT(MAAS) AS Say? FROM PERSONEL WHERE ULKE='ABD'

--DISTINCT 
SELECT COUNT(DISTINCT ULKE) AS ULKE_SAYISI FROM PERSONEL

--MAX() MIN() FONKSIYONU
SELECT MAX(YAS) AS ENYASLI, MIN(YAS) AS ENGECNC FROM PERSONEL
SELECT ISIM  ,yas AS ENYASLI FROM PERSONEL where yas=(select MAX(YAS) from PERSONEL)
SELECT ISIM  ,yas AS ENGENC FROM PERSONEL where yas=(select MIN(YAS) from PERSONEL)

--SUM FONLSIYONU
SELECT SUM(MAAS) AS TOPLAM_MAAS FROM PERSONEL

--GROUP BY
select ulke from PERSONEL GROUP BY ULKE
SELECT ULKE, AVG(MAAS) AS ORTALAMA_MAAS_ULKE FROM PERSONEL GROUP BY ULKE--ULKELERE GORE ORTALAMA MAASLARI GRUPLAYALIM
SELECT CINSIYET, AVG(MAAS) AS ORTALAMA_MAAS_CINSIYET FROM PERSONEL GROUP BY CINSIYET--CINSIYETE GORE ORTALAMA MAASLARI GRUPLAYALIM
SELECT ULKE,KENT FROM PERSONEL GROUP BY ULKE,KENT--turk?ye de ankara 2 kay?t var bu sorguda yaln?z 1 kay?t getirdi
SELECT COUNT(*), ULKE,KENT FROM PERSONEL GROUP BY ULKE,KENT--Count ile butun kay?tlar? getirdik
SELECT ULKE, CINSIYET, AVG(YAS), COUNT(*) FROM PERSONEL GROUP BY ULKE, CINSIYET
SELECT ULKE, CINSIYET, AVG(YAS), COUNT(*) FROM PERSONEL WHERE MAAS>2000 GROUP BY ULKE, CINSIYET

--Having ifadesi
SELECT KENT , COUNT(*) as CALISAN_SAYISI FROM PERSONEL GROUP BY KENT HAVING COUNT(*)>1
SELECT ULKE ,CINSIYET,AVG(MAAS) AS ORTALAMA_MAAS FROM PERSONEL GROUP BY ULKE,CINSIYET HAVING AVG(MAAS)>3000
SELECT ULKE, AVG(YAS) AS ORT_YAS,AVG(MAAS) AS ORT_MAAS ,COUNT(*) AS KISI_SAY FROM PERSONEL WHERE MAAS>=2000 GROUP BY ULKE HAVING AVG(YAS)>=25

--Personelleri ulkelerine gore gruplayarak ortalama maas? en buyuyuk olan ulkenin maas ortalamas?n? getiren sorguyu yaz?n?z
--1.YOL
SELECT TOP(1) ULKE, AVG(MAAS) FROM PERSONEL GROUP BY ULKE ORDER BY AVG(MAAS) DESC
--2.YOL
SELECT MAX(ORT_MAAS) AS ORTALAMA_MAAS FROM(SELECT ULKE as ulke_adi,AVG(MAAS) AS ORT_MAAS FROM PERSONEL GROUP BY ULKE ) AS MAAS 
