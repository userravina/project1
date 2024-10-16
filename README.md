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
import 'package:get/get.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  var homestayTitle = ''.obs;
  var selectedType = ''.obs;

  void nextPage() {
    if (currentPage.value < 7) {
      currentPage.value++;
    }
  }

  RxBool get isTitleNotEmpty => homestayTitle.value.isNotEmpty.obs;
  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }

  void selectHomeStayType(String type) {
    selectedType.value = type;
    update();
  }
  bool isHomeStayTypeSelected(String type) {
    return selectedType.value == type;
  }
  bool isCurrentPageValid() {
    switch (currentPage.value) {
      case 1:
        return homestayTitle.value.isNotEmpty;
      case 2:
        return selectedType.value.isNotEmpty;

      default:
        return false;
    }
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../controller/add_properties_controller.dart';

class CustomAddPropertiesPage extends StatelessWidget {
  final String title;
  final Widget body;
  final String stepCount;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const CustomAddPropertiesPage({
    required this.title,
    required this.body,
    required this.stepCount,
    required this.onNext,
    this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left, size: 30),
                    onPressed: onBack,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              const SizedBox(height: 31),
              buildTitleStep(stepCount),
            body,
              SizedBox(height: 1.h),
              GetBuilder(
                init: AddPropertiesController(),
                builder: (controller) => CommonButton(
                  title: Strings.nextStep,
                  onPressed: controller.isCurrentPageValid() ? onNext : null,
                  backgroundColor: controller.isCurrentPageValid()
                      ? AppColors.buttonColor
                      : AppColors.lightPerpul,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
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
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
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
      title: Strings.homestayTitle,
      stepCount: (controller.currentPage.value).toString(),
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
          Padding(padding: EdgeInsets.only(left: 10.w,right: 10.w),

            child: Slider(
              value: controller.currentPage.value.toDouble(),
              onChanged: (value) {
                controller.currentPage.value = value.toInt();
              },
              min: 0.0,inactiveColor: AppColors.inactiveDotColor,
              activeColor: AppColors.buttonColor,

              max: 8.0,
              divisions: 8,
            ),
          ),
        ],
      ),
      onNext: () {
        FocusManager.instance.primaryFocus?.unfocus();
          onNext();
      },
      onBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
          onBack();
      },
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

  const HomeStayTypeScreen(
      {Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller =
        Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      title: Strings.homestayType,
      stepCount: (controller.currentPage.value).toString(),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
                buildHomestayTypeCard(
                    Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.bedAndBreakfast,
                    Assets.imagesBedbreakfast, controller),
                buildHomestayTypeCard(
                    Strings.urban, Assets.imagesUrban, controller),
                buildHomestayTypeCard(
                    Strings.ecoFriendly, Assets.imagesEcofriendly, controller),
                buildHomestayTypeCard(
                    Strings.adventure, Assets.imagesAdventure, controller),
                buildHomestayTypeCard(
                    Strings.luxury, Assets.imagesLuxury, controller),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Slider(
            value: controller.currentPage.value.toDouble(),
            onChanged: (value) {
              controller.currentPage.value = value.toInt();
            },
            min: 0.0,
            max: 7.0,
            divisions: 7,
          ),
        ],
      ),
      onNext: () {
        onNext();
      },
      onBack: () {
        onBack();
      },
    );
  }

  Widget buildHomestayTypeCard(
      String type, String image, AddPropertiesController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectHomeStayType(type);
      },
      child: Obx(
        () {
          bool isSelected = controller.isHomeStayTypeSelected(type);
          return Container(
            height: 120,
            width: 160,
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.selectContainerColor : AppColors.white,
              border: Border.all(
                color: isSelected ?AppColors.buttonColor: AppColors.borderContainerGriedView,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(AppRadius.radius10),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(image,
                    height: 5.h, width: 10.w, fit: BoxFit.contain),
                Spacer(),
                Center(
                  child: Text(
                    type,
                    style: FontManager.regular(16, color: AppColors.black),
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
import 'package:travellery_mobile/travellery_mobile/routes_app/all_routes_app.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestay_type.dart';
import '../../accommodation_details_pages/accommodation_details_page.dart';
import '../controller/add_properties_controller.dart';
import 'widget_view/homestay_title1.dart';

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
      controller.currentPage.value++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.accoummodationPage);
    }
  }

  void backPage() {
    if (controller.currentPage.value > 1) {
      controller.currentPage.value--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage3);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // pages
          HomeStayTitleScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTypeScreen(
            onNext: nextPage,
            onBack: backPage,
          ),

          AccommodationDetailsPage(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTypeScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTitleScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTypeScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTitleScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
          HomeStayTypeScreen(
            onNext: nextPage,
            onBack: backPage,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../common_widgets/common_button.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/font_manager.dart';
import '../steps/controller/add_properties_controller.dart';
import '../steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import 'custtom_container.dart';

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
      title: Strings.accommodationDetails,
      stepCount: (controller.currentPage.value).toString(),
      body: buildBody(controller),
      onNext: () {
        FocusManager.instance.primaryFocus?.unfocus();
        // Add your logic for the next step
      },
      onBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
        // Add your logic for going back
      },
    );
  }

  Widget buildBody(AddPropertiesController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w), // Add horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccommodationOption(
            title: Strings.entirePlace,
            subtitle: Strings.wholePlacetoGuests,
            imageAsset: Assets.imagesTraditional,
          ),
          SizedBox(height: 3.h),
          _buildAccommodationOption(
            title: Strings.privateRoom,
            subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
            imageAsset: Assets.imagesPrivateRoom,
          ),
          SizedBox(height: 4.h),
          _buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests),
          SizedBox(height: 2.h),
          _buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed),
          SizedBox(height: 2.h),
          _buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed),
          SizedBox(height: 2.h),
          _buildCustomContainer(Assets.imagesExtraFloor, Strings.extraFloorMattress),
          SizedBox(height: 2.h),
          _buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms),
          SizedBox(height: 2.h),
          _buildCustomContainer(Assets.imagesKitchen, Strings.kitchenAvailable),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAccommodationOption({
    required String title,
    required String subtitle,
    required String imageAsset,
  }) {
    return Container(
      width: double.infinity, // Use double.infinity to take full width
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(AppRadius.radius10),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: FontManager.regular(16, color: AppColors.black),
        ),
        subtitle: Text(
          subtitle,
          style: FontManager.regular(12, color: AppColors.greyText),
        ),
        leading: Image.asset(
          imageAsset,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
        ),
        trailing: Radio(
          value: true,
          groupValue: null,
          onChanged: (value) {},
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minVerticalPadding: 0,
        minTileHeight: 5,
      ),
    );
  }

  Widget _buildCustomContainer(String imageAsset, String title) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      defaultNumber: Strings.defutlNumber,
    );
  }
}


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
