import 'package:flutter/material.dart';
import 'package:truck_track/core/themes/themes.dart';

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty.png', width: 180, height: 180),
          SizedBox(height: 30),
          Text(
            'Tidak ada data',
            style: Themes.titleStyle.copyWith(
              color: Themes.primaryColor,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Data masih kosong, silahkan tambah data untuk menampilkan semua list data.',
            style: Themes.baseTextStyle.copyWith(
              color: Themes.darkColor,
              fontSize: 16,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
