USE toko_050;

-- KI-03: barang yang perlu dipesan ulang
-- Pertanyaan: barang apa yang stoknya di bawah batas minimum?
-- Harapan: hanya barang dengan stok_barang < batas_minimum_stok yang muncul, lengkap dengan kolom kurang (selisih batas dan stok) yang selalu bernilai positif; barang dengan kekurangan terbesar ada di baris paling atas. Barang yang stoknya sama dengan atau di atas batas tidak muncul.
SELECT kode_barang, nama_barang, stok_barang, batas_minimum_stok,
       batas_minimum_stok - stok_barang AS kurang
FROM barang
WHERE stok_barang < batas_minimum_stok
ORDER BY kurang DESC;

-- KI-03: status stok semua barang
-- Pertanyaan: tiap barang stoknya perlu dipesan, tepat di batas, atau aman?
-- Harapan: semua baris tabel barang muncul (jumlah baris sama dengan COUNT(*) barang), masing-masing berstatus 'perlu dipesan ulang', 'tepat di batas', atau 'aman'. Baris diurutkan dari stok terkecil, sehingga barang berstatus 'perlu dipesan ulang' cenderung berkumpul di bagian atas. Barang yang tidak muncul di kueri pertama harus berstatus 'tepat di batas' atau 'aman' di sini.
SELECT nama_barang, stok_barang, batas_minimum_stok,
       CASE WHEN stok_barang < batas_minimum_stok THEN 'perlu dipesan ulang'
            WHEN stok_barang = batas_minimum_stok THEN 'tepat di batas'
            ELSE 'aman' END AS status_stok
FROM barang
ORDER BY stok_barang;

-- KI-02 (pendukung): barang tertentu
-- Pertanyaan: info stok dan harga untuk barang dengan kode tertentu?
-- Harapan: hanya barang berkode BT-001, BT-002, dan BT-003 yang muncul (maksimal 3 baris), masing-masing dengan harga jual dan stoknya. Kode yang tidak ada di tabel tidak menghasilkan baris, dan tidak muncul galat.
SELECT kode_barang, nama_barang, harga_jual_barang, stok_barang
FROM barang
WHERE kode_barang IN ('BT-001', 'BT-002', 'BT-003');

-- KI-01 (pendukung): pesanan pada rentang waktu
-- Pertanyaan: pesanan apa saja yang masuk pada 5 Oktober 2026?
-- Harapan: hanya pesanan yang tanggal_jam_pesanan-nya jatuh pada 5 Oktober 2026 (pukul 00:00 sampai 23:59) yang muncul, dengan waktu tampil berformat dd-mm-yyyy jj:mm dan terurut dari yang paling pagi. Pesanan tanggal 4 dan 6 Oktober tidak ikut. Jika tidak ada pesanan pada hari itu, hasilnya kosong.
SELECT no_pesanan,
       DATE_FORMAT(tanggal_jam_pesanan, '%d-%m-%Y %H:%i') AS waktu_pesan,
       ongkos_kirim_pesanan
FROM pesanan
WHERE tanggal_jam_pesanan >= '2026-10-05' AND tanggal_jam_pesanan < '2026-10-06'
ORDER BY tanggal_jam_pesanan;

-- KI-04 (pendukung): pencarian pelanggan lewat email (AB-07)
-- Pertanyaan: pelanggan mana yang emailnya berakhiran @mail.com?
-- Harapan: hanya pelanggan dengan email berakhiran @mail.com yang muncul, dengan kolom pelanggan berbentuk "Nama (kode)", terurut menurut abjad nama. Pelanggan dengan domain email lain tidak ikut.
SELECT CONCAT(nama_pelanggan, ' (', kode_pelanggan, ')') AS pelanggan,
       email_pelanggan
FROM pelanggan
WHERE email_pelanggan LIKE '%@mail.com'
ORDER BY nama_pelanggan;

