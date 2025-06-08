//NOTE: ini pakai model baru khusus untuk data di profil. kalo pake model biasa susah karna
//pas login gak nyimpan id penitip
class PenitipRaw {
  final String idPenitip;
  final int idUser;
  final String nik;
  final String fotoKtp;
  final int saldo;
  final int poin;
  final int? rating;

  PenitipRaw({
    required this.idPenitip,
    required this.idUser,
    required this.nik,
    required this.fotoKtp,
    required this.saldo,
    required this.poin,
    this.rating,
  });

  factory PenitipRaw.fromJson(Map<String, dynamic> json) {
    return PenitipRaw(
      idPenitip: json['id_penitip'] ?? '',
      idUser: json['id_user'] ?? 0,
      nik: json['nik'] ?? '',
      fotoKtp: json['foto_ktp'] ?? '',
      saldo: json['saldo'] ?? 0,
      poin: json['poin'] ?? 0,
      rating: json['rating'] as int?,
    );
  }
}
