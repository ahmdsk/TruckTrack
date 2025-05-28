class JenisKendaraan {
    JenisKendaraan({
        required this.id,
        required this.nama,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String nama;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory JenisKendaraan.fromJson(Map<String, dynamic> json){ 
        return JenisKendaraan(
            id: json["id"] ?? 0,
            nama: json["nama"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
