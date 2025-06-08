class PengirimanKurir {
  final String idPenjualan;
  final String idKurir;
  final String jadwalPengiriman;
  final String statusPengiriman;
  final AlamatPengiriman alamat;

  PengirimanKurir({
    required this.idPenjualan,
    required this.idKurir,
    required this.jadwalPengiriman,
    required this.statusPengiriman,
    required this.alamat,
  });

  factory PengirimanKurir.fromJson(Map<String, dynamic> json) {
    return PengirimanKurir(
      idPenjualan: json['id_penjualan'],
      idKurir: json['id_kurir'],
      jadwalPengiriman: json['jadwal_pengiriman'],
      statusPengiriman: json['status_pengiriman'],
      alamat: AlamatPengiriman.fromJson(json['alamat']),
    );
  }
}

class AlamatPengiriman {
  final int idAlamat;
  final String label;
  final String kabupatenKota;
  final String kecamatan;
  final String kodePos;
  final String detailAlamat;
  final Pembeli pembeli;

  AlamatPengiriman({
    required this.idAlamat,
    required this.label,
    required this.kabupatenKota,
    required this.kecamatan,
    required this.kodePos,
    required this.detailAlamat,
    required this.pembeli,
  });

  factory AlamatPengiriman.fromJson(Map<String, dynamic> json) {
    return AlamatPengiriman(
      idAlamat: json['id_alamat'],
      label: json['label'],
      kabupatenKota: json['kabupaten_kota'],
      kecamatan: json['kecamatan'],
      kodePos: json['kode_pos'],
      detailAlamat: json['detail_alamat'],
      pembeli: Pembeli.fromJson(json['pembeli']),
    );
  }
}

class Pembeli {
  final String idPembeli;
  final UserPembeli user;

  Pembeli({
    required this.idPembeli,
    required this.user,
  });

  factory Pembeli.fromJson(Map<String, dynamic> json) {
    return Pembeli(
      idPembeli: json['id_pembeli'],
      user: UserPembeli.fromJson(json['user']),
    );
  }
}

class UserPembeli {
  final String nama;
  final String email;
  final String noTelp;

  UserPembeli({
    required this.nama,
    required this.email,
    required this.noTelp,
  });

  factory UserPembeli.fromJson(Map<String, dynamic> json) {
    return UserPembeli(
      nama: json['nama'],
      email: json['email'],
      noTelp: json['no_telp'],
    );
  }
}