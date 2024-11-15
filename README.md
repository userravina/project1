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

import 'dart:convert';
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
      accommodationDetails: AccommodationDetails.fromJson(jsonDecode(json['accommodationDetails'])),
      amenities: List<Amenities>.from(jsonDecode(json['amenities']).map((x) => Amenities.fromJson(x))),
      houseRules: List<HouseRules>.from(jsonDecode(json['houseRules']).map((x) => HouseRules.fromJson(x))),
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

      description: json['description'],
      basePrice: json['basePrice'],
      weekendPrice: json['weekendPrice'],
      ownerContactNo: json['ownerContactNo'],
      ownerEmailId: json['ownerEmailId'],
      homestayContactNo: List<HomestayContactNo>.from(jsonDecode(json['homestayContactNo']).map((x) => HomestayContactNo.fromJson(x))),
      homestayEmailId: List<HomestayEmailId>.from(jsonDecode(json['homestayEmailId']).map((x) => HomestayEmailId.fromJson(x))),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'homestayType': homestayType,
      'accommodationDetails': jsonEncode(accommodationDetails.toJson()),
      'amenities': jsonEncode(amenities.map((x) => x.toJson()).toList()),
      'houseRules': jsonEncode(houseRules.map((x) => x.toJson()).toList()),
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
      'description': description,
      'basePrice': basePrice,
      'weekendPrice': weekendPrice,
      'ownerContactNo': ownerContactNo,
      'ownerEmailId': ownerEmailId,
      'homestayContactNo': jsonEncode(homestayContactNo.map((x) => x.toJson()).toList()),
      'homestayEmailId': jsonEncode(homestayEmailId.map((x) => x.toJson()).toList()),
      'status': status,
    };
  }
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
  Future<void> homeStayAddData2() async {
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

  Future<void> homeStayAddDataLocally() async {
    LoadingProcessCommon().showLoading();
    final homestayData = LocalHomestaydataModel(
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

    Get.toNamed(Routes.previewPage, arguments: {'index': 0, 'homestayData': homestayData,});
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travellery_mobile/generated/assets.dart';
import 'dart:io';
import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_dialog.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../add_properties_screen/add_properties_steps/data/model/local_homestaydata_model.dart';
import '../controller/preview_properties_controller.dart';
import 'package:travellery_mobile/screen/your_properties_screen/controller/your_properties_controller.dart';

class PreviewPage extends StatefulWidget {
  final int selectedIndex;

  const PreviewPage({super.key, required this.selectedIndex});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {

  final PreviewPropertiesController previewController = Get.put(PreviewPropertiesController());
  late TabController _tabController;
  late LocalHomestaydataModel arguments;

  @override
  void initState() {
    super.initState();
     arguments = Get.arguments;

    _tabController = TabController(length:  2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final homestayData = arguments;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:  GetBuilder<YourPropertiesController>(
        init:  YourPropertiesController() ,
        builder: (controller) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                EdgeInsets.fromLTRB(5.w, statusBarHeight + 3.2.h, 4.w,10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.selectedIndex == 1
                          ? Strings.details
                          : Strings.preview,
                      style: FontManager.medium(20, color: AppColors.black),
                    ),
                    const Spacer(),
                    if (widget.selectedIndex == 1)...[
                      PopupMenuButton<String>(
                        color: AppColors.backgroundColor,
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.textAddProreties,
                        ),
                        onSelected: (value) {
                          if (value == Strings.edit) {
                            // controller.currentPage.value = 1;
                            // Get.toNamed(Routes.addPropertiesScreen,
                            //     arguments: {'index': 1});
                          } else if (value == Strings.delete) {
                            CustomDialog.showCustomDialog(
                              context: context,
                              message: Strings.deleteDesc,
                              imageAsset: Assets.imagesDeletedialog,
                              buttonLabel: Strings.resend,
                              changeEmailLabel: Strings.changeEmail,
                              onResendPressed: () {
                                print("xxzzzzzzzzzzzz");
                                controller.deleteProperties();

                              },
                              onChangeEmailPressed: () {},
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            buildPopupMenuItem(
                                Assets.imagesEdit,
                                Strings.edit,
                                AppColors.editBackgroundColor,
                                AppColors.blueColor),
                            buildPopupMenuItem(
                                Assets.imagesDeleteVector,
                                Strings.delete,
                                AppColors.deleteBackgroundColor,
                                AppColors.redColor),
                          ];
                        },
                      )
                    ],
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          previewController.updateCarouselIndex(index);
                        },
                        padEnds: false,
                        disableCenter: true,
                        aspectRatio: 1.6,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                      ),
                      carouselController: previewController.carouselController,
                      items: widget.selectedIndex == 1
                          ? controller.property.homestayData!.homestayPhotos!
                          .map((imagePath) {
                        return ClipRRect(
                          borderRadius:
                          const BorderRadius.all(AppRadius.radius10),
                          child: null != imagePath.url
                              ? Image.network(imagePath.url!,
                              fit: BoxFit.cover)
                              : Container(
                            color: Colors.grey[300],
                          ),
                        );
                      }).toList()
                          : controller.property.homestayData!.homestayPhotos!.map((imagePath) {
                        return ClipRRect(
                          borderRadius:
                          const BorderRadius.all(AppRadius.radius10),
                          child: null != imagePath.url
                              ? Image.file(File(imagePath.url!),
                              fit: BoxFit.cover)
                              : Container(
                            color: Colors.grey[300],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Obx(
                          () => AnimatedSmoothIndicator(
                        count: controller
                            .property.homestayData!.homestayPhotos!.length,
                        effect: const ExpandingDotsEffect(
                            activeDotColor: AppColors.buttonColor,
                            dotColor: AppColors.inactiveDotColor,
                            spacing: 2,
                            dotHeight: 5,
                            dotWidth: 5),
                        onDotClicked: (index) {
                          previewController.carouselController
                              .jumpToPage(index);
                        },
                        activeIndex: previewController.carouselIndex.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    widget.selectedIndex == 1
                        ? Container(
                      height: 2.7.h,
                      width: 19.6.w,
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(AppRadius.radius4),
                          color:
                          controller.property.homestayData!.status! ==
                              "Pending Approval"
                              ? AppColors.pendingColor
                              : controller.property.homestayData!
                              .status! ==
                              "Approved"
                              ? AppColors.approvedColor
                              : AppColors.greyText),
                      child: Center(
                        child: Text(
                          controller.property.homestayData!.status!,
                          style: FontManager.regular(12,
                              color: AppColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.selectedIndex == 1
                        ? const SizedBox(
                      height: 12,
                    )
                        : const SizedBox.shrink(),
                    Text(
                      widget.selectedIndex == 1
                          ? controller.property.homestayData!.title!
                          : controller.property.homestayData!.title!,
                      style: FontManager.semiBold(28,
                          color: AppColors.textAddProreties),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      widget.selectedIndex == 1
                          ? Strings.newYorkUSA
                          : Strings.newYorkUSA,
                      style: FontManager.regular(14, color: AppColors.greyText),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                        '${controller.property.homestayData!.basePrice} - ${controller.property.homestayData!.weekendPrice}',
                        style: FontManager.medium(20,
                            color: AppColors.textAddProreties)),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  unselectedLabelColor: AppColors.greyText,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 0.5.w,
                  tabs: const [
                    Tab(text: Strings.details),
                    Tab(text: Strings.contact),
                  ],
                ),
              ),
            ),
            buildTabBarView(controller),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> buildPopupMenuItem(
      String image, String choice, Color bColor, Color tColor) {
    return PopupMenuItem<String>(
      value: choice,
      child: Container(
        width: double.infinity,
        height: 5.h,
        decoration: BoxDecoration(
            color: bColor,
            borderRadius: const BorderRadius.all(AppRadius.radius4)),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Image.asset(
              image,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  choice.capitalizeFirst!,
                  style: TextStyle(color: tColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildTabBarView(YourPropertiesController controller) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150.h,
        child: TabBarView(
          controller: _tabController,
          children: [
            buildDetailsView(controller),
            buildContactView(controller),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsView(YourPropertiesController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                height: 5.h,
                width: 35.w,
                decoration: const BoxDecoration(
                  color: AppColors.lightPerpul,
                  borderRadius: BorderRadius.all(AppRadius.radius24),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Image.asset(
                      Assets.imagesTraditional,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      controller.property.homestayData!.homestayType!,
                      style:
                      FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 5.h,
                width: 35.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(AppRadius.radius24),
                    border: Border.all(color: AppColors.lightPerpul)),
                child: Row(
                  children: [
                    const Spacer(),
                    Image.asset(
                      Assets.imagesTraditional,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      controller.property.homestayData!.accommodationDetails!
                          .entirePlace ==
                          true
                          ? Strings.entirePlace
                          : Strings.privateRoom,
                      style:
                      FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    const Spacer(),
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
                        "${controller.property.homestayData!.accommodationDetails!.bedrooms} ${Strings.bedRooms}",
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
                        "${controller.property.homestayData!.accommodationDetails!.maxGuests} ${Strings.guest}",
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
                        "${controller.property.homestayData!.accommodationDetails!.doubleBed} ${Strings.doubleBed}",
                        style: FontManager.regular(12,
                            color: AppColors.textAddProreties),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
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
                        "${controller.property.homestayData!.accommodationDetails!.singleBed} ${Strings.singleBed}",
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
                        "${controller.property.homestayData!.accommodationDetails!.bathrooms} ${Strings.bathRooms}",
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
              const Spacer(),
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
                    text: controller.property.homestayData!.description,
                    style: FontManager.regular(12, color: AppColors.black),
                  ),
                  // TextSpan(
                  //   style:
                  //       FontManager.regular(12, color: AppColors.buttonColor),
                  //   text: Strings.readMore,
                  //   recognizer: TapGestureRecognizer()
                  //     ..onTap = () => Get.toNamed(''),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          buildTimeSection(controller),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(),
          SizedBox(height: 2.h),
          CommonButton(
            title: Strings.done,
            onPressed: () {
              widget.selectedIndex == 1
                  ? Get.toNamed('')
                  : Get.toNamed(Routes.termsAndCondition);
            },
          ),
        ],
      ),
    );
  }

  Widget buildTimeSection(YourPropertiesController controller) {
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
            borderRadius: const BorderRadius.all(AppRadius.radius10),
            border: Border.all(color: AppColors.borderContainerGriedView),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTimeItem(
                  Assets.imagesClock,
                  Strings.checkInTime,
                  controller.property.homestayData!.flexibleCheckIn == true
                      ? Strings.flexible
                      : controller.property.homestayData!.checkInTime!),
              buildTimeSeparator(),
              buildTimeItem(
                  Assets.imagesClock,
                  Strings.checkOutTime,
                  controller.property.homestayData!.flexibleCheckOut == true
                      ? Strings.flexible
                      : controller.property.homestayData!.checkOutTime!),
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
          decoration:
          const BoxDecoration(color: AppColors.borderContainerGriedView),
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
          decoration: const BoxDecoration(
              color: AppColors.greyText,
              borderRadius: BorderRadius.all(AppRadius.radius10),
              image: DecorationImage(
                  image: AssetImage(Assets.imagesMapDefoulte),
                  fit: BoxFit.cover)),
        ),
        SizedBox(height: 2.h),
        Text(
            "400 West 42nd Street, Hell's Kitchen, New York, NY 10036, United States",
            style: FontManager.regular(12, color: AppColors.black)),
      ],
    );
  }

  Widget buildContactView(YourPropertiesController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Text(Strings.ownerDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          buildContactRow(Assets.imagesCallicon,
              controller.property.homestayData!.ownerContactNo!),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon,
              controller.property.homestayData!.ownerEmailId!),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          ...controller.property.homestayData!.homestayContactNo!
              .map((contact) {
            return Column(
              children: [
                buildContactRow(Assets.imagesCallicon, contact.contactNo!),
                SizedBox(height: 1.h),
              ],
            );
          }),
          SizedBox(height: 1.h),
          ...controller.property.homestayData!.homestayEmailId!.map((email) {
            return Column(
              children: [
                buildContactRow(Assets.imagesEmailicon, email.emailId!),
                SizedBox(height: 1.h),
              ],
            );
          }),
          SizedBox(height: 5.h),
          CommonButton(
            title: Strings.done,
            onPressed: () => widget.selectedIndex == 1
                ? Get.toNamed('')
                : Get.toNamed(Routes.termsAndCondition),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColors.backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}


import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class PreviewPropertiesController extends GetxController{
  var carouselIndex = 0.obs;
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselSliderController();
  }


  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
  }
}
 import 'package:flutter/material.dart';
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
  }

  void hideLoading() {
    isLoading = false;
    Get.back();
  }
}


