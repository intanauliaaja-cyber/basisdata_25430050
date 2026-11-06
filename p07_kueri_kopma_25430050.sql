USE kopma_050;

-- ===== D.1 Proyeksi dan Penyaringan =====

-- KI-03: barang yang perlu dipesan ulang
-- Pertanyaan: barang apa yang stoknya di bawah batas minimum?
-- Harapan: 1 baris, Roti Cokelat (MKN-001), stok 6 dari minimum 10, kurang 4.
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
       stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_barang < stok_min_barang
ORDER BY kurang DESC;

-- Pertanyaan: barang apa saja yang kategorinya ATK atau minuman?
-- Harapan: 3 baris (Buku Tulis 58, Pulpen Gel 0.5, Air Mineral 600);
--          ATK tampil dulu baru minuman, Roti Cokelat tidak muncul.
SELECT kode_barang, nama_barang, kategori_barang, harga_jual_barang
FROM barang
WHERE kategori_barang IN ('ATK', 'minuman')
ORDER BY kategori_barang, nama_barang;

-- Pertanyaan: nota apa saja yang terjadi pada September 2026?
-- Harapan: 3 baris, urut dari yang paling awal: PJ-2609-0142 (24 Sep 10:15),
--          PJ-2609-0144 (25 Sep 09:00), PJ-2609-0145 (25 Sep 09:30).
SELECT no_nota_penjualan, tgl_penjualan, bayar_penjualan
FROM penjualan
WHERE tgl_penjualan >= '2026-09-01' AND tgl_penjualan < '2026-10-01'
ORDER BY tgl_penjualan;

-- Pertanyaan: anggota mana yang belum punya nomor HP?
-- Harapan: 1 baris, A-0003 Salma Nihayatussadiyah, kolom no_hp_anggota berisi NULL.
SELECT no_anggota, nama_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL;

-- ===== D.2 Pola Teks dan Nilai Kosong =====

-- Pertanyaan: anggota yang namanya mengandung huruf "a", tampil dengan label
--             mudah dibaca (5 terbaru).
-- Harapan: 3 baris (ketiga nama punya huruf "a"); label berbentuk
--          "nama (no_anggota)"; Salma tampil hp "-" bukan NULL;
--          keterangan "Diskon 5%" untuk yang aktif, "Tanpa diskon" untuk nonaktif.
SELECT CONCAT(nama_anggota, ' (', no_anggota, ')') AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tgl_daftar,
       IFNULL(no_hp_anggota, '-') AS hp,
       CASE status_anggota WHEN 'aktif' THEN 'Diskon 5%'
            ELSE 'Tanpa diskon' END AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;

-- ===== D.3 Tanggal dan Perhitungan per Baris =====

-- Pertanyaan: sudah berapa hari tiap anggota terdaftar, dan termasuk baru
--             (kurang dari 180 hari) atau lama?
-- Harapan: 3 baris; yang daftar setelah 10 Mei 2026 berkategori "baru",
--          yang lebih awal "lama". (isi sendiri per anggota setelah cek tgl_daftar)
SELECT nama_anggota, tgl_daftar_anggota,
       DATEDIFF(CURDATE(), tgl_daftar_anggota) AS lama_hari,
       IF(DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180, 'baru', 'lama') AS kategori
FROM anggota
ORDER BY lama_hari DESC;

-- Pertanyaan: apa saja isi nota PJ-2609-0142 dan berapa subtotal tiap barang?
-- Harapan: 3 baris (3 barang di nota); Pulpen Gel (ATK-001) qty 3 harga 4000
--          subtotal 12000; subtotal dua barang lain = qty x harga satuan.
SELECT id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan,
       qty_detail_penjualan * harga_satuan_detail_penjualan AS subtotal
FROM detail_penjualan
WHERE id_penjualan = 1
ORDER BY id_barang;