-- KI-04 (pendukung): kelengkapan data pelanggan
-- Pertanyaan: pelanggan mana yang belum punya nomor HP?
-- Harapan: hanya pelanggan yang no_hp_pelanggan-nya NULL yang muncul, sehingga kolom no_hp_pelanggan pada semua baris hasil kosong (NULL). Jika semua pelanggan sudah punya nomor HP, hasilnya kosong. IS NULL dipakai karena = NULL tidak akan pernah menghasilkan baris.
SELECT kode_pelanggan, nama_pelanggan, no_hp_pelanggan
FROM pelanggan
WHERE no_hp_pelanggan IS NULL;

-- KI-05 (pendukung): pembayaran lunas pada rentang tanggal
-- Pertanyaan: pembayaran apa saja yang sudah lunas selama Oktober 2026?
-- Harapan: hanya pembayaran berstatus 'Lunas' dengan tanggal_bayar antara 1 dan 31 Oktober 2026 yang muncul, terurut dari tanggal paling awal. Pembayaran 'Belum lunas' dan pembayaran di luar Oktober tidak ikut.
SELECT no_pembayaran, id_pesanan, metode_pembayaran, jumlah_bayar, tanggal_bayar
FROM pembayaran
WHERE status_pembayaran = 'Lunas'
  AND tanggal_bayar BETWEEN '2026-10-01' AND '2026-10-31'
ORDER BY tanggal_bayar;

-- KI-05 (pendukung): pembayaran belum lunas (belum boleh dikirim, AB-08)
-- Pertanyaan: pesanan mana yang pembayarannya belum lunas?
-- Harapan: hanya pembayaran berstatus 'Belum lunas' yang muncul, terurut dari tanggal paling awal. Id pesanan pada hasil ini adalah pesanan yang belum boleh dikirim menurut AB-08. Tidak ada baris berstatus 'Lunas' di hasil.
SELECT no_pembayaran, id_pesanan, jumlah_bayar, tanggal_bayar
FROM pembayaran
WHERE status_pembayaran = 'Belum lunas'
ORDER BY tanggal_bayar;

-- KI-06 (pendukung): faktur pembelian dari satu pemasok
-- Pertanyaan: faktur apa saja dari pemasok nomor 1, dari yang terbaru?
-- Harapan: hanya faktur pembelian milik pemasok dengan id 1 yang muncul, dengan tanggal berformat dd-mm-yyyy dan status pembelian. Faktur terbaru ada di baris paling atas, yang terlama di bawah. Faktur pemasok lain tidak ikut.
SELECT no_faktur_pembelian, DATE_FORMAT(tgl_pembelian, '%d-%m-%Y') AS tanggal,
       status_pembelian
FROM pembelian
WHERE id_pemasok = 1
ORDER BY tgl_pembelian DESC;

-- KI-02 (pendukung): baris pesanan dengan qty banyak
-- Pertanyaan: baris pesanan mana yang qty-nya 2 atau lebih, subtotal terbesar dulu?
-- Harapan: hanya baris detail_pesanan dengan qty 2 atau lebih yang muncul, dengan kolom subtotal (qty x harga satuan) terurut dari yang terbesar. Hasil dibatasi paling banyak 10 baris. Baris ber-qty 1 tidak ikut.
SELECT id_pesanan, id_barang, qty_detail_pesanan, harga_satuan_detail_pesanan,
       qty_detail_pesanan * harga_satuan_detail_pesanan AS subtotal
FROM detail_pesanan
WHERE qty_detail_pesanan >= 2
ORDER BY subtotal DESC
LIMIT 10;

-- ===== KI yang belum dapat dijawab dengan satu tabel (dijawab di Pertemuan 9-12) =====
-- KI-01 omzet dan jumlah pesanan per hari/bulan (butuh SUM, COUNT, dan JOIN detail)
-- KI-02 lima barang terlaris per bulan (butuh SUM qty dan JOIN barang)
-- KI-04 sepuluh pelanggan belanja terbesar (butuh JOIN tiga tabel dan SUM)
-- KI-05 pesanan sudah dibayar tetapi belum dikirim (butuh JOIN pesanan, pembayaran, pengiriman)
-- KI-06 riwayat pembelian per pemasok dengan nama pemasok (butuh JOIN pemasok)