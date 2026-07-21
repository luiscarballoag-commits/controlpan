import 'package:flutter/material.dart';

class DashboardBanner extends StatelessWidget {
  const DashboardBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/images/dashboard_banner.png",
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}
