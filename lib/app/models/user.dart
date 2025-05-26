class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.role,
    required this.noTelp,
    required this.alamat,
    required this.noSim,
    required this.statusAktif,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? role;
  final String? noTelp;
  final String? alamat;
  final dynamic noSim;
  final bool statusAktif;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      role: json["role"],
      noTelp: json["no_telp"],
      alamat: json["alamat"],
      noSim: json["no_sim"],
      statusAktif: json["status_aktif"] == 1 || json["status_aktif"] == true,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
    );
  }
}
