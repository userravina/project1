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

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/custom_photo_upload_image.dart';
import '../../controller/add_properties_controller.dart';

class PhotoPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PhotoPage({super.key, required this.onNext, required this.onBack});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

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
          const SizedBox(height: 10),
          PhotoUploadContainer(
            index: 0,
            imagePath: controller.coverImagePaths.isNotEmpty
                ? controller.coverImagePaths[0]
                : null,
            onImageSelected: (path) {
              setState(() {
                if (path != null) {
                  controller.coverImagePaths.value = [path];
                }
              });
            },
            isSingleSelect: true,
          ),
          const SizedBox(height: 30),
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

  // Widget photoUploadRows() {
  //   int imagesPerRow = 2;
  //   int totalImages = controller.imagePaths.length;
  //
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: imagesPerRow,
  //       childAspectRatio: 1.4,
  //       crossAxisSpacing: 10.0,
  //       mainAxisSpacing: 10.0,
  //     ),
  //     itemCount: totalImages,
  //     itemBuilder: (context, index) {
  //       int uploadedImages =  controller.imagePaths.where((paths) => paths.isNotEmpty).length;
  //
  //       return GestureDetector(
  //         onTap: () async {
  //           var result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true,
  //           );
  //
  //           if (result != null && result.paths.isNotEmpty) {
  //             List<String> selectedPaths =
  //                 result.paths.map((path) => path!).toList();
  //             if (selectedPaths.length > 5) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                     content: Text('You can only select up to 5 images.')),
  //               );
  //               return;
  //             }
  //
  //             setState(() {
  //               controller.imagePaths[index] = selectedPaths;
  //             });
  //           }
  //         },
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             PhotoUploadContainer(
  //               index: index,
  //               imagePath: controller.imagePaths[index].isNotEmpty
  //                   ? controller.imagePaths[index].first
  //                   : null,
  //               onImageSelected: (paths) {
  //                 setState(() {
  //                   controller.imagePaths[index] = paths!.split(",");
  //                 });
  //               },
  //               isSingleSelect: false,
  //             ),
  //             if (controller.imagePaths[index].isNotEmpty)
  //               CircularPercentIndicator(
  //                 radius: 23,
  //                 lineWidth: 2.0,
  //                 animation: true,
  //                 circularStrokeCap: CircularStrokeCap.round,
  //                 percent: controller.imagePaths[index].length / 5,
  //                 center: Text(
  //                   "${(controller.imagePaths[index].length / 5 * 100).toStringAsFixed(0)}%",
  //                   style: FontManager.regular(13, color: AppColors.white),
  //                 ),
  //                 progressColor: AppColors.white,
  //                 footer: Text(
  //                   Strings.uploadingImage,
  //                   style: FontManager.regular(12, color: AppColors.white),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget photoUploadRows() {
    int imagesPerRow = 2;
    int totalImages = controller.imagePaths.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: imagesPerRow,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: totalImages,
      itemBuilder: (context, index) {
        return PhotoUploadContainer(
          index: index,
          imagePath: controller.imagePaths[index],
          onImageSelected: (path) {
            setState(() {
              controller.imagePaths[index] = path;
            });
          },
          isSingleSelect: true,
        );
      },
    );
  }
}
 import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
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
  final bool isSingleSelect;

  const PhotoUploadContainer({
    super.key,
    required this.index,
    this.imagePath,
    required this.onImageSelected,
    this.isSingleSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imagePath == null
            ? DottedBorder(
          borderType: BorderType.RRect,color: AppColors.texFiledColor,strokeWidth: 1,
          radius: Radius.circular(10),
          child: Container(
            height: 130,
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppRadius.radius10),
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
                        recognizer: TapGestureRecognizer()..onTap = () async {

                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: isSingleSelect,
                          );
                          if (result != null) {
                            if (isSingleSelect) {
                              String filePath = result.files.single.path!;
                              print("${Strings.fileExpection} $filePath for index $index");
                              onImageSelected(filePath);
                            } else {
                              List<String> paths = result.paths
                                  .where((path) => path != null)
                                  .map((path) => path!)
                                  .toList();
                              print("${Strings.fileExpection} Selected paths for index $index: $paths");
                              onImageSelected(paths.join(","));
                            }
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
          ),
        )
            : Container(
          height: 130,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(AppRadius.radius10),
            image: DecorationImage(
              image: FileImage(File(imagePath!)),
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (isSingleSelect && imagePath != null)
          Padding(
            padding: EdgeInsets.only(top: 2.h, right: 2.w),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    Assets.imagesEditCoverImage,
                    height: 12,
                    width: 12,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
} import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';
import '../../common_widget/common_add_container.dart';
import '../../common_widget/common_add_textfield.dart';

class PriceAndContactDetailsPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PriceAndContactDetailsPage(
      {super.key, required this.onNext, required this.onBack});

  @override
  State<PriceAndContactDetailsPage> createState() =>
      _PriceAndContactDetailsPageState();
}

class _PriceAndContactDetailsPageState
    extends State<PriceAndContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => CustomAddPropertiesPage(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.basePrice,
                        style: FontManager.regular(14, color: AppColors.black),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        hintText: Strings.basePrice,
                        onChanged: (value) {
                          controller.basePrice.value = value;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    Strings.to,
                    style: FontManager.regular(14, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.weekendPrice,
                        style: FontManager.regular(14, color: AppColors.black),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        hintText: Strings.weekendPrice,
                        onChanged: (value) {
                          controller.weekendPrice.value = value;
                        },
                      ),
                    ],
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
            Text(Strings.ownerContactNo, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              keyboardType: TextInputType.number,
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
                controller.ownerContactNumber.value = value!;
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
                controller.ownerEmail.value = value;
              },
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.homeStayDetails,
              style: FontManager.semiBold(18, color: AppColors.buttonColor),
            ),
            SizedBox(height: 1.5.h),
            Text(Strings.homeStayContactNo, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            controller.homeStayContactNumbers.isNotEmpty
                ? CommonAddContainer(
                    items: controller.homeStayContactNumbers,
                    onRemove: (index) {
                      controller.removeHomeStayContactNumber(index);
                    },
                  )
                : SizedBox.shrink(),
            controller.homeStayContactNumbers.isNotEmpty
                ? SizedBox(
                    height: 2.h,
                  )
                : SizedBox.shrink(),
            CommonAddTextfield(
              controller: controller.homeStayContactNumbersController,
              itemCount: controller.homeStayContactNumbers.length,
              hintText: Strings.homeStayContactNo,
              keyboardType: TextInputType.number,
              onAdd: (newAdd) {
                controller.addHomeStayContactNumber(newAdd);
              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.homeStayEmailID,
                style: FontManager.regular(14, color: AppColors.black)),
            SizedBox(height: 0.5.h),
            controller.homeStayContactNumbers.isNotEmpty
                ? CommonAddContainer(
                    items: controller.homeStayEmails,
                    onRemove: (index) {
                      controller.removeHomeStayEmails(index);
                    },
                  )
                : SizedBox.shrink(),
            controller.homeStayContactNumbers.isNotEmpty
                ? SizedBox(height: 2.h)
                : SizedBox.shrink(),
            CommonAddTextfield(
              controller: controller.homeStayEmailsController,
              itemCount: controller.homeStayEmails.length,
              hintText: Strings.enterHomeStayEmailID,
              onAdd: (newAdd) {
                controller.addHomeStayEmails(newAdd);
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/data/repository/homestay_repository.dart';
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_string.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  RxString homestayTitle = ''.obs;
  var selectedType = ''.obs;
  var selectedTypeImage = ''.obs;
  var selectedAccommodation = ''.obs;
  var selectedAccommodationImage = ''.obs;
  final PageController pageController = PageController();
  var homeStayRepository = getIt<HomeStayRepository>();
  var apiHelper = getIt<ApiHelper>();

  List<String> pageTitles = [
    Strings.homestayTitle,
    Strings.homestayType,
    Strings.accommodationDetails,
    Strings.amenities,
    Strings.houseRules,
    Strings.checkInOutDetails,
    Strings.address,
    Strings.photos,
    Strings.homeStayDescription,
    Strings.priceAndContactDetailsPage,
    Strings.preview,
    Strings.termsAndConditions
  ];

  bool canGoToNextPage() {
    return isCurrentPageValid();
  }

  void nextPage() {
    if (currentPage.value < 10) {
      if(currentPage.value == 6){
        Get.toNamed(Routes.location);
        return;
      }
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),

        curve: Curves.easeIn,
      );
    } else {
      homeStayAddData();


      Get.toNamed(Routes.previewPage, arguments: {
        'index': 0,
      },);
    }
  }

  void backPage() {
    if (currentPage.value > 1) {
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  // homestayTitle Page Logic

  TextEditingController homeStayTitleController = TextEditingController();

  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }

  // homestayType Page Logic
  void selectHomeStayType(String index,String image) {
    selectedType.value = index;
    selectedTypeImage.value = image;
    update();
  }

  bool isHomeStayTypeSelected(String index) {
    return selectedType.value == index;
  }

  // Accommodation Page Logic
  void selectAccommodation(String value,String image) {
    selectedAccommodation.value = value;
    selectedAccommodationImage.value = image;
  }

  var maxGuestsCount = 0.obs;
  var singleBedCount = 0.obs;
  var bedroomsCount = 0.obs;
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

    int selectedIndex = customAmenities.length + index;
    if (selectedIndex < selectedAmenities.length) {
      selectedAmenities.removeAt(selectedIndex);
    }
  }

  void toggleAmenity(int index) {

    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
    }
    update();
  }


  // House Rules and New Rules Logic
  final List<String> customRules = [
    Strings.noSmoking,
    Strings.noDrinking,
    Strings.noPet,
    Strings.damageToProperty,
  ];

  RxList<bool> selectedRules = <bool>[].obs;
  TextEditingController rulesName = TextEditingController();
  List<TextEditingController> rulesTextControllers = [];
  var addRules = <String>[].obs;
  List<String> allRules = [];

  void createAllRules() {
    allRules = [...customRules, ...addRules];
  }

  void addRulesMethod(String rulesName) {
    addRules.add(rulesName);
    selectedRules.add(true);
    rulesTextControllers.add(TextEditingController());
    createAllRules();
    update();
  }

  void removeRules(int index) {
    if (index < addRules.length) {
      if (index < rulesTextControllers.length) {
        rulesTextControllers[index].dispose();
        rulesTextControllers.removeAt(index);
      }
      addRules.removeAt(index);
      createAllRules();
    }

    int selectedIndex = customRules.length + index;
    if (selectedIndex < customRules.length) {
      customRules.removeAt(selectedIndex);
    }
  }

  void toggleRules(int index) {

    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedAmenities.addAll(List.generate(customAmenities.length, (_) => false));
    selectedRules.addAll(List.generate(customRules.length, (_) => false));
    createAllAmenities();
  }

  // Check - in/ut details page logic

  var flexibleWithCheckInTime = false.obs;
  var flexibleWithCheckInOut = false.obs;
  Rx<DateTime> checkInTime = DateTime.now().obs;
  Rx<DateTime> checkOutTime = DateTime.now().obs;

  void checkInTimeUpdate(var value){
    flexibleWithCheckInTime.value = value;
    update();
  }

  void checkOutTimeUpdate(var value){
    flexibleWithCheckInOut.value = value;
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
  RxBool isValidation = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityTownController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  void saveAddress(String? value) {
    if (value != null) {
      address.value = value;
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
  var coverImagePaths = <String?>[null].obs;
  var imagePaths = List<String?>.filled(6, null).obs;
  // var imagePaths = List<List<String?>>.filled(6, []).obs;

  // description Page add logic
  var description = ''.obs;

  void setDescription(String value) {
    description.value = value;
    update();
  }

  // Price and Contact details page logic

  var basePrice = ''.obs;
  var weekendPrice = ''.obs;
  var ownerContactNumber = ''.obs;
  var ownerEmail = ''.obs;
  var homeStayContactNumbers = <String>[].obs;
  TextEditingController homeStayContactNumbersController = TextEditingController();

  void addHomeStayContactNumber(String newAdd) {
    homeStayContactNumbers.add(newAdd);
    update();
  }

  void removeHomeStayContactNumber(int index) {
    if (index < homeStayContactNumbers.length) {
      homeStayContactNumbers.removeAt(index);
    }
    update();
  }


  var homeStayEmails = <String>[].obs;
  TextEditingController homeStayEmailsController = TextEditingController();

  void addHomeStayEmails(String newAdd) {
    homeStayEmails.add(newAdd);
    update();
  }

  void removeHomeStayEmails(int index) {
    if (index < homeStayEmails.length) {
      homeStayEmails.removeAt(index);
    }
    update();
  }


  // api add data
   Future<void> homeStayAddData() async {

     dio.FormData formData = dio.FormData.fromMap({
       "title": homestayTitle.value,
       "homestayType": selectedType.value,
       "accommodationDetails": jsonEncode({
         "entirePlace": selectedAccommodation.value == 'entirePlace',
         "privateRoom": selectedAccommodation.value == 'privateRoom',
         "maxGuests": maxGuestsCount.value,
         "bedrooms": bedroomsCount.value,
         "singleBed": singleBedCount.value,
         "doubleBed": doubleBedCount.value,
         "extraFloorMattress": extraFloorCount.value,
         "bathrooms": bathRoomsCount.value,
         "kitchenAvailable": isKitchenAvailable.value,
       }),
     "amenities":jsonEncode(allAmenities.map((amenity) {
       int index = allAmenities.indexOf(amenity);
       return {
         "name": amenity,
         "isChecked": selectedAmenities[index],
         "isNewAdded": selectedAmenities.length > customAmenities.length && index >= customAmenities.length,
       };
     }).toList()),
       "houseRules":jsonEncode(allRules.map((rules) {
         int index = allRules.indexOf(rules);
         return {
           "name": rules,
           "isChecked": selectedRules[index],
           "isNewAdded": selectedRules.length > customRules.length && index >= customRules.length,
         };
       }).toList()),
       "checkInTime": checkInTime.value,
       "checkOutTime": checkOutTime.value,
       "flexibleCheckIn": flexibleWithCheckInTime.value,
       "flexibleCheckOut": flexibleWithCheckInOut.value,
       "longitude": "72.88692069643963",
       "latitude": "21.245049600735083",
       "address":  address.value,
       "street": streetAddress.value,
       "landmark": landmark.value,
       "city": city.value,
       "pinCode": pinCode.value,
       "state": state.value,
       "showSpecificLocation": isSpecificLocation,
       "coverPhoto": await dio.MultipartFile.fromFile(coverImagePaths[0]!, filename: "coverPhoto.jpg"),
       // "homestayPhotos": ,
       "description": description.value,
       "basePrice": 20000,
       "weekendPrice": 100000,
       "ownerContactNo": 3000000,
       "ownerEmailId": 6000000,
       "homestayContactNo": homeStayContactNumbers.map((contact) => {
         "contactNo": contact,
       }).toList(),
       "homestayEmailId": homeStayEmails.map((email) => {
         "EmailId": email,
       }).toList(),
       "status": "Draft",
       "createdBy": "671777327fb924f8aaa26f72",
     });
     // for (int index = 0; index < imagePaths.length; index++) {
     //   if (imagePaths[index] != null) {
     //     formData.files.add(MapEntry(
     //       "homestayPhotos:",
     //       await dio.MultipartFile.fromFile(imagePaths[index]!, filename: "photo_$index.jpg"),
     //     ));
     //   }
     // }
     homeStayRepository.homeStayData(formData: formData).then((value) {
       Get.snackbar('', 'Homestay Data created successfully!');
      },);
   }

  bool isCurrentPageValid() {
    switch (currentPage.value) {
      case 1:
        return homestayTitle.value.isNotEmpty;
      case 2:
        return selectedType.value.isNotEmpty;
      case 3:
        return selectedAccommodation.value.isNotEmpty;
      case 4:
        return selectedAmenities.contains(true);
      case 5:
        return  selectedRules.contains(true);
      case 6:
        return flexibleWithCheckInTime.value || flexibleWithCheckInOut.value == true;
      case 7:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 8:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 9:
        return description.value.isNotEmpty;
      case 10:
        return basePrice.value.isNotEmpty;
      default:
        return false;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../utils/font_manager.dart';

class CommonAddContainer extends StatelessWidget {
  final RxList<String> items;
  final Function(int) onRemove;

  const CommonAddContainer({
    super.key,
    required this.items,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context,index) {
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
                      items[index],
                      style: FontManager.regular(16, color: AppColors.textAddProreties),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        onRemove(index);
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
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../utils/font_manager.dart';

class CommonAddTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onAdd;
  final int itemCount;
  final TextInputType? keyboardType;

  const CommonAddTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onAdd,
    required this.itemCount,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                child: TextFormField(
                  keyboardType: keyboardType,
                  controller: controller,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "$hintText ${itemCount + 1}",
                    hintStyle: FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        final String newItem = controller.text.trim();
                        if (newItem.isNotEmpty) {
                          onAdd(newItem);
                          controller.clear();
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
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/common_widget/common_add_textfield.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../common_widget/common_add_container.dart';
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
              CommonAddContainer(
                items: controller.addAmenities,
                onRemove: (index) {
                  controller.removeAmenity(index);
                },
              ),
              SizedBox(height: 2.h),
              CommonAddTextfield(
                controller: controller.amenitiesName,
                hintText: Strings.amenities,
                onAdd: (newAmenity) {
                  controller.addAmenity(newAmenity);
                },
                itemCount: controller.addAmenities.length,
              ),
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/common_widget/common_add_textfield.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../common_widget/common_add_container.dart';
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
                    child: const Icon(Icons.keyboard_arrow_left, size: 30),
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
              CommonAddContainer(
                items: controller.addRules,
                onRemove: (index) {
                  controller.removeRules(index);
                },
              ),
              SizedBox(height: 2.h),
              CommonAddTextfield(
                controller: controller.rulesName,
                hintText: Strings.rules,
                onAdd: (newRule) {
                  controller.addRulesMethod(newRule);
                },
                itemCount: controller.addRules.length,
              ),
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
                        borderRadius: const BorderRadius.all(AppRadius.radius4),
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

