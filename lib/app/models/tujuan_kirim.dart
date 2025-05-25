import 'package:truck_track/app/models/pesanan.dart';
import 'package:truck_track/app/models/user.dart';

class TujuanKirim {
  TujuanKirim({
    required this.id,
    required this.pesananId,
    required this.createdBy,
    required this.latitudeTujuan,
    required this.longitudeTujuan,
    required this.latitudeAsal,
    required this.longitudeAsal,
    required this.jarak,
    required this.waktuTempuh,
    required this.alamatTujuan,
    required this.alamatAsal,
    required this.catatan,
    required this.sudahDilewati,
    required this.createdAt,
    required this.updatedAt,
    required this.pesanan,
    required this.user,
  });

  final int id;
  final int pesananId;
  final int createdBy;
  final String latitudeTujuan;
  final String longitudeTujuan;
  final String latitudeAsal;
  final String longitudeAsal;
  final String? jarak;
  final String? waktuTempuh;
  final String alamatTujuan;
  final String alamatAsal;
  final String? catatan;
  final bool sudahDilewati;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Pesanan? pesanan;
  final User? user;

  factory TujuanKirim.fromJson(Map<String, dynamic> json) {
    return TujuanKirim(
      id: json["id"] ?? 0,
      pesananId: json["pesanan_id"] ?? 0,
      createdBy: json["created_by"] ?? 0,
      latitudeTujuan: json["latitude_tujuan"] ?? "",
      longitudeTujuan: json["longitude_tujuan"] ?? "",
      latitudeAsal: json["latitude_asal"] ?? "",
      longitudeAsal: json["longitude_asal"] ?? "",
      jarak: json["jarak"] ?? "-",
      waktuTempuh: json["waktu_tempuh"] ?? "-",
      alamatTujuan: json["alamat_tujuan"] ?? "-",
      alamatAsal: json["alamat_asal"] ?? "",
      catatan: json["catatan"] ?? "-",
      sudahDilewati: json["sudah_dilewati"] ?? false,
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      pesanan:
          json["pesanan"] == null ? null : Pesanan.fromJson(json["pesanan"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}
