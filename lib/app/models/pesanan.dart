import 'package:truck_track/app/models/user.dart';

class Pesanan {
  Pesanan({
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
    required this.noSegelAtas,
    required this.noSegelBawah,
    required this.noSuratJalan,
    required this.createdAt,
    required this.updatedAt,
    required this.costumer,
    required this.driver,
    required this.manager,
    
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
  final dynamic alamatPengiriman;
  final String noSegelAtas;
  final String noSegelBawah;
  final String noSuratJalan;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? costumer;
  final User? driver;
  final User? manager;

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id: json["id"] ?? 0,
      noPesanan: json["no_pesanan"] ?? "",
      costumerId: json["costumer_id"] ?? 0,
      driverId: json["driver_id"] ?? 0,
      managerId: json["manager_id"] ?? 0,
      tanggalPesanan: DateTime.tryParse(json["tanggal_pesanan"] ?? ""),
      statusPesanan: json["status_pesanan"] ?? "",
      jenisBbm: json["jenis_bbm"] ?? "",
      volumeBbm: double.parse(json["volume_bbm"].toString()).toInt(),
      alamatPengiriman: json["alamat_pengiriman"],
      noSegelAtas: json["no_segel_atas"] ?? "",
      noSegelBawah: json["no_segel_bawah"] ?? "",
      noSuratJalan: json["no_surat_jalan"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      costumer:
          json["costumer"] == null ? null : User.fromJson(json["costumer"]),
      driver: json["driver"] == null ? null : User.fromJson(json["driver"]),
      manager:
          json["manager"] == null ? null : User.fromJson(json["manager"]),
    );
  }
}
