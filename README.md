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
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller/addProperties_controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/custom_view.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/common_widget/custom_accomodation.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/font_manager.dart';
import 'accomodation_type_custom.dart';

class AccommodationDetailsPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AccommodationDetailsPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller = Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: buildBody(controller),
    );
  }

  Widget buildBody(AddPropertiesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAccommodationOption(
          title: Strings.entirePlace,
          subtitle: Strings.wholePlacetoGuests,
          imageAsset: Assets.imagesSingleBed,
          value: 'entirePlace',
          controller: controller,
        ),
        const SizedBox(height: 20),
        buildAccommodationOption(
          title: Strings.privateRoom,
          subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
          imageAsset: Assets.imagesSingleBed,
          value: 'privateRoom',
          controller: controller,
        ),
        SizedBox(height: 4.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.maxGuests,
            controller.maxGuestsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed,
            controller.singleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.bedRooms,
            controller.bedroomsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.doubleBed,
            controller.doubleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed,
            Strings.extraFloorMattress, controller.extraFloorCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.bathRooms,
            controller.bathRoomsCount),
        SizedBox(height: 2.h),
        Container(
          width: 100.w,
          height: 7.h,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderContainerGriedView,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                Assets.imagesSingleBed,
                height: 3.h, // Responsive height
                width: 3.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 3.w), // Adjusted spacing
              Text(
                Strings.kitchenAvailable,
                style: FontManager.regular(15, color: AppColors.black), // Responsive font size
                textAlign: TextAlign.start,
                textScaler: TextScaler.linear(1),
              ), Spacer(),Obx(() => Text(
                Strings.yes,
                style: FontManager.regular(14.sp,
                    color: controller.isKitchenAvailable.value
                        ? AppColors.black
                        : AppColors.greyText),
              )),
              Obx(() {
                return  Transform.scale(scale: 0.7,
                  child: Switch(
                    value: controller.isKitchenAvailable.value,
                    onChanged: (value) {
                      controller.isKitchenAvailable.value = value;
                    },
                    activeColor: AppColors.buttonColor,
                  ),
                );
              }),
              Obx(() => Text(
                Strings.no,
                style: FontManager.regular(14.sp,
                    color: controller.isKitchenAvailable.value
                        ? AppColors.greyText
                        : AppColors.black),
              )),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/font_manager.dart';
import '../controller/addProperties_controller.dart';

Widget buildAccommodationOption({
  required String title,
  required String subtitle,
  required String imageAsset,
  required String value,
  required AddPropertiesController controller,
  // final Function(String) onChanged;
  // final bool isSelected;
}) {
  return GestureDetector(
    onTap: () {},
    child: Obx(() {
      bool isSelected = controller.selectedAccommodation.value == value;
      return Container(
        width: double.infinity,
        height: 10.h,
        decoration: BoxDecoration(
          // color: isSelected ? AppColors.selectContainerColor : Colors.white,
          color: isSelected ? AppColors.texFiledColor : Colors.white,
          borderRadius: BorderRadius.all(AppRadius.radius10),
          border: Border.all(
            color: isSelected
                ? AppColors.buttonColor
                : AppColors.borderContainerGriedView,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imageAsset,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1.h),
                  Text(
                    title,
                    style: FontManager.regular(16, color: AppColors.black),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      subtitle,
                      style:
                      FontManager.regular(12, color: AppColors.greyText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Obx(() => Radio(
                value: value,
                groupValue: controller.selectedAccommodation.value,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.selectAccommodation(newValue,imageAsset);
                  }
                },
              )),
            ),
          ],
        ),
      );
    }),
  );
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller/addProperties_controller.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/font_manager.dart';



class CusttomContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final RxInt count;

  const CusttomContainer({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 7.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 0.w),
          Image.asset(
            imageAsset,
            height: 26,
            width: 26,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: FontManager.regular(15, color: AppColors.black),
            textScaler: TextScaler.linear(1),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.find<AddPropertiesController>().decrement(count);
                },
                child: Image.asset(
                  Assets.imagesSingleBed,
                  height: 20.sp,
                ),
              ),
              SizedBox(width: 1.w),
              Container(
                width: 11.w,
                height: 4.h,
                decoration: const BoxDecoration(
                  color: AppColors.perpalContainer,
                  borderRadius: BorderRadius.all(AppRadius.radius4),
                ),
                child: Obx(() {
                  return TextField(
                    controller: TextEditingController(text: count.value.toString()),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 16),
                    ),
                    style: FontManager.regular(14),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      count.value = int.tryParse(value) ?? 0;
                    },
                  );
                }),
              ),
              SizedBox(width: 1.w),
              GestureDetector(
                onTap: () {
                  Get.find<AddPropertiesController>().increment(count);
                },
                child: Image.asset(
                  Assets.imagesSingleBed,
                  height: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
