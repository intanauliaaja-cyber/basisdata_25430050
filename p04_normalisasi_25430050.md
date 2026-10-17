P04 Normalisasi Proyek: Toko Larosa IAN



NIM: 25430050

Nama: Intan Aulia Nurwulan



1\. Dokumen sumber dan UNF



Dokumen sumber: Nota Penjualan fiktif Toko Larosa IAN (No. Pesanan

PS-2610-0031), dari p02\_kebutuhan\_data\_25430050.md.



Satu nota menyimpan grup berulang barang (di dalam tanda { }), maksimal 8

baris (AB-01).



NOTA\_UNF (no\_pesanan, tanggal\_jam\_pesanan, kode\_admin, nama\_admin,

&#x20;         kode\_pelanggan, nama\_pelanggan, alamat\_tujuan\_pesanan,

&#x20;         { kode\_barang, nama\_barang, qty\_detail\_pesanan,

&#x20;           harga\_satuan\_detail\_pesanan, subtotal\_detail\_pesanan },

&#x20;         jumlah\_pesanan, potongan\_pesanan, ongkos\_kirim\_pesanan,

&#x20;         total\_pesanan, metode\_pembayaran, status\_pembayaran,

&#x20;         no\_resi\_pengiriman)



2\. Dependensi fungsional dan aturan bisnis



|FD|Dependensi|Dasar|
|-|-|-|
|FD1|no\_pesanan -> tanggal\_jam\_pesanan, kode\_admin, kode\_pelanggan, alamat\_tujuan\_pesanan, ongkos\_kirim\_pesanan, potongan\_pesanan|AB-01 (nomor pesanan unik)<br />AB-03 (potongan per pesanan)<br />AB-06 (alamat dan ongkos kirim per pesanan)|
|FD2|kode\_admin -> nama\_admin|Kode admin unik (kamus data)|
|FD3|kode\_pelanggan -> nama\_pelanggan|AB-02, AB-07 (kode pelanggan unik)|
|FD4|kode\_barang -> nama\_barang|Kode barang unik (kamus data)|
|FD5|(no\_pesanan, kode\_barang) -> qty\_detail\_pesanan, harga\_satuan\_detail\_pesanan|AB-01, AB-05 (harga disimpan per baris pesanan)|
|FD6|qty\_detail\_pesanan, harga\_satuan\_detail\_pesanan -> subtotal\_detail\_pesanan|Turunan|
|FD7|no\_pesanan -> metode\_pembayaran, status\_pembayaran|AB-08 (satu pesanan nol atau satu pembayaran)|
|FD8|no\_pesanan -> no\_resi\_pengiriman|AB-08 (satu pesanan nol atau satu pengiriman)|
|FD9|no\_pesanan -> jumlah\_pesanan, total\_pesanan|Turunan|



3\. Tahapan normalisasi



1NF



Grup berulang dihilangkan: satu baris untuk setiap barang di setiap pesanan.

Kunci primer menjadi komposit (no\_pesanan, kode\_barang).



NOTA\_1NF (no\_pesanan (PK), kode\_barang (PK), tanggal\_jam\_pesanan,

&#x20;         kode\_admin, nama\_admin, kode\_pelanggan, nama\_pelanggan,

&#x20;         alamat\_tujuan\_pesanan, nama\_barang, qty\_detail\_pesanan,

&#x20;         harga\_satuan\_detail\_pesanan, subtotal\_detail\_pesanan,

&#x20;         jumlah\_pesanan, potongan\_pesanan, ongkos\_kirim\_pesanan,

&#x20;         total\_pesanan, metode\_pembayaran, status\_pembayaran,

&#x20;         no\_resi\_pengiriman)



2NF



Atribut yang hanya bergantung pada no\_pesanan (FD1, FD7, FD8, FD9) dan yang

hanya bergantung pada kode\_barang (FD4) bergantung pada sebagian kunci

komposit. Keduanya dipisah menjadi relasi sendiri. Sisanya menjadi detail

pesanan.



PESANAN (no\_pesanan (PK), tanggal\_jam\_pesanan, kode\_admin, nama\_admin,

&#x20;        kode\_pelanggan, nama\_pelanggan, alamat\_tujuan\_pesanan,

&#x20;        jumlah\_pesanan, potongan\_pesanan, ongkos\_kirim\_pesanan,

&#x20;        total\_pesanan, metode\_pembayaran, status\_pembayaran,

&#x20;        no\_resi\_pengiriman)



DETAIL\_PESANAN (no\_pesanan (PK, FK), kode\_barang (PK, FK),

&#x20;               qty\_detail\_pesanan, harga\_satuan\_detail\_pesanan,

&#x20;               subtotal\_detail\_pesanan)



BARANG (kode\_barang (PK), nama\_barang)





3NF



Di relasi PESANAN terdapat dua rantai ketergantungan:

\- no\_pesanan -> kode\_admin -> nama\_admin

\- no\_pesanan -> kode\_pelanggan -> nama\_pelanggan



Admin dan pelanggan dipisah menjadi relasi sendiri.



Data pembayaran dan pengiriman bergantung langsung pada no\_pesanan, jadi

secara 3NF tidak wajib dipisah. Keduanya tetap dipisah sesuai ERD proyek,

karena berupa entitas sendiri dengan kardinalitas nol atau satu per pesanan

(AB-08: pengiriman hanya setelah lunas), sehingga kolomnya tidak terus-menerus

berisi NULL di tabel pesanan. Ini keputusan desain, bukan tuntutan 3NF.



Kategori barang tidak punya atribut lain yang bergantung padanya, jadi

kategori\_barang tetap 3NF jika disimpan di BARANG. ERD memisahkannya menjadi

tabel kategori supaya nilainya konsisten (Kemeja, Dress, Kain). Ini juga

keputusan desain.



Nilai turunan (subtotal\_detail\_pesanan, jumlah\_pesanan, total\_pesanan)

tidak disimpan (lihat bagian 5).



Skema hasil 3NF:



PESANAN (

&#x20;   no\_pesanan (PK),

&#x20;   tanggal\_jam\_pesanan,

&#x20;   kode\_admin (FK),

&#x20;   kode\_pelanggan (FK),

&#x20;   alamat\_tujuan\_pesanan,

&#x20;   ongkos\_kirim\_pesanan,

&#x20;   potongan\_pesanan

)



DETAIL\_PESANAN (

&#x20;   no\_pesanan (PK, FK),

&#x20;   kode\_barang (PK, FK),

&#x20;   qty\_detail\_pesanan,

&#x20;   harga\_satuan\_detail\_pesanan

)



BARANG (

&#x20;   kode\_barang (PK),

&#x20;   nama\_barang,

&#x20;   kategori\_barang (FK),

&#x20;   harga\_jual\_barang,

&#x20;   stok\_barang,

&#x20;   batas\_minimum\_stok

)



KATEGORI (

&#x20;   nama\_kategori (PK)

)



ADMIN (

&#x20;   kode\_admin (PK),

&#x20;   nama\_admin,

&#x20;   peran\_admin

)



PELANGGAN (

&#x20;   kode\_pelanggan (PK),

&#x20;   email\_pelanggan,

&#x20;   nama\_pelanggan,

&#x20;   no\_hp\_pelanggan,

&#x20;   alamat\_pelanggan,

&#x20;   status\_aktif\_pelanggan,

&#x20;   tgl\_daftar\_pelanggan

)



PEMBAYARAN (

&#x20;   no\_pembayaran (PK),

&#x20;   no\_pesanan (FK),

&#x20;   metode\_pembayaran,

&#x20;   jumlah\_bayar,

&#x20;   tanggal\_bayar,

&#x20;   status\_pembayaran

)



PENGIRIMAN (

&#x20;   no\_resi\_pengiriman (PK),

&#x20;   no\_pesanan (FK),

&#x20;   kurir,

&#x20;   tanggal\_kirim,

&#x20;   status\_kirim

)



Keterangan: (PK) = kunci primer, (FK) = kunci tamu. Kolom kode\_pelanggan di

PESANAN wajib diisi (AB-02).



Ringkasan tahapan:

|Tahap|Relasi|
|-|-|
|UNF|NOTA\_UNF|
|1NF|NOTA\_1NF|
|2NF|PESANAN, DETAIL\_PESANAN, BARANG|
|3NF|PESANAN, DETAIL\_PESANAN, BARANG, KATEGORI, ADMIN, PELANGGAN, PEMBAYARAN, PENGIRIMAN|





4\. Pemeriksaan BCNF per table



|Tabel|Penentu yang bukan kunci kandidat|Hasil|
|-|-|-|
|PESANAN|Tidak ada. Satu-satunya penentu adalah no\_pesanan (kunci)|Memenuhi BCNF|
|DETAIL\_PESANAN|Tidak ada. Satu-satunya penentu adalah (no\_pesanan, kode\_barang) (kunci)|Memenuhi BCNF|
|BARANG|Tidak ada. Satu-satunya penentu adalah kode\_barang (kunci)|Memenuhi BCNF|
|KATEGORI|Tidak ada. Hanya satu atribut, yaitu kuncinya|Memenuhi BCNF|
|ADMIN|Tidak ada. Satu-satunya penentu adalah kode\_admin (kunci)|Memenuhi BCNF|
|PELANGGAN|Tidak ada. Penentunya kode\_pelanggan dan email\_pelanggan, keduanya kunci kandidat (AB-07)|Memenuhi BCNF|
|PEMBAYARAN|Tidak ada. Penentunya no\_pembayaran dan no\_pesanan, keduanya kunci kandidat karena satu pesanan punya paling banyak satu pembayaran|Memenuhi BCNF|
|PENGIRIMAN|Tidak ada. Penentunya no\_resi\_pengiriman dan no\_pesanan, keduanya kunci kandidat karena satu pesanan punya paling banyak satu pengiriman|Memenuhi BCNF|





5\. Keputusan penyimpanan nilai turunan



|Nilai|Cara menghitung|Keputusan|Alasan|
|-|-|-|-|
|subtotal\_detail\_pesanan|qty x harga satuan|Tidak disimpan|Dapat dihitung dari detail pesanan, sehingga tidak mungkin tidak konsisten|
|jumlah\_pesanan|Jumlah seluruh subtotal pada satu pesanan|Tidak disimpan|Dapat dihitung dari detail pesanan|
|total\_pesanan|jumlah - potongan + ongkos kirim|Tidak disimpan|Dapat dihitung. Contoh nota PS-2610-0031: 555.000 - 6.000 + 18.000 = 567.000|
|potongan\_pesanan|-|Disimpan|Nilai potongan setiap pesanan harus tetap sama walau aturan potongan (AB-03) berubah kemudian|
|ongkos\_kirim\_pesanan|-|Disimpan|Ongkos kirim ditetapkan per pesanan (AB-06)|
|jumlah\_bayar|-|Disimpan|Mencatat jumlah uang yang benar-benar dibayarkan, bukan hasil hitung dari pesanan|





6\. Perubahan ERD proyek



| No|Bagian ERD|Sebelum|Sesudah|Alasan|
|-|-|-|-|-|
|1|admin, kunci primer|id\_pelanggan|id\_admin| Nama kunci primer tertukar dengan tabel pelanggan; kunci tamu di pesanan sudah bernama id\_admin|
|2|pelanggan, kode\_pelanggan|CHAR(6)|CHAR(7)|Format kode PL-0123 terdiri dari 7 karakter|
|3|pembayaran, jumlah bayar|jumlah bayar|jumlah\_bayar|Nama kolom tidak boleh berspasi; sesuai kamus data|
|4|pembayaran.id\_pesanan dan pengiriman.id\_pesanan|Tanpa UNIQUE|Ditambah UNIQUE|Satu pesanan punya paling banyak satu pembayaran dan satu pengiriman (FD7, FD8, AB-08)|
|5|Relasi pelanggan dan pesanan|Sisi pelanggan 0..1; id\_pelanggan di pesanan|Sisi pelanggan 1; id\_pelanggan di pesanan wajib diisi|AB-02: pesanan hanya dapat dibuat oleh pelanggan terdaftar yang berstatus aktif|
|6|pemasok|Tanpa kode\_pemasok|Ditambah kode\_pemasok VARCHAR(10) UNIQUE|Ada di kamus data (unik) dan entitas Pemasok pada dokumen kebutuhan data|
|7|pembayaran|Tanpa tanggal\_bayar|ditambah tanggal\_bayar DATE|Ada di entitas Pembayaran pada dokumen kebutuhan data|
|8|pengiriman|Tanpa kurir dan tanggal\_kirim|Ditambah kurir VARCHAR(50) dan tanggal\_kirim DATE|Ada di entitas Pengiriman pada dokumen kebutuhan data|





