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
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/font_manager.dart';


class CusttomContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final RxInt count;

  const CusttomContainer({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            imageAsset,
            height: 26,
            width: 26,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: FontManager.regular(14, color: AppColors.black),
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.find<AddPropertiesController>().decrement(count);
                },
                child: Image.asset(
                  Assets.imagesDividecircle,
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
                  Assets.imagesPluscircle,
                  height: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/font_manager.dart';

class AmenityAndHouseRulesContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const AmenityAndHouseRulesContainer({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: GestureDetector(
        onTap: onSelect, // Handle selection
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 3.w),
              Image.asset(
                imageAsset,
                height: 28,
                width: 28,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5.w),
              Text(
                title,
                style: FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              Spacer(),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected ? AppColors.buttonColor : AppColors.borderContainerGriedView,
              ),
              SizedBox(width: 3.w),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import '../../../../../../generated/assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';

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
      decoration: BoxDecoration(borderRadius: BorderRadius.all(AppRadius.radius10),
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
      child:imagePath != null
          ? SizedBox.shrink(): Column(
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_string.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  var homestayTitle = ''.obs;
  var selectedType = ''.obs;
  var selectedAccommodation = ''.obs;
  final PageController pageController = PageController();

  List<String> pageTitles = [
    Strings.homestayTitle,
    Strings.homestayType,
    Strings.accommodationDetails,
    Strings.amenities,
    Strings.houseRules,
    Strings.checkInOutDetails,
    Strings.location,
    Strings.address,
    Strings.photos,
    Strings.homeStayDescription,
    Strings.priceAndContactDetailsPage,
    Strings.preview,
    Strings.termsAndConditions
  ];

  void nextPage() {
    if (currentPage.value < 10) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  void backPage() {
    if (currentPage.value > 1) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  // homestayTitle Page Logic

  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }


  // homestayType Page Logic
  void selectHomeStayType(String index) {
    selectedType.value = index;
    update();
  }

  bool isHomeStayTypeSelected(String index) {
    return selectedType.value == index;
  }

  // Accommodation Page Logic
  void selectAccommodation(String value) {
    selectedAccommodation.value = value;
  }

  var maxGuestsCount = 0.obs;
  var singleBedCount = 0.obs;
  var doubleBedCount = 0.obs;
  var extraFloorCount = 0.obs;
  var bathRoomsCount = 0.obs;
  var isKitchenAvailable = false.obs;


  void increment(RxInt count) {
    count.value++;
  }

  void decrement(RxInt count) {
    if (count.value > 0) {
      count.value--;
    }
  }

  // Amenities and New Amenities Page Logic

  RxList<bool> selectedAmenities = List.generate(10, (index) => false).obs;
  List<TextEditingController> textControllers = [];
  var amenities = [].obs;

  void addAmenity(String amenityName) {
    amenities.add(amenityName);
    selectedAmenities.add(false);
  }

  void removeAmenity(int index) {
    if (index < amenities.length) {
      amenities.removeAt(index);
      textControllers[index].dispose();
      textControllers.removeAt(index);
    }
  }

  void toggleAmenity(int index) {
    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
      update();
    }
  }

  // House Rules and New Rules Logic

  RxList<bool> selectedRules = List.generate(10, (index) => false).obs;
  List<TextEditingController> rulesTextControllers = [];
  var rules = [].obs;

  void addRules(String amenityName) {
    rules.add(amenityName);
    selectedRules.add(false);
  }

  void removeRules(int index) {
    if (index < rules.length) {
      rules.removeAt(index);
      rulesTextControllers[index].dispose();
      rulesTextControllers.removeAt(index);
    }
  }

  void toggleRules(int index) {
    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
      update();
    }
  }

  // Check - in/ut details page logic

  var isCheckInTime = false.obs;
  var isCheckInOut = false.obs;
  Rx<DateTime> checkInTime = DateTime.now().obs;
  Rx<DateTime> checkOutTime = DateTime.now().obs;

  void checkInTimeUpdate(var value){
    isCheckInTime.value = value;
    update();
  }

  void checkOutTimeUpdate(var value){
    isCheckInOut.value = value;
    update();
  }

  // location page add logic

  // Address page add logic
  var address = ''.obs;
  var streetAddress = ''.obs;
  var landmark = ''.obs;
  var city = ''.obs;
  var pinCode = ''.obs;
  var state = ''.obs;
  var isSpecificLocation = false.obs;

  void saveAddress(String? value) {
    if (value != null) {
      address.value = value;
      print('11111111111${address.value}111111111111111');
      update();
    }
  }

  void saveStreetAddress(String? value) {
    if (value != null) {
      streetAddress.value = value;
      update();

    }
  }

  void saveLandmark(String? value) {
    if (value != null) {
      landmark.value = value;
      update();

    }
  }

  void saveCity(String? value) {
    if (value != null) {
      city.value = value;
      update();

    }
  }

  void savePinCode(String? value) {
    if (value != null) {
      pinCode.value = value;
      update();

    }
  }

  void saveState(String? value) {
    if (value != null) {
      state.value = value;
      update();

    }
  }

  // Photos pade add logic

  var imagePaths = List<String?>.filled(7, null).obs;

  // description Page add logic
  var description = ''.obs;

  void setDescription(String value) {
    description.value = value;
    update();
  }

  // Price and Contact details page logic

  var startPrice = ''.obs;
  var endPrice = ''.obs;
  var ownerContactNumber = ''.obs;
  var ownerEmail = ''.obs;
  var homeStayContactNumbers = [].obs;
  var homeStayEmails = <String>[].obs;


  bool isCurrentPageValid() {
    switch (currentPage.value) {
      case 1:
        return homestayTitle.value.isNotEmpty;
      case 2:
        return selectedType.value.isNotEmpty;
      case 3:
        return selectedAccommodation.value.isNotEmpty;
      case 4:
        return  selectedAmenities[0] || selectedAmenities[1] || selectedAmenities[2] == true;
      case 5:
        return  selectedRules[0] || selectedRules[1] || selectedRules[2] == true;
      case 6:
        return isCheckInTime.value && isCheckInOut.value == true;
      case 8:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 9:
        return imagePaths.any((path) => path != null);
      case 10:
        return description.value.isNotEmpty;
      case 11:
        return startPrice.value.isNotEmpty;
      default:
        return false;
    }
  }

}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_colors.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            body,
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}import 'package:flutter/material.dart';
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
                    child: Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    Strings.newAmenities,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Obx(() =>
                  buildTitleStep(controller.currentPage.value.toString())),
              addTextFieldShow(),
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
                            borderRadius: BorderRadius.all(AppRadius.radius4),
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

  Widget addTextFieldShow() {
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
                  addAmenityLayout(index),
                  SizedBox(height: 2.h),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget addAmenityLayout(int index) {
    if (index >= controller.textControllers.length) {
      controller.textControllers.add(TextEditingController());
    }
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
                controller: controller.textControllers[index],
                style:
                    FontManager.regular(16, color: AppColors.textAddProreties),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (value) {
                  controller.amenities[index] = value;
                },
                onChanged: (value) {
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
            const Spacer(),
            GestureDetector(
              onTap: () {},
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

  Widget addTextField() {
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
                    hintText: "Amenity ${controller.amenities.length}",
                    hintStyle:
                        FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.addAmenity(
                            "Amenity ${controller.amenities.length}");
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
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';

class NewRulesPages extends StatefulWidget {
  const NewRulesPages({super.key});

  @override
  State<NewRulesPages> createState() => _NewRulesPagesState();
}

class _NewRulesPagesState extends State<NewRulesPages> {
  final AddPropertiesController controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.2.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    Strings.newRules,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              Obx(() =>
                  buildTitleStep(controller.currentPage.value.toString())),
              addTextFieldShow(),
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
                        borderRadius: BorderRadius.all(AppRadius.radius4),
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

  Widget addTextFieldShow() {
    return Column(
      children: [
        customAmenities(Strings.homeTheater),
        SizedBox(height: 2.h),
        customAmenities(Strings.masterSuiteBalcony),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.rules.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  addAmenityLayout(index),
                  SizedBox(height: 2.h),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget addAmenityLayout(int index) {
    if (index >= controller.rulesTextControllers.length) {
      controller.rulesTextControllers.add(TextEditingController());
    }
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
                controller: controller.rulesTextControllers[index],
                style:
                FontManager.regular(16, color: AppColors.textAddProreties),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (value) {
                  controller.rules[index] = value;
                },
                onChanged: (value) {
                  controller.rules[index] = value;
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.removeRules(index);
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

  Widget customAmenities(String rulesName) {
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
              rulesName,
              style: FontManager.regular(16, color: AppColors.textAddProreties),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
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

  Widget addTextField() {
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
                    hintText: "Rules ${controller.rules.length}",
                    hintStyle:
                    FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.addRules(
                            "Rules ${controller.rules.length}");
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
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';

class AddressPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddressPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController addressController = Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: Column(
        children: [
          SizedBox(height: 2.5.h),
          addressPageTextFieldsCommon(
            label: Strings.address,
            hint: Strings.enterYourAddress,
            onChanged:(p0) {
              addressController.saveAddress(p0);
            },
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            label: Strings.streetAddress,
            hint: Strings.enterYourStreetAddress,
            onChanged: addressController.saveStreetAddress,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            label: Strings.landmark,
            hint: Strings.landmark,
            onChanged: addressController.saveLandmark,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            label: Strings.cityTown,
            hint: Strings.cityTown,
            onChanged: addressController.saveCity,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            label: Strings.pinCode,
            hint: Strings.pinCode,
            onChanged: addressController.savePinCode,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            label: Strings.state,
            hint: Strings.state,
            onChanged: addressController.saveState,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.showYourSpecificLocation, style: FontManager.regular(16, color: AppColors.textAddProreties)),
              Obx(() => Switch(
                value: addressController.isSpecificLocation.value,
                onChanged: (value) {
                  addressController.isSpecificLocation.value = value;
                },
                thumbColor: WidgetStateProperty.all(AppColors.buttonColor),
              )),
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
        ],
      ),
    );
  }

  Widget addressPageTextFieldsCommon({
    required String label,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: label, style: FontManager.regular(14, color: AppColors.black)),
              TextSpan(style: FontManager.regular(14, color: AppColors.redAccent), text: Strings.addressIcon),
            ],
          ),
        ),
        SizedBox(height: 0.5.h),
        CustomTextField(
          hintText: hint,
          onChanged: onChanged,
        ),
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
import '../../common_widget/amenities_and_houserules_custom.dart';
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
                    imageAsset: Assets.imagesWiFi,
                    title: Strings.wiFi,
                    isSelected: controller.selectedAmenities[0],
                    onSelect: () => controller.toggleAmenity(0),
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesAirCondioner,
                    title: Strings.airConditioner,
                    isSelected: controller.selectedAmenities[1],
                    onSelect: () => controller.toggleAmenity(1),
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesFirAlarm,
                    title: Strings.fireAlarm,
                    isSelected: controller.selectedAmenities[2],
                    onSelect: () => controller.toggleAmenity(2),
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
          AmenityAndHouseRulesContainer(
            imageAsset: Assets.imagesHometherater,
            title: Strings.homeTheater,
            isSelected: controller.selectedAmenities[3],
            onSelect: () => controller.toggleAmenity(3),
          ),
          SizedBox(height: 1.2.h),
          AmenityAndHouseRulesContainer(
            imageAsset: Assets.imagesMastrSuite,
            title: Strings.masterSuiteBalcony,
            isSelected: controller.selectedAmenities[4],
            onSelect: () => controller.toggleAmenity(4),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.amenities.length,
              itemBuilder: (context, index) {
                if (index >= controller.selectedAmenities.length) {
                  controller.selectedAmenities.add(false);
                }
                return Column(
                  children: [
                    SizedBox(height: 15),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesMastrSuite,
                      title: controller.amenities[index],
                      isSelected: controller.selectedAmenities[index],
                      onSelect: () => controller.toggleAmenity(index),
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
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';

class CheckInOutDetailsPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CheckInOutDetailsPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  State<CheckInOutDetailsPage> createState() => _CheckInOutDetailsPageState();
}

class _CheckInOutDetailsPageState extends State<CheckInOutDetailsPage> {
  final AddPropertiesController  controller = Get.find<AddPropertiesController>();


  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        children: [
          SizedBox(height: 2.5.h),
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
              time: controller.checkInTime.value,
              is24HourMode: false,
              isShowSeconds: true,
              itemHeight: 60,
              normalTextStyle: FontManager.regular(20),
              highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
              isForce2Digits: true,
              onTimeChange: (time) {
                controller.checkInTime.value = time;
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Checkbox(activeColor: AppColors.buttonColor,
                value: controller.isCheckInTime.value,
                onChanged: (bool? newValue) {
                  controller.isCheckInTime.value = newValue ?? false;
                  controller.checkInTimeUpdate(controller.isCheckInTime.value);
                },
                side: const BorderSide(color: AppColors.texFiledColor),
              )),
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
              time: controller.checkOutTime.value,
              is24HourMode: false,
              isShowSeconds: true,
              itemHeight: 60,
              normalTextStyle: FontManager.regular(20),
              highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
              isForce2Digits: true,
              onTimeChange: (time) {
                controller.checkOutTime.value = time;
              },
            ),
          ),

          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Checkbox(activeColor: AppColors.buttonColor,
                value: controller.isCheckInOut.value,
                onChanged: (bool? newValue) {
                  controller.isCheckInOut.value = newValue ?? false;
                  controller.checkOutTimeUpdate(controller.isCheckInOut.value);
                },
                side: const BorderSide(color: AppColors.texFiledColor),
              )),
              Text(
                Strings.flexibleWithCheckInTime,
                style: FontManager.regular(color: AppColors.black, 14),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
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
          SizedBox(height: 2.5.h),
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
}import 'package:flutter/material.dart';
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
          SizedBox(height: 2.5.h),
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
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

class HomeStayDescriptionPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HomeStayDescriptionPage({
    Key? key,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: AddPropertiesController(),builder: (controller) =>  CustomAddPropertiesPage(
        body: Column(
          children: [
            SizedBox(height: 2.5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    Strings.description,
                    style: FontManager.regular(14, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            CustomTextField(
              maxLines: 7,
              maxLength: 500,
              hintText: Strings.enterDescription,
              onChanged: (value) {
                controller.setDescription(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/amenities_and_houserules_custom.dart';
import '../../controller/add_properties_controller.dart';

class HouseRulesPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HouseRulesPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  State<HouseRulesPage> createState() => _HouseRulesPageState();
}

class _HouseRulesPageState extends State<HouseRulesPage> {

  final AddPropertiesController controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.newRules);
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
                  Strings.addRules,
                  style:
                  FontManager.medium(18.sp, color: AppColors.buttonColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Obx(() {
            return Column(children: [
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoSmoking,
                title: Strings.noSmoking,
                isSelected: controller.selectedRules[1],
                onSelect: () => controller.toggleRules(1),
              ),
              SizedBox(height: 2.h),
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoDrinking,
                title: Strings.noDrinking,
                isSelected: controller.selectedRules[2],
                onSelect: () => controller.toggleRules(2),
              ),
              SizedBox(height: 2.h),
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoPet,
                title: Strings.noPet,
                isSelected: controller.selectedRules[3],
                onSelect: () => controller.toggleRules(3),
              ),
              SizedBox(height: 5.3.h),
            ],);
          },),
          Text(
            Strings.newRules,
            style: FontManager.medium( 18, color: AppColors.textAddProreties),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          AmenityAndHouseRulesContainer(
            imageAsset: Assets.imagesDamageToProretiy,
            title: Strings.damageToProperty,
            isSelected: controller.selectedRules[4],
            onSelect: () => controller.toggleRules(4),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.rules.length,
              itemBuilder: (context, index) {
                if (index >= controller.selectedRules.length) {
                  controller.selectedRules.add(false);
                }
                return Column(
                  children: [
                    SizedBox(height: 15),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesMastrSuite,
                      title: controller.rules[index],
                      isSelected: controller.selectedRules[index],
                      onSelect: () => controller.toggleRules(index),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travellery_mobile/travellery_mobile/common_widgets/common_button.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_dialog.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/app_string.dart';

class LocationView extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const LocationView({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

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
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   showLocationPermitionDialog();
  // }
  // void showLocationPermitionDialog() {
  //   CustomDialog.showCustomDialog(
  //     context: context,
  //     title: Strings.turnLocationOn,
  //     message: Strings.locationDiscription,
  //     imageAsset: Assets.imagesQuestionDialog,
  //     buttonLabel: Strings.settings,
  //     changeEmailLabel: Strings.cancel,
  //     onResendPressed: () {
  //       Get.back();
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Strings.addLocation, style: FontManager.regular(18)),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/routes_app/all_routes_app.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/custom_photo_upload_image.dart';
import '../../controller/add_properties_controller.dart';

class PhotoPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PhotoPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override

  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final AddPropertiesController controller =  Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.5.h),
          Text(
            Strings.coverPhoto,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          SizedBox(height: 10),
          PhotoUploadContainer(
            index: 0,
            imagePath: controller.imagePaths[0],
            onImageSelected: (path) {
              setState(() {
                controller.imagePaths[0] = path;
              });
            },
          ),
          SizedBox(height: 30),
          Text(
            Strings.homestayPhotos,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          SizedBox(height: 2.h),
          photoUploadRows(),
          SizedBox(height: 7.h),
        ],
      ),
    );
  }

  Widget photoUploadRows() {
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
                    index: rowIndex * 2 + 1,
                    imagePath: controller.imagePaths[rowIndex * 2 + 1],
                    onImageSelected: (path) {
                      setState(() {
                        controller.imagePaths[rowIndex * 2 + 1] = path;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: PhotoUploadContainer(
                    index: rowIndex * 2 + 2,
                    imagePath: controller.imagePaths[rowIndex * 2 + 2],
                    onImageSelected: (path) {
                      setState(() {
                        controller.imagePaths[rowIndex * 2 + 2] = path;
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';

class PriceAndContactDetailsPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PriceAndContactDetailsPage({super.key, required this.onNext, required this.onBack});

  @override
  State<PriceAndContactDetailsPage> createState() =>
      _PriceAndContactDetailsPageState();
}

class _PriceAndContactDetailsPageState
    extends State<PriceAndContactDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: AddPropertiesController(),builder: (controller) =>  CustomAddPropertiesPage(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.5.h),
            Text(
              Strings.price,
              style: FontManager.regular(14, color: AppColors.black),
            ),
            SizedBox(height: 0.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: CustomTextField(
                    hintText: Strings.enterStartPrice,
                    onChanged: (value) {
                      controller.startPrice.value = value;
                    },
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    Strings.to,
                    style: FontManager.regular(14, color: Colors.black),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: CustomTextField(
                    hintText: Strings.enterEndPrice,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.ownerDetails,
              style: FontManager.semiBold(18, color: AppColors.buttonColor),
            ),
            SizedBox(height: 1.5.h),
            Text(Strings.ownerContactNo,
                style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              hintText: Strings.mobileNumberHint,
              validator: (value) {
                if (value!.isEmpty) {
                  return Strings.mobileNumberError;
                } else if (value.length < 10) {
                  return Strings.mobileNumberLengthError;
                }
                return null;
              },
              onSaved: (value) {
                // Handle saved value
              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.ownerEmailID,
                style: FontManager.regular(14, color: AppColors.black)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              hintText: Strings.emailHint,
              validator: (value) {
                if (value!.isEmpty) {
                  return Strings.emailEmpty;
                } else if (!GetUtils.isEmail(value)) {
                  return Strings.invalidEmail;
                }
                return null;
              },
              onChanged: (value) {

              },
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.homeStayDetails,
              style: FontManager.semiBold(18, color: AppColors.buttonColor),
            ),
            SizedBox(height: 1.5.h),
            Text(Strings.homeStayContactNo,
                style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              textStyle: FontManager.regular(16),
              suffixIconImage: Image.asset(
                Assets.imagesPluscircle2,
                height: 17,
                width: 17,
                fit: BoxFit.contain,
              ),
              showSuffixIcon: true,
              hintText: Strings.homeStayContactNo1,
              onSaved: (value) {

              },
            ),
            SizedBox(height: 2.h),
            CustomTextField(
              suffixIconImage: Image.asset(
                Assets.imagesPluscircle2,
                height: 17,
                width: 17,
                fit: BoxFit.contain,
              ),
              showSuffixIcon: true,
              hintText: Strings.homeStayContactNo1,
              onSaved: (value) {

              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.homeStayEmailID,
                style: FontManager.regular(14, color: AppColors.black)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              suffixIconImage: Image.asset(
                Assets.imagesPluscircle2,
                height: 17,
                width: 17,
                fit: BoxFit.contain,
              ),
              showSuffixIcon: true,
              hintText: Strings.homeStayEmailID1,
              onSaved: (value) {

              },

            ),
            SizedBox(height: 2.h),
            CustomTextField(
              suffixIconImage: Image.asset(
                Assets.imagesPluscircle2,
                height: 17,
                width: 17,
                fit: BoxFit.contain,
              ),
              showSuffixIcon: true,
              hintText: Strings.homeStayEmailID2,
              onSaved: (value) {

              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/address_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/check_in_out_details_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestaydescription_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/location_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/amenities_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestay_title1.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/homestay_type.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/house_rules_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/photo_page.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/view/widget_view/price_and_contact_details_page.dart';
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
  const AddPropertiesScreen({super.key});

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
}

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();
  final PageController _pageController = PageController();

  void nextPage() {
    if (controller.currentPage.value < 11) {
      FocusManager.instance.primaryFocus?.unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.previewPage, arguments: {'index': 0});
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
                    AccommodationDetailsPage(
                        onNext: nextPage, onBack: backPage),
                    AmenitiesPage(onNext: nextPage, onBack: backPage),
                    HouseRulesPage(onNext: nextPage, onBack: backPage),
                    CheckInOutDetailsPage(onNext: nextPage, onBack: backPage),
                    LocationView(onNext: nextPage, onBack: backPage),
                    AddressPage(onNext: nextPage, onBack: backPage),
                    PhotoPage(onNext: nextPage, onBack: backPage),
                    HomeStayDescriptionPage(onNext: nextPage, onBack: backPage),
                    PriceAndContactDetailsPage(onNext: nextPage, onBack: backPage),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: LinearProgressIndicator(
                    value: controller.currentPage.value / 10,
                    backgroundColor: AppColors.greyText,
                    color: AppColors.buttonColor,
                    minHeight: 3,
                    borderRadius: BorderRadius.all(AppRadius.radius4),
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
            Obx(
              () => (controller.currentPage.value == 3)
                  ? SizedBox(height: 1.h)
                  : SizedBox(
                      height: 0,
                    ),
            ),
            Obx(
              () => (controller.currentPage.value == 3)
                  ? GestureDetector(
                      onTap: () {
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
                      },
                      child: Text(
                        Strings.saveAndExit,
                        style: FontManager.medium(18,
                            color: AppColors.buttonColor),
                      ))
                  : SizedBox(height: 5.h),
            ),
            Obx(
              () => (controller.currentPage.value == 3)
                  ? SizedBox(height: 1.5.h)
                  : SizedBox(
                      height: 0,
                    ),
            ),
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
          "${Strings.stepCount} $stepCount/10",
          style: FontManager.regular(18, color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PreviewPropertiesController extends GetxController{
  var carouselIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
    pageController.jumpToPage(index);
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/generated/assets.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import 'dart:io';
import '../../../common_widgets/common_button.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../your_properties_screen/your_properties_page/your_properties_page.dart';
import '../controller/preview_properties_controller.dart';

class PreviewPage extends StatefulWidget {
  final int selectedIndex;

  const PreviewPage({super.key, required this.selectedIndex});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {
  final AddPropertiesController controller = Get.find();
  final PreviewPropertiesController previewController = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedIndex == 1) {
      final args = Get.arguments;
      final Property property = args['property'];
      final String? imagePath = args['imagePath'];
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              buildHeader(),
              SizedBox(height: 2.h),
              buildImageSlider(),
              SizedBox(height: 3.h),
              buildPropertyDetails(),
              SizedBox(height: 2.h),
              buildTabBar(),
              Expanded(child: buildTabBarView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
        SizedBox(width: 8),
        Text(
          widget.selectedIndex == 1 ? Strings.done : Strings.preview,
          style: FontManager.medium(20, color: AppColors.black),
        ),
        const Spacer(),
        if (widget.selectedIndex == 1) ...[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textAddProreties,
            ),
            onSelected: (value) {
              if (value == Strings.edit) {
                Get.toNamed(Routes.addPropertiesScreen);
              } else if (value == Strings.delete) {
                // Handle delete action
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                buildPopupMenuItem(Strings.edit, Colors.blue),
                buildPopupMenuItem(Strings.delete, Colors.red),
              ];
            },
          )
        ],
      ],
    );
  }

  PopupMenuItem<String> buildPopupMenuItem(String choice, Color color) {
    return PopupMenuItem<String>(
      value: choice,
      child: Container(
        color: color,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          choice.capitalizeFirst!,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildImageSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {},
            padEnds: false,
            disableCenter: true,
            aspectRatio: 1.6,
            enlargeCenterPage: true,
            autoPlay: false,
            enableInfiniteScroll: false,
            viewportFraction: 1,
          ),
          items: controller.imagePaths.map((imagePath) {
            return ClipRRect(
              borderRadius: BorderRadius.all(AppRadius.radius10),
              child: imagePath != null
                  ? Image.file(File(imagePath), fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey[300],
                    ),
            );
          }).toList(),
        ),
        // Obx(() => SmoothPageIndicator(
        //     controller: previewController.pageController,
        //     count: controller.imagePaths.length,
        //     effect: const ExpandingDotsEffect(
        //       activeDotColor: AppColors.buttonColor,
        //       dotColor: AppColors.inactiveDotColor,
        //       dotHeight: 2,
        //     ),
        //     onDotClicked: (index) {
        //       previewController.pageController.jumpToPage(index);
        //       previewController.updateCarouselIndex(index);
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget buildPropertyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.5.h),
        widget.selectedIndex == 1
            ? Container(
                height: 2.h,
                width: 10.w,
                decoration: BoxDecoration(
                  color: AppColors.approvedColor,
                ),
              )
            : SizedBox.shrink(),
        Text(Strings.hiltonViewVilla,
            style: FontManager.semiBold(28, color: AppColors.textAddProreties)),
        SizedBox(height: 1.5.h),
        Text(Strings.hiltonViewVilla,
            style: FontManager.regular(14, color: AppColors.greyText)),
        SizedBox(height: 1.5.h),
        Text(Strings.doller,
            style: FontManager.medium(20, color: AppColors.textAddProreties)),
      ],
    );
  }

  Widget buildTabBar() {
    return TabBar(
      unselectedLabelColor: AppColors.greyText,
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 1.w,
      tabs: const [
        Tab(text: Strings.details),
        Tab(text: Strings.contact),
      ],
    );
  }

  Widget buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        buildDetailsView(),
        buildContactView(),
      ],
    );
  }

  Widget buildDetailsView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                height: 5.h,
                width: 35.w,
                decoration: BoxDecoration(
                  color: AppColors.lightPerpul,
                  borderRadius: BorderRadius.all(AppRadius.radius24),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      Assets.imagesTraditional,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      Strings.traditional,
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 5.h,
                width: 35.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius24),
                    border: Border.all(color: AppColors.lightPerpul)),
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      Assets.imagesTraditional,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      Strings.entirePlace,
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesBedRooms,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultbedrooms,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesMaxGuests,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultGuests,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesDubleBed,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultDoubleBed,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesSingleBed,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultSingleBed,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesBathRooms,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultBathrooms,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesExtraFloor,
                        height: 5.h,
                        width: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        Strings.defultFloorMattress,
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Text(
                Strings.description,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.descriptionReadMore,
                    style: FontManager.regular(12, color: AppColors.black),
                  ),
                  TextSpan(
                    style:
                        FontManager.regular(12, color: AppColors.buttonColor),
                    text: Strings.readMore,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.toNamed(''),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          buildDescription(),
          SizedBox(height: 2.h),
          buildTimeSection(),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(),
          SizedBox(height: 7.h),
          CommonButton(
            title: Strings.done,
            onPressed: () => Get.toNamed(Routes.termsAndCondition),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.description,
            style: FontManager.medium(18, color: AppColors.textAddProreties)),
        SizedBox(height: 2.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: Strings.descriptionReadMore,
                  style: FontManager.regular(12, color: AppColors.black)),
              TextSpan(
                text: Strings.readMore,
                style: FontManager.regular(12, color: AppColors.buttonColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.toNamed(''),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.time,
            style: FontManager.medium(18, color: AppColors.textAddProreties)),
        SizedBox(height: 2.h),
        Container(
          height: 9.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(AppRadius.radius10),
            border: Border.all(color: AppColors.borderContainerGriedView),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTimeItem(
                  Assets.imagesClock, Strings.checkInTime, "07 : 30 PM"),
              buildTimeSeparator(),
              buildTimeItem(
                  Assets.imagesClock, Strings.checkOutTime, "Flexible"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTimeItem(String iconPath, String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset(iconPath, height: 14, width: 14),
            SizedBox(width: 1.w),
            Text(label,
                style:
                    FontManager.regular(12, color: AppColors.textAddProreties)),
          ],
        ),
        Text(time, style: FontManager.medium(15, color: AppColors.buttonColor)),
      ],
    );
  }

  Widget buildTimeSeparator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 6.h,
          width: 1,
          decoration: BoxDecoration(color: AppColors.borderContainerGriedView),
        ),
      ],
    );
  }

  Widget buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.amenities,
            style: FontManager.medium(18, color: AppColors.textAddProreties)),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildAmenityItem(Assets.imagesWiFi, Strings.freeWifi),
            buildAmenityItem(Assets.imagesAirCondioner, Strings.airCondition2),
            buildAmenityItem(Assets.imagesHometherater, Strings.hometheater2),
            buildAmenityItem(Assets.imagesFirAlarm, Strings.firAlarm2),
          ],
        ),
      ],
    );
  }

  Widget buildAmenityItem(String iconPath, String label) {
    return Column(
      children: [
        Image.asset(iconPath, height: 35, width: 35),
        SizedBox(height: 2.w),
        Text(label,
            style: FontManager.regular(12, color: AppColors.textAddProreties),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget buildHouseRules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.houseRules,
            style: FontManager.medium(18, color: AppColors.textAddProreties)),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildHouseRuleItem(Assets.imagesNoSmoking, Strings.noSmoking2),
            buildHouseRuleItem(Assets.imagesNoDrinking, Strings.noDrinking2),
            buildHouseRuleItem(Assets.imagesNoPet, Strings.noPet2),
            buildHouseRuleItem(
                Assets.imagesDamageToProretiy, Strings.damageToProperty2),
          ],
        ),
      ],
    );
  }

  Widget buildHouseRuleItem(String iconPath, String label) {
    return Column(
      children: [
        Image.asset(iconPath, height: 35, width: 35),
        SizedBox(height: 2.w),
        Text(label,
            style: FontManager.regular(12, color: AppColors.textAddProreties),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.address,
            style: FontManager.medium(18, color: AppColors.textAddProreties)),
        SizedBox(height: 2.h),
        Container(
          width: 100.w,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.greyText,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
            "400 West 42nd Street, Hell's Kitchen, New York, NY 10036, United States",
            style: FontManager.regular(12, color: AppColors.black)),
      ],
    );
  }

  Widget buildContactView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Text(Strings.ownerDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          buildContactRow(Assets.imagesCallicon, Strings.defultCallNumber),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon, Strings.defultEmail),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          buildContactRow(Assets.imagesCallicon, Strings.defultCallNumber),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesCallicon, Strings.defultCallNumber),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon, Strings.defultEmail),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon, Strings.defultEmail),
          SizedBox(height: 5.h),
          CommonButton(
            title: Strings.done,
            onPressed: () => Get.toNamed(Routes.termsAndCondition),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget buildContactRow(String iconPath, String text) {
    return Row(
      children: [
        Image.asset(iconPath, height: 35, width: 35),
        SizedBox(width: 2.w),
        Text(text, style: FontManager.regular(14, color: AppColors.black)),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';

import '../../../../generated/assets.dart';
import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_dialog.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Row(
                children: [
                  const Icon(Icons.keyboard_arrow_left, size: 30),
                  const SizedBox(width: 8),
                  Text(
                    Strings.description,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              const SizedBox(height: 31),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  Strings.term1,
                  style: FontManager.regular(14, color: AppColors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  Strings.term1desc,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  Strings.term2,
                  style: FontManager.regular(14, color: AppColors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  Strings.term2desc,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  Strings.term3,
                  style: FontManager.regular(14, color: AppColors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  Strings.term3desc,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  Strings.term4,
                  style: FontManager.regular(14, color: AppColors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  Strings.term4desc,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
              ),
              SizedBox(height: 2.h,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(activeColor: AppColors.buttonColor,
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
                      });
                    },
                    side: const BorderSide(color: AppColors.texFiledColor),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        Strings.term1desc,
                        style: FontManager.regular(14, color: AppColors.texFiledColor),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),
              CommonButton(
                backgroundColor: isChecked == false ? AppColors.lightPerpul : AppColors.buttonColor,
                title: Strings.submit,
                onPressed: () {
                  CustomDialog.showCustomDialog(
                    context: context,
                    title: Strings.congratulations,
                    message: Strings.congraDesc,
                    imageAsset: Assets.imagesCongratulation,
                    buttonLabel: Strings.okay,
                    onResendPressed: () {
                      Get.toNamed(Routes.yourPropertiesPage);
                    },
                    onChangeEmailPressed: () {
                    },
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';

import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';

class YourPropertiesPage extends StatefulWidget {
  const YourPropertiesPage({super.key});

  @override
  State<YourPropertiesPage> createState() => _YourPropertiesPageState();
}

class _YourPropertiesPageState extends State<YourPropertiesPage> {
  final List<Property> properties = [
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.hiltonViewVilla,
      location: Strings.newYorkUSA,
      status: Strings.approved,
      statusColor: AppColors.approvedColor,
      tag: Strings.ecoFriendly,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.pending,
      statusColor: AppColors.pendingColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.draft,
      statusColor: AppColors.greyText,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.rejected,
      statusColor: AppColors.rejectedColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.rejected,
      statusColor: AppColors.rejectedColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.draft,
      statusColor: AppColors.greyText,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.pending,
      statusColor: AppColors.pendingColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
  ];

  final AddPropertiesController controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundYourPropertiesPage,
        body: Column(
          children: [
            buildHeader(),
            SizedBox(height: 3.h),
            Expanded(
              child: ListView.builder(
                itemCount: controller.imagePaths.length,
                itemBuilder: (context, index) {
                  return buildPropertyCard(properties[index], index);
                },
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 10.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: AppRadius.radius16,
          bottomRight: AppRadius.radius16,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(width: 5.2.w),
              Text(
                Strings.yourProperties,
                style: FontManager.medium(20, color: AppColors.white),
              ),
              Spacer(),
              GestureDetector(onTap: () {
                Get.toNamed(Routes.addPropertiesScreen);
              },
                child: Icon(
                  Icons.add_circle,
                  size: 26,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 4.6.w),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget buildPropertyCard(Property property, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            Routes.previewPage,
            arguments: {
              'index': 1,
              'property': property,
              'imagePath': controller.imagePaths[index],
            },
          );
        },
        child: Container(
          height: 35.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 21.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                    image: DecorationImage(
                      image: controller.imagePaths[index] != null
                          ? FileImage(File(controller.imagePaths[index]!))
                          : NetworkImage(property.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.tag,
                      style: FontManager.regular(12, color: property.tagColor),
                    ),
                    Text(
                      property.status,
                      style: FontManager.regular(12, color: property.statusColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  property.title,
                  style: FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      property.location,
                      style: FontManager.regular(12, color: AppColors.greyText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Property {
  final String imageUrl;
  final String title;
  final String location;
  final String status;
  final Color statusColor;
  final String tag;
  final Color tagColor;

  Property({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.status,
    required this.statusColor,
    required this.tag,
    required this.tagColor,
  });
}
