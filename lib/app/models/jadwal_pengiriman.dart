import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/app/models/user.dart';

class JadwalPengiriman {
  JadwalPengiriman({
    required this.id,
    required this.noPesanan,
    required this.costumerId,
    required this.driverId,
    required this.managerId,
    required this.tanggalPesanan,
    required this.statusPesanan,
    required this.jenisBbm,
    required this.volumeBbm,
    required this.alamatPengiriman,
    required this.createdAt,
    required this.updatedAt,
    required this.tujuanKirim,
    required this.kendaraan,
    required this.driver,
  });

  final int id;
  final String noPesanan;
  final int costumerId;
  final int driverId;
  final int managerId;
  final DateTime? tanggalPesanan;
  final String statusPesanan;
  final String jenisBbm;
  final int volumeBbm;
  final String alamatPengiriman;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<TujuanKirim> tujuanKirim;
  final Kendaraan? kendaraan;
  final User? driver;

  factory JadwalPengiriman.fromJson(Map<String, dynamic> json) {
    return JadwalPengiriman(
      id: json["id"] ?? 0,
      noPesanan: json["no_pesanan"] ?? "",
      costumerId: json["costumer_id"] ?? 0,
      driverId: json["driver_id"] ?? 0,
      managerId: json["manager_id"] ?? 0,
      tanggalPesanan: DateTime.tryParse(json["tanggal_pesanan"] ?? ""),
      statusPesanan: json["status_pesanan"] ?? "",
      jenisBbm: json["jenis_bbm"] ?? "",
      volumeBbm: double.parse(json["volume_bbm"].toString()).toInt(),
      alamatPengiriman: json["alamat_pengiriman"] ?? "",
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      tujuanKirim:
          json["tujuan_kirim"] == null
              ? []
              : List<TujuanKirim>.from(
                json["tujuan_kirim"]!.map((x) => TujuanKirim.fromJson(x)),
              ),
      kendaraan: json["kendaraan"] != null
          ? Kendaraan.fromJson(json["kendaraan"])
          : null,
      driver: json["driver"] != null
          ? User.fromJson(json["driver"])
          : null,
    );
  }
}
