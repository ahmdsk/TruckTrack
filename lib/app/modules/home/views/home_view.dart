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
                ZoomTapAnimation(
                  onTap: () => Get.toNamed('/profile'),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(
                      'assets/images/profile-pict.jpg',
                    ),
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
                  style: Themes.titleStyle.copyWith(
                    color: Themes.whiteColor,
                    fontSize: 20,
                  ),
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
                    CardMenuHome(
                      title: 'Data Kendaraan',
                      icon: FeatherIcons.truck,
                      onTap: () => Get.toNamed('/kendaraan'),
                    ),
                    CardMenuHome(
                      title: 'Data Driver',
                      icon: FeatherIcons.user,
                      onTap: () => Get.toNamed('/pengguna'),
                    ),
                    CardMenuHome(
                      title: 'Total Pengiriman',
                      icon: FeatherIcons.box,
                    ),
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Themes.primaryColor.withAlpha(40), // ~15% opacity
              Themes.primaryColor.withAlpha(15), // ~5% opacity
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15), // ~6% opacity
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Themes.primaryColor.withAlpha(128), // ~50% opacity
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? FeatherIcons.truck,
              size: 42,
              color: Themes.primaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Themes.titleStyle.copyWith(
                color: Themes.darkColor.withAlpha(200), // ~78% opacity
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
