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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travellery_mobile_app/common_widget/common_button.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/list_homestay_screen/custom_view_list_home.dart';
import 'controller.dart';

class ListHomestayPages extends StatelessWidget {
  const ListHomestayPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<ListPageController>(
        init: ListPageController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 3.5.h),
                    Text(
                      Strings.listHomeStay,
                      style: FontManager.medium(22, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      Strings.listHomeStayGreyText,
                      style: FontManager.regular(15.sp,
                          color: AppColors.greyText),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.listPages.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    var pageData = controller.listPages[index];
                    return ListHomePageCard(
                      imagePath: pageData["imagePath"],
                      description: pageData["description"],
                      description2: pageData["description2"],
                      imageHeight: 25.h,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.listPages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.buttonColor,
                        dotColor: AppColors.greyText,
                        dotHeight: 4,
                      ),
                    ),
                    SizedBox(height: 7.5.h),
                    CommonButton(
                      title: Strings.getStarted,
                      onPressed: controller.onGetStartedButtonTap,
                    ),
                    SizedBox(height: 4.5.h),
                  ],
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import '../../../../utils/font_manager.dart';
import 'package:travellery_mobile_app/common_widget/common_button.dart';

class ListHomePageCard extends StatelessWidget {
  final String imagePath;
  final String description;
  final String description2;
  final double? imageWidth;
  final double? imageHeight;

  const ListHomePageCard({
    super.key,
    required this.imagePath,
    required this.description,
    required this.description2,
    this.imageWidth,
    this.imageHeight,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 9.5.h),
                Image.asset(
                  imagePath,
                  width: imageWidth ?? 90.w,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 2.5.h),
                Text(
                  description,
                  style: FontManager.medium(20, color: AppColors.buttonColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.8.h),
                Text(
                  description2,
                  style: FontManager.regular(12, color: AppColors.black),
                  textAlign: TextAlign.center,
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
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_routes.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';

class ListPageController extends GetxController {
  RxInt selectedIndex = 0.obs;


  RxBool isPasswordVisible = false.obs;
  PageController pageController = PageController();

  List<Map<String, dynamic>> listPages = [
    {
      "title": Strings.listHomeStay,
      "subtitle": Strings.listHomeStayGreyText,
      "imagePath": Assets.imagesListHome,
      "description": Strings.aboutYourStay,
      "description2": Strings.listHomeStayInto1,
    },
    {
      "title": Strings.listHomeStay,
      "subtitle": Strings.listHomeStayGreyText,
      "imagePath": Assets.imagesListHome2,
      "description": Strings.hotToGetThere,
      "description2": Strings.listHomeStayInto2,
    },
    {
      "title": Strings.listHomeStay,
      "subtitle": Strings.listHomeStayGreyText,
      "imagePath": Assets.imagesListHome3,
      "description": Strings.previewandPublish,
      "description2": Strings.listHomeStayInto3,
    },
  ];

  onGetStartedButtonTap() {
    if (selectedIndex.value + 1 < listPages.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    } else {
      Get.toNamed(Routes.login);
    }
  }

  onPageChanged(int index) {
    selectedIndex.value = index;
  }
}
import 'package:get/get.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  var homestayTitle = ''.obs;
  var selectedType = ''.obs;

  List<String> pageTitles = [
    Strings.homestayTitle,
    Strings.homestayType,
    Strings.accommodationDetails,
    Strings.amenities,
    Strings.newAmenities,
    Strings.houseRules,
    Strings.newRules,
    Strings.checkInOutDetails,
    Strings.location,
    Strings.address,
    Strings.photos,
    Strings.homeStayDescription,
    Strings.priceAndContactDetailsPage,
    Strings.preview,
    Strings.termsAndConditions
  ];

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
import 'package:travellery_mobile_app/common_widget/common_button.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller.dart';

class CustomAddPropertiesPage extends StatelessWidget {
  final Widget body;

  const CustomAddPropertiesPage({
    required this.body,
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
              body,
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile_app/common_widget/common_button.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_routes.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/widget/accommodation_details_page.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/widget/homeStay_type_page.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/widget/homeStaytitle_page.dart';
class AddPropertiesScreen extends StatefulWidget {
  const AddPropertiesScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
}

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  final AddPropertiesController controller = Get.find<AddPropertiesController>();
  final PageController _pageController = PageController();

  // Remove listener from initState and rely on onPageChanged instead
  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage.value < 8) {
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
            SizedBox(height: 5.h),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left, size: 30),
                  onPressed: backPage,
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
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  print("00000000000000${controller.currentPage.value}00000000000");
                  controller.currentPage.value = index + 1;
                  print("00000000000000${controller.currentPage.value}1111111111");
                },
                children: [
                  HomeStayTitleScreen(onNext: nextPage, onBack: backPage),
                  HomeStayTypeScreen(onNext: nextPage, onBack: backPage),
                  AccommodationDetailsPage(onNext: nextPage, onBack: backPage),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Obx(() => Slider(
              value: controller.currentPage.value.toDouble(),
              onChanged: (value) {
                controller.currentPage.value = value.toInt();
                _pageController.jumpToPage(controller.currentPage.value - 1);
              },
              min: 1.0,
              max: 8.0,
              divisions: 7,
              inactiveColor: AppColors.greyText,
              activeColor: AppColors.buttonColor,
            )),
            SizedBox(height: 2.h),
            Obx(() => CommonButton(
              title: Strings.nextStep,
              onPressed: controller.isCurrentPageValid() ? nextPage : null,
              backgroundColor: controller.isCurrentPageValid()
                  ? AppColors.buttonColor
                  : AppColors.lightPerpul,
            )),
            SizedBox(height: 5.h),
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
import 'package:travellery_mobile_app/common_widget/common_textformfield.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/custom_view.dart';

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
import 'package:travellery_mobile_app/generated/assets.dart';
import 'package:travellery_mobile_app/utils/app_color.dart';
import 'package:travellery_mobile_app/utils/app_radius.dart';
import 'package:travellery_mobile_app/utils/app_strings.dart';
import 'package:travellery_mobile_app/utils/font_manager.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/controller.dart';
import 'package:travellery_mobile_app/view/auth_flow/add_properties_screen/add_properties_pages/custom_view.dart';
class HomeStayTypeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HomeStayTypeScreen({
    Key? key,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller = Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 400, // Ensures that GridView takes the remaining space
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.traditional, Assets.imagesTraditional, controller),
                // buildHomestayTypeCard(Strings.bedAndBreakfast, Assets.imagesBedbreakfast, controller),
                // buildHomestayTypeCard(Strings.urban, Assets.imagesUrban, controller),
                // buildHomestayTypeCard(Strings.ecoFriendly, Assets.imagesEcofriendly, controller),
                // buildHomestayTypeCard(Strings.adventure, Assets.imagesAdventure, controller),
                // buildHomestayTypeCard(Strings.luxury, Assets.imagesLuxury, controller),
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
            decoration: BoxDecoration(
              color: isSelected ? AppColors.buttonColor : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.buttonColor : AppColors.borderContainerGriedView,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(AppRadius.radius10),
            ),
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  image,
                  height: 5.h,
                  width: 10.w,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                Center(
                  child: Text(
                    type,
                    style: FontManager.regular(12.sp, color: AppColors.black),
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
