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


  // api add data
  Future<void> homeStayAddData() async {
    showLoading();
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
      "checkInTime": DateFormat('hh:mm:ss a').format(checkInTime.value),
      "checkOutTime": DateFormat('hh:mm:ss a').format(checkOutTime.value),
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
      // "homestayPhotos": ,
      "description": description.value,
      "basePrice": 20000,
      "weekendPrice": 100000,
      "ownerContactNo": 3000000,
      "ownerEmailId": 6000000,
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
      "status": "Draft",
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

    homeStayRepository.homeStayData(formData: formData).then((value) {
        final singleFetchUserModel = Homestay.fromJson(value);
        getIt<StorageServices>().setHomeStayId(singleFetchUserModel.id);
        String? homeStayId = getIt<StorageServices>().getHomeStayId();
        if (homeStayId != null) {
          print("homeStayId user ID: $homeStayId");
        }
        Get.snackbar('', 'Homestay Data created successfully!');
        hideLoading();
        Get.toNamed(
          Routes.previewPage,
          arguments: {
            'index': 0,
          },
        );
      },
    );
  }

  late Homestay property;

  Future<void> getPropertiesData() async {
    property = await homeStayRepository.getPreviewPropertiesData();
    print("sdnbfnb${property.title}");
  } import 'package:get_storage/get_storage.dart';

class StorageServices {
  static String userToken = "userToken";
  static String userId = "userId";
  static String homeStayId = "homeStayId";


  static GetStorage storage = GetStorage();

  setUserToken(String? token) {
    storage.write(userToken, token);
  }

  String? getUserData() {
    return storage.read(userToken);
  }

  String getUserToken() {

    String? userData = getUserData();
    print('================ userData=== ${userData} ========================');
    if (userData != null) {
      print('================ token=== ${userData} ========================');
      return userData;
    }
    return "";
  }

  clearUserData() {
    return storage.remove(userToken);
  }

  cleanLocalStorage() {
    storage.remove(userToken);
  }

  setUserId(String id) {
    storage.write(userId, id);
  }

  String? getUserId2() {
    return storage.read(userId);
  }
  String? getUserId() {
    String? userData = getUserId2();
    if (userData != null) {
      print('================ id === $userData ========================');
      return userData;import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travellery_mobile/common_widgets/common_loading_process.dart';
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../common_widgets/common_image_picker.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../services/storage_services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
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
        homeStayAddData().then(
          (value) {},
        );
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
      "coverPhoto": await dio.MultipartFile.fromFile(coverImagePaths[0]!,filename: "coverPhoto.jpg"),
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

// Future<void> homeStayAddDataLocally() async {
//   // Show loading indicator if required (implement loading handling as per your UI)
//   LoadingProcessCommon().showLoading();
//
//   // Prepare data to store locally
//   final homestayData = {
//     "title": homestayTitle.value,
//     "homestayType": selectedType.value,
//     "accommodationDetails": jsonEncode({
//       "entirePlace": selectedAccommodation.value == Strings.entirePlaceValue,
//       "privateRoom": selectedAccommodation.value == Strings.privateRoomValue,
//       "maxGuests": maxGuestsCount.value,
//       "bedrooms": bedroomsCount.value,
//       "singleBed": singleBedCount.value,
//       "doubleBed": doubleBedCount.value,
//       "extraFloorMattress": extraFloorCount.value,
//       "bathrooms": bathRoomsCount.value,
//       "kitchenAvailable": isKitchenAvailable.value,
//     }),
//     "amenities": jsonEncode(allAmenities.map((amenity) {
//       int index = allAmenities.indexOf(amenity);
//       return {
//         "name": amenity,
//         "isChecked": selectedAmenities[index],
//         "isNewAdded": selectedAmenities.length > customAmenities.length &&
//             index >= customAmenities.length,
//       };
//     }).toList()),
//     "houseRules": jsonEncode(allRules.map((rules) {
//       int index = allRules.indexOf(rules);
//       return {
//         "name": rules,
//         "isChecked": selectedRules[index],
//         "isNewAdded": selectedRules.length > customRules.length &&
//             index >= customRules.length,
//       };
//     }).toList()),
//     "checkInTime": DateFormat('hh:mm a').format(checkInTime.value),
//     "checkOutTime": DateFormat('hh:mm a').format(checkOutTime.value),
//     "flexibleCheckIn": flexibleWithCheckInTime.value,
//     "flexibleCheckOut": flexibleWithCheckInOut.value,
//     "longitude": "72.88692069643963",
//     "latitude": "21.245049600735083",
//     "address": address.value,
//     "street": streetAddress.value,
//     "landmark": landmark.value,
//     "city": city.value,
//     "pinCode": pinCode.value,
//     "state": state.value,
//     "showSpecificLocation": isSpecificLocation,
//     "coverPhoto": coverImagePaths.isNotEmpty ? coverImagePaths[0] : null,
//     "description": description.value,
//     "basePrice": basePrice.value,
//     "weekendPrice": weekendPrice.value,
//     "ownerContactNo": ownerContactNumber.value,
//     "ownerEmailId": ownerEmail.value,
//     "homestayContactNo": jsonEncode(homeStayContactNumbers.map((contact) => {"contactNo": contact}).toList()),
//     "homestayEmailId": jsonEncode(homeStayEmails.map((email) => {"EmailId": email}).toList()),
//     "status": isEditing.value == true ? "Draft" : "Pending Approval",
//   };
//
//   // Use GetStorage to store the homestay data locally
//   final box = GetStorage();
//   await box.write('homestay_data', homestayData);  // Save data locally as JSON
//
//   // Hide loading indicator
//   LoadingProcessCommon().hideLoading();
//
//   // Show a success message to the user
//   Get.snackbar('Success', 'Homestay data saved locally');
//
//   // Navigate to the preview page (if required)
//   Get.toNamed(Routes.previewPage, arguments: {'index': 0});
// }


