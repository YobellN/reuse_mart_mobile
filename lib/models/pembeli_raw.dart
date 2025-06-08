class PembeliRaw {
  final String idPembeli;
  final int idUser;
  final int poin;
  final String? otp;
  final String? otpCreatedAt;

  PembeliRaw({
    required this.idPembeli,
    required this.idUser,
    required this.poin,
    this.otp,
    this.otpCreatedAt,
  });

  factory PembeliRaw.fromJson(Map<String, dynamic> json) {
    return PembeliRaw(
      idPembeli: json['id_pembeli'],
      idUser: json['id_user'],
      poin: json['poin'],
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'],
    );
  }
}
