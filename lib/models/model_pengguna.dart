class Pengguna {
  final int id;
  final String nama;
  final String alamat;
  final String deskripsi;
  final String? foto;
  final int idUser;

  Pengguna({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.deskripsi,
    this.foto,
    required this.idUser,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      deskripsi: json['deskripsi'],
      foto: json['foto'],
      idUser: json['id_user'],
    );
  }
}
