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
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/amenities_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestay_title1.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestay_type.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../common_widgets/common_dialog.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import 'widget_view/accommodation_details_page.dart';
import '../controller/add_properties_controller.dart';

class AddPropertiesScreen extends StatefulWidget {
  const AddPropertiesScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
}

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  final AddPropertiesController controller = Get.find<AddPropertiesController>();
  final PageController _pageController = PageController();

  void nextPage() {
    if (controller.currentPage.value < 8) {
      FocusManager.instance.primaryFocus?.unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  void backPage() {
    if (controller.currentPage.value > 1) {
      FocusManager.instance.primaryFocus?.unfocus();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Column(
          children: [
            SizedBox(height: 7.2.h),
            Row(
              children: [
                GestureDetector(
                  onTap: backPage,
                  child: Icon(Icons.keyboard_arrow_left, size: 30),
                ),
                const SizedBox(width: 8),
                Obx(() => Text(
                  controller.pageTitles[controller.currentPage.value - 1],
                  style: FontManager.medium(20, color: AppColors.black),
                )),
              ],
            ),
            SizedBox(height: 3.h),
            Obx(() => buildTitleStep(controller.currentPage.value.toString())),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    controller.currentPage.value = index + 1;
                  },
                  children: [
                    HomeStayTitleScreen(onNext: nextPage, onBack: backPage),
                    HomeStayTypeScreen(onNext: nextPage, onBack: backPage),
                    AccommodationDetailsPage(onNext: nextPage, onBack: backPage),
                    AmenitiesPage(onNext: nextPage, onBack: backPage),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Obx(() => Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: LinearProgressIndicator(
                value: controller.currentPage.value / 8,
                backgroundColor: AppColors.greyText,
                color: AppColors.buttonColor,
                minHeight: 3,borderRadius: BorderRadius.all(AppRadius.radius4),
              ),
            )),
            SizedBox(height: 2.h),
            Obx(() => CommonButton(
              title: Strings.nextStep,
              onPressed: controller.isCurrentPageValid() ? nextPage : null,
              backgroundColor: controller.isCurrentPageValid()
                  ? AppColors.buttonColor
                  : AppColors.lightPerpul,
            )),
        Obx(() => (controller.currentPage.value == 3)?SizedBox(height: 1.h): SizedBox(height: 0,),),
           Obx(() => (controller.currentPage.value == 3)? GestureDetector(onTap: () {
             CustomDialog.showCustomDialog(
               context: context,
               title: Strings.saveAndExit,
               message: Strings.questionDialogText,
               imageAsset: Assets.imagesQuestionDialog,
               buttonLabel: Strings.yes,
               changeEmailLabel: Strings.no,
               onResendPressed: () {
                 Get.toNamed(Routes.yourPropertiesPage);
               },
             );
           },child: Text(Strings.saveAndExit,style: FontManager.medium(18,color: AppColors.buttonColor),)) :SizedBox(height: 5.h),),
        Obx(() => (controller.currentPage.value == 3) ? SizedBox(height: 1.5.h): SizedBox(height: 0,),),
          ],
        ),
      ),
    );
  }

  Widget buildTitleStep(String stepCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $stepCount/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

class HomeStayTitleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HomeStayTitleScreen(
      {super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller =  Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.titleLabel, style: FontManager.regular(14)),
          SizedBox(height: 0.5.h),
          CustomTextField(
            maxLength: 100,
            hintText: Strings.enterTitle,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.enterTitle;
              }
              return null;
            },
            onSaved: (value) => controller.homestayTitle.value = value!,
            onChanged: (value) => controller.setTitle(value),
          ),
          SizedBox(height: 40.h,),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

class HomeStayTypeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HomeStayTypeScreen({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller = Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: Column(
        children: [
          Container(
            height: 60.h,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.sp,
              mainAxisSpacing: 19.sp,
              childAspectRatio: (MediaQuery.of(context).size.width / 1.6) / 160,
              children: [
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.bedAndBreakfast, Assets.imagesBedbreakfast, controller),
                buildHomestayTypeCard(Strings.urban, Assets.imagesUrban, controller),
                buildHomestayTypeCard(Strings.ecoFriendly, Assets.imagesEcofriendly, controller),
                buildHomestayTypeCard(Strings.adventure, Assets.imagesAdventure, controller),
                buildHomestayTypeCard(Strings.luxury, Assets.imagesLuxury, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHomestayTypeCard(String type, String image, AddPropertiesController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectHomeStayType(type);
      },
      child: Obx(
            () {
          bool isSelected = controller.isHomeStayTypeSelected(type);
          return Container(
            height: 120.sp,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.selectContainerColor : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.buttonColor : AppColors.borderContainerGriedView,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(AppRadius.radius10),
            ),
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(image, height: 35.1, width: 40.w, fit: BoxFit.contain),
                Spacer(),
                Center(
                  child: Text(
                    type,
                    style: FontManager.regular(16.sp, color: AppColors.black),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';

class HouseRulesPage extends StatefulWidget {
  const HouseRulesPage({super.key});

  @override
  State<HouseRulesPage> createState() => _HouseRulesPageState();
}

class _HouseRulesPageState extends State<HouseRulesPage> {
  final PageController _pageController = PageController();
  int currentPage = 1;

  void nextPage() {
    if (currentPage <= 8) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 31),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
            
                  children: [
                    Icon(Icons.keyboard_arrow_left, size: 30),
                    const SizedBox(width: 8),
                    Text(

                      Strings.houseRules,
                      style: FontManager.medium( 20, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTitleStep(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.buttonColor)),
                      child: Center(
                        child: Text(
                          Strings.addRules,
                          style: FontManager.regular(14,
                              color: AppColors.buttonColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              Assets.imagesNoSmoking,
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.noSmoking,
                              style: FontManager.regular( 14, color: AppColors.textAddProreties),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Icon(Icons.circle_outlined,color: AppColors.borderContainerGriedView,),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              Assets.imagesNoDrinking,
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.noDrinking,
                              style: FontManager.regular( 14, color: AppColors.textAddProreties),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Icon(Icons.check_circle_rounded,color: AppColors.buttonColor,),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              Assets.imagesNoPet,
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.noPet,
                              style: FontManager.regular( 14, color: AppColors.textAddProreties),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Icon(Icons.circle_outlined,color: AppColors.borderContainerGriedView,),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  Strings.newRules,
                  style: FontManager.medium( 18, color: AppColors.textAddProreties),
                ),
             
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 110.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: AppColors.borderContainerGriedView,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 3.w,
                        ),
                        Image.asset(
                          Assets.imagesDamageToProretiy,
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          Strings.damageToProperty,
                          style: FontManager.regular( 14, color: AppColors.textAddProreties),
                        ),
                        Spacer(),
            
                        SizedBox(
                          width: 1.w,
                        ),
                        Icon(Icons.check_circle,color: AppColors.buttonColor,),
                        SizedBox(
                          width: 3.w,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                CommonButton(
                  title: currentPage < 7 ? Strings.nextStep : Strings.done,
                  onPressed: () {
                     Get.toNamed(Routes.newRules);
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildTitleStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/routes_app/all_routes_app.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/amenities_custom.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

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
  List<bool> selectedAmenities = List.generate(6, (index) => false);

  void toggleAmenity(int index) {
    setState(() {
      selectedAmenities[index] = !selectedAmenities[index];
    });
  }

  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 3.h),
          AmenityTile(
            imageAsset: Assets.imagesWiFi,
            title: Strings.wiFi,
            isSelected: selectedAmenities[0],
            onSelect: () => toggleAmenity(0),
          ),
          SizedBox(height: 2.h),
          AmenityTile(
            imageAsset: Assets.imagesAirCondioner,
            title: Strings.airConditioner,
            isSelected: selectedAmenities[1],
            onSelect: () => toggleAmenity(1),
          ),
          SizedBox(height: 2.h),
          AmenityTile(
            imageAsset: Assets.imagesFirAlarm,
            title: Strings.fireAlarm,
            isSelected: selectedAmenities[2],
            onSelect: () => toggleAmenity(2),
          ),
          SizedBox(height: 0.5.h),
          SizedBox(height: 1.h),
          Text(
            Strings.newAmenities,
            style: FontManager.medium(18, color: AppColors.black),
          ),
          SizedBox(height: 2.h),
          AmenityTile(
            imageAsset: Assets.imagesHometherater,
            title: Strings.homeTheater,
            isSelected: selectedAmenities[3],
            onSelect: () => toggleAmenity(3),
          ),
          SizedBox(height: 2.h),
          AmenityTile(
            imageAsset: Assets.imagesMastrSuite,
            title: Strings.masterSuiteBalcony,
            isSelected: selectedAmenities[4],
            onSelect: () => toggleAmenity(4),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.amenities.length,
              itemBuilder: (context, index) {
                return AmenityTile(
                  imageAsset: Assets.imagesMastrSuite,
                  title: controller.amenities[index],
                  isSelected: selectedAmenities[4+index],
                  onSelect: () => toggleAmenity(4+index),
                );
              },
            );
          }),
          SizedBox(height: 2.h),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/accommondation_details.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

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
    final AddPropertiesController controller =
        Get.find<AddPropertiesController>();

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
          imageAsset: Assets.imagesTraditional,
          value: 'entirePlace',
          controller: controller,
        ),
        SizedBox(height: 20),
        buildAccommodationOption(
          title: Strings.privateRoom,
          subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
          imageAsset: Assets.imagesPrivateRoom,
          value: 'privateRoom',
          controller: controller,
        ),
        SizedBox(height: 4.h),
        _buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
            controller.maxGuestsCount),
        SizedBox(height: 2.h),
        _buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed,
            controller.singleBedCount),
        SizedBox(height: 2.h),
        _buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed,
            controller.doubleBedCount),
        SizedBox(height: 2.h),
        _buildCustomContainer(Assets.imagesExtraFloor,
            Strings.extraFloorMattress, controller.extraFloorCount),
        SizedBox(height: 2.h),
        _buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms,
            controller.bathRoomsCount),
        SizedBox(height: 2.h),
        Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderContainerGriedView,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0.w),
              Image.asset(
                Assets.imagesKitchen,
                height: 26,
                width: 26,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 3.w),
              Text(
                Strings.kitchenAvailable,
                style: FontManager.regular(14, color: AppColors.black),
                textAlign: TextAlign.start,
              ),
              Spacer(),
              Obx(() => Text(Strings.yes,style: FontManager.regular(14,color:  controller.isKitchenAvailable.value ? AppColors.black : AppColors.greyText),)),
              Obx(() {
                 return   Switch(
                   value: controller.isKitchenAvailable.value,
                   onChanged: (value) {
                     controller.isKitchenAvailable.value = value;
                   },
                   activeColor: AppColors.buttonColor,
                 );
              }),
              Obx(() => Text(Strings.no,style: FontManager.regular(14,color:  controller.isKitchenAvailable.value ? AppColors.greyText : AppColors.black),)),

            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildAccommodationOption({
    required String title,
    required String subtitle,
    required String imageAsset,
    required String value,
    required AddPropertiesController controller,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Obx(() {
        bool isSelected = controller.selectedAccommodation.value == value;
        return Container(
          width: double.infinity,
          height: 9.3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectContainerColor : Colors.white,
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
                child: Obx(() => Radio<String>(
                      value: value,
                      groupValue: controller.selectedAccommodation.value,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          controller.selectAccommodation(newValue);
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

  Widget _buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../routes_app/all_routes_app.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';

class NewRulesPages extends StatefulWidget {
  const NewRulesPages({super.key});

  @override
  State<NewRulesPages> createState() => _NewRulesPagesState();
}

class _NewRulesPagesState extends State<NewRulesPages> {
  int currentPage = 4;
  String? selectedType;

  void nextPage() {
    if (selectedType != null) {
      setState(() {
        currentPage++;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_left, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      Strings.newRules,
                      style: FontManager.medium(20, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                buildTitleStep(),
                Column(
                  children: [
                    SizedBox(height: 1.h),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.damageToProperty,
                              style: FontManager.regular( 16, color: AppColors.textAddProreties),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Image.asset(
                              Assets.imagesDividecircle2,
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.rules2,
                              style: FontManager.regular( 16, color: AppColors.greyText),
                            ),

                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Image.asset(
                              Assets.imagesDividecircle2,
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.rules3,
                              style: FontManager.regular( 16, color: AppColors.greyText),
                            ),

                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Image.asset(
                              Assets.imagesPluscircle2,
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.rules4,
                              style: FontManager.regular( 16, color: AppColors.greyText),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Image.asset(
                              Assets.imagesPluscircle2,
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 110.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.borderContainerGriedView,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              Strings.rules5,
                              style: FontManager.regular( 16, color: AppColors.greyText),
                            ),
                            Spacer(),

                            SizedBox(
                              width: 1.w,
                            ),
                            Image.asset(
                              Assets.imagesPluscircle2,
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 3.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 7.h,
                  width: 50.w,
                  child: Image.asset(Assets.imagesHomeProgres3, fit: BoxFit.contain),
                ),
                SizedBox(height: 1.h),
                CommonButton(
                  title: currentPage < 7 ? Strings.done : Strings.done,

                  onPressed: (){
                    Get.toNamed(Routes.checkInOutDetails);
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),);
  }
  Widget buildTitleStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget customContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';
class NewAmenitiesPages extends StatefulWidget {
  const NewAmenitiesPages({super.key});

  @override
  State<NewAmenitiesPages> createState() => _NewAmenitiesPagesState();
}

class _NewAmenitiesPagesState extends State<NewAmenitiesPages> {
  final AddPropertiesController controller = Get.find<AddPropertiesController>();

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
              _buildHeader(),
              SizedBox(height: 3.h),
              Obx(() => _buildTitleStep(controller.currentPage.value.toString())),
              _buildAmenitiesList(),
              _buildAddAmenityField(),
              SizedBox(height: 12.h),
              _buildProgressIndicator(),
              SizedBox(height: 1.h),
              _buildDoneButton(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.keyboard_arrow_left, size: 30),
        ),
        const SizedBox(width: 8),
        Obx(() => Text(
          controller.pageTitles[controller.currentPage.value],
          style: FontManager.medium(20, color: AppColors.black),
        )),
      ],
    );
  }

  Widget _buildAmenitiesList() {
    return Column(
      children: [
        customAmenities(Strings.homeTheater),
        SizedBox(height: 2.h),
        customAmenities(Strings.masterSuiteBalcony),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.amenities.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _buildAmenityContainer(controller.amenities[index], index),
                  SizedBox(height: 2.h),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildAmenityContainer(String amenityName, int index) {
    TextEditingController textController = TextEditingController(text: amenityName);

    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5.w),
            Expanded(
              child: TextFormField(
                controller: textController,
                style: FontManager.regular(16, color: AppColors.textAddProreties),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.amenities,
                ),
                onFieldSubmitted: (value) {
                  controller.amenities[index] = value;
                },
                onChanged: (value) {
                  // Update the value in the controller live
                  controller.amenities[index] = value;
                },
              ),
            ),
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
    );
  }

  Widget customAmenities(String amenityName) {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5.w),
            Text(
              amenityName,
              style: FontManager.regular(16, color: AppColors.textAddProreties),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Implement remove functionality here
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
    );
  }

  Widget _buildAddAmenityField() {
    return Container(
      width: 110.w,

      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5.w),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                child: TextFormField(
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "Amenity ${controller.amenities.length + 1}",
                    hintStyle: FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.addAmenity("Amenity ${controller.amenities.length + 1}");
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: LinearProgressIndicator(
        value: controller.currentPage.value / 8,
        backgroundColor: AppColors.greyText,
        color: AppColors.buttonColor,
        minHeight: 3,
        borderRadius: BorderRadius.all(AppRadius.radius4),
      ),
    ));
  }

  Widget _buildDoneButton() {
    return CommonButton(
      title: Strings.done,
      onPressed: () {
        Get.back();
      },
    );
  }

  Widget _buildTitleStep(String stepCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $stepCount/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import '../../../../../generated/assets.dart';
import '../../../common_widgets/common_button.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';

class CheckInOutDetailsPage extends StatefulWidget {
  const CheckInOutDetailsPage({super.key});

  @override
  State<CheckInOutDetailsPage> createState() => _CheckInOutDetailsPageState();
}

class _CheckInOutDetailsPageState extends State<CheckInOutDetailsPage> {
  bool isChecked = false;
  bool isChecked1 = true;
  int currentPage = 5;
  String? selectedType;

  void nextPage() {
    if (selectedType != null) {
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_left, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      Strings.checkInOutDetails,
                      style: FontManager.medium(20, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                buildTitleStep(),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Strings.checkInTime,
                        style: FontManager.medium(color: AppColors.black, 16)),
                  ],
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TimePickerSpinner(
                    locale: const Locale('en', ''),
                    time: DateTime.now(),
                    is24HourMode: false,
                    isShowSeconds: true,
                    itemHeight: 60,
                    normalTextStyle: FontManager.regular(20),
                    highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        // dateTime = time;
                      });
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue ?? false;
                        });
                      },
                      side: const BorderSide(color: AppColors.texFiledColor),
                    ),
                    Text(Strings.flexibleWithCheckInTime,
                        style: FontManager.regular(color: AppColors.black, 14)),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Strings.checkOutTime,
                        style: FontManager.medium(color: AppColors.black, 16)),
                  ],
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TimePickerSpinner(
                    locale: const Locale('en', ''),
                    time: DateTime.now(),
                    is24HourMode: false,
                    isShowSeconds: true,
                    itemHeight: 60,
                    normalTextStyle: FontManager.regular(20),
                    highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        // dateTime = time;
                      });
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: isChecked1,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked1 = newValue ?? true;
                        });
                      },
                      side: const BorderSide(color: AppColors.texFiledColor),
                    ),
                    Text(
                      Strings.flexibleWithCheckInTime,
                      style: FontManager.regular(color: AppColors.black, 14),
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 7.h),
                SizedBox(
                  height: 7.h,
                  width: 50.w,
                  child: Image.asset(Assets.imagesHomeProgres4,
                      fit: BoxFit.contain),
                ),
                SizedBox(height: 1.h),
                CommonButton(
                  title: currentPage < 7 ? Strings.nextStep : Strings.done,
                  onPressed: () async {
                    Get.toNamed(Routes.locationView);
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitleStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travellery_mobile/travellery_mobile/common_widgets/common_button.dart';
import '../../../../generated/assets.dart';
import '../../../common_widgets/common_dialog.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/font_manager.dart';
import '../../../utils/app_string.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  late GoogleMapController mapController;
  static const LatLng initialPosition = LatLng(37.7749, -122.4194);
  LatLng selectedPosition = initialPosition;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onTap(LatLng position) {
    setState(() {
      selectedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 12,
                    ),
                    onTap: onTap,
                    markers: {
                      Marker(
                        markerId: MarkerId('selected-location'),
                        position: selectedPosition,
                      ),
                    },
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_left, size: 30),
                      const SizedBox(width: 8),
                      Text(
                        Strings.location,
                        style: FontManager.medium(20, color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 45.h,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.addLocation, style: FontManager.regular(18)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: CommonButton(
                    title: Strings.nextStep,
                    onPressed: () {
                      CustomDialog.showCustomDialog(
                        context: context,
                        title: Strings.turnLocationOn,
                        message: Strings.locationDiscription,
                        imageAsset: Assets.imagesQuestionDialog,
                        buttonLabel: Strings.settings,
                        changeEmailLabel: Strings.cancel,
                        onResendPressed: () {
                          Get.toNamed(Routes.addressPage);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../common_widgets/common_button.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../../utils/textFormField.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int currentPage = 6;

  String? address;
  String? streetAddress;
  String? landmark;
  String? city;
  String? pinCode;
  String? state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_left, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      Strings.address,
                      style: FontManager.medium(20, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                buildTitleStep(),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.address,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.enterYourAddress,
                  onSaved: (value) => address = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.streetAddress,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.enterYourStreetAddress,
                  onSaved: (value) => streetAddress = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.landmark,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.landmark,
                  onSaved: (value) => landmark = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.cityTown,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.cityTown,
                  onSaved: (value) => city = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.pinCode,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.pinCode,
                  onSaved: (value) => pinCode = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.state,
                            style:
                                FontManager.regular(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(14,
                                color: AppColors.redAccent),
                            text: Strings.addressIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  hintText: Strings.state,
                  onSaved: (value) => state = value,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.showYourSpecificLocation,
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {
                        setState(() {});
                      },
                      thumbColor:
                          WidgetStateProperty.all(AppColors.buttonColor),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Text(
                    Strings.addressDiscription,
                    style: FontManager.regular(12, color: AppColors.greyText),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 7.h),
                SizedBox(
                  height: 7.h,
                  width: 50.w,
                  child: Image.asset(Assets.imagesHomeProgress5,
                      fit: BoxFit.contain),
                ),
                SizedBox(height: 1.h),
                CommonButton(
                  title: Strings.nextStep,
                  onPressed: () {
                    Get.toNamed(Routes.photoPage);
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitleStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/routes_app/all_routes_app.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../generated/assets.dart';
import '../../../common_widgets/common_button.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import 'custom_photo_upload_image.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  int currentPage = 7;
  List<String?> imagePaths = List.filled(6, null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Strings.photos,
                      style: FontManager.medium(20, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTitleStep(),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  Strings.coverPhoto,
                  style: FontManager.regular(14, color: AppColors.textAddProreties),
                ),
                SizedBox(height: 10),
                PhotoUploadContainer(
                  index: 0,
                  imagePath: imagePaths[0],
                  onImageSelected: (path) {
                    setState(() {
                      imagePaths[0] = path;
                    });
                  },
                ),
                SizedBox(height: 30),
                Text(
                  Strings.homestayPhotos,
                  style: FontManager.regular(14, color: AppColors.textAddProreties),
                ),
                SizedBox(height: 2.h),
                buildPhotoUploadRows(),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 7.h,
                      width: 50.w,
                      child: Image.asset(Assets.imagesImageProgres6, fit: BoxFit.contain),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                CommonButton(
                  title: Strings.nextStep,
                  onPressed: () {
                    Get.toNamed(Routes.homeStayDescriptionPage);
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitleStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Strings.stepCount} $currentPage/8",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPhotoUploadRows() {
    return Column(
      children: List.generate(3, (rowIndex) {
        return Column(
          children: [
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: PhotoUploadContainer(
                    index: rowIndex * 2,
                    imagePath: imagePaths[rowIndex * 2],
                    onImageSelected: (path) {
                      setState(() {
                        imagePaths[rowIndex * 2] = path; // Update the image path
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: PhotoUploadContainer(
                    index: rowIndex * 2 + 1,
                    imagePath: imagePaths[rowIndex * 2 + 1],
                    onImageSelected: (path) {
                      setState(() {
                        imagePaths[rowIndex * 2 + 1] = path; // Update the image path
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../generated/assets.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';

class PhotoUploadContainer extends StatelessWidget {
  final int index;
  final String? imagePath;
  final ValueChanged<String?> onImageSelected;

  const PhotoUploadContainer({
    Key? key,
    required this.index,
    this.imagePath,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 150.w,
      decoration: BoxDecoration(
        image: imagePath != null
            ? DecorationImage(
          image: FileImage(File(imagePath!)),
          fit: BoxFit.fill,
        )
            : DecorationImage(
          image: AssetImage(Assets.imagesImageRectangle),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesUploadImage,
            height: 30,
            width: 30,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: Strings.photoChooseDiscription,
                  style: FontManager.regular(10, color: AppColors.greyText),
                ),
                TextSpan(
                  mouseCursor: SystemMouseCursors.click,
                  style: FontManager.regular(10, color: AppColors.buttonColor),
                  text: Strings.chooseFile,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                      if (result != null) {
                        String filePath = result.files.single.path!;
                        print("${Strings.fileExpection} $filePath for index $index");
                        onImageSelected(filePath);
                      } else {
                        print(Strings.noFileSelectedExpection);
                      }
                    },
                ),
                TextSpan(
                  style: FontManager.regular(10, color: AppColors.greyText),
                  text: Strings.to,
                ),
                TextSpan(
                  style: FontManager.regular(10, color: AppColors.greyText),
                  text: Strings.upload,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
