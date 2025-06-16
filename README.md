# Pemodelan Risiko COVID-19 di Sulawesi Selatan Menggunakan Model CAR Localised

Repositori ini merupakan tugas UAS mata kuliah **Statistika Spasial** yang disusun oleh **Yuni Sabrina Effendy**. Analisis dilakukan untuk memodelkan **risiko relatif penyebaran COVID-19** di wilayah Sulawesi Selatan menggunakan pendekatan **Conditional Autoregressive (CAR) Localised Model**.

## Dataset
- Data COVID-19, populasi, densitas, dan jarak dari ibu kota untuk 24 kabupaten/kota di Sulawesi Selatan (2020).
- Sumber: data sekunder dan shapefile spasial (`.shp`).

## Metodologi
- Model spasial: `S.CARlocalised` dari package `CARBayes` (Bayesian Spatial Modelling).
- Diuji dua kombinasi prior `inverse-gamma`:  
  - (0.5, 0.005)  
  - (0.1, 0.001)

- Evaluasi model menggunakan:  
  - DIC (Deviance Information Criterion)  
  - WAIC (Widely Applicable Information Criterion)  
  - LMPL (Log Marginal Pseudo-Likelihood)

## 🧾 Hasil Utama
- **Model terbaik**: CAR Localised dengan prior inverse-gamma(0.1, 0.001)  
  - DIC = 294.34  
  - WAIC = 322.43
- **Moran's I** = 0.0449 (tidak signifikan) → tidak ada autokorelasi spasial kuat.
- **Jarak terhadap ibu kota** signifikan negatif → makin jauh dari ibu kota, risiko COVID-19 lebih rendah.
- Risiko relatif (`RR`) tertinggi berada di **Makassar** (RR > 2.8).

## 🗺️ Visualisasi
Peta sebaran risiko relatif dihasilkan menggunakan `ggplot2` dan `sf`, dengan gradasi warna dari **biru (RR < 1)** hingga **merah (RR > 1)**.

## 📦 Tools & Library
- R  
- Packages: `CARBayes`, `rgdal`, `sf`, `spdep`, `ggplot2`, `ape`

## 👩‍💻 Author
**Yuni Sabrina Effendy**  
