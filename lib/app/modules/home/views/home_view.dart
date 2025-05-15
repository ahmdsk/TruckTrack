import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:truck_track/core/themes/themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20,
          left: Themes.basePadding.left,
          right: Themes.basePadding.right,
          bottom: Themes.basePadding.bottom,
        ),
        child: Column(
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 18,
              children: [
                CircleAvatar(
                  backgroundColor: Themes.primaryColor,
                  minRadius: 30,
                  maxRadius: 30,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jhon Doe',
                      style: Themes.titleStyle.copyWith(fontSize: 20),
                    ),
                    Text('Manajer', style: Themes.bodyStyle),
                  ],
                ),
              ],
            ),
            // Truck Image
            Center(
              child: Image.asset(
                'assets/images/truck.png',
                width: 320,
                height: 320,
              ),
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Themes.primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  'Truck Tracking',
                  style: Themes.titleStyle.copyWith(color: Themes.whiteColor, fontSize: 20),
                ),
              ),
            ),
            // Grid View 2 Columns
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GridView.count(
                  crossAxisCount: 2,
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    CardMenuHome(title: 'Data Kendaraan', icon: FeatherIcons.truck),
                    CardMenuHome(title: 'Total Pengiriman', icon: FeatherIcons.box),
                    CardMenuHome(title: 'Data Driver', icon: FeatherIcons.user),
                    CardMenuHome(
                      title: 'Jadwal Pengiriman',
                      icon: FeatherIcons.calendar,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardMenuHome extends StatelessWidget {
  const CardMenuHome({super.key, required this.title, this.icon, this.onTap});

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap ?? () => debugPrint('Card Menu $title'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Themes.primaryColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: Themes.titleStyle.copyWith(
                color: Themes.darkColor.withAlpha(90),
                fontSize: 18,
              ),
            ),
            Icon(icon ?? FeatherIcons.truck, size: 38, color: Themes.darkColor),
          ],
        ),
      ),
    );
  }
}
