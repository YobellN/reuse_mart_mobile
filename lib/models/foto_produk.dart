class FotoProduk {
  final int idFotoProduk;
  final String idProduk;
  final String pathFoto;
  final int thumbnail;

  FotoProduk({
    required this.idFotoProduk,
    required this.idProduk,
    required this.pathFoto,
    required this.thumbnail,
  });

  factory FotoProduk.fromJson(Map<String, dynamic> json) {
    return FotoProduk(
      idFotoProduk: json['id_foto_produk'],
      idProduk: json['id_produk'],
      pathFoto: json['path_foto'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id_foto_produk': idFotoProduk,
    'id_produk': idProduk,
    'path_foto': pathFoto,
    'thumbnail': thumbnail,
  };
  
}