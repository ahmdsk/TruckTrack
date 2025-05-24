import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/core/themes/themes.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = sl<AuthService>();
    final user = authService.currentUser;
    debugPrint("User: ${user?.name}");

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
              children: [
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
                          user?.name ?? '-',
                          style: Themes.titleStyle.copyWith(fontSize: 20),
                        ),
                        Text(
                          user?.role?.toUpperCase() ?? '-',
                          style: Themes.bodyStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Logout Button
                ZoomTapAnimation(
                  onTap: () async {
                    await authService.logout();

                    if (!authService.isLoggedIn) {
                      Get.offAllNamed('/login');
                    } else {
                      showCustomSnackbar(
                        title: 'Gagal',
                        message: 'Gagal logout',
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Themes.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      FeatherIcons.logOut,
                      color: Themes.whiteColor,
                      size: 24,
                    ),
                  ),
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
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: buildMenuByRole(user?.role ?? 'manajer'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> buildMenuByRole(String role) {
  if (role == 'manajer') {
    return [
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
        title: 'Atur Pesanan',
        icon: FeatherIcons.box,
        onTap: () => Get.toNamed('/setting-order'),
      ),
      CardMenuHome(
        title: 'Jadwal Pengiriman',
        icon: FeatherIcons.calendar,
        onTap: () => Get.toNamed('/jadwal-pengiriman'),
      ),
    ];
  } else if (role == 'costumer') {
    return [
      CardMenuHome(
        title: 'Cek Pesanan',
        icon: FeatherIcons.truck,
        onTap: () => Get.toNamed('/cek-pesanan')
      ),
      CardMenuHome(
        title: 'Riwayat Pesanan',
        icon: FeatherIcons.clock,
        onTap: () => Get.toNamed('/riwayat-pesanan'),
      ),
    ];
  } else if (role == 'driver') {
    return [
      CardMenuHome(
        title: 'Jadwal Saya',
        icon: FeatherIcons.calendar,
        onTap: () => Get.toNamed('/jadwal-driver'),
      ),
      CardMenuHome(
        title: 'Status Pengiriman',
        icon: FeatherIcons.truck,
        onTap: () => Get.toNamed('/status-pengiriman'),
      ),
    ];
  } else {
    return [];
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
