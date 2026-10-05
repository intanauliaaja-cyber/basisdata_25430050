##### Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera (Kopma)



###### 1\. Latar belakang dan aktivitas organisasi



Kopma menjual alat tulis, makanan ringan, dan minuman di lingkungan kampus. Pembeli dapat berupa anggota atau umum. Mahasiswa mendaftar sebagai anggota dengan NIM, nama, program studi, dan nomor HP, lalu memperoleh nomor anggota berformat A-xxxx. Anggota aktif memperoleh diskon 5% untuk setiap nota.



Tiga kasir bekerja bergantian per sif. Kasir mencatat penjualan dan mencetak nota. Setiap sore petugas gudang memeriksa stok; bila stok suatu barang di bawah batas minimum, ia membuat pesanan pembelian ke pemasok. Ketika barang datang, stok bertambah sesuai faktur pemasok. Setiap awal bulan, ketua koperasi menerima laporan omzet, barang terlaris, barang dengan stok menipis, dan anggota paling aktif.

Kutipan wawancara. Ketua: "Harga barang sering naik, jadi kami bingung saat melihat nota lama." Petugas gudang: "Kadang di buku catatan stoknya malah minus." Kasir: "Anggota sering lupa membawa kartu, jadi kami mencarinya lewat NIM."



###### 2\. Aktor dan proses bisnis



|Kode|Proses bisnis|Aktor|Pemicu|
|-|-|-|-|
|PB-01|Mendaftarkan anggota|Kasir (atas permintaan mahasiswa)|Mahasiswa ingin menjadi anggota|
|PB-02|Mencatat penjualan|Kasir|Pembeli membayar di kasir|
|PB-03|Memesan barang ke pemasok|Petugas gudang|Stok di bawah batas minimum|
|PB-04|Menerima barang dari pemasok|Petugas gudang|Barang datang bersama faktur|
|PB-05|Menyusun laporan bulanan|Ketua koperasi|Awal bulan|

###### 

###### 3\. Dokumen sumber yang dianalisis



Nota penjualan Kopma (Gambar 2.5), contoh No. PJ-2609-0142. Elemen data pada nota berdasarkan anotasi gambar:

* Identitas transaksi: nomor nota, tanggal
* Relasi ke kasir dan anggota
* Barang, qty, harga saat transaksi
* Nilai turunan (dihitung): subtotal, jumlah, diskon anggota 5%, total
* Data pembayaran: bayar tunai, Kembali



###### 4\. Entitas kandidat dan elemen data



|Entitas kandidat|Elemen data utama|Sumber|
|-|-|-|
|Anggota|nomor anggota, NIM, nama, program studi, nomor HP, status aktif|Formulir pendaftaran|
|Barang|kode, nama, kategori, harga jual, stok, batas minimum stok|Daftar barang, faktur|
|Penjualan|nomor nota, tanggal-jam, kasir, anggota (opsional), bayar|Nota penjualan|
|Detail penjualan|nomor nota, barang, qty, harga saat transaksi|Nota penjualan|
|Petugas|kode petugas, nama, peran (kasir/gudang/ketua)|Wawancara|
|Pemasok|kode, nama, telepon, alamat|Faktur pemasok|
|Pembelian dan detailnya|nomor faktur, tanggal, pemasok, barang, qty, harga beli|Faktur pemasok|

###### 

###### 5\. Aturan bisnis



|Kode|Aturan bisnis|
|-|-|
|AB-01|Setiap nota memiliki nomor unik dan minimal satu baris barang.|
|AB-02|Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 5%.|
|AB-03|Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok tersedia.|
|AB-04|Harga jual yang dipakai pada nota disimpan per baris dan tidak berubah meski harga barang kemudian naik.|
|AB-05|NIM anggota unik; pencarian anggota dapat dilakukan lewat nomor anggota atau NIM.|
|AB-06|Pesanan pembelian dibuat bila stok kurang dari batas minimum barang tersebut.|

###### 

###### 6\. Kebutuhan informasi



|Kode|Kebutuhan informasi|Data yang diperlukan|
|-|-|-|
|KI-01|Omzet dan jumlah nota per hari dan per bulan|Penjualan, detail penjualan|
|KI-02|Lima barang terlaris per bulan berdasarkan qty|Detail penjualan, barang|
|KI-03|Barang dengan stok di bawah batas minimum|Barang|
|KI-04|Sepuluh anggota dengan belanja terbesar per bulan|Penjualan, detail penjualan, anggota|

###### 

###### 7\. Matriks CRUD



|Proses|Anggota|Barang|Penjualan|Detail|Pemasok|Pembelian|
|-|-|-|-|-|-|-|
|PB-01 Daftar anggota|C||||||
|PB-02 Catat penjualan|R|R, U|C|C|||
|PB-03 Pesan ke pemasok||R|||R|C|
|PB-04 Terima barang||U|||R|U|
|PB-05 Laporan bulanan|R|R|R|R||R|

###### 

###### 8\. Kamus data awal



|Elemen|Arti|Contoh|Aturan|Penanggung jawab|
|-|-|-|-|-|
|no\_anggota|Nomor anggota koperasi|A-0457|Unik, format A-4 digit|Ketua|
|nim\_anggota|NIM anggota|2301010123|Unik, 10 digit|Ketua|
|no\_hp\_anggota|Nomor HP anggota|0812xxxx|Data pribadi, akses terbatas|Ketua|
|no\_nota\_penjualan|Nomor nota penjualan|PJ-2609-0142|Unik per nota|Kasir|
|harga\_satuan\_detail\_penjualan|Harga jual saat transaksi|4000|Bilangan bulat >= 0 (rupiah)|Kasir|
|stok\_barang|Jumlah barang tersedia|35|Bilangan bulat >= 0 (AB-03)|Petugas gudang|

###### 

###### 9\. Kebutuhan non-fungsional data



* Perkiraan +-150 nota per hari.
* Data transaksi disimpan minimal lima tahun.
* Nomor HP anggota hanya boleh dilihat oleh ketua.



###### 10\. Isu kualitas data yang diantisipasi



Berdasarkan kutipan wawancara:

* Harga barang sering naik, sehingga nota lama sulit dicek (AB-04).
* Stok di buku catatan kadang minus (AB-03).
* Anggota lupa membawa kartu, sehingga dicari lewat NIM (AB-05).

