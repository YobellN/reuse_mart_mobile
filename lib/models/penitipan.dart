import 'package:reuse_mart_mobile/models/Penitip.dart';

class Penitipan {
  final String idPenitipan;
  final String idPenitip;
  final String idQc;
  final String? idHunter;
  final String tanggalPenitipan;
  final String tenggatPenitipan;
  final String tenggatPengambilan;
  final int statusPerpanjangan;
  final Penitip penitip;

  Penitipan({
    required this.idPenitipan,
    required this.idPenitip,
    required this.idQc,
    required this.idHunter,
    required this.tanggalPenitipan,
    required this.tenggatPenitipan,
    required this.tenggatPengambilan,
    required this.statusPerpanjangan,
    required this.penitip,
  });

  factory Penitipan.fromJson(Map<String, dynamic> json) {
    return Penitipan(
      idPenitipan: json['id_penitipan'],
      idPenitip: json['id_penitip'],
      idQc: json['id_qc'],
      idHunter: json['id_hunter'],
      tanggalPenitipan: json['tanggal_penitipan'],
      tenggatPenitipan: json['tenggat_penitipan'],
      tenggatPengambilan: json['tenggat_pengambilan'],
      statusPerpanjangan: json['status_perpanjangan'],
      penitip: Penitip.fromJson(json['penitip']),
    );
  }
}
