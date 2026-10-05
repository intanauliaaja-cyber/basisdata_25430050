##### Dokumen Kebutuhan Data - Toko Larosa IAN



###### 1\. Latar belakang dan aktivitas organisasi



Toko Larosa IAN adalah toko fiktif yang melayani penjualan pakaian batik secara daring, pencatatan stok barang, transaksi pembelian pelanggan, serta pengelolaan data pemasok. Layanan ini mencakup pencatatan barang masuk dan keluar, pembuatan nota penjualan, dan laporan penjualan berkala.

Pelanggan mendaftar, lalu memesan barang batik. Admin toko mencatat pesanan, pembayaran, dan pengiriman. Petugas gudang memeriksa stok dan mencatat barang masuk dari pemasok. Setiap awal bulan, pemilik toko menerima laporan penjualan.



###### 2\. Aktor dan proses bisnis



|Kode|Proses bisnis|Aktor|Pemicu|
|-|-|-|-|
|PB-01|Mendaftarkan dan memperbarui data pelanggan|Pelanggan; Admin (mengubah status aktif)|Calon pelanggan ingin berbelanja|
|PB-02|Mengelola katalog barang|Admin|Ada barang baru atau perubahan harga|
|PB-03|Mencatat pesanan penjualan|Admin|Pelanggan memesan barang|
|PB-04|Mencatat pembayaran pesanan|Admin|Pelanggan membayar|
|PB-05|Mencatat pengiriman pesanan|Admin|Pesanan sudah dibayar|
|PB-06|Mencatat pembelian barang dari pemasok|Petugas gudang|Barang datang bersama faktur|
|PB-07|Mengelola data pemasok|Petugas gudang|Ada pemasok baru atau perubahan data pemasok|
|PB-08|Menyusun laporan penjualan berkala|Pemilik toko|Awal bulan|

## 

###### 3\. Dokumen sumber yang dianalisis



Nota penjualan fiktif Toko Larosa IAN:


TOKO LAROSA IAN - Nota Penjualan
No. Pesanan : PS-2610-0031
Tanggal     : 05-10-2026 14:20
Admin       : Ayu (A02)
Pelanggan   : PL-0123 / Sari W.
Alamat      : Jl. Melati No. 5, Metro

Barang                    Qty   Harga     Subtotal
Kemeja Batik Parang M      1    185.000    185.000
Dress Batik Kawung L       1    250.000    250.000
Kain Batik Tulis 2 m       1    120.000    120.000
-----------------------------------------------
Jumlah                                     555.000
Potongan pelanggan                           6.000
Ongkos kirim                                18.000
TOTAL                                      567.000
Pembayaran  : Transfer, Lunas
No. Resi    : RS-880231


Pembedahan:

* Identitas transaksi: nomor pesanan, tanggal-jam.
* Relasi: admin pencatat, pelanggan.
* Alamat tujuan: alamat pengiriman (disimpan per pesanan).
* Baris barang: barang, qty, harga saat transaksi.
* Nilai turunan (dihitung): subtotal, jumlah, total.
* Nilai yang disimpan: potongan pelanggan, ongkos kirim.
* Data pembayaran: metode, status lunas.
* Data pengiriman: nomor resi.
* 

###### 4\. Entitas kandidat dan elemen data



|Entitas kandidat|Elemen data utama|Sumber|
|-|-|-|
|Pelanggan|kode pelanggan, nama, email, nomor HP, alamat, status aktif|Formulir pendaftaran|
|Barang|kode barang, nama, kategori, harga jual, stok, batas minimum stok|Katalog, faktur pemasok|
|Pesanan|nomor pesanan, tanggal-jam, pelanggan, alamat tujuan, ongkos kirim, potongan|Nota penjualan|
|Detail pesanan|nomor pesanan, barang, qty, harga saat transaksi|Nota penjualan|
|Pembayaran|nomor pembayaran, pesanan, metode, jumlah bayar, tanggal bayar, status|Nota penjualan, bukti pembayaran|
|Pengiriman|nomor resi, pesanan, kurir, tanggal kirim, status kirim|Nota penjualan, resi|
|Pemasok|kode pemasok, nama, telepon, alamat|Faktur pemasok|
|Pembelian dan detailnya|nomor faktur, tanggal, pemasok, barang, qty, harga beli|Faktur pemasok|

###### 

###### 5\. Aturan bisnis



|Kode|Aturan bisnis|
|-|-|
|AB-01|Setiap pesanan memiliki nomor unik, minimal satu dan maksimal 8 baris barang.|
|AB-02|Pesanan hanya dapat dibuat oleh pelanggan terdaftar yang berstatus aktif.|
|AB-03|Pelanggan terdaftar aktif memperoleh potongan Rp6.000 untuk setiap pesanan.|
|AB-04|Stok barang tidak boleh negatif; pesanan ditolak bila qty melebihi stok tersedia.|
|AB-05|Harga satuan yang dipakai pada pesanan disimpan per baris dan tidak berubah meski harga katalog kemudian berubah.|
|AB-06|Alamat tujuan dan ongkos kirim disimpan per pesanan.|
|AB-07|Email pelanggan unik; pencarian pelanggan dapat dilakukan lewat kode pelanggan atau email.|
|AB-08|Pesanan hanya dikirim setelah pembayaran berstatus lunas.|
|AB-09|Stok barang bertambah sesuai qty pada faktur pembelian dari pemasok.|

###### 

###### 6\. Kebutuhan informasi



