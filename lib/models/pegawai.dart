import 'package:reuse_mart_mobile/models/User.dart';

class Pegawai {
  final String idPegawai;
  final int idUser;
  final int idJabatan;
  final String nip;
  final String tanggalLahir;
  final double totalKomisi;
  final User user;

  Pegawai({
    required this.idPegawai,
    required this.idUser,
    required this.idJabatan,
    required this.nip,
    required this.tanggalLahir,
    required this.totalKomisi,
    required this.user,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      idUser: json['id_user'],
      idJabatan: json['id_jabatan'],
      nip: json['nip'],
      tanggalLahir: json['tanggal_lahir'],
      totalKomisi: json['total_komisi'].toDouble(),
      user: User.fromJson(json['user']),
    );
  }
}
