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
      return userData;
    }
    return "";
  }


  setHomeStayId(String id) {
    storage.write(homeStayId, id);
  }

  String? getHomeStayData() {
    return storage.read(homeStayId);
  }
  String? getHomeStayId() {
    String? userData = getHomeStayData();
    if (userData != null) {
      print('================ id === $userData ========================');
      return userData;
    }
    return "";
  }
}
class Homestay {
  String title;
  String homestayType;
  AccommodationDetails accommodationDetails;
  List<Amenity> amenities;
  List<HouseRule> houseRules;
  String checkInTime;
  String checkOutTime;
  bool flexibleCheckIn;
  bool flexibleCheckOut;
  double longitude;
  double latitude;
  String address;
  String street;
  String landmark;
  String city;
  String pinCode;
  String state;
  bool showSpecificLocation;
  CoverPhoto coverPhoto;
  List<HomestayPhoto> homestayPhotos;
  String description;
  int basePrice;
  int weekendPrice;
  String ownerContactNo;
  String ownerEmailId;
  List<Contact> homestayContactNo;
  List<Email> homestayEmailId;
  String status;
  String createdBy;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Homestay({
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
    required this.coverPhoto,
    required this.homestayPhotos,
    required this.description,
    required this.basePrice,
    required this.weekendPrice,
    required this.ownerContactNo,
    required this.ownerEmailId,
    required this.homestayContactNo,
    required this.homestayEmailId,
    required this.status,
    required this.createdBy,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Homestay.fromJson(Map<String, dynamic> json) {
    return Homestay(
      title: json['homestay']['title'],
      homestayType: json['homestay']['homestayType'],
      accommodationDetails: AccommodationDetails.fromJson(json['homestay']['accommodationDetails']),
      amenities: (json['homestay']['amenities'] as List)
          .map((e) => Amenity.fromJson(e))
          .toList(),
      houseRules: (json['homestay']['houseRules'] as List)
          .map((e) => HouseRule.fromJson(e))
          .toList(),
      checkInTime: json['homestay']['checkInTime'],
      checkOutTime: json['homestay']['checkOutTime'],
      flexibleCheckIn: json['homestay']['flexibleCheckIn'],
      flexibleCheckOut: json['homestay']['flexibleCheckOut'],
      longitude: json['homestay']['longitude'],
      latitude: json['homestay']['latitude'],
      address: json['homestay']['address'],
      street: json['homestay']['street'],
      landmark: json['homestay']['landmark'],
      city: json['homestay']['city'],
      pinCode: json['homestay']['pinCode'],
      state: json['homestay']['state'],
      showSpecificLocation: json['homestay']['showSpecificLocation'],
      coverPhoto: CoverPhoto.fromJson(json['homestay']['coverPhoto']),
      homestayPhotos: (json['homestay']['homestayPhotos'] as List)
          .map((e) => HomestayPhoto.fromJson(e))
          .toList(),
      description: json['homestay']['description'],
      basePrice: json['homestay']['basePrice'],
      weekendPrice: json['homestay']['weekendPrice'],
      ownerContactNo: json['homestay']['ownerContactNo'],
      ownerEmailId: json['homestay']['ownerEmailId'],
      homestayContactNo: (json['homestay']['homestayContactNo'] as List)
          .map((e) => Contact.fromJson(e))
          .toList(),
      homestayEmailId: (json['homestay']['homestayEmailId'] as List)
          .map((e) => Email.fromJson(e))
          .toList(),
      status: json['homestay']['status'],
      createdBy: json['homestay']['createdBy'],
      id: json['homestay']['_id'],
      createdAt: DateTime.parse(json['homestay']['createdAt']),
      updatedAt: DateTime.parse(json['homestay']['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'homestay': {
        'title': title,
        'homestayType': homestayType,
        'accommodationDetails': accommodationDetails.toJson(),
        'amenities': amenities.map((e) => e.toJson()).toList(),
        'houseRules': houseRules.map((e) => e.toJson()).toList(),
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
        'coverPhoto': coverPhoto.toJson(),
        'homestayPhotos': homestayPhotos.map((e) => e.toJson()).toList(),
        'description': description,
        'basePrice': basePrice,
        'weekendPrice': weekendPrice,
        'ownerContactNo': ownerContactNo,
        'ownerEmailId': ownerEmailId,
        'homestayContactNo': homestayContactNo.map((e) => e.toJson()).toList(),
        'homestayEmailId': homestayEmailId.map((e) => e.toJson()).toList(),
        'status': status,
        'createdBy': createdBy,
        '_id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      }
    };
  }
}

class AccommodationDetails {
  bool entirePlace;
  bool privateRoom;
  int maxGuests;
  int bedrooms;
  int singleBed;
  int doubleBed;
  int extraFloorMattress;
  int bathrooms;
  bool kitchenAvailable;

  AccommodationDetails({
    required this.entirePlace,
    required this.privateRoom,
    required this.maxGuests,
    required this.bedrooms,
    required this.singleBed,
    required this.doubleBed,
    required this.extraFloorMattress,
    required this.bathrooms,
    required this.kitchenAvailable,
  });

  factory AccommodationDetails.fromJson(Map<String, dynamic> json) {
    return AccommodationDetails(
      entirePlace: json['entirePlace'],
      privateRoom: json['privateRoom'],
      maxGuests: json['maxGuests'],
      bedrooms: json['bedrooms'],
      singleBed: json['singleBed'],
      doubleBed: json['doubleBed'],
      extraFloorMattress: json['extraFloorMattress'],
      bathrooms: json['bathrooms'],
      kitchenAvailable: json['kitchenAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entirePlace': entirePlace,
      'privateRoom': privateRoom,
      'maxGuests': maxGuests,
      'bedrooms': bedrooms,
      'singleBed': singleBed,
      'doubleBed': doubleBed,
      'extraFloorMattress': extraFloorMattress,
      'bathrooms': bathrooms,
      'kitchenAvailable': kitchenAvailable,
    };
  }
}

class Amenity {
  String name;
  bool isChecked;
  bool isNewAdded;
  String id;

  Amenity({
    required this.name,
    required this.isChecked,
    required this.isNewAdded,
    required this.id,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      name: json['name'],
      isChecked: json['isChecked'],
      isNewAdded: json['isNewAdded'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
      'isNewAdded': isNewAdded,
      '_id': id,
    };
  }
}

class HouseRule {
  String name;
  bool isChecked;
  bool isNewAdded;
  String id;

  HouseRule({
    required this.name,
    required this.isChecked,
    required this.isNewAdded,
    required this.id,
  });

  factory HouseRule.fromJson(Map<String, dynamic> json) {
    return HouseRule(
      name: json['name'],
      isChecked: json['isChecked'],
      isNewAdded: json['isNewAdded'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
      'isNewAdded': isNewAdded,
      '_id': id,
    };
  }
}

class CoverPhoto {
  String publicId;
  String url;

  CoverPhoto({
    required this.publicId,
    required this.url,
  });

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(
      publicId: json['public_id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }
}

class HomestayPhoto {
  String publicId;
  String url;
  String id;

  HomestayPhoto({
    required this.publicId,
    required this.url,
    required this.id,
  });

  factory HomestayPhoto.fromJson(Map<String, dynamic> json) {
    return HomestayPhoto(
      publicId: json['public_id'],
      url: json['url'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
      '_id': id,
    };
  }
}

class Contact {
  String contactNo;
  String id;

  Contact({
    required this.contactNo,
    required this.id,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactNo: json['contactNo'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactNo': contactNo,
      '_id': id,
    };
  }
}

class Email {
  String emailId;
  String id;

  Email({
    required this.emailId,
    required this.id,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      emailId: json['EmailId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmailId': emailId,
      '_id': id,
    };
  }
}
import 'package:dio/dio.dart' as dio;
import '../../../../../api_helper/api_helper.dart';
import '../../../../../api_helper/api_uri.dart';
import '../../../../../api_helper/getit_service.dart';
import '../../../../../services/storage_services.dart';
import '../model/add_properties_model.dart';

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

  // Future<ResponseModel<CityModel>> getCityList() async {
  //   dio.Response? response =
  //   await apiProvider.getData("${apiURLs.baseUrl}${apiURLs.getCityList}");
  //   Map<String, dynamic> data = response?.data;
  //   return ResponseModel<CityModel>.fromJson(data);
  // }

  Future<Homestay> getPreviewPropertiesData() async {
    String? homeStayId = getIt<StorageServices>().getHomeStayId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/$homeStayId",
    );
    Map<String, dynamic> data = response!.data;
    return Homestay.fromJson(data);
  }

}
 import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travellery_mobile/generated/assets.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import 'dart:io';
import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_dialog.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../add_properties_screen/steps/data/model/add_properties_model.dart';
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

  late Property modelData;
  String? imagePath;
  dynamic arguments;

  @override
  void initState() {
    super.initState();
    controller.getPropertiesData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    if (widget.selectedIndex == 1) {
      arguments = Get.arguments;
      modelData = arguments['modelData'];
      imagePath = arguments['imagePath'];
    } else {
      arguments = Get.arguments;
      // if (arguments != null && arguments['model'] is AddPropertiesModel) {
      //   addPropertiesModel = arguments['model'] as AddPropertiesModel;
      // }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(4.w, statusBarHeight + 10, 4.w, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.selectedIndex == 1 ? Strings.done : Strings.preview,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                  const Spacer(),
                  if (widget.selectedIndex == 1) ...[
                    PopupMenuButton<String>(
                      color: AppColors.backgroundColor,
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.textAddProreties,
                      ),
                      onSelected: (value) {
                        if (value == Strings.edit) {
                          controller.currentPage.value = 1;
                          Get.toNamed(Routes.addPropertiesScreen,
                              arguments: {'index': 1});
                        } else if (value == Strings.delete) {
                          CustomDialog.showCustomDialog(
                            context: context,
                            message: Strings.deleteDesc,
                            imageAsset: Assets.imagesDeletedialog,
                            buttonLabel: Strings.resend,
                            changeEmailLabel: Strings.changeEmail,
                            onResendPressed: () {
                              Get.toNamed(Routes.verificationPage);
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 18),
              child: Column(
                children: [
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     onPageChanged: (index, reason) {
                  //       previewController.updateCarouselIndex(index);
                  //     },
                  //     padEnds: false,
                  //     disableCenter: true,
                  //     aspectRatio: 1.6,
                  //     enlargeCenterPage: true,
                  //     autoPlay: true,
                  //     enableInfiniteScroll: false,
                  //     viewportFraction: 1,
                  //   ),
                  //   carouselController: previewController.carouselController,
                  //   items: widget.selectedIndex == 1
                  //       ? buildFallbackImages()
                  //       : controller.imagePaths.map((imagePath) {
                  //           return ClipRRect(
                  //             borderRadius:
                  //                 const BorderRadius.all(AppRadius.radius10),
                  //             child: imagePath != null
                  //                 ? Image.file(File(imagePath),
                  //                     fit: BoxFit.cover)
                  //                 : Container(
                  //                     color: Colors.grey[300],
                  //                   ),
                  //           );
                  //         }).toList(),
                  // ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Obx(
                    () => AnimatedSmoothIndicator(
                      count: controller.imagePaths.length,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: AppColors.buttonColor,
                          dotColor: AppColors.inactiveDotColor,
                          spacing: 2,
                          dotHeight: 5,
                          dotWidth: 5),
                      onDotClicked: (index) {
                        previewController.carouselController.jumpToPage(index);
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
                            color: modelData.statusColor,
                          ),
                          child: Center(
                            child: Text(
                              modelData.status,
                              style: FontManager.regular(12,
                                  color: AppColors.white),
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
                        ? modelData.title
                        : Strings.hiltonViewVilla,
                    style: FontManager.semiBold(28,
                        color: AppColors.textAddProreties),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    widget.selectedIndex == 1
                        ? modelData.location
                        : Strings.newYorkUSA,
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(Strings.doller,
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
          buildTabBarView(),
        ],
      ),
    );
  }

  List<Widget> buildFallbackImages() {
    return [
      ClipRRect(
        borderRadius: const BorderRadius.all(AppRadius.radius10),
        child: imagePath != null
            ? Image.file(File(imagePath!), fit: BoxFit.cover)
            : Image.network(modelData.imageUrl, fit: BoxFit.cover),
      ),
    ];
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

  SliverToBoxAdapter buildTabBarView() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150.h,
        child: TabBarView(
          controller: _tabController,
          children: [
            buildDetailsView(),
            buildContactView(),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsView() {
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
                      Strings.traditional,
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
                      Strings.entirePlace,
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
          buildTimeSection(),
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
            borderRadius: const BorderRadius.all(AppRadius.radius10),
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
            buildHouseRuleItem(Assets.imagesDamageToProretiy, Strings.damageToProperty2),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
 
