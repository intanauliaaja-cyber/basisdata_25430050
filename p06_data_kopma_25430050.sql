USE kopma_050;

INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
  ('K01','Dimas','kasir'), ('K02','Sari','kasir'), ('K03','Rina','kasir'),
  ('G01','Joko','gudang'), ('P01','Ketua Kopma','ketua');

INSERT INTO barang (kode_barang, nama_barang, kategori_barang,
  harga_jual_barang, stok_barang, stok_min_barang) VALUES
  ('ATK-001','Pulpen Gel 0.5','ATK',4000,120,20),
  ('ATK-002','Buku Tulis 58','ATK',6500,80,20),
  ('MNM-001','Air Mineral 600','minuman',4000,48,24),
  ('MKN-001','Roti Cokelat','makanan',5000,6,10);

INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota,
  no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
  ('A-0001','2543001101','Nazia Karinnafila','Ilmu Komputer','081234500101','aktif','2025-08-18'),
  ('A-0002','2543001102','Mufid Falih Huda','Ilmu Komputer','081234500102','aktif','2025-09-02'),
  ('A-0003','2543001103','Salma Nihayatussadiyah','Pendidikan Matematika',NULL,'aktif','2025-09-15'),
  ('A-0004','2443001104','Aditya Pratama','Teknik Informatika','081234500104','nonaktif','2024-09-10');

INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
  ('CV Sumber Makmur Sentosa','0725410029','Jl. Melati No. 12, Metro'),
  ('UD Bawang Lanang','0725410035','Jl. Kenanga No. 5, Metro');

-- D.2 Nota penjualan PJ-2609-0142
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas,
  id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000);

INSERT INTO detail_penjualan (id_penjualan, id_barang,
  qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 3, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-001';

INSERT INTO detail_penjualan (id_penjualan, id_barang,
  qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 2, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-002';

INSERT INTO detail_penjualan (id_penjualan, id_barang,
  qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 1, harga_jual_barang FROM barang WHERE kode_barang = 'MNM-001';

UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 1;
UPDATE barang SET stok_barang = stok_barang - 2 WHERE id_barang = 2;
UPDATE barang SET stok_barang = stok_barang - 1 WHERE id_barang = 3;