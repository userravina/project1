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


  // Amenities and New Amenities Page Logic
  final List<String> customAmenities = [
    Strings.wiFi,
    Strings.airConditioner,
    Strings.fireAlarm,
    Strings.homeTheater,
    Strings.masterSuiteBalcony
  ];

  RxList<bool> selectedAmenities = <bool>[].obs;

  TextEditingController amenitiesName = TextEditingController();
  List<TextEditingController> textControllers = [];
  var addAmenities = <String>[].obs;
  List<String> allAmenities = [];

  void createAllAmenities() {
    allAmenities = [...customAmenities, ...addAmenities];
    print("conbined list${allAmenities}");
  }

  @override
  void onInit() {
    super.onInit();
    selectedAmenities.addAll(List.generate(customAmenities.length, (_) => false));
    createAllAmenities();
    print("rrrrrrrrr${selectedAmenities}");
  }

  void addAmenity(String amenityName) {
    addAmenities.add(amenityName);
    selectedAmenities.add(true);
    textControllers.add(TextEditingController());
    createAllAmenities();
    update();
  }

  void removeAmenity(int index) {
    if (index < addAmenities.length) {
      if (index < textControllers.length) {
        textControllers[index].dispose();
        textControllers.removeAt(index);
      }
      addAmenities.removeAt(index);
      createAllAmenities();
    }

    // Remove from selectedAmenities accordingly
    int selectedIndex = customAmenities.length + index;
    if (selectedIndex < selectedAmenities.length) {
      selectedAmenities.removeAt(selectedIndex);
    }
  }

  void toggleAmenity(int index) {

    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
      print("Toggled amenity at index $index: ${selectedAmenities[index]}");
    }
    update();
  }

  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_routes.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller/addProperties_controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/custom_view.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/common_widget/amenitiy_and_house_rules.dart';
import '../../../../../utils/font_manager.dart';

class AmenitiesPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AmenitiesPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.newamenities);
            },
            child: Container(
              height: 6.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.buttonColor),
              ),
              child: Center(
                child: Text(
                  Strings.addAmenities,
                  style:
                      FontManager.medium(18.sp, color: AppColors.buttonColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 3.5.h),
          Obx(
            () {
              return Column(
                children: [
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesSingleBed,
                    title: Strings.wiFi,
                    isSelected: controller.selectedAmenities[0],
                    onSelect: () => controller.toggleAmenity(0),
                    // isNewAdded: false,
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesSingleBed,
                    title: Strings.airConditioner,
                    isSelected: controller.selectedAmenities[1],
                    onSelect: () => controller.toggleAmenity(1),
                    // isNewAdded: false,
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesSingleBed,
                    title: Strings.fireAlarm,
                    isSelected: controller.selectedAmenities[2],
                    onSelect: () => controller.toggleAmenity(2),
                    // isNewAdded: false,
                  ),
                  SizedBox(height: 5.3.h),
                ],
              );
            },
          ),
          Text(
            Strings.newAmenities,
            style: FontManager.medium(18, color: AppColors.black),
          ),
          SizedBox(height: 2.h),
          Obx(
            () => AmenityAndHouseRulesContainer(
              imageAsset: Assets.imagesSingleBed,
              title: Strings.homeTheater,
              isSelected: controller.selectedAmenities[3],
              onSelect: () => controller.toggleAmenity(3),
              // isNewAdded: false,
            ),
          ),
          SizedBox(height: 1.2.h),
          Obx(
            () => AmenityAndHouseRulesContainer(
              imageAsset: Assets.imagesSingleBed,
              title: Strings.masterSuiteBalcony,
              isSelected: controller.selectedAmenities[4],
              onSelect: () => controller.toggleAmenity(4),
              // isNewAdded: false,
            ),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.addAmenities.length,
              itemBuilder: (context, index) {
                final amenityIndex;
                amenityIndex = index + controller.customAmenities.length;
                print("%%%%%%%%%%${amenityIndex}%%%%%%%%%%%%%");
                return Column(
                  children: [
                    const SizedBox(height: 2),
                    Obx(
                          () => AmenityAndHouseRulesContainer(
                        imageAsset: Assets.imagesSingleBed,
                        title: controller.addAmenities[index],
                        isSelected: controller.selectedAmenities[amenityIndex],
                        onSelect: () => controller.toggleAmenity(amenityIndex),
                        // isNewAdded: true,
                      ),
                    ),
                  ],
                );
              },
            );
          }),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile_app/common_widget/common_button.dart';
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_radius.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller/addProperties_controller.dart';


class NewAmenitiesPages extends StatefulWidget {
  const NewAmenitiesPages({super.key});

  @override
  State<NewAmenitiesPages> createState() => _NewAmenitiesPagesState();
}

class _NewAmenitiesPagesState extends State<NewAmenitiesPages> {
  final AddPropertiesController controller =
  Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.2.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    Strings.newAmenities,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              buildTitleStep(controller.currentPage.value.toString()),
              amenitiesList(),
              SizedBox(height: 2.h),
              addTextField(),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: LinearProgressIndicator(
                        value: controller.currentPage.value / 10,
                        backgroundColor: AppColors.greyText,
                        color: AppColors.buttonColor,
                        minHeight: 3,
                        borderRadius:
                        const BorderRadius.all(AppRadius.radius4),
                      ),
                    )),
                    SizedBox(height: 1.h),
                    CommonButton(
                      title: Strings.done,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addTextField() {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5.w),
            Obx(() =>  Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                child: TextFormField(
                  controller: controller.amenitiesName,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "Amenity ${controller.addAmenities.length + 1}",
                    hintStyle: FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        final String newAmenity = controller.amenitiesName.text.trim();
                        print("111111aaaaaa${newAmenity}");
                        if (newAmenity.isNotEmpty) {
                          print("222222222}");
                          controller.addAmenity(newAmenity);
                          controller.amenitiesName.clear();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Image.asset(
                          Assets.imagesPluscircle2,
                          height: 20,
                          width: 18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget amenitiesList() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.addAmenities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: 110.w,
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppColors.borderContainerGriedView),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5.w),
                    Text(
                      controller.addAmenities[index],
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.removeAmenity(index);
                      },
                      child: Image.asset(
                        Assets.imagesDividecircle2,
                        height: 21,
                        width: 22,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 3.5.w),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildTitleStep(String stepCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $stepCount/10",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
 "addAmenities":jsonEncode(allAmenities.map((amenity)  {
        int index = allAmenities.indexOf(amenity);
        print("aaaaaaaaaaaa${selectedAmenities.length > customAmenities.length && index >= customAmenities.length}");
        return {
          "name": amenity,
          "isChecked": selectedAmenities[index],
          "isNewAdded": selectedAmenities.length > customAmenities.length && index >= customAmenities.length,
        };
        // "name": amenity,
        // "isChecked": selectedAmenities[allAmenities.indexOf(amenity)],
        // "isNewAdded": true,