|Kode|Kebutuhan informasi|Data yang diperlukan|
|-|-|-|
|KI-01|Omzet dan jumlah pesanan per hari dan per bulan|Pesanan, detail pesanan|
|KI-02|Lima barang terlaris per bulan berdasarkan qty|Detail pesanan, barang|
|KI-03|Barang dengan stok di bawah batas minimum|Barang|
|KI-04|Sepuluh pelanggan dengan belanja terbesar per bulan|Pesanan, detail pesanan, pelanggan|
|KI-05|Pesanan yang sudah dibayar tetapi belum dikirim|Pesanan, pembayaran, pengiriman|
|KI-06|Riwayat pembelian barang per pemasok|Pembelian, pemasok|

###### 

###### 7\. Matriks CRUD



|Proses|Pelanggan|Barang|Pesanan|Detail|Pembayaran|Pengiriman|Pemasok|Pembelian|
|-|-|-|-|-|-|-|-|-|
|PB-01 Daftar/ubah pelanggan|C, U||||||||
|PB-02 Kelola katalog||C, U|||||||
|PB-03 Catat pesanan|R|R, U|C|C|||||
|PB-04 Catat pembayaran|||R, U||C||||
|PB-05 Catat pengiriman|||R, U||R|C|||
|PB-06 Catat pembelian||U|||||R|C|
|PB-07 Kelola pemasok|||||||C, U||
|PB-08 Laporan berkala|R|R|R|R|R|R|R|R|

###### 

###### 8\. Kamus data awal



|Elemen|Arti|Contoh|Aturan|Penanggung jawab|
|-|-|-|-|-|
|kode\_pelanggan|Kode pelanggan|PL-0123|Unik, format PL-4 digit|Admin|
|nama\_pelanggan|Nama lengkap pelanggan|Sari Wulandari|Wajib diisi|Admin|
|email\_pelanggan|Email pelanggan|sari@mail.com|Unik (AB-07), data pribadi|Admin|
|no\_hp\_pelanggan|Nomor HP pelanggan|0812xxxx|Data pribadi, akses terbatas|Admin|
|alamat\_pelanggan|Alamat utama pelanggan|Jl. Melati No. 5, Metro|Data pribadi, akses terbatas|Admin|
|status\_aktif\_pelanggan|Status keaktifan pelanggan|Aktif|Aktif atau Nonaktif (AB-02)|Admin|
|kode\_barang|Kode barang|BT-001|Unik|Admin|
|nama\_barang|Nama barang|Kemeja Batik Parang M|Wajib diisi|Admin|
|kategori\_barang|Kategori barang|Kemeja|Kemeja, Dress, atau Kain|Admin|
|harga\_jual\_barang|Harga jual di katalog|185000|Bilangan bulat >= 0 (rupiah)|Admin|
|stok\_barang|Jumlah barang tersedia|12|Bilangan bulat >= 0 (AB-04)|Petugas gudang|
|batas\_minimum\_stok|Batas stok menipis|3|Bilangan bulat >= 0|Petugas gudang|
|no\_pesanan|Nomor pesanan|PS-2610-0031|Unik per pesanan (AB-01)|Admin|
|tanggal\_jam\_pesanan|Waktu pesanan dibuat|2026-10-05 14:20|Wajib diisi|Admin|
|alamat\_tujuan\_pesanan|Alamat pengiriman pesanan|Jl. Melati No. 5, Metro|Disimpan per pesanan (AB-06)|Admin|
|ongkos\_kirim\_pesanan|Ongkos kirim pesanan|18000|Bilangan bulat >= 0 (rupiah)|Admin|
|qty\_detail\_pesanan|Jumlah barang pada baris pesanan|1|Bilangan bulat >= 1|Admin|
|harga\_satuan\_detail\_pesanan|Harga jual saat transaksi|185000|Bilangan bulat >= 0 (AB-05)|Admin|
|metode\_pembayaran|Cara pembayaran|Transfer|Transfer atau E-wallet|Admin|
|jumlah\_bayar|Jumlah yang dibayarkan|567000|Bilangan bulat >= 0 (rupiah)|Admin|
|status\_pembayaran|Status pembayaran|Lunas|Belum lunas atau Lunas (AB-08)|Admin|
|no\_resi\_pengiriman|Nomor resi pengiriman|RS-880231|Unik per pengiriman|Admin|
|kode\_pemasok|Kode pemasok|PM-01|Unik|Petugas gudang|
|no\_faktur\_pembelian|Nomor faktur pembelian|FK-2609-0007|Unik per faktur|Petugas gudang|
|harga\_beli\_detail\_pembelian|Harga beli dari pemasok|90000|Bilangan bulat >= 0 (rupiah)|Petugas gudang|

###### 

###### 9\. Kebutuhan non-fungsional data



* **Volume:** perkiraan 70 pesanan per hari (40 + 5 x P).
* **Retensi:** data transaksi disimpan minimal lima tahun.
* **Data pribadi:** nama, email, nomor HP, dan alamat pelanggan. Hanya admin dan pemilik toko yang boleh melihatnya; petugas gudang tidak boleh.
* **Perhitungan P:** dua digit terakhir NIM 25430050 adalah 50. 50 mod 9 = 5, maka P = 5 + 1 = **6**.

  * Batas maksimal item per pesanan = P + 2 = 8 (AB-01).
  * Potongan pelanggan = P ribu rupiah = Rp6.000 (AB-03).
  * Perkiraan volume harian = 40 + 5 x 6 = 70 pesanan.



###### 10\. Isu kualitas data yang diantisipasi



* Harga katalog berubah sehingga nota lama sulit dicek (AB-05).
* Stok barang menjadi negatif (AB-04).
* Alamat pelanggan berubah sehingga alamat pesanan lama ikut berubah (AB-06).
* Email pelanggan ganda (AB-07).

