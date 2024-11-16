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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class LoadingProcessCommon   {


  var isLoading = false;
  static Widget loadingDialog() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.greyText,),
    );
  }

  void showLoading() {
    isLoading = true;
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: loadingDialog(),
      ),
      barrierDismissible: false,
    );
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void hideLoading() {
    isLoading = false;
    Get.back();
  }

} 

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../screen/your_properties_screen/controller/your_properties_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/app_string.dart';
import '../utils/font_manager.dart';

Widget buildPropertyCard(YourPropertiesController controller,int index) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
    child: GestureDetector(
      onTap: () {
        controller.getDetails(index);
      },
      child: Container(
        height: 259,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 157,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(AppRadius.radius10),
                  image: DecorationImage(
                    image:  NetworkImage(controller.propertiesList[index].coverPhoto!.url!),
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
                    controller.propertiesList[index].homestayType!,
                    style: FontManager.regular(12, color: AppColors.buttonColor),
                  ),
                  Text(
                    controller.propertiesList[index].status!,
                    style: FontManager.regular(12, color:  controller.propertiesList[index].status! == "Pending Approval"? AppColors.pendingColor :
                    controller.propertiesList[index].status! == "Approved"? AppColors.approvedColor : AppColors.greyText ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 7.0),
              child: Text(
                controller.propertiesList[index].title!,
                style: FontManager.medium(16, color: AppColors.textAddProreties),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.buttonColor),
                  SizedBox(width: 1.4.w),
                  Text(
                    Strings.newYorkUSA,
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travellery_mobile/common_widgets/common_loading_process.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/data/model/local_homestaydata_model.dart';
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../common_widgets/common_image_picker.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../services/storage_services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../reuseble_flow/data/model/homestay_reused_model.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/homestay_model.dart';
import '../data/repository/homestay_repository.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  RxString homestayTitle = ''.obs;
  var selectedType = ''.obs;
  var selectedTypeImage = ''.obs;
  var selectedAccommodation = ''.obs;
  var selectedAccommodationImage = ''.obs;
  RxBool isLoading = false.obs;
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

  void nextPage() {
    print("nnnnnnnnnooopppppeeeeeeennnnnnnnn");
    LoadingProcessCommon().showLoading();
    if (currentPage.value < 10) {
      if (currentPage.value == 7) {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          isValidation.value = false;
          FocusManager.instance.primaryFocus?.unfocus();

          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          return;
        }
      }
      if (currentPage.value == 6) {
        Get.toNamed(Routes.location);
        return;
      }
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        homeStayAddDataLocally();
      } else {
        return;
      }
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

  Widget loadingDialog() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.greyText,
      ),
    );
  }

  // homestayTitle Page Logic

  TextEditingController homeStayTitleController = TextEditingController();

  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }

  // homestayType Page Logic
  void selectHomeStayType(String index, String image) {
    selectedType.value = index;
    selectedTypeImage.value = image;
    update();
  }

  bool isHomeStayTypeSelected(String index) {
    return selectedType.value == index;
  }

  // Accommodation Page Logic
  void selectAccommodation(String value, String image) {
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
    selectedAmenities
        .addAll(List.generate(customAmenities.length, (_) => false));
    selectedRules.addAll(List.generate(customRules.length, (_) => false));
    createAllAmenities();
  }

  // Check - in/ut details page logic
  var flexibleWithCheckInTime = false.obs;
  var flexibleWithCheckInOut = false.obs;
  Rx<DateTime> checkInTime = DateTime.now().obs;
  Rx<DateTime> checkOutTime = DateTime.now().obs;

  void checkInTimeUpdate(DateTime newTime) {
    checkInTime.value = newTime;
    update();
  }

  void checkOutTimeUpdate(DateTime newTime) {
    checkOutTime.value = newTime;
    update();
  }

  void toggleCheckInFlexibility(bool value) {
    flexibleWithCheckInTime.value = value;
    update();
  }

  void toggleCheckOutFlexibility(bool value) {
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
  var imagePaths = RxList<String?>.filled(6, null);

  // var imagePaths = List<List<String?>>.filled(6, []).obs;

  var imagePickerCommon = ImagePickerCommon();

  Future<void> pickPropertyImage(int index,
      {required bool isSingleSelect}) async {
    final croppedFile = await imagePickerCommon.pickImage(
      source: ImageSource.gallery,
      isSingleSelect: isSingleSelect,
      index: index,
    );
    if (croppedFile != null) {
      if (isSingleSelect) {
        coverImagePaths.value = [croppedFile.path];
      } else {
        imagePaths[index] = croppedFile.path;
      }
    }
  }

  // description Page add logic
  var description = ''.obs;
  TextEditingController descriptionController = TextEditingController();

  void setDescription(String value) {
    description.value = value;
    update();
  }

  // Price and Contact details page logic

  var basePrice = ''.obs;
  var weekendPrice = ''.obs;
  var ownerContactNumber = ''.obs;
  var ownerEmail = ''.obs;
  TextEditingController basePriceController = TextEditingController();
  TextEditingController weekendPriceController = TextEditingController();
  TextEditingController ownerContactNumberController = TextEditingController();
  TextEditingController ownerEmailController = TextEditingController();
  var homeStayContactNumbers = <String>[].obs;
  TextEditingController homeStayContactNumbersController =
      TextEditingController();

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

  RxBool isEditing = false.obs;

  // api add data
  Future<void> homeStayAddData() async {
    LoadingProcessCommon().showLoading();
    String? userId = getIt<StorageServices>().getUserId();
    dio.FormData formData = dio.FormData.fromMap({
      "title": homestayTitle.value,
      "homestayType": selectedType.value,
      "accommodationDetails": jsonEncode({
        "entirePlace": selectedAccommodation.value == Strings.entirePlaceValue,
        "privateRoom": selectedAccommodation.value == Strings.privateRoomValue,
        "maxGuests": maxGuestsCount.value,
        "bedrooms": bedroomsCount.value,
        "singleBed": singleBedCount.value,
        "doubleBed": doubleBedCount.value,
        "extraFloorMattress": extraFloorCount.value,
        "bathrooms": bathRoomsCount.value,
        "kitchenAvailable": isKitchenAvailable.value,
      }),
      "amenities": jsonEncode(allAmenities.map((amenity) {
        int index = allAmenities.indexOf(amenity);
        return {
          "name": amenity,
          "isChecked": selectedAmenities[index],
          "isNewAdded": selectedAmenities.length > customAmenities.length &&
              index >= customAmenities.length,
        };
      }).toList()),
      "houseRules": jsonEncode(allRules.map((rules) {
        int index = allRules.indexOf(rules);
        return {
          "name": rules,
          "isChecked": selectedRules[index],
          "isNewAdded": selectedRules.length > customRules.length &&
              index >= customRules.length,
        };
      }).toList()),
      "checkInTime": DateFormat('hh:mm a').format(checkInTime.value),
      "checkOutTime": DateFormat('hh:mm a').format(checkOutTime.value),
      "flexibleCheckIn": flexibleWithCheckInTime.value,
      "flexibleCheckOut": flexibleWithCheckInOut.value,
      "longitude": "72.88692069643963",
      "latitude": "21.245049600735083",
      "address": address.value,
      "street": streetAddress.value,
      "landmark": landmark.value,
      "city": city.value,
      "pinCode": pinCode.value,
      "state": state.value,
      "showSpecificLocation": isSpecificLocation,
      "coverPhoto": await dio.MultipartFile.fromFile(coverImagePaths[0]!,
          filename: "coverPhoto.jpg"),
      "description": description.value,
      "basePrice": basePrice.value,
      "weekendPrice": weekendPrice.value,
      "ownerContactNo": ownerContactNumber.value,
      "ownerEmailId": ownerEmail.value,
      "homestayContactNo": jsonEncode(homeStayContactNumbers
          .map((contact) => {
                "contactNo": contact,
              })
          .toList()),
      "homestayEmailId": jsonEncode(homeStayEmails
          .map((email) => {
                "EmailId": email,
              })
          .toList()),
      "status": isEditing.value == true ? "Draft" : "Pending Approval",
      "createdBy": userId,
    });

    for (int index = 0; index < imagePaths.length; index++) {
      if (imagePaths[index] != null) {
        formData.files.add(MapEntry(
          "homestayPhotos",
          await dio.MultipartFile.fromFile(imagePaths[index]!,
              filename: "photo.jpg"),
        ));
      }
    }

    homeStayRepository.homeStayData(formData: formData).then(
      (value) {
        final singleFetchUserModel = HomestayData.fromJson(value);
        getIt<StorageServices>().setHomeStayId(singleFetchUserModel.homestay!.sId!);
        String? homeStayId = getIt<StorageServices>().getHomeStayId();
        if (homeStayId != null) {
          print("homeStayId user ID: $homeStayId");
        }
        getSinglePropertiesData().then(
          (value) {
            LoadingProcessCommon().hideLoading();
            Get.snackbar('', 'Homestay Data created successfully!');
            Get.toNamed(
              Routes.previewPage,
              arguments: {
                'index': 0,
              },
            );
          },
        );
      },
    );
  }

  Future<void> homeStayAddDataLocally() async {
    LoadingProcessCommon().showLoading();
    List<HomestayPhotos> homestayPhotosList = imagePaths
        .where((path) => path != null)
        .map((path) => HomestayPhotos(url: path))
        .toList();

    LocalHomestaydataModel homestayData = LocalHomestaydataModel(
      title: homestayTitle.value,
      homestayType: selectedType.value,
      accommodationDetails: AccommodationDetails(
        entirePlace: selectedAccommodation.value == Strings.entirePlaceValue,
        privateRoom: selectedAccommodation.value == Strings.privateRoomValue,
        maxGuests: maxGuestsCount.value,
        bedrooms: bedroomsCount.value,
        singleBed: singleBedCount.value,
        doubleBed: doubleBedCount.value,
        extraFloorMattress: extraFloorCount.value,
        bathrooms: bathRoomsCount.value,
        kitchenAvailable: isKitchenAvailable.value,
      ),
      amenities: allAmenities.map((amenity) {
        int index = allAmenities.indexOf(amenity);
        return Amenities(
          name: amenity,
          isChecked: selectedAmenities[index],
          isNewAdded: selectedAmenities.length > customAmenities.length && index >= customAmenities.length,
        );
      }).toList(),
      houseRules: allRules.map((rules) {
        int index = allRules.indexOf(rules);
        return HouseRules(
          name: rules,
          isChecked: selectedRules[index],
          isNewAdded: selectedRules.length > customRules.length && index >= customRules.length,
        );
      }).toList(),
      checkInTime: DateFormat('hh:mm a').format(checkInTime.value),
      checkOutTime: DateFormat('hh:mm a').format(checkOutTime.value),
      flexibleCheckIn: flexibleWithCheckInTime.value,
      flexibleCheckOut: flexibleWithCheckInOut.value,
      longitude: "72.88692069643963",
      latitude: "21.245049600735083",
      address: address.value,
      street: streetAddress.value,
      landmark: landmark.value,
      city: city.value,
      pinCode: pinCode.value,
      state: state.value,
      showSpecificLocation: isSpecificLocation.value,
      coverPhoto: coverImagePaths.isNotEmpty ? coverImagePaths[0] : null,
      homestayPhotos: homestayPhotosList.isNotEmpty ? homestayPhotosList : null,
      description: description.value,
      basePrice: basePrice.value,
      weekendPrice: weekendPrice.value,
      ownerContactNo: ownerContactNumber.value,
      ownerEmailId: ownerEmail.value,
      homestayContactNo: homeStayContactNumbers.map((contact) => HomestayContactNo(contactNo: contact)).toList(),
      homestayEmailId: homeStayEmails.map((email) => HomestayEmailId(emailId: email)).toList(),
      status: isEditing.value ? "Draft" : "Pending Approval",
    );
    LoadingProcessCommon().hideLoading();
    Get.snackbar('Success', 'Homestay data saved locally');
    Get.toNamed(
      Routes.previewPage,
      arguments: {
        'index': 0,
        'homestayData': homestayData,
      },
    );
  }

  late HomeStaySingleFetchResponse property;

  Future<void> getSinglePropertiesData() async {
    property = await homeStayRepository.getSingleFetchPreviewProperties();
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
        return selectedRules.contains(true);
      case 6:
        return flexibleWithCheckInTime.value ||
            flexibleWithCheckInOut.value == true;
      case 7:
        return address.value.isNotEmpty &&
            streetAddress.value.isNotEmpty &&
            landmark.value.isNotEmpty &&
            city.value.isNotEmpty &&
            pinCode.value.isNotEmpty &&
            state.value.isNotEmpty;
      case 8:
        return coverImagePaths[0] != null;
      case 9:
        return description.value.isNotEmpty;
      case 10:
        return basePrice.value.isNotEmpty &&
            weekendPrice.value.isNotEmpty &&
            ownerContactNumber.value.isNotEmpty &&
            ownerEmail.value.isNotEmpty &&
            homeStayContactNumbers.isNotEmpty &&
            homeStayEmails.isNotEmpty;
      default:
        return false;
    }
  }
}

