class User {
  final int id;
  final String email;
  final String noTelepon;
  final String role;
  final String? foto;

  User({
    required this.id,
    required this.email,
    required this.noTelepon,
    required this.role,
    this.foto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      noTelepon: json['no_telfon'],
      role: json['role'],
      foto: json['foto'],
    );
  }
}
