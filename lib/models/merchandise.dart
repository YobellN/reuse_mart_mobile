class Merchandise {
  int idMerchandise;
  String namaMerchandise;
  int stok;
  int poinPenukaran;
  String fotoMerchandise;

  Merchandise({
    required this.idMerchandise,
    required this.namaMerchandise,
    required this.stok,
    required this.poinPenukaran,
    required this.fotoMerchandise,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) {
    return Merchandise(
      idMerchandise: json['id_merchandise'],
      namaMerchandise: json['nama_merchandise'],
      stok: json['stok'],
      poinPenukaran: json['poin_penukaran'],
      fotoMerchandise: json['foto_merchandise'],
    );
  }

}