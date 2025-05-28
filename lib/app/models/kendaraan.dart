import 'package:truck_track/app/models/user.dart';

class Kendaraan {
  Kendaraan({
    required this.id,
    required this.idDriver,
    required this.noPolisi,
    required this.jenisKendaraan,
    required this.kapasitasTangki,
    required this.createdAt,
    required this.updatedAt,
    required this.driver,
    required this.noSegelAtas,
    required this.noSegelBawah,
    required this.noSuratJalan,
  });

  final int id;
  final int idDriver;
  final String noPolisi;
  final String jenisKendaraan;
  final String kapasitasTangki;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final User? driver;
  final String noSegelAtas;
  final String noSegelBawah;
  final String noSuratJalan;

  factory Kendaraan.fromJson(Map<String, dynamic> json) {
    return Kendaraan(
      id: json["id"] ?? 0,
      idDriver: json["id_driver"] ?? 0,
      noPolisi: json["no_polisi"] ?? "",
      jenisKendaraan: json["jenis_kendaraan"] ?? "",
      kapasitasTangki: json["kapasitas_tangki"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      driver: json["driver"] == null ? null : User.fromJson(json["driver"]),
      noSegelAtas: json["no_segel_atas"] ?? "",
      noSegelBawah: json["no_segel_bawah"] ?? "",
      noSuratJalan: json["no_surat_jalan"] ?? "",
    );
  }
}
