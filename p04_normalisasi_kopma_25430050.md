P04 Normalisasi Kopma



NIM: 25430050

Nama: Intan Aulia Nurwulan



D.1 Dari UNF ke 1NF



Langkah 1: Relasi UNF



NOTA\_UNF (no\_nota\_penjualan, tgl\_penjualan, kode\_petugas, nama\_petugas,

&#x20;         no\_anggota, nama\_anggota,

&#x20;         { kode\_barang, nama\_barang, qty\_detail\_penjualan,

&#x20;           harga\_satuan\_detail\_penjualan, subtotal\_detail\_penjualan },

&#x20;         jumlah\_penjualan, diskon\_penjualan, total\_penjualan)



Langkah 2: Relasi 1NF



NOTA\_1NF (no\_nota\_penjualan (PK), kode\_barang (PK), tgl\_penjualan,

&#x20;         kode\_petugas, nama\_petugas, no\_anggota, nama\_anggota,

&#x20;         nama\_barang, qty\_detail\_penjualan,

&#x20;         harga\_satuan\_detail\_penjualan, subtotal\_detail\_penjualan,

&#x20;         jumlah\_penjualan, diskon\_penjualan, total\_penjualan)



D.2 Dependensi Fungsional



Langkah 3: Daftar FD



FD1: no\_nota\_penjualan -> tgl\_penjualan, kode\_petugas, no\_anggota   (AB-01)

FD2: kode\_petugas -> nama\_petugas

FD3: no\_anggota -> nama\_anggota                                      (AB-05)

FD4: kode\_barang -> nama\_barang

FD5: (no\_nota\_penjualan, kode\_barang) -> qty\_detail\_penjualan,

&#x20;                                        harga\_satuan\_detail\_penjualan (AB-04)

FD6: qty\_detail\_penjualan, harga\_satuan\_detail\_penjualan

&#x20;                                     -> subtotal\_detail\_penjualan   (turunan)





D.3 Menuju 2NF dan 3NF



Langkah 4: 2NF



PENJUALAN (no\_nota\_penjualan (PK), tgl\_penjualan, kode\_petugas,

&#x20;          nama\_petugas, no\_anggota, nama\_anggota,

&#x20;          jumlah\_penjualan, diskon\_penjualan, total\_penjualan)



DETAIL\_PENJUALAN (no\_nota\_penjualan (PK, FK), kode\_barang (PK, FK),

&#x20;                 qty\_detail\_penjualan, harga\_satuan\_detail\_penjualan,

&#x20;                 subtotal\_detail\_penjualan)



BARANG (kode\_barang (PK), nama\_barang)





Langkah 5: 3NF



PENJUALAN (no\_nota\_penjualan (PK), tgl\_penjualan, kode\_petugas (FK),

&#x20;          no\_anggota (FK), jumlah\_penjualan, diskon\_penjualan,

&#x20;          total\_penjualan)



PETUGAS (kode\_petugas (PK), nama\_petugas)



ANGGOTA (no\_anggota (PK), nama\_anggota)



Langkah 6: Nilai turunan



subtotal\_detail\_penjualan, jumlah\_penjualan, dan total\_penjualan dapat

dihitung dari detail dan status anggota. Nilai-nilai ini diputuskan tidak

disimpan di tabel operasional, sehingga tidak mungkin tidak konsisten.



Skema hasil 3NF



PENJUALAN (

&#x20;   no\_nota\_penjualan (PK),

&#x20;   tgl\_penjualan,

&#x20;   kode\_petugas (FK),

&#x20;   no\_anggota (FK),

&#x20;   bayar\_penjualan

)



DETAIL\_PENJUALAN (

&#x20;   no\_nota\_penjualan (PK, FK),

&#x20;   kode\_barang (PK, FK),

&#x20;   qty\_detail\_penjualan,

&#x20;   harga\_satuan\_detail\_penjualan

)



BARANG (

&#x20;   kode\_barang (PK),

&#x20;   nama\_barang,

&#x20;   kategori\_barang,

&#x20;   harga\_jual\_barang,

&#x20;   stok\_barang,

&#x20;   stok\_min\_barang

)



PETUGAS (

&#x20;   kode\_petugas (PK),

&#x20;   nama\_petugas,

&#x20;   peran\_petugas

)



ANGGOTA (

&#x20;   no\_anggota (PK),

&#x20;   nim\_anggota,

&#x20;   nama\_anggota,

&#x20;   prodi\_anggota,

&#x20;   no\_hp\_anggota,

&#x20;   status\_anggota,

&#x20;   tgl\_daftar\_anggota

)



Keterangan: (PK) = kunci primer, (FK) = kunci tamu



D.4 Mencocokkan dengan Skema Kanonik



Langkah 7: Perbandingan dengan Tabel 4.2



|Tabel|Kunci primer|Kunci unik|Kunci tamu|
|-|-|-|-|
|petugas|id\_petugas|kode\_petugas|-|
|anggota|id\_anggota|no\_anggota, nim\_anggota|-|
|barang|id\_barang|kode\_barang|-|
|pemasok|id\_pemasok|-|-|
|penjualan|id\_penjualan|no\_nota\_penjualan|id\_petugas, id\_anggota|
|detail\_penjualan|id\_penjualan, id\_barang|-|id\_penjualan, id\_barang|
|pembelian|id\_pembelian|-|id\_pemasok|
|detail\_pembelian|id\_pembelian, id\_barang|-|id\_pembelian, id\_barang|



Perbedaan utama:

\- Skema kanonik memakai kunci pengganti (surrogate key) id\_\* sebagai kunci

&#x20; primer, sedangkan hasil normalisasi saya memakai kode alami (misalnya

&#x20; no\_nota\_penjualan, kode\_barang) sebagai kunci primer. Pada skema kanonik,

&#x20; kode alami itu menjadi kunci unik.

\- Tabel pemasok, pembelian, dan detail\_pembelian ada di skema kanonik tetapi

&#x20; belum muncul di hasil saya, karena yang dinormalisasi di modul ini hanya

&#x20; nota penjualan.



Langkah 8: Pemeriksaan BCNF per table



|tabel|penentu yang bukan kunci kandidat|hasil|
|-|-|-|
|PENJUALAN|tidak ada, satu satunya penentu adalah no\_nota\_penjualan (kunci)|memenuhi BNCF|
|DETAIL\_PENJUALAN|tidak ada, satu satunya penentu adalah (no\_nota\_penjualan, kode\_barang) (kunci)|memenuhi BNCF|
|BARANG|tidak ada, satu satunya penentu adalah kode\_barang (kunci)|memenuhi BNCF|
|PETUGAS|tidak ada, satu satunya penentu adalah kode\_petugas (kunci)|memenuhi BNCF|
|ANGGOTA|tidak ada, penentunya no\_anggota dan nim\_anggota, keduanya kunci kandidat|memenuhi BNCF|



E. Latihan dan Modifikasi



E.1 Beberapa nomor telepon untuk setiap pemasok



Relasi pemasok saat ini menyimpan satu nomor telepon per pemasok. Jika satu

pemasok boleh punya beberapa nomor, telepon\_pemasok menjadi atribut

bernilai banyak, dan itu melanggar 1NF.



UNF (telepon menjadi grup berulang):



PEMASOK\_UNF (id\_pemasok, nama\_pemasok, alamat\_pemasok,

&#x20;            { telepon\_pemasok })



1NF (satu baris untuk setiap nomor, kunci primer komposit):



PEMASOK\_1NF (id\_pemasok (PK), telepon\_pemasok (PK),

&#x20;            nama\_pemasok, alamat\_pemasok)



2NF: nama\_pemasok dan alamat\_pemasok hanya bergantung pada sebagian kunci

(id\_pemasok), sehingga dipisah. Pada relasi hasil pemisahan tidak ada lagi

ketergantungan transitif, jadi 3NF juga terpenuhi.



Relasi baru:



PEMASOK (

&#x20;   id\_pemasok (PK),

&#x20;   nama\_pemasok,

&#x20;   alamat\_pemasok

)



TELEPON\_PEMASOK (

&#x20;   id\_pemasok (PK, FK),

&#x20;   no\_telepon\_pemasok (PK)

)



E.2 Contoh data yang melanggar 3NF



Andaikan nama\_anggota disimpan di tabel penjualan:



PENJUALAN (no\_nota\_penjualan (PK), tgl\_penjualan, kode\_petugas,

&#x20;          no\_anggota, nama\_anggota)



Pelanggaran 3NF: ada rantai no\_nota\_penjualan -> no\_anggota -> nama\_anggota.

nama\_anggota (bukan kunci) bergantung pada no\_anggota (bukan kunci).



Contoh data (anggota A-001 muncul di tiga nota):



| no\_nota\_penjualan | tgl\_penjualan | kode\_petugas | no\_anggota | nama\_anggota |

|-------------------|---------------|--------------|------------|--------------|

| PJ-2609-0001      | 2026-09-01    | P01          | A-001      | Budi Santoso |

| PJ-2609-0002      | 2026-09-03    | P01          | A-001      | Budi Santoso |

| PJ-2609-0003      | 2026-09-05    | P02          | A-001      | Budi Santoso |



Kueri ubah yang memperlihatkan anomali. Budi mengganti ejaan namanya, tetapi

hanya satu nota yang ikut diubah:



sql

UPDATE penjualan

SET nama\_anggota = 'Budi Santosa'

WHERE no\_nota\_penjualan = 'PJ-2609-0001';



Hasilnya, anggota A-001 punya dua nama yang berbeda:



sql

SELECT no\_anggota, COUNT(DISTINCT nama\_anggota) AS jumlah\_nama

FROM penjualan

GROUP BY no\_anggota

HAVING COUNT(DISTINCT nama\_anggota) > 1;



Data menjadi tidak konsisten (anomali ubah). Agar benar, UPDATE harus

mengubah semua baris dengan no\_anggota = 'A-001'. Jika nama\_anggota hanya

disimpan di tabel anggota, cukup satu baris yang diubah.

