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
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../utils/app_string.dart';

class OnboardingController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();
  List<Map<String, dynamic>> onboardingList = [
    {
      "title": Strings.onboardingTitle1,
      "desc": Strings.onboardingDescription1,
      "image": Assets.imagesInto1
    },
    {
      "title": Strings.onboardingTitle2,
      "desc": Strings.onboardingDescription2,
      "image": Assets.imagesInto2
    },
    {
      "title": Strings.onboardingTitle3,
      "desc": Strings.onboardingDescription3,
      "image": Assets.imagesInto3
    }
  ];

  onNextButtonTap() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_radius.dart';
import '../common_onboarding.dart';
import '../controller/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: OnboardingController(),
        builder: (controller) {
          return Stack(
            children: [
              PageView.builder(
                itemCount: controller.onboardingList.length,
                controller: controller.pageController,
                onPageChanged: (value) {
                  controller.selectedIndex.value = value;
                },
                itemBuilder: (context, index) {
                  var map = controller.onboardingList[index];
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(map["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: AppRadius.radiusM,
                      topRight: AppRadius.radiusM,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 3.h),
                      SmoothPageIndicator(
                          controller: controller.pageController,
                          count: controller.onboardingList.length,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: AppColors.buttonColor,
                              dotColor: AppColors.inactiveDotColor,
                              dotHeight: 4),
                          // your preferred effect
                          onDotClicked: (index) {}),
                      Obx(() {
                        var map = controller
                            .onboardingList[controller.selectedIndex.value];
                        return OnboardingCard(
                          title: map["title"],
                          isLast: (controller.selectedIndex.value + 1) ==
                              controller.onboardingList.length,
                          description: map["desc"],
                          onNext: () {
                            controller.onNextButtonTap();
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';

import '../../../../generated/assets.dart';
import '../../utils/app_string.dart';
import '../../utils/font_manager.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onNext;

  final bool isLast;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.description, 
    required this.onNext,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            title,
            style: FontManager.medium(24),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              description,
              style: FontManager.regular(12, color: AppColors.greyText),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: onNext,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5.2.h,
                padding: EdgeInsets.symmetric(horizontal: isLast ? 34 : 16),
                decoration: const BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.all(AppRadius.radiusSM),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      isLast ? Strings.getStarted : Strings.nextButton,
                      style: FontManager.regular(
                        16,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      Assets.imagesIntoarro,
                      color: AppColors.white,
                      width: 5.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
