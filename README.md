# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<p>
<img src="https://user-images.githubusercontent.com/120082785/220397599-f5b30425-689b-459b-a885-142f62cde580.png" height="50%" width="30%">
<img src="https://user-images.githubusercontent.com/120082785/220398046-f935dcc0-6bfe-453e-8990-c8b968a9abf0.png" height="100%" width="30%">
</p>
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; // Import Sizer for responsiveness
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_radius.dart';
import 'package:travellery_mobile_app/view/auth_flow/traveling_flow/home_page.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primary300,
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              index: 0,
              icon: Icons.home,
              label: 'Home',
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.search,
              label: 'Search',
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        height: 6.h,
        width: 20.w,
        decoration: _selectedIndex == index
            ? BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.all(AppRadius.radius36),
        )
            : BoxDecoration(),
        child: _selectedIndex == index
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.buttonColor,
              size: 18.sp,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: TextStyle(
                color: AppColors.buttonColor,
                fontSize: 14.sp,
              ),
            ),
          ],
        )
            : Icon(
          icon,
          color: Colors.grey,
          size: 18.sp, // Responsive icon size
        ),
      ),
    );
  }
}
