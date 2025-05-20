import 'package:truck_track/app/models/user.dart';

class Kendaraan {
    Kendaraan({
        required this.id,
        required this.idDriver,
        required this.noPolisi,
        required this.jenisKendaraan,
        required this.kapasitasTangki,
        required this.noSegel,
        required this.createdAt,
        required this.updatedAt,
        required this.driver,
    });

    final int id;
    final int idDriver;
    final String noPolisi;
    final String jenisKendaraan;
    final String kapasitasTangki;
    final String noSegel;
    final DateTime? createdAt;
    final dynamic updatedAt;
    final User? driver;

    factory Kendaraan.fromJson(Map<String, dynamic> json){ 
        return Kendaraan(
            id: json["id"] ?? 0,
            idDriver: json["id_driver"] ?? 0,
            noPolisi: json["no_polisi"] ?? "",
            jenisKendaraan: json["jenis_kendaraan"] ?? "",
            kapasitasTangki: json["kapasitas_tangki"] ?? "",
            noSegel: json["no_segel"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: json["updated_at"],
            driver: json["driver"] == null ? null : User.fromJson(json["driver"]),
        );
    }

}