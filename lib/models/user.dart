class User {
  final String nama;
  final String email;
  final String noTelp;
  final String role;
  final String? fcmToken;

  User({
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.role,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json['nama'],
      email: json['email'],
      noTelp: json['no_telp'],
      role: json['role'],
      fcmToken: json['fcm_token'],
    );
  }
}