import '../../../../reuseble_flow/data/model/homestay_reused_model.dart';

class HomestayData {
  String? message;
  Homestay? homestay;

  HomestayData({this.message, this.homestay});

  HomestayData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    homestay = json['homestay'] != null
        ? Homestay.fromJson(json['homestay'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (homestay != null) {
      data['homestay'] = homestay!.toJson();
    }
    return data;
  }
}

class Homestay {
  String? title;
  String? homestayType;
  AccommodationDetails? accommodationDetails;
  List<Amenities>? amenities;
  List<HouseRules>? houseRules;
  String? checkInTime;
  String? checkOutTime;
  bool? flexibleCheckIn;
  bool? flexibleCheckOut;
  double? longitude;
  double? latitude;
  String? address;
  String? street;
  String? landmark;
  String? city;
  String? pinCode;
  String? state;
  bool? showSpecificLocation;
  CoverPhoto? coverPhoto;
  List<HomestayPhotos>? homestayPhotos;
  String? description;
  int? basePrice;
  int? weekendPrice;
  String? ownerContactNo;
  String? ownerEmailId;
  List<HomestayContactNo>? homestayContactNo;
  List<HomestayEmailId>? homestayEmailId;
  String? status;
  String? createdBy;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Homestay(
      {this.title,
        this.homestayType,
        this.accommodationDetails,
        this.amenities,
        this.houseRules,
        this.checkInTime,
        this.checkOutTime,
        this.flexibleCheckIn,
        this.flexibleCheckOut,
        this.longitude,
        this.latitude,
        this.address,
        this.street,
        this.landmark,
        this.city,
        this.pinCode,
        this.state,
        this.showSpecificLocation,
        this.coverPhoto,
        this.homestayPhotos,
        this.description,
        this.basePrice,
        this.weekendPrice,
        this.ownerContactNo,
        this.ownerEmailId,
        this.homestayContactNo,
        this.homestayEmailId,
        this.status,
        this.createdBy,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Homestay.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    homestayType = json['homestayType'];
    accommodationDetails = json['accommodationDetails'] != null
        ? AccommodationDetails.fromJson(json['accommodationDetails'])
        : null;
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }
    if (json['houseRules'] != null) {
      houseRules = <HouseRules>[];
      json['houseRules'].forEach((v) {
        houseRules!.add(HouseRules.fromJson(v));
      });
    }
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    flexibleCheckIn = json['flexibleCheckIn'];
    flexibleCheckOut = json['flexibleCheckOut'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    street = json['street'];
    landmark = json['landmark'];
    city = json['city'];
    pinCode = json['pinCode'];
    state = json['state'];
    showSpecificLocation = json['showSpecificLocation'];
    coverPhoto = json['coverPhoto'] != null
        ? CoverPhoto.fromJson(json['coverPhoto'])
        : null;
    if (json['homestayPhotos'] != null) {
      homestayPhotos = <HomestayPhotos>[];
      json['homestayPhotos'].forEach((v) {
        homestayPhotos!.add(HomestayPhotos.fromJson(v));
      });
    }
    description = json['description'];
    basePrice = json['basePrice'];
    weekendPrice = json['weekendPrice'];
    ownerContactNo = json['ownerContactNo'];
    ownerEmailId = json['ownerEmailId'];
    if (json['homestayContactNo'] != null) {
      homestayContactNo = <HomestayContactNo>[];
      json['homestayContactNo'].forEach((v) {
        homestayContactNo!.add(HomestayContactNo.fromJson(v));
      });
    }
    if (json['homestayEmailId'] != null) {
      homestayEmailId = <HomestayEmailId>[];
      json['homestayEmailId'].forEach((v) {
        homestayEmailId!.add(HomestayEmailId.fromJson(v));
      });
    }
    status = json['status'];
    createdBy = json['createdBy'];
    sId = json['_id'].toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['homestayType'] = homestayType;
    if (accommodationDetails != null) {
      data['accommodationDetails'] = accommodationDetails!.toJson();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    if (houseRules != null) {
      data['houseRules'] = houseRules!.map((v) => v.toJson()).toList();
    }
    data['checkInTime'] = checkInTime;
    data['checkOutTime'] = checkOutTime;
    data['flexibleCheckIn'] = flexibleCheckIn;
    data['flexibleCheckOut'] = flexibleCheckOut;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['address'] = address;
    data['street'] = street;
    data['landmark'] = landmark;
    data['city'] = city;
    data['pinCode'] = pinCode;
    data['state'] = state;
    data['showSpecificLocation'] = showSpecificLocation;
    if (coverPhoto != null) {
      data['coverPhoto'] = coverPhoto!.toJson();
    }
    if (homestayPhotos != null) {
      data['homestayPhotos'] =
          homestayPhotos!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['basePrice'] = basePrice;
    data['weekendPrice'] = weekendPrice;
    data['ownerContactNo'] = ownerContactNo;
    data['ownerEmailId'] = ownerEmailId;
    if (homestayContactNo != null) {
      data['homestayContactNo'] =
          homestayContactNo!.map((v) => v.toJson()).toList();
    }
    if (homestayEmailId != null) {
      data['homestayEmailId'] =
          homestayEmailId!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
} 
import '../../../../reuseble_flow/data/model/homestay_reused_model.dart';

class LocalHomestaydataModel {
  String title;
  String homestayType;
  AccommodationDetails accommodationDetails;
  List<Amenities> amenities;
  List<HouseRules> houseRules;
  String checkInTime;
  String checkOutTime;
  bool flexibleCheckIn;
  bool flexibleCheckOut;
  String longitude;
  String latitude;
  String address;
  String street;
  String landmark;
  String city;
  String pinCode;
  String state;
  bool showSpecificLocation;
  String? coverPhoto;
  List<HomestayPhotos>? homestayPhotos;
  String description;
  String basePrice;
  String weekendPrice;
  String ownerContactNo;
  String ownerEmailId;
  List<HomestayContactNo> homestayContactNo;
  List<HomestayEmailId> homestayEmailId;
  String status;

  LocalHomestaydataModel({
    required this.title,
    required this.homestayType,
    required this.accommodationDetails,
    required this.amenities,
    required this.houseRules,
    required this.checkInTime,
    required this.checkOutTime,
    required this.flexibleCheckIn,
    required this.flexibleCheckOut,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.street,
    required this.landmark,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.showSpecificLocation,
    this.coverPhoto,
    this.homestayPhotos,
    required this.description,
    required this.basePrice,
    required this.weekendPrice,
    required this.ownerContactNo,
    required this.ownerEmailId,
    required this.homestayContactNo,
    required this.homestayEmailId,
    required this.status,
  });
  factory LocalHomestaydataModel.fromJson(Map<String, dynamic> json) {
    return LocalHomestaydataModel(
      title: json['title'],
      homestayType: json['homestayType'],
      accommodationDetails: AccommodationDetails.fromJson(json['accommodationDetails']),
      amenities: List<Amenities>.from(json['amenities'].map((x) => Amenities.fromJson(x))),
      houseRules: List<HouseRules>.from(json['houseRules'].map((x) => HouseRules.fromJson(x))),
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'],
      flexibleCheckIn: json['flexibleCheckIn'],
      flexibleCheckOut: json['flexibleCheckOut'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      address: json['address'],
      street: json['street'],
      landmark: json['landmark'],
      city: json['city'],
      pinCode: json['pinCode'],
      state: json['state'],
      showSpecificLocation: json['showSpecificLocation'],
      coverPhoto: json['coverPhoto'],
      homestayPhotos: json['homestayPhotos'] != null
          ? List<HomestayPhotos>.from(json['homestayPhotos'].map((x) => HomestayPhotos.fromJson(x)))
          : null,
      description: json['description'],
      basePrice: json['basePrice'],
      weekendPrice: json['weekendPrice'],
      ownerContactNo: json['ownerContactNo'],
      ownerEmailId: json['ownerEmailId'],
      homestayContactNo: List<HomestayContactNo>.from(json['homestayContactNo'].map((x) => HomestayContactNo.fromJson(x))),
      homestayEmailId: List<HomestayEmailId>.from(json['homestayEmailId'].map((x) => HomestayEmailId.fromJson(x))),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'homestayType': homestayType,
      'accommodationDetails': accommodationDetails.toJson(),
      'amenities': List<dynamic>.from(amenities.map((x) => x.toJson())),
      'houseRules': List<dynamic>.from(houseRules.map((x) => x.toJson())),
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'flexibleCheckIn': flexibleCheckIn,
      'flexibleCheckOut': flexibleCheckOut,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'street': street,
      'landmark': landmark,
      'city': city,
      'pinCode': pinCode,
      'state': state,
      'showSpecificLocation': showSpecificLocation,
      'coverPhoto': coverPhoto,
      'homestayPhotos': homestayPhotos != null
          ? List<dynamic>.from(homestayPhotos!.map((x) => x.toJson()))
          : null,
      'description': description,
      'basePrice': basePrice,
      'weekendPrice': weekendPrice,
      'ownerContactNo': ownerContactNo,
      'ownerEmailId': ownerEmailId,
      'homestayContactNo': List<dynamic>.from(homestayContactNo.map((x) => x.toJson())),
      'homestayEmailId': List<dynamic>.from(homestayEmailId.map((x) => x.toJson())),
      'status': status,
    };
  }
} 
import 'package:dio/dio.dart' as dio;
import '../../../../../api_helper/api_helper.dart';
import '../../../../../api_helper/api_uri.dart';
import '../../../../../api_helper/getit_service.dart';
import '../../../../../services/storage_services.dart';
import '../../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';

class HomeStayRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<Map<String, dynamic>> homeStayData(
      {required dio.FormData formData}) async {
    dio.Response? response = await apiProvider.postFormData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}",
      data: formData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchPreviewProperties() async {
    String? homeStayId = getIt<StorageServices>().getHomeStayId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/$homeStayId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/address_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/amenities_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/check_in_out_details_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/homestay_title1.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/homestay_type.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/homestaydescription_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/house_rules_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/photo_page.dart';
import 'package:travellery_mobile/screen/add_properties_screen/add_properties_steps/view/widget_view/price_and_contact_details_page.dart';
import 'package:travellery_mobile/utils/app_radius.dart';
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
  final int index;

  const AddPropertiesScreen({super.key, required this.index});

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
}

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => PopScope(
        canPop: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Column(
                children: [
                  SizedBox(height: 7.2.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: controller.backPage,
                        child: const Icon(Icons.keyboard_arrow_left, size: 30),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => Text(
                          widget.index == 1
                              ? "Edit ${controller.pageTitles[controller.currentPage.value - 1]}"
                              : controller.pageTitles[controller.currentPage.value - 1],
                          style: FontManager.medium(
                            20,
                            color: AppColors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Obx(() =>
                  buildTitleStep(controller.currentPage.value.toString())),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: PageView(
                        // physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        onPageChanged: (index) {
                          controller.currentPage.value = index + 1;
                        },
                        children: [
                          HomeStayTitleScreen(controller: controller),
                          HomeStayTypeScreen(controller: controller),
                          AccommodationDetailsPage(controller: controller),
                          AmenitiesPage(controller: controller),
                          HouseRulesPage(controller: controller),
                          CheckInOutDetailsPage(controller: controller),
                          AddressPage(controller: controller),
                          PhotoPage(controller: controller),
                          HomeStayDescriptionPage(controller: controller),
                          PriceAndContactDetailsPage(controller: controller),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: LinearProgressIndicator(
                          value: controller.currentPage.value / 10,
                          backgroundColor: AppColors.greyText,
                          color: AppColors.buttonColor,
                          minHeight: 3,
                          borderRadius:
                              const BorderRadius.all(AppRadius.radius4),
                        ),
                      )),
                  SizedBox(height: 2.h),
                  Obx(() => CommonButton(
                        title: Strings.nextStep,
                        onPressed: controller.isCurrentPageValid()
                            ? controller.nextPage
                            : null,
                        backgroundColor: controller.isCurrentPageValid()
                            ? AppColors.buttonColor
                            : AppColors.lightPerpul,
                      )),
                  Obx(
                    () => (controller.currentPage.value == 3 ||
                            controller.currentPage.value == 4)
                        ? SizedBox(height: 1.h)
                        : const SizedBox(
                            height: 0,
                          ),
                  ),
                  Obx(
                    () => (controller.currentPage.value == 3 ||
                            controller.currentPage.value == 4)
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
                              widget.index == 1
                                  ? Strings.updateAndExit
                                  : Strings.saveAndExit,
                              style: FontManager.medium(18,
                                  color: AppColors.buttonColor),
                            ))
                        : SizedBox(height: 5.h),
                  ),
                  Obx(
                    () => (controller.currentPage.value == 3 ||
                            controller.currentPage.value == 4)
                        ? SizedBox(height: 1.5.h)
                        : const SizedBox(
                            height: 0,
                          ),
                  ),
                ],
              ),
            ),
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
 class APIUrls{

  String baseUrl = "https://travellery-backend.onrender.com";
  String signupUrl = "/user/signup";
  String loginUrl = "/user/login";
  String googleRegisterUrl = "/user/google-registration/";
  String forgePasswordUrl = "/user/forgot-password";
  String userGetUrl = "/user/";
  String verifyUrl = "/user/verfify-otp";
  String resetPasswordUrl = "/user/reset-password";
  String homeStayUrl = "/homestay/create";
  String homeStaySingleFetchUrl = "/homestay";
  String propertiesDelete = "/homestay/DeleteHomestay";

} 
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';

class CustomTimePickerSection extends StatelessWidget {
  final String label;
  final Rx<DateTime> selectedTime;
  final Function(DateTime) onTimeChange;
  final RxBool flexibleTimeController;
  final String flexibleText;
  final ValueChanged<bool?> onFlexibleChange;

  const CustomTimePickerSection({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeChange,
    required this.flexibleTimeController,
    required this.flexibleText,
    required this.onFlexibleChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: FontManager.medium(color: AppColors.black, 16),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        TimePicker(
          selectedTime: selectedTime,
          onTimeChange: onTimeChange,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Checkbox(
                  activeColor: AppColors.buttonColor,
                  value: flexibleTimeController.value,
                  onChanged: onFlexibleChange,
                  side: const BorderSide(color: AppColors.texFiledColor),
                )),
            Text(
              flexibleText,
              style: FontManager.regular(color: AppColors.black, 14),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

class TimePicker extends StatelessWidget {
  final Rx<DateTime> selectedTime;
  final Function(DateTime) onTimeChange;

  const TimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 15.w, right: 15.w),
              child: const Divider(color: Colors.grey),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 15.w, right: 15.w),
              child: const Divider(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createTimePicker(
                  range: List.generate(12, (index) => index + 1),
                  selectedValue: selectedTime.value.hour % 12 == 0
                      ? 12
                      : selectedTime.value.hour % 12,
                  onValueSelected: (value) => onTimeSelect(
                    hour: value,
                    selectedTime: selectedTime,
                    onTimeChange: onTimeChange,
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: List.generate(60, (index) => index),
                    selectedValue: selectedTime.value.minute,
                    onValueSelected: (value) => onTimeSelect(
                      minute: value,
                      selectedTime: selectedTime,
                      onTimeChange: onTimeChange,
                    ),
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: List.generate(60, (index) => index),
                    selectedValue: selectedTime.value.second,
                    onValueSelected: (value) => onTimeSelect(
                      second: value,
                      selectedTime: selectedTime,
                      onTimeChange: onTimeChange,
                    ),
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: ["AM", "PM"],
                    selectedValue: selectedTime.value.hour < 12 ? "AM" : "PM",
                    onValueSelected: (value) {
                      final isPM = value == "PM";
                      onTimeSelect(
                        hour: isPM
                            ? selectedTime.value.hour + 12
                            : selectedTime.value.hour - 12,
                        selectedTime: selectedTime,
                        onTimeChange: onTimeChange,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void onTimeSelect({
    int? hour,
    int? minute,
    int? second,
    required Rx<DateTime> selectedTime,
    required Function(DateTime) onTimeChange,
  }) {
    final updatedTime = DateTime(
      selectedTime.value.year,
      selectedTime.value.month,
      selectedTime.value.day,
      hour ?? selectedTime.value.hour,
      minute ?? selectedTime.value.minute,
      second ?? selectedTime.value.second,
    );
    onTimeChange(updatedTime);
    selectedTime.value = updatedTime;
  }
}

Widget createTimePicker({
  required List<dynamic> range,
  required dynamic selectedValue,
  required ValueChanged<dynamic> onValueSelected,
}) {
  return SizedBox(
    width: 16.w,
    height: 18.h,
    child: ListWheelScrollView.useDelegate(
      itemExtent: 50,
      diameterRatio: 1.2,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) => onValueSelected(range[index]),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final value = range[index];
          final isSelected = value == selectedValue;
          return Center(
            child: Text(
              value.toString().padLeft(2, '0'),
              style: isSelected
                  ? FontManager.semiBold(20, color: AppColors.buttonColor)
                  : FontManager.medium(20, color: AppColors.black),
            ),
          );
        },
        childCount: range.length,
      ),
    ),
  );
}

Widget dotProvide() {
  return Text(
    ':',
    style: FontManager.semiBold(20, color: AppColors.texFiledColor),
  );
}
 import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';

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
                borderType: BorderType.RRect,
                color: AppColors.texFiledColor,
                strokeWidth: 1,
                radius: const Radius.circular(10),
                child: Container(
                  height: 130,
                  width: 150.w,
                  decoration: const BoxDecoration(
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
                              style: FontManager.regular(10,
                                  color: AppColors.greyText),
                            ),
                            TextSpan(
                              mouseCursor: SystemMouseCursors.click,
                              style: FontManager.regular(10,
                                  color: AppColors.buttonColor),
                              text: Strings.chooseFile,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await Get.put(AddPropertiesController())
                                      .pickPropertyImage(index,
                                          isSingleSelect: isSingleSelect);
                                },
                            ),
                            TextSpan(
                              style: FontManager.regular(10,
                                  color: AppColors.greyText),
                              text: Strings.to,
                            ),
                            TextSpan(
                              style: FontManager.regular(10,
                                  color: AppColors.greyText),
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
                  borderRadius: const BorderRadius.all(AppRadius.radius10),
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
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';

class CommonAddTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onAdd;
  final int itemCount;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CommonAddTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onAdd,
    required this.itemCount,
    this.keyboardType,
    this.validator,
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
                  validator: validator,
                  keyboardType: keyboardType,
                  controller: controller,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "$hintText ${itemCount + 1}",
                    hintStyle:
                        FontManager.regular(16, color: AppColors.greyText),
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
import '../../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';

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
                      items[index],
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    const Spacer(),
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

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';

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
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: GestureDetector(
        onTap: onSelect,
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
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const Spacer(),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected
                    ? AppColors.buttonColor
                    : AppColors.borderContainerGriedView,
              ),
              SizedBox(width: 3.w),
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
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';
import '../../common_widget/common_add_container.dart';
import '../../common_widget/common_add_textfield.dart';

class NewAmenitiesPages extends StatefulWidget {
  const NewAmenitiesPages({super.key});

  @override
  State<NewAmenitiesPages> createState() => _NewAmenitiesPagesState();
}

class _NewAmenitiesPagesState extends State<NewAmenitiesPages> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());

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
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';
import '../../common_widget/common_add_textfield.dart';
import '../../common_widget/common_add_container.dart';

class NewRulesPages extends StatefulWidget {
  const NewRulesPages({super.key});

  @override
  State<NewRulesPages> createState() => _NewRulesPagesState();
}

class _NewRulesPagesState extends State<NewRulesPages> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());

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
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/accommodation_type_of_place.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../common_widgets/accommondation_details.dart';
import '../../controller/add_properties_controller.dart';

class AccommodationDetailsPage extends StatelessWidget {
  final AddPropertiesController controller;

  const AccommodationDetailsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBody(controller),
          SizedBox(height: 1.h),
        ],
      ),
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
          value: Strings.entirePlaceValue,
          controller: controller,
        ),
        const SizedBox(height: 20),
        buildAccommodationOption(
          title: Strings.privateRoom,
          subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
          imageAsset: Assets.imagesPrivateRoom,
          value: Strings.privateRoomValue,
          controller: controller,
        ),
        SizedBox(height: 4.h),
        buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
            controller.maxGuestsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed,
            controller.singleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(
            Assets.imagesBedRooms, Strings.bedRooms, controller.bedroomsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed,
            controller.doubleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesExtraFloor,
            Strings.extraFloorMattress, controller.extraFloorCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0.w),
              Image.asset(
                Assets.imagesKitchen,
                height: 3.h,
                width: 3.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 3.w),
              Text(
                Strings.kitchenAvailable,
                style: FontManager.regular(15, color: AppColors.black),
                textAlign: TextAlign.start,
                textScaler: const TextScaler.linear(1),
              ),
              const Spacer(),
              Obx(() => Text(
                    Strings.yes,
                    style: FontManager.regular(14.sp,
                        color: controller.isKitchenAvailable.value
                            ? AppColors.black
                            : AppColors.greyText),
                  )),
              Obx(() {
                return Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    activeTrackColor: AppColors.buttonColor,
                    activeColor: AppColors.white,
                    inactiveThumbColor: AppColors.buttonColor,
                    value: controller.isKitchenAvailable.value,
                    onChanged: (value) {
                      controller.isKitchenAvailable.value = value;
                    },
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
        const SizedBox(height: 16),
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
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textformfield.dart';
import '../../controller/add_properties_controller.dart';

class AddressPage extends StatelessWidget {
  final AddPropertiesController controller;

  const AddressPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.5.h),
          addressPageTextFieldsCommon(
            controller: controller.addressController,
            label: Strings.address,
            hint: Strings.enterYourAddress,
            onChanged: (p0) {
              controller.saveAddress(p0);
            },
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.streetAddressController,
            label: Strings.streetAddress,
            hint: Strings.enterYourStreetAddress,
            onChanged: controller.saveStreetAddress,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.landmarkController,
            label: Strings.landmark,
            hint: Strings.landmark,
            onChanged: controller.saveLandmark,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.cityTownController,
            label: Strings.cityTown,
            hint: Strings.cityTown,
            onChanged: controller.saveCity,
          ),
          SizedBox(height: 2.h),
          Obx(
            () => addressPageTextFieldsCommon(
                controller: controller.pinCodeController,
                keybordeType: TextInputType.number,
                label: Strings.pinCode,
                hint: Strings.pinCode,
                onChanged: (value) {
                  controller.savePinCode(value);
                  if (controller.formKey.currentState!.validate()) {
                    controller.isValidation.value = true;
                  } else {
                    controller.isValidation.value = false;
                  }
                },
                isValidating: controller.isValidation.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.pinCodeEnterValidation;
                  } else if (value.length < 6) {
                    return Strings.pinMaximumDigit;
                  } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                    return Strings.pinOnlyDigit;
                  }
                  return null;
                }),
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.stateController,
            label: Strings.state,
            hint: Strings.state,
            onChanged: controller.saveState,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.showYourSpecificLocation,
                  style: FontManager.regular(16,
                      color: AppColors.textAddProreties)),
              const Spacer(),
              Obx(
                () => Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    activeTrackColor: AppColors.buttonColor,
                    activeColor: AppColors.white,
                    value: controller.isSpecificLocation.value,
                    onChanged: (value) {
                      controller.isSpecificLocation.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Text(
              Strings.addressDiscription,
              style: FontManager.regular(12, color: AppColors.greyText),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
        ],
      ),
    );
  }

  Widget addressPageTextFieldsCommon({
    required String label,
    required String hint,
    required Function(String?) onChanged,
    TextInputType? keybordeType,
    final TextEditingController? controller,
    final String? Function(String?)? validator,
    final bool isValidating = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: label,
                  style: FontManager.regular(14, color: AppColors.black)),
              TextSpan(
                  style: FontManager.regular(14, color: AppColors.redAccent),
                  text: Strings.addressIcon),
            ],
          ),
        ),
        SizedBox(height: 0.5.h),
        CustomTextField(
          isValidating: isValidating,
          controller: controller,
          keyboardType: keybordeType,
          hintText: hint,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';
import '../common_widget/amenities_and_houserules_custom.dart';

class AmenitiesPage extends StatefulWidget {
  final AddPropertiesController controller;

  const AmenitiesPage({super.key, required this.controller});

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
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
                      title: controller.customAmenities[0],
                      isSelected: controller.selectedAmenities[0],
                      onSelect: () => controller.toggleAmenity(0),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesAirCondioner,
                      title: controller.customAmenities[1],
                      isSelected: controller.selectedAmenities[1],
                      onSelect: () => controller.toggleAmenity(1),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesFirAlarm,
                      title: controller.customAmenities[2],
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
            Obx(
              () => AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesHometherater,
                title: controller.customAmenities[3],
                isSelected: controller.selectedAmenities[3],
                onSelect: () => controller.toggleAmenity(3),
              ),
            ),
            SizedBox(height: 1.2.h),
            Obx(
              () => AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesMastrSuite,
                title: controller.customAmenities[4],
                isSelected: controller.selectedAmenities[4],
                onSelect: () => controller.toggleAmenity(4),
              ),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.addAmenities.length,
                itemBuilder: (context, index) {
                  final int amenityIndex;
                  amenityIndex = index + controller.customAmenities.length;
                  return Column(
                    children: [
                      const SizedBox(height: 2),
                      Obx(
                        () => AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesSingleBed,
                          title: controller.addAmenities[index],
                          isSelected:
                              controller.selectedAmenities[amenityIndex],
                          onSelect: () =>
                              controller.toggleAmenity(amenityIndex),
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
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_string.dart';
import '../../controller/add_properties_controller.dart';
import '../common_widget/custom_time_picker.dart';

class CheckInOutDetailsPage extends StatelessWidget {
  final AddPropertiesController controller;
  const CheckInOutDetailsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 1.5.h),
          CustomTimePickerSection(
            label: Strings.checkInTime,
            selectedTime: controller.checkInTime,
            onTimeChange: (time) {
              controller.checkInTimeUpdate(time);
            },
            flexibleTimeController: controller.flexibleWithCheckInTime,
            flexibleText: Strings.flexibleWithCheckInTime,
            onFlexibleChange: (value) {
              controller.toggleCheckInFlexibility(value ?? false);
            },
          ),
          SizedBox(height: 2.h),
          CustomTimePickerSection(
            label: Strings.checkOutTime,
            selectedTime: controller.checkOutTime,
            onTimeChange: (time) {
              controller.checkOutTimeUpdate(time);
            },
            flexibleTimeController: controller.flexibleWithCheckInOut,
            flexibleText: Strings.flexibleWithCheckInTime,
            onFlexibleChange: (value) {
              controller.toggleCheckOutFlexibility(value ?? false);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textformfield.dart';
import '../../controller/add_properties_controller.dart';

class HomeStayTitleScreen extends StatelessWidget {
  final AddPropertiesController controller;

  const HomeStayTitleScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          Text(Strings.titleLabel, style: FontManager.regular(14)),
          SizedBox(height: 0.5.h),
          CustomTextField(
            controller: controller.homeStayTitleController,
            maxLength: (100),
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
          SizedBox(
            height: 40.h,
          ),
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

class HomeStayTypeScreen extends StatelessWidget {
  final AddPropertiesController controller;
  const HomeStayTypeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.5.h),
          SizedBox(
            height: 60.h,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.sp,
              mainAxisSpacing: 19.sp,
              childAspectRatio: (MediaQuery.of(context).size.width / 1.6) / 160,
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
        ],
      ),
    );
  }

  Widget buildHomestayTypeCard(
      String type, String image, AddPropertiesController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectHomeStayType(type, image);
      },
      child: Obx(
        () {
          bool isSelected = controller.isHomeStayTypeSelected(type);
          return Container(
            height: 120.sp,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.selectContainerColor : AppColors.white,
              border: Border.all(
                color: isSelected
                    ? AppColors.buttonColor
                    : AppColors.borderContainerGriedView,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(AppRadius.radius10),
            ),
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(image,
                    height: 35.1, width: 40.w, fit: BoxFit.contain),
                const Spacer(),
                Center(
                  child: Text(
                    type,
                    style: FontManager.regular(16.sp, color: AppColors.black),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textformfield.dart';
import '../../controller/add_properties_controller.dart';

class HomeStayDescriptionPage extends StatelessWidget {
  final AddPropertiesController controller;

  const HomeStayDescriptionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            controller: controller.descriptionController,
            maxLines: 7,
            maxLength: 500,
            hintText: Strings.enterDescription,
            onChanged: (value) {
              controller.setDescription(value);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';
import '../common_widget/amenities_and_houserules_custom.dart';

class HouseRulesPage extends StatefulWidget {
  final AddPropertiesController controller;
  const HouseRulesPage({super.key, required this.controller});

  @override
  State<HouseRulesPage> createState() => _HouseRulesPageState();
}

class _HouseRulesPageState extends State<HouseRulesPage> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Obx(
            () {
              return Column(
                children: [
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesNoSmoking,
                    title: controller.customRules[0],
                    isSelected: controller.selectedRules[0],
                    onSelect: () => controller.toggleRules(0),
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesNoDrinking,
                    title: controller.customRules[1],
                    isSelected: controller.selectedRules[1],
                    onSelect: () => controller.toggleRules(1),
                  ),
                  SizedBox(height: 2.h),
                  AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesNoPet,
                    title: controller.customRules[2],
                    isSelected: controller.selectedRules[2],
                    onSelect: () => controller.toggleRules(2),
                  ),
                  SizedBox(height: 5.3.h),
                ],
              );
            },
          ),
          Text(
            Strings.newRules,
            style: FontManager.medium(18, color: AppColors.textAddProreties),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          Obx(
            () => AmenityAndHouseRulesContainer(
              imageAsset: Assets.imagesDamageToProretiy,
              title: controller.customRules[3],
              isSelected: controller.selectedRules[3],
              onSelect: () => controller.toggleRules(3),
            ),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.addRules.length,
              itemBuilder: (context, index) {
                final int rulesIndex;
                rulesIndex = index + controller.customRules.length;
                return Column(
                  children: [
                    const SizedBox(height: 2),
                    Obx(
                      () => AmenityAndHouseRulesContainer(
                        imageAsset: Assets.imagesSingleBed,
                        title: controller.addRules[index],
                        isSelected: controller.selectedRules[rulesIndex],
                        onSelect: () => controller.toggleRules(rulesIndex),
                        // isNewAdded: true,
                      ),
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
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/app_string.dart';
import '../../controller/add_properties_controller.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  // LatLng kMapCenter = const LatLng(19.018255973653343, 72.84793849278007);
  // LatLng? _currentPosition;
  // GoogleMapController? _mapController;

  final AddPropertiesController controller = Get.put(AddPropertiesController());

  @override
  void initState() {
    super.initState();
    // _checkLocationAndProceed();
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(height: 7.2.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.currentPage.value = 7;
                  },
                  child: const Icon(Icons.keyboard_arrow_left, size: 30),
                ),
                const SizedBox(width: 8),
                Text(
                  Strings.location,
                  style: FontManager.medium(20, color: AppColors.black),
                ),
              ],
            ),
            Flexible(
              child: Stack(
                children: [
                  Image.asset(Assets.imagesMapDefoulte),
                  // GoogleMap(
                  //   onMapCreated: (GoogleMapController controller) {
                  //     _mapController = controller;
                  //     if (_currentPosition != null) {
                  //       _mapController!.animateCamera(
                  //         CameraUpdate.newLatLng(_currentPosition!),
                  //       );
                  //     } else {
                  //       _mapController!.animateCamera(
                  //         CameraUpdate.newLatLng(kMapCenter),
                  //       );
                  //     }
                  //   },
                  //   initialCameraPosition: CameraPosition(
                  //     target: _currentPosition ?? kMapCenter,
                  //     zoom: 11,
                  //   ),
                  //   markers: {
                  //     if (_currentPosition != null)
                  //       Marker(
                  //         markerId: MarkerId('current_location'),
                  //         position: _currentPosition!,
                  //       ),
                  //   },
                  // ),
                  Positioned(
                    bottom: 5.h,
                    left: 16,
                    right: 16,
                    child: CommonButton(
                      title: Strings.nextStep,
                      onPressed: () {
                        if (controller.currentPage.value == 6) {
                          controller.currentPage.value = 7;
                          controller.nextPage();
                          Get.back();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
  // Future<void> getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     _showPermissionDialog();
  //     return;
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     _showPermissionDialog();
  //     return;
  //   }
  //
  //   try {
  //     final LocationSettings locationSettings = LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 100,
  //     );
  //
  //     Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  //     setState(() {
  //       _currentPosition = LatLng(position.latitude, position.longitude);
  //     });
  //
  //     if (_mapController != null) {
  //       _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
  //     }
  //   } catch (e) {
  //     print('Could not get the current location: $e');
  //   }
  // }
  //
  // void _checkLocationAndProceed() async {
  //   bool enabled = await Geolocator.isLocationServiceEnabled();
  //
  //   if (enabled) {
  //     controller.nextPage();
  //   } else {
  //     CustomDialog.showCustomDialog(
  //       context: context,
  //       title: Strings.turnLocationOn,
  //       message: Strings.locationDiscription,
  //       imageAsset: Assets.imagesQuestionDialog,
  //       buttonLabel: Strings.settings,
  //       changeEmailLabel: Strings.cancel,
  //       onResendPressed: () {
  //         Geolocator.openLocationSettings().then((_) {
  //           Get.back(); // Close the dialog
  //         });
  //       },
  //     );
  //   }
  // }
  //
  // void _showPermissionDialog() {
  //   CustomDialog.showCustomDialog(
  //     context: context,
  //     title: 'Location Permission Required',
  //     message: 'This app needs location permissions to function correctly. Please enable them in the settings.',
  //     imageAsset: Assets.imagesQuestionDialog,
  //     buttonLabel: Strings.settings,
  //     changeEmailLabel: Strings.cancel,
  //     onResendPressed: () {
  //       Geolocator.openLocationSettings().then((_) {
  //       });
  //     },
  //   );
  // }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';
import '../common_widget/custom_photo_upload_image.dart';

class PhotoPage extends StatefulWidget {
  final AddPropertiesController controller;
  const PhotoPage({super.key, required this.controller});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h),
            Text(
              Strings.coverPhoto,
              style: FontManager.regular(14, color: AppColors.textAddProreties),
            ),
            const SizedBox(height: 10),
            Obx(
              () => PhotoUploadContainer(
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
    int totalImages = widget.controller.imagePaths.length;

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
        return Obx(
          () => PhotoUploadContainer(
            index: index,
            imagePath: widget.controller.imagePaths[index],
            onImageSelected: (path) {
              setState(() {
                widget.controller.imagePaths[index] = path;
              });
            },
            isSingleSelect: false,
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_validation.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textformfield.dart';
import '../../controller/add_properties_controller.dart';
import '../common_widget/common_add_container.dart';
import '../common_widget/common_add_textfield.dart';

class PriceAndContactDetailsPage extends StatefulWidget {
  final AddPropertiesController controller;
  const PriceAndContactDetailsPage({super.key, required this.controller});

  @override
  State<PriceAndContactDetailsPage> createState() =>
      _PriceAndContactDetailsPageState();
}

class _PriceAndContactDetailsPageState
    extends State<PriceAndContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder(
          init: AddPropertiesController(),
          builder: (controller) => Column(
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
                              style: FontManager.regular(14,
                                  color: AppColors.black),
                            ),
                            SizedBox(height: 0.5.h),
                            CustomTextField(
                              controller: controller.basePriceController,
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
                              style: FontManager.regular(14,
                                  color: AppColors.black),
                            ),
                            SizedBox(height: 0.5.h),
                            CustomTextField(
                              controller: controller.weekendPriceController,
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
                    style:
                        FontManager.semiBold(18, color: AppColors.buttonColor),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(Strings.ownerContactNo, style: FontManager.regular(14)),
                  CustomTextField(
                    controller: controller.ownerContactNumberController,
                    keyboardType: TextInputType.number,
                    hintText: Strings.mobileNumberHint,
                    validator: (value) => AppValidation.validateMobile(value),
                    onChanged: (value) {
                      controller.ownerContactNumber.value = value;
                    },
                  ),
                  SizedBox(height: 0.5.h),
                  SizedBox(height: 3.h),
                  Text(Strings.ownerEmailID,
                      style: FontManager.regular(14, color: AppColors.black)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.ownerEmailController,
                    hintText: Strings.emailHint,
                    validator: (value) => AppValidation.validateEmail(value),
                    onChanged: (value) {
                      controller.ownerEmail.value = value;
                    },
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    Strings.homeStayDetails,
                    style:
                        FontManager.semiBold(18, color: AppColors.buttonColor),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(Strings.homeStayContactNo,
                      style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  controller.homeStayContactNumbers.isNotEmpty
                      ? CommonAddContainer(
                          items: controller.homeStayContactNumbers,
                          onRemove: (index) {
                            controller.removeHomeStayContactNumber(index);
                          },
                        )
                      : const SizedBox.shrink(),
                  controller.homeStayContactNumbers.isNotEmpty
                      ? SizedBox(
                          height: 2.h,
                        )
                      : const SizedBox.shrink(),
                  CommonAddTextfield(
                    // validator: AppValidation.validateMobile,
                    controller: controller.homeStayContactNumbersController,
                    itemCount: controller.homeStayContactNumbers.length,
                    hintText: Strings.enterHomeStayContactNo,
                    keyboardType: TextInputType.number,
                    onAdd: (newAdd) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.addHomeStayContactNumber(newAdd);
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.homeStayEmailID,
                      style: FontManager.regular(14, color: AppColors.black)),
                  SizedBox(height: 0.5.h),
                  controller.homeStayEmails.isNotEmpty
                      ? CommonAddContainer(
                          items: controller.homeStayEmails,
                          onRemove: (index) {
                            controller.removeHomeStayEmails(index);
                          },
                        )
                      : const SizedBox.shrink(),
                  controller.homeStayEmails.isNotEmpty
                      ? SizedBox(height: 2.h)
                      : const SizedBox.shrink(),
                  CommonAddTextfield(
                    // validator: AppValidation.validateEmail,
                    controller: controller.homeStayEmailsController,
                    itemCount: controller.homeStayEmails.length,
                    hintText: Strings.enterHomeStayEmailID,
                    onAdd: (newAdd) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.addHomeStayEmails(newAdd);
                      }
                    },
                  ),
                ],
              )),
    );
  }
}
import 'package:flutter/material.dart';
import '../../generated/assets.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'font_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIconData;
  final Image? prefixIconImage;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool showSuffixIcon;
  final Widget? suffixIconImage;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLength;
  final int maxLines;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isForgetPage;
  final bool isValidating;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIconData,
    this.prefixIconImage,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.showSuffixIcon = false,
    this.suffixIconImage,
    this.onSuffixIconPressed,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.textStyle,
    this.controller,
    this.isForgetPage = false,
    this.isValidating = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      style: textStyle ?? FontManager.regular(14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: FontManager.regular(12, color: AppColors.texFiledColor),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.texFiledColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        prefixIcon: prefixIconImage != null
            ? Padding(
                padding: const EdgeInsets.only(left: 0, top: 13, bottom: 13),
                child: prefixIconImage,
              )
            : prefixIconData != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(prefixIconData, color: AppColors.texFiledColor),
                  )
                : null,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.texFiledColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.texFiledColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.texFiledColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorTextfieldColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        errorStyle:
            FontManager.regular(10, color: AppColors.errorTextfieldColor),
        suffixIcon: (isForgetPage && isValidating)
            ? const Icon(
                Icons.error_outline,
                weight: 0.2,
                color: AppColors.errorTextfieldColor,
              )
            : (showSuffixIcon
                ? (suffixIconImage != null
                    ? Padding(
                        padding: const EdgeInsets.all(14),
                        child: suffixIconImage,
                      )
                    : IconButton(
                        icon: obscureText
                            ? Image.asset(
                                Assets.imagesEyesDisable,
                                height: 20,
                                width: 20,
                              )
                            : Image.asset(
                                Assets.imagesEyesEneble,
                                height: 20,
                                width: 20,
                              ),
                        onPressed: onSuffixIconPressed,
                      ))
                : null),
      ),
    );
  }
}
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import 'app_string.dart';

class AppValidation {

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.nameError;
    }
    return null;
  }

  static String? validateMobile(String? value) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (value == null || value.isEmpty) {
      return Strings.mobileNumberError;
    } else if (!phoneRegex.hasMatch(value)) {
      return Strings.mobileNumberLengthError;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.emailEmpty;
    } else if (!GetUtils.isEmail(value)) {
      return Strings.emailFormatError;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.passwordError;
    } else if (value.length < 8) {
      return Strings.passwordLengthError;
    }
    return null;
  }
  //
  // static String? validateConfirmPassword(String? value, String password) {
  //   if (value != password) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }
}
// lib/utils/strings.dart

class Strings {
  // Onboarding Titles
  static const String onboardingTitle1 = "Book with ease, travel with joy";
  static const String onboardingTitle2 =
      "Discover and find your perfect healing place";
  static const String onboardingTitle3 = "Giving the best deal just for you";

  // Onboarding Descriptions
  static const String onboardingDescription1 =
      '"Discover a seamless booking experience with our user-friendly interface and exclusive deals."';
  static const String onboardingDescription2 =
      '"Escape to a world of tranquility and rejuvenation. Discover our curated selection of wellness retreats and healing spaces."';
  static const String onboardingDescription3 =
      '"Get exclusive offers and discounts on hotels, flights, and packages, curated just for your travel style."';

  // Button Texts
  static const String nextButton = "Next";

  // General Strings
  static const String welcome = "Welcome";
  static const String gladToSeeYou = "Glad to see you!";

  // Form Labels
  static const String rememberMe = "Remember me";
  static const String forgetPassword = "Forget password?";
  static const String loginButton = "Login";
  static const String dontHaveAccount = "Don’t have an account?";

  // Validation Messages
  static const String emailEmpty = 'The email field is required.';
  static const String invalidEmail = 'Invalid email. Please enter your registered email';
  static const String passwordEmpty = 'Please enter your password';
  static const String shortPassword = 'Password must be at least 6 characters';

  // Hint texts
  static const String nameHint = 'Enter your name';
  static const String mobileNumberHint = 'Enter your Mobile Number';
  static const String emailHint = 'Enter Your Email';
  static const String passwordHint = 'Enter your Password';
  static const String confirmPasswordHint = 'Confirm Password';
  static const String addProfileImage = 'Add Profile Image';

  // Labels
  static const String createAccount = 'Create Account';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String nameLabel = 'Name';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String emailLabel = 'Email';
  static const String signUp = ' Sign Up';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String login = 'Login';

  // Error messages
  static const String nameError = 'The name field is required.';
  static const String mobileNumberError =
      'The mobile number field is required.';
  static const String mobileNumberLengthError =
      'Mobile number must be at least 10 digits';
  static const String emailError = 'Please enter your email';
  static const String emailFormatError = 'Please enter a valid email';
  static const String passwordError = 'The password field is required.';
  static const String passwordLengthError =
      'Password must be at least 8 characters long.';
  static const String confirmPasswordError =
      'The confirm password field is required.';
  static const String passwordMatchError = 'Passwords do not match';

  static const String forgetPasswordPrompt =
      "Provide your account's email for which you want to reset your password";
  static const String reset = "Reset";
  static const String resend = "Resend";
  static const String cancel = "Cancel";
  static const String checkYouEmail = "Check Your Email";
  static const String theEmailHasBeenResent =
      "The email has been resent. You will receive an email with a verification code to reset your password.";
  static const String changeEmail = "Change Email";

  // verification
  static const String verificationCodeTitle = "Verification Code";
  static const String verificationCodePrompt =
      "Enter your verification code sent to ";
  static const String verificationCodeHint = "Enter verification code.";
  static const String verificationCodeError = "Please enter a valid code";
  static const String verify = "Verify";
  static const String verifyFullCodeError = "Please enter the full code";
  static const String success = "Success";
  static const String verificationCodeEntered = "Verification code entered!";
  static const String error = "Error";
  static const String verifiCodeComple = "Please enter a complete code.";

  static const String resetPassword = "Reset Password";
  static const String resetCodePrompt =
      "Enter new password amd confirm password.";
  static const String newPasswordLabel = "New password";
  static const String confirmPassword = "Confirm Password";
  static const String otpEmpty = "This field cannot be empty";
  static const String submit = "Submit";

  static const String passwordUpdate = "Password Updated";
  static const String thepasswordChange = "Your password has been updated";
  static const String listHomeStay = "List Homestay";
  static const String listHomeStayGreyText =
      "List your stay in few simple steps to earn and welcome travelers across the world";
  static const String aboutYourStay = "About your Stay";
  static const String listHomeStayInto1 =
      "Give your stay a catchy name and detailed description and provide basic info around accommodation details , amenities you offer , House rules and checkin/checkout details";
  static const String getStarted = "Get Started";
  static const String hotToGetThere = "How to get there";
  static const String listHomeStayInto2 =
      "Upload beautiful images of your stay as well location and contact details";
  static const String previewandPublish = "Preview and Publish";
  static const String listHomeStayInto3 =
      "Just preview how your details would look like to a traveler and publish. Your are all set to go !";
  static const String homestayTitle = 'Homestay Title';
  static const String homestayType = 'Homestay Type';
  static const String titleLabel = 'Title';
  static const String enterTitle = 'Enter title';
  static const String titleHint = '0/100';
  static const String stepCount = 'STEP';
  static const String nextStep = 'Next';
  static const String done = "Done";
  static const String accommodationDetails = "Accommodation Details";
  static const String entirePlace = "Entire Place";
  static const String entirePlaceValue = "entirePlace";

  static const String wholePlacetoGuests = "Whole place to Guests";
  static const String privateRoom = "Private Room";
  static const String privateRoomValue = "privatePlace";
  static const String guestsSleepInPrivateRoomButSomeAreasAreShared =
      "Guests sleep in private room but some areas are shared";
  static const String maxGuests = "Max. Guests";
  static const String bedRooms = "Bedrooms";
  static const String singleBed = "Single Bed";
  static const String doubleBed = "Double Bed";
  static const String extraFloorMattress = "Extra floor mattress";
  static const String bathRooms = "Bathrooms";
  static const String kitchenAvailable = "Kitchen available";
  static const String defutlNumber = "06";
  static const String saveAndExit = "Save And Exit";
  static const String saveExit1 = "Save & Exit";
  static const String questionDialogText = "Are you sure, you want to exit? All changes done till now would be saved as Dtaft.";
  static const String yes = "Yes";
  static const String no = "No";
  static const String amenities = 'Amenities';
  static const String newAmenities = 'New Amenities';
  static const String wiFi = 'Wi-Fi';
  static const String airConditioner = 'Air-conditioner';
  static const String fireAlarm = 'Fire alarm';
  static const String homeTheater = 'Home Theater';
  static const String masterSuiteBalcony = 'Master Suite Balcony';
  static const String amenities3 = 'Amenities 3';
  static const String amenities4 = 'Amenities 4';
  static const String amenities5 = 'Amenities 5';
  static const String houseRules = 'House Rules';
  static const String addRules = '+ Add Rules';
  static const String addAmenities = '+ Add Amenities';
  static const String noSmoking = 'No smoking';
  static const String noDrinking = 'No drinking';
  static const String noPet = 'No pet';
  static const String newRules = 'New Rules';
  static const String damageToProperty = 'Damage to Property';
  static const String rules = 'Rules';
  static const String checkInOutDetails = 'Check-in/out details';
  static const String checkInTime = 'Check-In Time';
  static const String checkOutTime = 'Check-Out Time';
  static const String flexibleWithCheckInTime = 'Flexible with Check-in time';
  static const String selectCheckInTime = 'Select Check In Time';
  static const String selectCheckOutTime = 'Select Check Out Time';
  static const String selectTime = 'Select Time';
  static const String turnLocationOn = 'Turn Location On';
  static const String locationDiscription = 'Your Location is off. please turn on Location to allow travelbud to see your location.';
  static const String settings = 'Settings';
  static const String location = 'Location';
  static const String addLocation = 'Add Location';
  static const String address = 'Address';
  static const String addressIcon = '*';
  static const String streetAddress = 'Street Address';
  static const String landmark = 'Landmark';
  static const String cityTown = 'City/Town';
  static const String pinCode = 'Pin code';
  static const String state = 'State';
  static const String showYourSpecificLocation = 'Show your specific location';
  static const String addressDiscription = 'Make it clear to guests where your place is located. We’ll only share your address after they’ve made a reservation.';
  static const String enterYourAddress = 'Enter your address';
  static const String enterYourStreetAddress = 'Enter your street address';
  static const String enterYourLandmark = 'Enter your landmark';
  static const String enterYourCity = 'Enter your city';
  static const String enterYourPinCode = 'Enter your pin code';
  static const String selectYourState = 'Select your state';
  static const String coverPhoto = 'Cover Photo';
  static const String photoChooseDiscription = 'Click photo or';
  static const String chooseFile = ' choose file';
  static const String to = ' to\n';
  static const String upload = 'upload';
  static const String homestayPhotos = 'Homestay Photos';
  static const String photos = 'Photos';
  static const String fileExpection = 'Picked file';
  static const String noFileSelectedExpection = 'No file selected';
  static const String homeStayDescription = 'Homestay Description';
  static const String description = 'Description';
  static const String enterDescription = 'Enter description';
  static const String priceAndContactDetailsPage = 'Price and Contact Details';
  static const String basePrice = 'Base Price';
  static const String weekendPrice = 'Weekend Price';
  static const String enterStartPrice = 'Enter start price';
  static const String enterEndPrice = 'Enter end price';
  static const String ownerDetails = 'Owner Details';
  static const String ownerContactNo = 'Owner Contact No.';
  static const String ownerEmailID = 'Owner Email ID';
  static const String homeStayDetails = 'Homestay Details';
  static const String homeStayContactNo = 'Homestay Contact No.';
  static const String enterHomeStayContactNo = 'Enter homestay contact no.';
  static const String homeStayEmailID = 'Homestay Email ID';
  static const String enterHomeStayEmailID = 'Enter homestay email ID';
  static const String preview = 'Preview';
  static const String hiltonViewVilla = 'Hilton View Villa';
  static const String newYorkUSA = 'New York, USA';
  static const String doller = '5,000 - 6,500';
  static const String details = 'Details';
  static const String contact = 'Contact';
  static const String traditional = 'Traditional';
  static const String defultbedrooms = 'Bedrooms';
  static const String defultSingleBed = '5 Single Bed';
  static const String defultGuests = '12 Guests';
  static const String defultBathrooms = '6 Bathrooms';
  static const String defultDoubleBed = '6 Double Bed';
  static const String defultFloorMattress = '2 Floor mattress';
  static const String descriptionReadMore =
      "'Hilton View Villa is a luxurious retreat offering modern comfort with stunning panoramic views. Featuring elegant rooms, private balconies, a pool,  and gourmet dining, it's perfect for guests seeking relaxation and exclusivity in a scenic setting. ";
  static const String readMore = ' Read more...';
  static const String time = 'Time';
  static const String termsAndConditions = 'Terms & Conditions';
  static const String term1 = '1. Term 1';
  static const String term2 = '2. Term 2';
  static const String term3 = '3. Term 3';
  static const String term4 = '4. Term 4';
  static const String term1desc =
      'Lorem ipsum dolor sit amet consectetur. Nisl a pellentesque id semper quam donec. Hendrerit eleifend at vel curabitur. Risus morbi adipiscing porttitor et facilisis. Ornare massa at ut morbi felis dui senectus. Cum ac varius sapien id nam nisl.';
  static const String term2desc =
      'Aliquet lacus vitae bibendum morbi. Id ornare ultricies sit sapien arcu auctor sed pretium. Non lectus egestas consectetur urna viverra tincidunt iaculis lacus donec. Mauris arcu gravida dui mauris nunc mauris blandit. Ut quam augue sodales nibh quis. Eu suspendisse aliquet sed blandit nullam libero. Nunc vivamus non id eleifend ullamcorper. Non malesuada consectetur ante ultrices morbi. Tortor maecenas sed scelerisque fermentum ut quam. Urna enim etiam fames gravida.';
  static const String term3desc =
      'Mi bibendum volutpat non eget. Ultrices semper sit enim tincidunt. Vitae purus sed in sapien feugiat ac a. Congue sit lacus nulla non nibh facilisi tempor justo. Porttitor augue enim diam netus aliquam ut. Cursus pretium in fringilla gravida. Id habitasse dictum proin feugiat amet elit. Ac gravida et quis diam elementum aliquet. Ante lorem id lacus sit arcu quam gravida in. Tellus mollis malesuada nulla phasellus vitae aliquet risus neque odio. Rhoncus condimentum sagittis at nisl pellentesque sed vitae id. ';
  static const String term4desc =
      'Morbi vel aliquam nisl vel a convallis faucibus at. Pulvinar tellus imperdiet amet massa turpis suspendisse non id. Aliquet sagittis maecenas vitae sapien sapien consequat accumsan ultricies. Pellentesque morbi et pellentesque aliquet integer vulputate. Id nunc nisl vitae facilisis turpis tempus. Nisi nulla faucibus erat metus bibendum sollicitudin suscipit laoreet. Urna pharetra risus magnis orci amet sed interdum malesuada.';

  static const String seeAll = 'See all';
  static const String freeWifi = 'Free \n Wifi';
  static const String airCondition2 = 'Air- \n Condition';
  static const String hometheater2 = 'Home \n Theater';
  static const String firAlarm2 = 'Fir \n alarm';

  static const String noSmoking2 = 'No \n smoking';
  static const String noDrinking2 = 'No- \n drinking';
  static const String noPet2 = 'No Pet';
  static const String damageToProperty2 = 'Damage to \n Property';

  static const String defultCallNumber = '+1 23456 78901';
  static const String defultEmail = 'travellery1234@gmail.com';

  static const String congratulations = 'Congratulations';
  static const String congraDesc =
      'Congratulations, you are one step away from getting You property listed.  \n Review process would be completed within 48 hours.';
  static const String okay = 'Okay';
  static const String yourProperties = 'Your Properties';
  static const String ecoFriendly = 'Eco-Friendly';
  static const String approved = 'Approved';
  static const String luxury = 'luxury';
  static const String pending = 'Pending';
  static const String rejected = 'Rejected';
  static const String evolveBackCoorg = 'Evolve Back Coorg';
  static const String urban = 'Urban';
  static const String draft = 'Draft';
  static const String edit = 'edit';
  static const String delete = 'Delete';
  static const String chooseImageSource = 'Choose Image Source';
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String bedAndBreakfast = 'Bed & Breakfast';
  static const String adventure = 'Adventure ';
  static const String deleteDesc =
      'Are you sure you want to delete this properties ? ';
  static const String updateAndExit = 'Update and Exit ';
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String trips = 'Trips';
  static const String helloJhon = 'Hello Jhon!';
  static const String welcomeToTravelbud = 'Welcome to Travelbud.';
  static const String search = 'Search';
  static const String delhi = 'Delhi';
  static const String goa = 'Goa';
  static const String jaipur = 'Jaipur';
  static const String kerela = 'Kerela';
  static const String uttarakhand = 'Uttarakhand';
  static const String properties = 'Properties';
  static const String defultDoller = '₹ 10,000 - 12,000';
  static const String defultDoller1 = '₹ 15,000 - 20,000';
  static const String defultDoller2 = '₹ 20,000 - 25,000';
  static const String defultDoller3 = '₹ 14,000 - 20,000';
  static const String defultDoller4 = '₹ 10,000 - 15,000';
  static const String defultDoller5 = '₹ 16,000 - 20,000';
  static const String defultDoller6 = '₹ 13,000 - 20,000';
  static const String filter = 'Filter';
  static const String priceRange = 'Price Range';
  static const String minimum = 'Minimum';
  static const String maximum = 'Maximum';
  static const String sortByPrice = 'Sort by Price';
  static const String any = 'Any';
  static const String lowestToHighest = 'Lowest to Highest';
  static const String highestToLowest = 'Highest to Lowest ';
  static const String typeOfPlace = 'Type of place';
  static const String clearAll = 'Clear All';
  static const String showMore = 'Show more';
  static const String orUseMyCurrentLocation = 'or use my current location';
  static const String recentSearch = 'Recent Search';
  static const String apply = 'Apply';
  static const String defult5Night = '5 nights';
  static const String selectGuest = 'Select Guest';
  static const String adults = 'Adults';
  static const String children = 'Adults';
  static const String infants = 'Infants';
  static const String ages14orAbove = 'Ages 14 or above';
  static const String ages2to13 = 'Ages 2-13';
  static const String under2 = 'Under 2';
  static const String checkInOutDate = 'Check in - out date';
  static const String reserve = 'Reserve';
  static const String bookingRequest = 'Booking Request';
  static const String yourBookingDetails = 'Your Booking Details';
  static const String date = 'Dates';
  static const String guest = 'Guest';
  static const String priceDetails = 'Price Details';
  static const String taxes = 'Taxes';
  static const String serviceFee = 'Service fee';
  static const String total = 'Total';
  static const String mealsIncluded = 'Meals Included';
  static const String freeBreakfastLunchDinner = 'Free Breakfast, Lunch & Dinner';
  static const String cancellationPolicy = 'Cancellation Policy';
  static const String freeCancellationUntil = 'Free Cancellation until 15 Jun 2024';
  static const String houseRulesDes = 'We expect guests to treat Host’s place like your own and look after it.';
  static const String houseRulesDes2 = 'Read and comply with all the House rules mentioned by Host.';
  static const String houseRulesDes3 = 'Valid identity proof for all the guests required at the time of check-in';
  static const String confirmPaymentDesc = 'I also agree to the Uploaded Terms of Service, Payments Terms of Service and I acknowledgement the Privacy Policy ';
  static const String confirmPayment = 'Confirm Payment';
  static const String uploadingImage = "Uploading...";
  static const String pinCodeEnterValidation = 'Please enter a PIN code';
  static const String pinMaximumDigit = 'Enter maximum 6 digit number';
  static const String pinOnlyDigit = 'PIN code must contain only digits';
  static const String flexible = "Flexible";
  static const String minutes = "minutes";
  static const String upcoming = "Upcoming";
  static const String cancelRefund = "Cancel/Refund";
  static const String completed = "Completed";




}
  dio: ^5.7.0
  image_cropper: ^8.0.2
  get_it: ^8.0.1
  pretty_dio_logger: ^1.4.0
  get_storage: ^2.1.1
  google_maps_flutter: ^2.9.0
  pinput: ^5.0.0
  percent_indicator: ^4.2.3
  dotted_border: ^2.1.0
  timer_count_down: ^2.2.2
  flutter_image_compress: ^2.3.0

