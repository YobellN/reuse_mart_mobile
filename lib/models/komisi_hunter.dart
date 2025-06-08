class KomisiHunter {
  final String idDetailPenjualan;
  final String idPenitip;
  final String idHunter;
  final double komisiHunter;

  KomisiHunter({
    required this.idDetailPenjualan,
    required this.idPenitip,
    required this.idHunter,
    required this.komisiHunter,
  });

  factory KomisiHunter.fromJson(Map<String, dynamic> json) {
    return KomisiHunter(
      idDetailPenjualan: json['id_detail_penjualan'],
      idPenitip: json['id_penitip'],
      idHunter: json['id_hunter'],
      komisiHunter: json['komisi_hunter'],
    );
  }
}
