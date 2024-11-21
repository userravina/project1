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

class BottomNavigationController extends GetxController{

  var selectedIndex = 0.obs;

  void selectedUpdate(int index) {
    selectedIndex.value = index;
    update();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../profile_pages/view/profile_page.dart';
import '../../traveling_flow/view/home_pages/home_page.dart';
import '../controller/bottom_controller.dart';
import '../../traveling_flow/view/trip_pages/trips_page.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller =
        Get.put(BottomNavigationController());

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeTravelingPage(),
            TripsPage(),
            ProfilePage(),
          ],
        );
      }),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Obx(
              () => buildNavItem(
                index: 0,
                imagePath: controller.selectedIndex.value == 0
                    ? Assets.imagesHomeVector
                    : Assets.imagesBottomHome2,
                label: Strings.home,
                onTap: () => controller.selectedUpdate(0),
              ),
            ),
            Obx(
              () => buildNavItem(
                index: 1,
                imagePath: controller.selectedIndex.value == 1
                    ? Assets.imagesBottomTrip2
                    : Assets.imagesBottomTrip,
                label: Strings.trips,
                onTap: () => controller.selectedUpdate(1),
              ),
            ),
            Obx(
              () => buildNavItem(
                index: 2,
                imagePath: controller.selectedIndex.value == 2
                    ? Assets.imagesBottomProfile2
                    : Assets.imagesBottomProfile,
                label: Strings.profile,
                onTap: () => controller.selectedUpdate(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.4.h,
        width: 111,
        decoration: BoxDecoration(
          color: index ==
                  Get.find<BottomNavigationController>().selectedIndex.value
              ? AppColors.bottomActiveColor
              : Colors.transparent,
          borderRadius: const BorderRadius.all(AppRadius.radius36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 21.sp,
              height: 21.sp,
            ),
            SizedBox(width: 2.w),
            if (index ==
                Get.find<BottomNavigationController>().selectedIndex.value)
              Text(
                label,
                style:
                    FontManager.semiBold(14.sp, color: AppColors.buttonColor),
              ),
          ],
        ),
      ),
    );
  }
}
 import 'package:get/get.dart';
import 'package:travellery_mobile/screen/traveling_flow/data/repository/traveling_repository.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../common_widgets/common_loading_process.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/home_properties_model.dart';

class TravelingHomeController extends GetxController{
  HomeTravelingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();

  Future<void> getYourPropertiesData() async {
    homeProperty = await travelingRepository.getYourProperties(limit: 5);
    if (homeProperty != null && homeProperty!.homestaysData != null) {
      propertiesList = homeProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
    update();
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final singleFetchUserModel = propertiesList[index].id;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
          (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(Routes.detailsYourProperties,
        );
      },
    );
  }

  late HomeStaySingleFetchResponse detailsProperty;

  Future<void> getSingleYourProperties() async {
    detailsProperty =
    await travelingRepository.getSingleFetchYourProperties();
  }

}import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../your_properties_screen/view/your_properties_page.dart';

class TravelingFlow extends GetxController{

  RxInt selectedIndex = 0.obs;

  RxInt  selectedSorting = 1.obs;
  var selectedTypeOfPlace = ''.obs;
  var selectedTypeOfPlaceImage = ''.obs;
  var selectedHomeStayType = ''.obs;

  void onSelectSoring(var index) {
    selectedSorting.value = index;
    update();
  }

  void onSelectHomeStayType(var index) {
    selectedHomeStayType.value = index;
  }

  void selectType(String value,String image) {
    selectedTypeOfPlace.value = value;
    selectedTypeOfPlaceImage.value = image;
  }

   RxList<Property> properties = [

    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.hiltonViewVilla,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller,
      statusColor: AppColors.buttonColor,
      tag: Strings.ecoFriendly,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.delhi,
      status: Strings.defultDoller1,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.jaipur,
      status: Strings.defultDoller2,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.uttarakhand,
      status: Strings.defultDoller3,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.kerela,
      status: Strings.defultDoller4,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.goa,
      status: Strings.defultDoller5,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller6,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
  ].obs;
   RxList<Property> filteredProperties = RxList<Property>();
   RxBool isSearching = false.obs;

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void updateDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
  }

  var adultCount = 1.obs;
  var childCount = 1.obs;
  var infantCount = 1.obs;

  void incrementAdult() => adultCount.value++;
  void decrementAdult() {
    if (adultCount.value > 0) adultCount.value--;
  }

  void incrementChild() => childCount.value++;
  void decrementChild() {
    if (childCount.value > 0) childCount.value--;
  }

  void incrementInfant() => infantCount.value++;
  void decrementInfant() {
    if (infantCount.value > 0) infantCount.value--;
  }
}
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';

class HomeTravelingPropertiesModel {
  String? message;
  List<ReUsedDataModel>? homestaysData;
  int? totalHomestay;

  HomeTravelingPropertiesModel({this.message, this.homestaysData, this.totalHomestay});

  HomeTravelingPropertiesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['HomestaysData'] != null) {
      homestaysData = <ReUsedDataModel>[];
      json['HomestaysData'].forEach((v) {
        homestaysData!.add(ReUsedDataModel.fromJson(v));
      });
    }
    totalHomestay = json['totalHomestay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (homestaysData != null) {
      data['HomestaysData'] = homestaysData!.map((v) => v.toJson()).toList();
    }
    data['totalHomestay'] = totalHomestay;
    return data;
  }
}
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/api_uri.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../services/storage_services.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import 'package:dio/dio.dart' as dio;
import '../model/home_properties_model.dart';

class TravelingRepository{

  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingPropertiesModel> getYourProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchYourProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }
}import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/utils/app_radius.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../../common_widgets/common_button.dart';
import '../../controller/traveling_flow_controller.dart';

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({super.key});

  @override
  State<BookingRequestPage> createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final TravelingFlow controller = Get.put(TravelingFlow());
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.3.h),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.keyboard_arrow_left_rounded,
                          size: 30)),
                  SizedBox(width: 1.w),
                  Text(
                    Strings.checkInOutDate,
                    style: FontManager.medium(20, color: AppColors.black),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Card(
                color: AppColors.white,
                elevation: 3,
                shadowColor: const Color(0xffEEEEEE),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 90,
                        height: 73,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(AppRadius.radius10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.hiltonViewVilla,
                            style: FontManager.semiBold(16,
                                color: AppColors.textAddProreties),
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.newYorkUSA,
                                style: FontManager.regular(12,
                                    color: AppColors.divaide2Color),
                              ),
                              SizedBox(width: 1.4.w),
                              const Icon(Icons.location_on,
                                  color: AppColors.buttonColor),
                            ],
                          ),
                          Text(
                            Strings.entirePlace,
                            style: FontManager.regular(10,
                                color: AppColors.buttonColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.yourBookingDetails,
                style:
                    FontManager.semiBold(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.date,
                style:
                    FontManager.medium(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Text(
                "${controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : ''} - ${controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : ''}",
                style: FontManager.regular(14, color: AppColors.greyText),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.guest,
                style:
                    FontManager.medium(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Row(
                children: [
                  Text(
                    "${controller.adultCount.value} ${Strings.adults}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Container(
                    width: 1.5,
                    height: 3.h,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Text(
                    "${controller.childCount.value} ${Strings.children}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Container(
                    width: 1.5,
                    height: 3.h,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Text(
                    "${controller.infantCount.value} ${Strings.infants}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.priceDetails,
                style:
                    FontManager.semiBold(16, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.defult5Night,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "6,000",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.taxes,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "60",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.serviceFee,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "600",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaideColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.total,
                    style: FontManager.semiBold(14, color: AppColors.black),
                  ),
                  Text(
                    "6,660",
                    style: FontManager.semiBold(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.mealsIncluded,
                style:
                    FontManager.semiBold(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.freeBreakfastLunchDinner,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.cancellationPolicy,
                style:
                    FontManager.semiBold(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.freeCancellationUntil,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRules,
                style:
                    FontManager.semiBold(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRulesDes,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRulesDes2,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                Strings.houseRulesDes3,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.buttonColor,
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
                      });
                    },
                    side: const BorderSide(color: AppColors.texFiledColor),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    flex: 2,
                    child: Text(
                      Strings.confirmPaymentDesc,
                      style: FontManager.regular(10,
                          color: AppColors.texFiledColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              CommonButton(
                title: Strings.confirmPayment,
                onPressed: () {},
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../controller/traveling_flow_controller.dart';

class CheckinoutdatePage extends StatefulWidget {
  const CheckinoutdatePage({super.key});

  @override
  State<CheckinoutdatePage> createState() => _CheckinoutdatePageState();
}

class _CheckinoutdatePageState extends State<CheckinoutdatePage> {
  final TravelingFlow controller = Get.put(TravelingFlow());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.3.h),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.keyboard_arrow_left_rounded,
                        size: 30)),
                SizedBox(width: 1.w),
                Text(
                  Strings.checkInOutDate,
                  style: FontManager.medium(20, color: AppColors.black),
                )
              ],
            ),
            SizedBox(height: 3.h,),
            SizedBox(
              height: 260,
              child: SfDateRangePicker(
                backgroundColor: AppColors.datePickerBackgroundColor,
                rangeSelectionColor: AppColors.selectContainerColor,
                startRangeSelectionColor: AppColors.buttonColor,
                endRangeSelectionColor: AppColors.buttonColor,
                selectionColor: AppColors.buttonColor,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.datePickerBackgroundColor,
                  textStyle: FontManager.regular(16, color: AppColors.black),
                ),
                onSelectionChanged: (args) {
                  if (args.value is PickerDateRange) {
                    final PickerDateRange range = args.value;
                    controller.updateDateRange(
                        range.startDate, range.endDate);
                  }
                },
                selectionMode: DateRangePickerSelectionMode.extendableRange,
                initialSelectedRanges: [
                  PickerDateRange(
                    DateTime.now(),
                    DateTime.now().add(const Duration(days: 1)),
                  ),
                ],
                minDate: DateTime(2020),
                maxDate: DateTime(2025),
              ),
            ),
            SizedBox(height: 1.8.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.defult5Night,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "${controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : ''} - ${controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : ''}",
                    style: FontManager.regular(12, color: AppColors.greyText),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.8.h),
            Text(
              Strings.selectGuest,
              style:
                  FontManager.semiBold(16, color: AppColors.textAddProreties),
            ),
            SizedBox(height: 1.8.h),
            createGuestRow(Strings.adults, Strings.ages14orAbove,
                controller.adultCount),
            SizedBox(height: 1.8.h),
            createDivider(),
            SizedBox(height: 1.8.h),
            createGuestRow(
                Strings.children, Strings.ages2to13, controller.childCount),
            SizedBox(height: 1.8.h),
            createDivider(),
            SizedBox(height: 1.8.h),
            createGuestRow(
                Strings.infants, Strings.under2, controller.infantCount),
            SizedBox(
              height: 6.h,
            ),
            CommonButton(
              title: Strings.nextStep,
              onPressed: () {
                Get.toNamed(Routes.bookingRequestPage);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createGuestRow(String title, String subtitle, RxInt count) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    FontManager.regular(16, color: AppColors.textAddProreties)),
            Text(subtitle,
                style: FontManager.regular(11, color: AppColors.greyText)),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => count.value > 0 ? count.value-- : null,
              child: Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius6),
                  color: AppColors.selectGuestDecColor,
                ),
                child:
                    Center(child: Image.asset(Assets.imagesMinus, width: 15)),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Text("${count.value}")),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => count.value++,
              child: Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius6),
                  color: AppColors.buttonColor,
                ),
                child: const Icon(Icons.add, color: AppColors.white, size: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget createDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      decoration: const BoxDecoration(color: AppColors.greyText),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../../utils/font_manager.dart';
import '../../../add_properties_screen/add_properties_steps/controller/add_properties_controller.dart';
import '../../../add_properties_screen/add_properties_steps/view/common_widget/amenities_and_houserules_custom.dart';
import '../../controller/traveling_flow_controller.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final AddPropertiesController addcontroller =
  Get.put(AddPropertiesController());
  final TravelingFlow controller = Get.put(TravelingFlow());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 7.3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: Text(
                      Strings.filter,
                      style: FontManager.medium(19.4.sp,
                          color: AppColors.textAddProreties),
                    ),
                  ),
                  GestureDetector(onTap: () {
                    Get.back();
                  },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.greyText,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3.9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.priceRange,
                    style: FontManager.medium(18,
                        color: AppColors.textAddProreties),
                  ),
                ],
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Container(
                width: double.infinity,
                height: 74,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(Assets.imagesDefultChart),
                )),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.minimum,
                          style: FontManager.regular(16.1.sp,
                              color: AppColors.textAddProreties),
                        ),
                        SizedBox(height: 0.5.h),
                        Container(
                          width: 110.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: AppColors.borderContainerGriedView),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: TextFormField(
                                    style: FontManager.regular(16,
                                        color: AppColors.textAddProreties),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "₹ 5,00"),
                                    onFieldSubmitted: (value) {
                                      // controller.amenities[index] = value;
                                    },
                                    onChanged: (value) {
                                      // controller.amenities[index] = value;
                                    },
                                  ),
                                ),
                                SizedBox(width: 3.5.w),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.maximum,
                          style: FontManager.regular(16.1.sp,
                              color: AppColors.textAddProreties),
                        ),
                        SizedBox(height: 0.5.h),
                        Container(
                          width: 110.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: AppColors.borderContainerGriedView),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: TextFormField(
                                    style: FontManager.regular(16,
                                        color: AppColors.textAddProreties),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "₹ 2,000"),
                                    onFieldSubmitted: (value) {
                                      // controller.amenities[index] = value;
                                    },
                                    onChanged: (value) {
                                      // controller.amenities[index] = value;
                                    },
                                  ),
                                ),
                                SizedBox(width: 3.5.w),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                Strings.sortByPrice,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () => AmenityAndHouseRulesContainer(
                  imageAsset: Assets.imagesAny,
                  title: Strings.any,
                  isSelected: controller.selectedSorting.value == 0,
                  onSelect: () => controller.onSelectSoring(0),
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => AmenityAndHouseRulesContainer(
                  imageAsset: Assets.imagesLtohighest,
                  title: Strings.lowestToHighest,
                  isSelected: controller.selectedSorting.value == 1,
                  onSelect: () => controller.onSelectSoring(1),
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => AmenityAndHouseRulesContainer(
                  imageAsset: Assets.imagesHToLowest,
                  title: Strings.highestToLowest,
                  isSelected: controller.selectedSorting.value == 2,
                  onSelect: () => controller.onSelectSoring(2),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                Strings.typeOfPlace,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              buildTypeOfPlace(
                title: Strings.entirePlace,
                subtitle: Strings.wholePlacetoGuests,
                imageAsset: Assets.imagesTraditional,
                value: 'entirePlace',
                controller: controller,
              ),
              const SizedBox(height: 20),
              buildTypeOfPlace(
                title: Strings.privateRoom,
                subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
                imageAsset: Assets.imagesPrivateRoom,
                value: 'privateRoom',
                controller: controller,
              ),
              SizedBox(
                height: 3.2.h,
              ),
              Text(
                Strings.homestayType,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              buildTypeOfPlace(
                imageAsset: Assets.imagesTraditional,
                title: Strings.traditional,
                controller: controller,
                value: 'traditional',
                height: 7.6.h,
              ),
              SizedBox(height: 2.h),
              buildTypeOfPlace(
                imageAsset: Assets.imagesBedAndBreakfast2,
                title: Strings.bedAndBreakfast,
                controller: controller,
                value: 'bedAndBreakfast',
                height: 7.6.h,
              ),
              SizedBox(height: 2.h),
              buildTypeOfPlace(
                imageAsset: Assets.imagesUrban2,
                title: Strings.urban,
                controller: controller,
                value: 'urban',
                height: 7.6.h,
              ),
              SizedBox(height: 2.h),
              buildTypeOfPlace(
                imageAsset: Assets.imagesEcoFriendly2,
                title: Strings.ecoFriendly,
                controller: controller,
                value: 'ecoFriendly',
                height: 7.6.h,
              ),
              SizedBox(height: 2.h),
              buildTypeOfPlace(
                imageAsset: Assets.imagesAdvanture2,
                title: Strings.adventure,
                controller: controller,
                value: 'adventure',
                height: 7.6.h,
              ),
              SizedBox(height: 2.h),
              buildTypeOfPlace(
                imageAsset: Assets.imagesLuxury2,
                title: Strings.luxury,
                controller: controller,
                value: 'luxury',
                height: 7.6.h,
              ),
              SizedBox(
                height: 3.2.h,
              ),
              Text(
                Strings.accommodationDetails,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
                  addcontroller.maxGuestsCount),
              SizedBox(height: 2.h),
              buildCustomContainer(Assets.imagesBedRooms, Strings.singleBed,
                  addcontroller.singleBedCount),
              SizedBox(height: 2.h),
              buildCustomContainer(Assets.imagesSingleBed, Strings.bedRooms,
                  addcontroller.bedroomsCount),
              SizedBox(height: 2.h),
              buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed,
                  addcontroller.doubleBedCount),
              SizedBox(height: 2.h),
              buildCustomContainer(Assets.imagesExtraFloor,
                  Strings.extraFloorMattress, addcontroller.extraFloorCount),
              SizedBox(height: 2.h),
              buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms,
                  addcontroller.bathRoomsCount),
              SizedBox(height: 2.h),
              Container(
                width: 100.w,
                height: 7.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                    Obx(() => Checkbox(
                          activeColor: AppColors.buttonColor,
                          value: addcontroller.isKitchenAvailable.value,
                          onChanged: (bool? newValue) {
                            addcontroller.isKitchenAvailable.value =
                                newValue ?? false;
                          },
                          side:
                              const BorderSide(color: AppColors.texFiledColor),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 3.2.h,
              ),
              Text(
                Strings.amenities,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () {
                  return Column(
                    children: [
                      AmenityAndHouseRulesContainer(
                        imageAsset: Assets.imagesWiFi,
                        title: Strings.wiFi,
                        isSelected: addcontroller.selectedAmenities[0],
                        onSelect: () => addcontroller.toggleAmenity(0),
                      ),
                      SizedBox(height: 2.h),
                      AmenityAndHouseRulesContainer(
                        imageAsset: Assets.imagesAirCondioner,
                        title: Strings.airConditioner,
                        isSelected: addcontroller.selectedAmenities[1],
                        onSelect: () => addcontroller.toggleAmenity(1),
                      ),
                      SizedBox(height: 2.h),
                      AmenityAndHouseRulesContainer(
                        imageAsset: Assets.imagesFirAlarm,
                        title: Strings.fireAlarm,
                        isSelected: addcontroller.selectedAmenities[2],
                        onSelect: () => addcontroller.toggleAmenity(2),
                      ),
                      SizedBox(height: 2.h),
                     AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesHometherater,
                          title: Strings.homeTheater,
                          isSelected: addcontroller.selectedAmenities[3],
                          onSelect: () => addcontroller.toggleAmenity(3),
                        ),
                      SizedBox(height: 2.h),
                     AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesMastrSuite,
                          title: Strings.masterSuiteBalcony,
                          isSelected: addcontroller.selectedAmenities[4],
                          onSelect: () => addcontroller.toggleAmenity(4),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 2.4.h),
              const Text(Strings.showMore,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.buttonColor,
                    color: AppColors.buttonColor,
                  )),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        height: 5.9.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,border: Border.all(color: AppColors.buttonColor),
                          borderRadius: BorderRadius.all(AppRadius.radius10),
                        ),
                        child: Center(
                          child: Text(
                            Strings.clearAll,
                            style: FontManager.medium(18, color: AppColors.buttonColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 5.9.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,border: Border.all(color: AppColors.buttonColor),
                          borderRadius: BorderRadius.all(AppRadius.radius10),
                        ),
                        child: Center(
                          child: Text(
                            Strings.submit,
                            style: FontManager.medium(18, color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }

  Widget buildTypeOfPlace({
    required String title,
    String? subtitle,
    required String imageAsset,
    required String value,
    required TravelingFlow controller,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Obx(() {
        bool isSelected;
        height == null
            ? isSelected = controller.selectedTypeOfPlace.value == value
            : isSelected = controller.selectedHomeStayType.value == value;

        return Container(
          width: double.infinity,
          height: height ?? 9.3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectContainerColor : Colors.white,
            borderRadius: const BorderRadius.all(AppRadius.radius10),
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
                  color:
                      isSelected ? AppColors.buttonColor : AppColors.greyText,
                ),
              ),
              subtitle == null
                  ? SizedBox(
                      width: 2.5,
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      title,
                      style: FontManager.regular(16,
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.black),
                    ),
                    SizedBox(height: 2),
                    subtitle == null
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              subtitle,
                              style: FontManager.regular(12,
                                  color: AppColors.greyText),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => Radio(
                    value: value,
                    groupValue: height == null
                        ? controller.selectedTypeOfPlace.value
                        : controller.selectedHomeStayType.value,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        height == null
                            ? controller.selectType(newValue, imageAsset)
                            : controller.onSelectHomeStayType(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/screen/traveling_flow/controller/home_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_properti_card.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';

class HomeTravelingPage extends StatefulWidget {
  const HomeTravelingPage({super.key});

  @override
  State<HomeTravelingPage> createState() => _HomeTravelingPageState();
}

class _HomeTravelingPageState extends State<HomeTravelingPage> {
  final List<Property> properties = [
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.hiltonViewVilla,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller,
      statusColor: AppColors.buttonColor,
      tag: Strings.ecoFriendly,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller1,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller2,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller3,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller4,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller5,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller6,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
  ];

  final destinations = [
    {
      'image': "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.delhi,
    },
    {
      'image': "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.goa,
    },
    {
      'image': "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.jaipur,
    },
    {
      'image': "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.kerela,
    },
    {
      'image': "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.uttarakhand,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(init: TravelingHomeController(), builder: (controller) =>  Column(
          children: [
            buildHeader(),
            const SizedBox(height: 26),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: destinations.map((destination) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 9.4.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(AppRadius.radius10),
                            image: DecorationImage(
                              image: NetworkImage(destination['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14,),
                        Text(
                          destination['label']!,
                          style: FontManager.regular(12, color: AppColors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    Strings.properties,
                    style: FontManager.semiBold(20.sp, color: AppColors.black),
                  ),
                ),
              ],
            ),
      controller.homeProperty == null ?  const Center(child: CircularProgressIndicator()) : Expanded(
              child: ListView.builder(
                itemCount: controller.propertiesList.length,
                itemBuilder: (context, index) {
                  return PropertyCard(
                    coverPhotoUrl:
                    controller.propertiesList[index].coverPhoto!.url!,
                    homestayType:
                    controller.propertiesList[index].homestayType!,
                    title: controller.propertiesList[index].title!,
                    onTap: () => controller.getDetails(index),
                    location: Strings.newYorkUSA,
                    status: controller.propertiesList[index].status!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 190,
      width: 100.w,
      decoration: const BoxDecoration(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.helloJhon,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                  Text(
                    Strings.welcomeToTravelbud,
                    style: FontManager.regular(14,
                        color: AppColors.greyWelcomeToTravelbud),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                Assets.imagesTv,
                width: 42,
                height: 36,
              ),
              SizedBox(width: 4.6.w),
            ],
          ),
          SizedBox(height: 4.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Container(
                height: 6.h,
                width: 75.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius10),
                  color: AppColors.white,
                ),
                child: Center(
                  child: TextField(
                    onTap: () {
                      Get.toNamed(Routes.search);
                    },
                    cursorColor: AppColors.greyText,
                    decoration: InputDecoration(
                      hintText: Strings.search,
                      hintStyle: FontManager.regular(16.sp,
                          color: AppColors.searchTextColor),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.searchIconColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(onTap: () {
                Get.toNamed(Routes.filterPage);
              },
                child: Container(
                  height: 6.h,
                  width: 15.w,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.imagesFilterslines,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
        ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../add_properties_screen/add_properties_steps/controller/add_properties_controller.dart';
import '../../../add_properties_screen/add_properties_steps/view/common_widget/amenities_and_houserules_custom.dart';
import '../../../your_properties_screen/view/your_properties_page.dart';
import '../../controller/traveling_flow_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());
  final TravelingFlow travelingFlowController = Get.put(TravelingFlow());

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    travelingFlowController.filteredProperties
        .addAll(travelingFlowController.properties);
    searchController.addListener(filterProperties);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProperties() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      travelingFlowController.isSearching.value = false;
      travelingFlowController.filteredProperties
          .assignAll(travelingFlowController.properties);
    } else {
      travelingFlowController.isSearching.value = true;
      travelingFlowController.filteredProperties
          .assignAll(travelingFlowController.properties.where((property) {
        return property.location.toLowerCase().contains(query);
      }).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: () {
                  Get.back();
                },child: const Icon(Icons.keyboard_arrow_left_rounded, size: 30)),
                SizedBox(width: 1.w),
                Flexible(
                  flex: 20,
                  child: Container(
                    height: 6.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(AppRadius.radius10),
                      color: AppColors.white,
                    ),
                    child: Center(
                      child: TextField(
                        controller: searchController,
                        cursorColor: AppColors.greyText,
                        decoration: InputDecoration(
                            hintText: Strings.search,
                            hintStyle: FontManager.regular(16.sp,
                                color: AppColors.searchTextColor),
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                Assets.imagesSearchIcon,
                                height: 15,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                            suffixIcon: IconButton(
                              icon: Image.asset(
                                Assets.imagesCloseIcon,
                                height: 22,
                                width: 22,
                              ),
                              onPressed: () {
                                searchController.clear();
                                travelingFlowController.filteredProperties
                                    .assignAll(
                                        travelingFlowController.properties);
                              },
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
           Obx(() =>  travelingFlowController.isSearching.value == true
                ? Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 3.1,
                                                  width: 44,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              AppRadius
                                                                  .radius4),
                                                      color: AppColors
                                                          .bottomCloseDividerColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            Strings.sortByPrice,
                                            style: FontManager.medium(18,
                                                color:
                                                    AppColors.textAddProreties),
                                          ),
                                          const SizedBox(height: 16.0),
                                          Obx(() =>
                                              AmenityAndHouseRulesContainer(
                                                imageAsset: Assets.imagesAny,
                                                title: Strings.any,
                                                isSelected:
                                                    travelingFlowController
                                                            .selectedSorting
                                                            .value ==
                                                        0,
                                                onSelect: () {
                                                  travelingFlowController
                                                      .onSelectSoring(0);
                                                  Navigator.pop(context);
                                                },
                                              )),
                                          const SizedBox(height: 8.0),
                                          Obx(() =>
                                              AmenityAndHouseRulesContainer(
                                                imageAsset:
                                                    Assets.imagesLtohighest,
                                                title: Strings.lowestToHighest,
                                                isSelected:
                                                    travelingFlowController
                                                            .selectedSorting
                                                            .value ==
                                                        1,
                                                onSelect: () {
                                                  travelingFlowController
                                                      .onSelectSoring(1);
                                                  Navigator.pop(context);
                                                },
                                              )),
                                          const SizedBox(height: 8.0),
                                          Obx(() =>
                                              AmenityAndHouseRulesContainer(
                                                imageAsset:
                                                    Assets.imagesHToLowest,
                                                title: Strings.highestToLowest,
                                                isSelected:
                                                    travelingFlowController
                                                            .selectedSorting
                                                            .value ==
                                                        2,
                                                onSelect: () {
                                                  travelingFlowController
                                                      .onSelectSoring(2);
                                                  Navigator.pop(context);
                                                },
                                              )),
                                          const SizedBox(height: 16.0),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 160,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.sortByPrice,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 3.1,
                                                  width: 44,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              AppRadius
                                                                  .radius4),
                                                      color: AppColors
                                                          .bottomCloseDividerColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.5.h,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 74,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(
                                                  Assets.imagesDefultChart),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 2.5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 5.9.h,
                                                    width: 20.w,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors
                                                          .clearContainerColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              AppRadius
                                                                  .radius10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Strings.clearAll,
                                                        style:
                                                            FontManager.regular(
                                                                18,
                                                                color: AppColors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    height: 5.9.h,
                                                    width: 20.w,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.buttonColor,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .buttonColor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(AppRadius
                                                                  .radius10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Strings.apply,
                                                        style:
                                                            FontManager.regular(
                                                                18,
                                                                color: AppColors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 16.0),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 160,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.priceRange,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 3.1,
                                                  width: 44,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              AppRadius
                                                                  .radius4),
                                                      color: AppColors
                                                          .bottomCloseDividerColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            Strings.typeOfPlace,
                                            style: FontManager.medium(18,
                                                color:
                                                    AppColors.textAddProreties),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          buildTypeOfPlace(
                                            title: Strings.entirePlace,
                                            subtitle:
                                                Strings.wholePlacetoGuests,
                                            imageAsset:
                                                Assets.imagesTraditional,
                                            value: 'entirePlace',
                                            controller: travelingFlowController,
                                          ),
                                          const SizedBox(height: 20),
                                          buildTypeOfPlace(
                                            title: Strings.privateRoom,
                                            subtitle: Strings
                                                .guestsSleepInPrivateRoomButSomeAreasAreShared,
                                            imageAsset:
                                                Assets.imagesPrivateRoom,
                                            value: 'privateRoom',
                                            controller: travelingFlowController,
                                          ),
                                          const SizedBox(height: 16.0),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 160,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.typeOfPlace,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:  MediaQuery.of(context).size.height * 0.7,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:

                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 3.1,
                                                  width: 44,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          AppRadius
                                                              .radius4),
                                                      color: AppColors
                                                          .bottomCloseDividerColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            Strings.homestayType,
                                            style: FontManager.medium(18,
                                                color:
                                                    AppColors.textAddProreties),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          buildTypeOfPlace(
                                            imageAsset:
                                                Assets.imagesTraditional,
                                            title: Strings.traditional,
                                            controller: travelingFlowController,
                                            value: 'traditional',
                                            height: 7.6.h,
                                          ),
                                          SizedBox(height: 2.h),
                                          buildTypeOfPlace(
                                            imageAsset:
                                                Assets.imagesBedAndBreakfast2,
                                            title: Strings.bedAndBreakfast,
                                            controller: travelingFlowController,
                                            value: 'bedAndBreakfast',
                                            height: 7.6.h,
                                          ),
                                          SizedBox(height: 2.h),
                                          buildTypeOfPlace(
                                            imageAsset: Assets.imagesUrban2,
                                            title: Strings.urban,
                                            controller: travelingFlowController,
                                            value: 'urban',
                                            height: 7.6.h,
                                          ),
                                          SizedBox(height: 2.h),
                                          buildTypeOfPlace(
                                            imageAsset:
                                                Assets.imagesEcoFriendly2,
                                            title: Strings.ecoFriendly,
                                            controller: travelingFlowController,
                                            value: 'ecoFriendly',
                                            height: 7.6.h,
                                          ),
                                          SizedBox(height: 2.h),
                                          buildTypeOfPlace(
                                            imageAsset: Assets.imagesAdvanture2,
                                            title: Strings.adventure,
                                            controller: travelingFlowController,
                                            value: 'adventure',
                                            height: 7.6.h,
                                          ),
                                          SizedBox(height: 2.h),
                                          buildTypeOfPlace(
                                            imageAsset: Assets.imagesLuxury2,
                                            title: Strings.luxury,
                                            controller: travelingFlowController,
                                            value: 'luxury',
                                            height: 7.6.h,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 125,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.homestayType,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    height: 3.1,
                                                    width: 44,
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            AppRadius
                                                                .radius4),
                                                        color: AppColors
                                                            .bottomCloseDividerColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              Strings.accommodationDetails,
                                              style: FontManager.medium(18,
                                                  color:
                                                  AppColors.textAddProreties),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            buildCustomContainer(
                                                Assets.imagesMaxGuests,
                                                Strings.maxGuests,
                                                controller.maxGuestsCount),
                                            SizedBox(height: 2.h),
                                            buildCustomContainer(
                                                Assets.imagesBedRooms,
                                                Strings.singleBed,
                                                controller.singleBedCount),
                                            SizedBox(height: 2.h),
                                            buildCustomContainer(
                                                Assets.imagesSingleBed,
                                                Strings.bedRooms,
                                                controller.bedroomsCount),
                                            SizedBox(height: 2.h),
                                            buildCustomContainer(
                                                Assets.imagesDubleBed,
                                                Strings.doubleBed,
                                                controller.doubleBedCount),
                                            SizedBox(height: 2.h),
                                            buildCustomContainer(
                                                Assets.imagesExtraFloor,
                                                Strings.extraFloorMattress,
                                                controller.extraFloorCount),
                                            SizedBox(height: 2.h),
                                            buildCustomContainer(
                                                Assets.imagesBathRooms,
                                                Strings.bathRooms,
                                                controller.bathRoomsCount),
                                            SizedBox(height: 2.h),
                                            Container(
                                              width: 100.w,
                                              height: 7.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors
                                                      .borderContainerGriedView,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
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
                                                    style: FontManager.regular(14,
                                                        color: AppColors.black),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  const Spacer(),
                                                  Obx(() => Checkbox(
                                                    activeColor:
                                                    AppColors.buttonColor,
                                                    value: controller
                                                        .isKitchenAvailable
                                                        .value,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      controller
                                                          .isKitchenAvailable
                                                          .value =
                                                          newValue ?? false;
                                                    },
                                                    side: const BorderSide(
                                                        color: AppColors
                                                            .texFiledColor),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16.0),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 190,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.accommodationDetails,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.backgroundColor,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    height: 3.1,
                                                    width: 44,
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                AppRadius
                                                                    .radius4),
                                                        color: AppColors
                                                            .bottomCloseDividerColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              Strings.amenities,
                                              style: FontManager.medium(18,
                                                  color:
                                                      AppColors.textAddProreties),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Obx(
                                              () {
                                                return Column(
                                                  children: [
                                                    AmenityAndHouseRulesContainer(
                                                      imageAsset:
                                                          Assets.imagesWiFi,
                                                      title: Strings.wiFi,
                                                      isSelected: controller
                                                          .selectedAmenities[0],
                                                      onSelect: () => controller
                                                          .toggleAmenity(0),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AmenityAndHouseRulesContainer(
                                                      imageAsset: Assets
                                                          .imagesAirCondioner,
                                                      title:
                                                          Strings.airConditioner,
                                                      isSelected: controller
                                                          .selectedAmenities[1],
                                                      onSelect: () => controller
                                                          .toggleAmenity(1),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AmenityAndHouseRulesContainer(
                                                      imageAsset:
                                                          Assets.imagesFirAlarm,
                                                      title: Strings.fireAlarm,
                                                      isSelected: controller
                                                          .selectedAmenities[2],
                                                      onSelect: () => controller
                                                          .toggleAmenity(2),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AmenityAndHouseRulesContainer(
                                                      imageAsset: Assets
                                                          .imagesHometherater,
                                                      title: Strings.homeTheater,
                                                      isSelected: controller
                                                          .selectedAmenities[3],
                                                      onSelect: () => controller
                                                          .toggleAmenity(3),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AmenityAndHouseRulesContainer(
                                                      imageAsset:
                                                          Assets.imagesMastrSuite,
                                                      title: Strings
                                                          .masterSuiteBalcony,
                                                      isSelected: controller
                                                          .selectedAmenities[4],
                                                      onSelect: () => controller
                                                          .toggleAmenity(4),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 16.0),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 34,
                                width: 115,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(AppRadius.radius6),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      Strings.amenities,
                                      style: FontManager.regular(15.sp,
                                          color: AppColors.textAddProreties),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesDropDaounIcon,
                                      height: 3.h,
                                      width: 2.5.w,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(Assets.imagesLocationIcon,
                              height: 22, width: 22, fit: BoxFit.contain),
                          SizedBox(width: 2.w),
                          Text(Strings.orUseMyCurrentLocation,
                              style: FontManager.regular(15.sp,
                                  color: AppColors.buttonColor)),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.recentSearch,
                              style: FontManager.regular(14,
                                  color: AppColors.greyWelcomeToTravelbud)),
                        ],
                      ),
                    ],
                  ),),
            SizedBox(height: 2.h),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount:
                        travelingFlowController.filteredProperties.length,
                    itemBuilder: (context, index) {
                      return buildPropertyCard(
                          travelingFlowController.filteredProperties[index],
                          index);
                    },
                  )),
            ),
            const SizedBox(height: 15.3),
          ],
        ),
      ),
    );
  }

  Widget buildPropertyCard(Property property, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 35.h,
          width: 100.w,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 21.h,
              //     width: 100.w,
              //     decoration: BoxDecoration(
              //       borderRadius: const BorderRadius.all(AppRadius.radius10),
              //       image: DecorationImage(
              //         image: controller.imagePaths[index] != null
              //             ? FileImage(File(controller.imagePaths[index]!))
              //             : NetworkImage(property.imageUrl),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
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
                      style: FontManager.semiBold(14.sp,
                          color: property.statusColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  property.title,
                  style:
                      FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
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

  Widget buildTypeOfPlace({
    required String title,
    String? subtitle,
    required String imageAsset,
    required String value,
    required TravelingFlow controller,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Obx(() {
        bool isSelected;
        height == null
            ? isSelected = controller.selectedTypeOfPlace.value == value
            : isSelected = controller.selectedHomeStayType.value == value;

        return Container(
          width: double.infinity,
          height: height ?? 9.3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectContainerColor : Colors.white,
            borderRadius: const BorderRadius.all(AppRadius.radius10),
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
                  color:
                      isSelected ? AppColors.buttonColor : AppColors.greyText,
                ),
              ),
              subtitle == null
                  ? const SizedBox(
                      width: 2.5,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      title,
                      style: FontManager.regular(16,
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.black),
                    ),
                    const SizedBox(height: 2),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              subtitle,
                              style: FontManager.regular(12,
                                  color: AppColors.greyText),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => Radio(
                    value: value,
                    groupValue: height == null
                        ? controller.selectedTypeOfPlace.value
                        : controller.selectedHomeStayType.value,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        height == null
                            ? controller.selectType(newValue, imageAsset)
                            : controller.onSelectHomeStayType(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
import 'package:sizer/sizer.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            headerTrip(),
            const SizedBox(height: 26),
            TabBar(
              unselectedLabelColor: AppColors.black,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              unselectedLabelStyle: FontManager.regular(14),
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              labelStyle: FontManager.regular(14, color: AppColors.buttonColor),
              indicatorWeight: 0.5.w,
              tabs: const [
                Tab(text: Strings.upcoming),
                Tab(text: Strings.cancelRefund),
                Tab(text: Strings.completed),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 530,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          2, (index) => customCardTrip("panding")),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children:
                          List.generate(2, (index) => customCardTrip("Cancel")),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          2, (index) => customCardTrip("Completed")),
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

  Widget customCardTrip(String? status) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const ClipOval(
                      child: Image(
                        image: AssetImage(Assets.imagesProfile),
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kristin Martine",
                                style: FontManager.regular(12),
                              ),
                              const Spacer(),
                              Text(
                                status!,
                                style: FontManager.regular(10,
                                    color: status == "panding"
                                        ? AppColors.pendingColor
                                        : status == "Cancel"
                                            ? AppColors.redAccent
                                            : AppColors.buttonColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "2 ${Strings.adults}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                              SizedBox(width: 1.3.h),
                              Container(
                                width: 1.5,
                                height: 1.5.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              SizedBox(width: 1.3.h),
                              Text(
                                "2 ${Strings.children}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                              SizedBox(width: 1.3.h),
                              Container(
                                width: 1.5,
                                height: 1.5.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              SizedBox(width: 1.3.h),
                              Text(
                                "2 ${Strings.infants}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  "Hilton View Villa",
                  style: FontManager.medium(14),
                ),
                SizedBox(height: 1.h),
                Text(
                  "P123456",
                  style: FontManager.regular(10, color: AppColors.buttonColor),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 157,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          "Booking Date",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "04 April 24 06:00 PM",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "Request ID",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "ABCD1234",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Booking Amount",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "\$ 6,66,666",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "Request Date",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "24 Nov 24 06:00 PM",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  "Free Cancellation upto 48 hours before check-in",
                  style: FontManager.regular(12, color: AppColors.buttonColor),
                ),
                SizedBox(height: 1.h),
                Text(
                  Strings.descriptionReadMore,
                  style: FontManager.regular(10, color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerTrip() {
    return Container(
      height: 99,
      width: double.infinity,
      decoration: const BoxDecoration(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.trips,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}


class AccommodationDetails {
  bool? entirePlace;
  bool? privateRoom;
  int? maxGuests;
  int? bedrooms;
  int? singleBed;
  int? doubleBed;
  int? extraFloorMattress;
  int? bathrooms;
  bool? kitchenAvailable;

  AccommodationDetails(
      {this.entirePlace,
        this.privateRoom,
        this.maxGuests,
        this.bedrooms,
        this.singleBed,
        this.doubleBed,
        this.extraFloorMattress,
        this.bathrooms,
        this.kitchenAvailable});

  AccommodationDetails.fromJson(Map<String, dynamic> json) {
    entirePlace = json['entirePlace'];
    privateRoom = json['privateRoom'];
    maxGuests = json['maxGuests'];
    bedrooms = json['bedrooms'];
    singleBed = json['singleBed'];
    doubleBed = json['doubleBed'];
    extraFloorMattress = json['extraFloorMattress'];
    bathrooms = json['bathrooms'];
    kitchenAvailable = json['kitchenAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entirePlace'] = entirePlace;
    data['privateRoom'] = privateRoom;
    data['maxGuests'] = maxGuests;
    data['bedrooms'] = bedrooms;
    data['singleBed'] = singleBed;
    data['doubleBed'] = doubleBed;
    data['extraFloorMattress'] = extraFloorMattress;
    data['bathrooms'] = bathrooms;
    data['kitchenAvailable'] = kitchenAvailable;
    return data;
  }
}

class Amenities {
  String? name;
  bool? isChecked;
  bool? isNewAdded;
  String? sId;

  Amenities({this.name, this.isChecked, this.isNewAdded, this.sId});

  Amenities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
    isNewAdded = json['isNewAdded'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    data['isNewAdded'] = isNewAdded;
    data['_id'] = sId;
    return data;
  }
}

class HouseRules {
  String? name;
  bool? isChecked;
  bool? isNewAdded;
  String? sId;

  HouseRules({this.name, this.isChecked, this.isNewAdded, this.sId});

  HouseRules.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
    isNewAdded = json['isNewAdded'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    data['isNewAdded'] = isNewAdded;
    data['_id'] = sId;
    return data;
  }
}

class CoverPhoto {
  String? publicId;
  String? url;

  CoverPhoto({this.publicId, this.url});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}

class HomestayPhotos {
  String? publicId;
  String? url;
  String? sId;

  HomestayPhotos({this.publicId, this.url, this.sId});

  HomestayPhotos.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}

class HomestayContactNo {
  String? contactNo;
  String? sId;

  HomestayContactNo({this.contactNo, this.sId});

  HomestayContactNo.fromJson(Map<String, dynamic> json) {
    contactNo = json['contactNo'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactNo'] = contactNo;
    data['_id'] = sId;
    return data;
  }
}

class HomestayEmailId {
  String? emailId;
  String? sId;

  HomestayEmailId({this.emailId, this.sId});

  HomestayEmailId.fromJson(Map<String, dynamic> json) {
    emailId = json['EmailId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmailId'] = emailId;
    data['_id'] = sId;
    return data;
  }
}


class CreatedBy {
  ProfileImage? profileImage;
  String? id;
  String? name;
  String? mobile;
  String? email;

  CreatedBy({
    this.profileImage,
    this.id,
    this.name,
    this.mobile,
    this.email,
  });

  CreatedBy.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    id = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['_id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}

class ProfileImage {
  String? publicId;
  String? url;

  ProfileImage({this.publicId, this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}
import 'homestay_reused_model.dart';

class HomeStaySingleFetchResponse {
  String? message;
  ReUsedDataModel? homestayData;

  HomeStaySingleFetchResponse({this.message, this.homestayData});

  HomeStaySingleFetchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    homestayData = json['HomestayData'] != null
        ? ReUsedDataModel.fromJson(json['HomestayData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (homestayData != null) {
      data['HomestayData'] = homestayData!.toJson();
    }
    return data;
  }
}


class ReUsedDataModel {
  AccommodationDetails? accommodationDetails;
  CoverPhoto? coverPhoto;
  String? id;
  String? title;
  String? homestayType;
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
  List<HomestayPhotos>? homestayPhotos;
  String? description;
  int? basePrice;
  int? weekendPrice;
  String? ownerContactNo;
  String? ownerEmailId;
  List<HomestayContactNo>? homestayContactNo;
  List<HomestayEmailId>? homestayEmailId;
  String? status;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;

  ReUsedDataModel({
    this.accommodationDetails,
    this.coverPhoto,
    this.id,
    this.title,
    this.homestayType,
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
    this.createdAt,
    this.updatedAt,
  });

  ReUsedDataModel.fromJson(Map<String, dynamic> json) {
    accommodationDetails = json['accommodationDetails'] != null
        ? AccommodationDetails.fromJson(json['accommodationDetails'])
        : null;
    coverPhoto = json['coverPhoto'] != null
        ? CoverPhoto.fromJson(json['coverPhoto'])
        : null;
    id = json['_id'];
    title = json['title'];
    homestayType = json['homestayType'];
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
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accommodationDetails != null) {
      data['accommodationDetails'] = accommodationDetails!.toJson();
    }
    if (coverPhoto != null) {
      data['coverPhoto'] = coverPhoto!.toJson();
    }
    data['_id'] = id;
    data['title'] = title;
    data['homestayType'] = homestayType;
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
    if (homestayPhotos != null) {
      data['homestayPhotos'] = homestayPhotos!.map((v) => v.toJson()).toList();
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
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';

Widget titleAndIcon({
  required String title,
  required Function() onBackTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 6.h),
      Row(
        children: [
          GestureDetector(
            onTap: onBackTap,
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: FontManager.medium(
              20,
              color: AppColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ],
  );
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common_widgets/common_dialog.dart';
import '../../../../../generated/assets.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isTraveling = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: Column(
        children: [
          headerProfile(),
          SizedBox(height: 3.h),
          Container(
            height: 39,
            width: 70.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.buttonColor),
              borderRadius: const BorderRadius.all(AppRadius.radius10),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTraveling = true;
                    });
                  },
                  child: Container(
                    width: 34.8.w,
                    decoration: BoxDecoration(
                      color:
                          isTraveling ? AppColors.buttonColor : AppColors.white,
                      borderRadius: isTraveling
                          ? const BorderRadius.all(AppRadius.radius10)
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        Strings.traveling,
                        style: FontManager.regular(
                          16,
                          color: isTraveling
                              ? AppColors.white
                              : AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTraveling = false;
                    });
                  },
                  child: Container(
                    width: 34.6.w,
                    decoration: BoxDecoration(
                      color: !isTraveling
                          ? AppColors.buttonColor
                          : AppColors.white,
                      borderRadius: !isTraveling
                          ? const BorderRadius.all(AppRadius.radius10)
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        Strings.hosting,
                        style: FontManager.regular(
                          16,
                          color: !isTraveling
                              ? AppColors.white
                              : AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Strings.additinalSettings,
                          style: FontManager.medium(18,
                              color: AppColors.textAddProreties),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.5.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.contactusPage);
                      },
                      image: Assets.imagesPhoneProfile,
                      title: Strings.contactUs,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.changePasswordPage);
                      },
                      image: Assets.imagesPasswordProfile,
                      title: Strings.changePassword,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.faqsPage);
                      },
                      image: Assets.imagesFaqsProfile,
                      title: Strings.fAQs,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.faqsPage);
                      },
                      image: Assets.imagesLegalProfile,
                      title: Strings.legalAndPrivacy,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.termsAndCondition);
                      },
                      image: Assets.imagesTermsProfile,
                      title: Strings.termsAndConditions,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.feedbackPage);
                      },
                      image: Assets.imagesFeedBackProfile,
                      title: Strings.feedBack,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        Get.toNamed(Routes.aboutUsPage);
                      },
                      image: Assets.imagesAboutProfile,
                      title: Strings.aboutUs,
                    ),
                    SizedBox(height: 1.6.h),
                    additionalSettingsWidgets(
                      onTap: () {
                        CustomDialog.showCustomDialog(
                          context: context,
                          message: Strings.logOutMessage,
                          imageAsset: Assets.imagesLogOutIcon,
                          buttonLabel: Strings.yes,
                          changeEmailLabel: Strings.no,
                          onResendPressed: () {
                            print("xxzzzzzzzzzzzz");
                            // controller.deleteProperties();
                          },
                          onChangeEmailPressed: () {},
                        );
                      },
                      image: Assets.imagesLogOutProfile,
                      title: Strings.logOut,
                    ),
                    SizedBox(height: 1.6.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerProfile() {
    return Container(
      height: 197,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: AppRadius.radius24,
          bottomRight: AppRadius.radius24,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.profile,
                  style: FontManager.medium(20, color: AppColors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editProfilePage);
                  },
                  child: Image.asset(
                    Assets.imagesProfileEdit,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    Assets.imagesDefualtProfile,
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jhon Doe",
                      style: FontManager.medium(16, color: AppColors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "jhondoe123@gmail.com",
                      style: FontManager.regular(12, color: AppColors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "9752348952",
                      style: FontManager.regular(12, color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget additionalSettingsWidgets(
      {String? image, String? title, final Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        child: Row(
          children: [
            SizedBox(width: 3.3.w),
            Image.asset(
              image!,
              height: 20,
              width: 20,
            ),
            SizedBox(width: 3.w),
            Text(
              title!,
              style: FontManager.regular(16),
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
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../../../../utils/textformfield.dart';
import '../../common_widget/title_icon_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.feedBack,
              onBackTap: () => Get.back(),
            ),
            SizedBox(height: 3.h),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const ClipOval(
                        child: Image(
                          image: AssetImage(Assets.imagesProfile),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Kristin Martine",
                                  style: FontManager.regular(18,
                                      color: AppColors.textAddProreties),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "21 September 2023, 12:15 AM",
                                  style: FontManager.regular(12,
                                      color: AppColors.greyText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.feedBack, style: FontManager.regular(16)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    // controller: controller.homeStayTitleController,
                    hintText: Strings.enterFeedBack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.enterFeedBack;
                      }
                      return null;
                    },
                    // onSaved: (value) => controller.homestayTitle.value = value!,
                    // onChanged: (value) => controller.setTitle(value),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Text(
                    Strings.review,
                    style: FontManager.medium(18,
                        color: AppColors.textAddProreties),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Assets.imagesProfile,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Max",
                                  style: FontManager.regular(18,
                                      color: AppColors.textAddProreties),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "01 September 2023, 12:10 AM",
                                  style: FontManager.regular(12,
                                      color: AppColors.greyText),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet consectetur. Porta eget at molestie lobortis consectetur lacus massa.",
                                    style: FontManager.regular(12,
                                        color: AppColors.textAddProreties),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: const BoxDecoration(
                        color: AppColors.borderContainerGriedView),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Assets.imagesProfile,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Max",
                                  style: FontManager.regular(18,
                                      color: AppColors.textAddProreties),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "01 September 2023, 12:10 AM",
                                  style: FontManager.regular(12,
                                      color: AppColors.greyText),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet consectetur. Porta eget at molestie lobortis consectetur lacus massa.",
                                    style: FontManager.regular(12,
                                        color: AppColors.textAddProreties),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            CommonButton(
              title: Strings.submit,
              onPressed: () {},
              backgroundColor: AppColors.buttonColor,
            ),
            SizedBox(
              height: 6.h,
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
import 'package:travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/utils/app_radius.dart';
import 'package:travellery_mobile/utils/font_manager.dart';

import '../../../../../../utils/app_string.dart';
import '../../common_widget/title_icon_widget.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
          titleAndIcon(
          title: Strings.fAQs,
          onBackTap: () => Get.back(),
        ),
        SizedBox(height: 3.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.texFiledColor),
              borderRadius: BorderRadius.all(AppRadius.radius10)),
          child: Column(
            children: [
            ExpansionTile(
            trailing: Icon(Icons.arrow_drop_down_outlined),
            title: Text(
              "What is a Travellery app?",
              style: FontManager.regular(13, color: AppColors.black),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "A travel app is a mobile or web application designed to assist users in planning, booking, and managing their travel experiences.",
                  style:
                  FontManager.regular(10, color: AppColors.black),
                ),
              ),
            ],
          ),
          ],
        ),
      )
      ],
    ),)
    ,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_validation.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../../../../utils/textformfield.dart';
import '../../common_widget/title_icon_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.editProfile,
              onBackTap: () => Get.back(),
            ),
            SizedBox(height: 3.5.h),
            Column(
              children: [
                Center(
                  child: Stack(
                    alignment: const Alignment(1.1, 1.1),
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(Assets.imagesDefualtProfile),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage(Assets.imagesEditcirculer),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Text(Strings.nameLabel, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.nameController,
              hintText: Strings.nameHint,
              prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                  width: 20, height: 20),
              validator: AppValidation.validateName,
              // onSaved: (value) => controller.name.value = value!,
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.emailLabel,
              style: FontManager.regular(14, color: Colors.black),
            ),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.emailController,
              hintText: Strings.emailHint,
              validator: AppValidation.validateEmail,
              // onChanged: (value) => controller.email.value = value,
              prefixIconImage: Image.asset(
                Assets.imagesEmail,
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(height: 3.h),
            Text(Strings.mobileNumberLabel, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.mobileController,
              keyboardType: TextInputType.number,
              hintText: Strings.mobileNumberHint,
              prefixIconImage:
                  Image.asset(Assets.imagesPhone, width: 20, height: 20),
              validator: AppValidation.validateMobile,
              // onSaved: (value) => controller.mobile.value = value!,
            ),
            const Spacer(),
            CommonButton(
              title: Strings.update,
              onPressed: () {},
              backgroundColor: AppColors.buttonColor,
            ),
            SizedBox(
              height: 11.h
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
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_validation.dart';
import '../../../../../../utils/textformfield.dart';
import '../../../../../../utils/font_manager.dart';
import '../../common_widget/title_icon_widget.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  State<ContactusPage> createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.contactUs,
              onBackTap: () => Get.back(),
            ),
            SizedBox(height: 3.5.h),
            Text(Strings.nameLabel, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.nameController,
              hintText: Strings.nameHint,
              prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                  width: 20, height: 20),
              validator: AppValidation.validateName,
              // onSaved: (value) => controller.name.value = value!,
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.emailLabel,
              style: FontManager.regular(14, color: Colors.black),
            ),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.emailController,
              hintText: Strings.emailHint,
              validator: AppValidation.validateEmail,
              // onChanged: (value) => controller.email.value = value,
              prefixIconImage: Image.asset(
                Assets.imagesEmail,
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(height: 3.h),
            Text(Strings.message, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.homeStayTitleController,
              hintText: Strings.enterYourMessage,
              validator: (value) {
                if (value!.isEmpty) {
                  return Strings.enterYourMessage;
                }
                return null;
              },
              // onSaved: (value) => controller.homestayTitle.value = value!,
              // onChanged: (value) => controller.setTitle(value),
            ),
            const Spacer(),
            CommonButton(
              title: Strings.submit,
              onPressed: () {},
              backgroundColor: AppColors.buttonColor,
            ),
            SizedBox(
              height: 11.h,
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
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_validation.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../../../../utils/textformfield.dart';
import '../../common_widget/title_icon_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.changePassword,
              onBackTap: () => Get.back(),
            ),
            SizedBox(height: 3.5.h),
            Text(Strings.currentPassword, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.resetNewPasswordController,
              hintText: Strings.enterYourCurrentPassword,
              prefixIconImage: Image.asset(
                Assets.imagesPassword,
                height: 20,
                width: 20,
              ),
              // obscureText: controller.isResetPasswordVisible.value,
              validator: AppValidation.validatePassword,
              showSuffixIcon: true,
              onSuffixIconPressed: () {
                setState(() {
                  // controller.isResetPasswordVisible.value =
                  // !controller.isResetPasswordVisible.value;
                });
              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.newPasswordLabel, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.resetNewPasswordController,
              hintText: Strings.passwordHint,
              prefixIconImage: Image.asset(
                Assets.imagesPassword,
                height: 20,
                width: 20,
              ),
              // obscureText: controller.isResetPasswordVisible.value,
              validator: AppValidation.validatePassword,
              showSuffixIcon: true,
              onSuffixIconPressed: () {
                setState(() {
                  // controller.isResetPasswordVisible.value =
                  // !controller.isResetPasswordVisible.value;
                });
              },
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.confirmPassword,
              style: FontManager.regular(14),
            ),
            SizedBox(height: 0.5.h),
            CustomTextField(
              // controller: controller.resetConfirmedNewPasswordController,
              hintText: Strings.confirmPasswordHint,
              prefixIconImage: Image.asset(
                Assets.imagesPassword,
                height: 20,
                width: 20,
              ),
              // obscureText: controller.isResetConfirmPasswordVisible.value,
              validator: AppValidation.validatePassword,
              showSuffixIcon: true,
              onSuffixIconPressed: () {
                setState(() {
                  // controller.isResetConfirmPasswordVisible.value =
                  // !controller.isResetConfirmPasswordVisible.value;
                });
              },
            ),
            const Spacer(),
            CommonButton(
              title: Strings.save,
              onPressed: () {},
              backgroundColor: AppColors.buttonColor,
            ),
            SizedBox(
              height: 11.h,
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
import 'package:travellery_mobile/screen/profile_pages/common_widget/title_icon_widget.dart';
import 'package:travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/utils/font_manager.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../utils/app_string.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.aboutUs,
              onBackTap: () => Get.back(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur. Nisl a pellentesque id semper quam donec. Hendrerit eleifend at vel curabitur. Risus morbi adipiscing porttitor et facilisis. Ornare massa at ut morbi felis dui senectus. Cum ac varius sapien id nam nisl. Aliquet lacus vitae bibendum morbi. Id ornare ultricies sit sapien arcu auctor sed pretium. Non lectus egestas consectetur urna viverra tincidunt iaculis lacus donec. Mauris arcu gravida dui mauris nunc mauris blandit. Ut quam augue sodales nibh quis. Eu suspendisse aliquet sed blandit nullam libero. Nunc vivamus non id eleifend ullamcorper. Non malesuada consectetur ante ultrices morbi. Tortor maecenas sed scelerisque fermentum ut quam. Urna enim etiam fames gravida. Mi bibendum volutpat non eget. Ultrices semper sit enim tincidunt. Vitae purus sed in sapien feugiat ac a. Congue sit lacus nulla non nibh facilisi tempor justo. Porttitor augue enim diam netus aliquam ut. Cursus pretium in fringilla gravida. Id habitasse dictum proin feugiat amet elit. Ac gravida et quis diam elementum aliquet. Ante lorem id lacus sit arcu quam gravida in. Tellus mollis malesuada nulla phasellus vitae aliquet risus neque odio. Rhoncus condimentum sagittis at nisl pellentesque sed vitae id. ",
                style: FontManager.regular(12, color: AppColors.black),
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Text(Strings.ownerDetails,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties)),
            SizedBox(height: 2.h),
            Row(
              children: [
                Image.asset(Assets.imagesCallicon, height: 35, width: 35),
                SizedBox(width: 2.w),
                Text(Strings.defultCallNumber,
                    style: FontManager.regular(14, color: AppColors.black)),
              ],
            ),
            SizedBox(height: 1.2.h),
            Row(
              children: [
                Image.asset(Assets.imagesEmailicon, height: 35, width: 35),
                SizedBox(width: 2.w),
                Text(Strings.defultEmail,
                    style: FontManager.regular(14, color: AppColors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/font_manager.dart';

class PropertyCard extends StatelessWidget {
  final String coverPhotoUrl;
  final String homestayType;
  final String status;
  final String title;
  final String location;
  final void Function()? onTap;

  const PropertyCard({
    super.key,
    required this.coverPhotoUrl,
    required this.homestayType,
    required this.status,
    required this.title,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: onTap,
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
                      image: NetworkImage(coverPhotoUrl),
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
                      homestayType,
                      style:
                          FontManager.regular(12, color: AppColors.buttonColor),
                    ),
                    Text(
                      status,
                      style: FontManager.regular(
                        12,
                        color: status == "Pending Approval"
                            ? AppColors.pendingColor
                            : status == "Approved"
                                ? AppColors.approvedColor
                                : AppColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  title,
                  style:
                      FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      location,
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
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:travellery_mobile/screen/traveling_flow/data/repository/traveling_repository.dart';
import '../screen/add_properties_screen/add_properties_steps/data/repository/homestay_repository.dart';
import '../screen/your_properties_screen/data/repository/your_properties_repository.dart';
import '../services/storage_services.dart';
import 'api_helper.dart';
import 'api_uri.dart';
import 'dio_interceptors.dart';
import '../screen/auth_flow/data/repository/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<APIUrls>(() => APIUrls());
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getDioInstance()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<HomeStayRepository>(() => HomeStayRepository());
  getIt.registerLazySingleton<StorageServices>(() => StorageServices());
  getIt.registerLazySingleton<YourPropertiesRepository>(() => YourPropertiesRepository());
  getIt.registerLazySingleton<TravelingRepository>(() => TravelingRepository());

}
import 'package:get/get.dart';
import 'package:travellery_mobile/screen/splash_screen/view/splash_page.dart';
import 'package:travellery_mobile/screen/your_properties_screen/view/details_page/details_page.dart';
import '../screen/add_properties_screen/add_properties_steps/view/add_properties_page.dart';
import '../screen/add_properties_screen/add_properties_steps/view/widget_view/add_new_amenities/add_new_amenities.dart';
import '../screen/add_properties_screen/add_properties_steps/view/widget_view/location_page.dart';
import '../screen/add_properties_screen/add_properties_steps/view/widget_view/new_rules_add/new_rules_add.dart';
import '../screen/add_properties_screen/list_homestay_pages/view/home_list_stay_page.dart';
import '../screen/auth_flow/view/forget_password_pages/reset_page/reset_page.dart';
import '../screen/auth_flow/view/forget_password_pages/verification_page/verification_page.dart';
import '../screen/auth_flow/view/forget_password_pages/forget_page/forget_password.dart';
import '../screen/auth_flow/view/login_page/login_page.dart';
import '../screen/auth_flow/view/signup_page/signup_page.dart';
import '../screen/preview_properties_screen/view/preview_page.dart';
import '../screen/preview_properties_screen/view/terms_and_condition_page.dart';
import '../screen/onboarding_pages/view/onboarding_page.dart';
import '../screen/profile_pages/view/abount_us/aboutUs_page.dart';
import '../screen/profile_pages/view/change_password/changepassword_page.dart';
import '../screen/profile_pages/view/contact_us/contactus_page.dart';
import '../screen/profile_pages/view/edit_profile/edit_profile_page.dart';
import '../screen/profile_pages/view/fAQs/fAQs_page.dart';
import '../screen/profile_pages/view/feed_back/feedBack_page.dart';
import '../screen/traveling_flow/view/booking_request/booking_request_page.dart';
import '../screen/bottom_navigation_bar/view/bottom_view.dart';
import '../screen/traveling_flow/view/checkIn_outedate/checkInOutDate_page.dart';
import '../screen/traveling_flow/view/filter/filter_page.dart';
import '../screen/traveling_flow/view/search/search_page.dart';
import '../screen/your_properties_screen/view/your_properties_page.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String forgetPage = '/forget';
  static const String verificationPage = '/verification';
  static const String resetPage = '/resetPage';
  static const String listHomestayPage1 = '/listHomestayPage1';
  static const String addPropertiesScreen = '/addPropertiesScreen';
  static const String newamenities = '/newamenities';
  static const String newRules = '/newRules';
  static const String location = '/location';
  static const String previewPage = '/previewPage';
  static const String termsAndCondition = '/termsAndCondition';
  static const String yourPropertiesPage = '/yourPropertiesPage';
  static const String detailsYourProperties = '/detailsYourProperties';
  static const String bottomPages = '/bottom';
  static const String filterPage = '/filterPage';
  static const String search = '/search';
  static const String checkInOutDatePage = '/checkInOutDatePage';
  static const String bookingRequestPage = '/bookingRequestPage';
  static const String editProfilePage = '/editProfilePage';
  static const String contactusPage = '/contactusPage';
  static const String changePasswordPage = '/changePasswordPage';
  static const String feedbackPage = '/feedbackPage';
  static const String aboutUsPage = '/aboutUsPage';
  static const String faqsPage = '/faqsPage';

  static List<GetPage> get routes {
    return [
      GetPage(name: splash, page: () => const SplashPage()),
      GetPage(name: onboarding, page: () => const OnboardingPage()),
      GetPage(name: signup, page: () => const SignupPage()),
      GetPage(name: login, page: () => const LoginPage()),
      GetPage(name: forgetPage, page: () => const ForgetPassword()),
      GetPage(
          name: verificationPage, page: () => const VerificationCodeScreen()),
      GetPage(name: resetPage, page: () => const ResetPasswordScreen()),
      GetPage(name: listHomestayPage1, page: () => const ListHomestayPages()),
      GetPage(
          name: addPropertiesScreen,
          page: () => AddPropertiesScreen(index: Get.arguments['index'] ?? 0)),
      GetPage(name: newamenities, page: () => const NewAmenitiesPages()),
      GetPage(name: newRules, page: () => const NewRulesPages()),
      GetPage(name: location, page: () => const LocationView()),
      GetPage(name: previewPage, page: () => const PreviewPage()),
      GetPage(
          name: termsAndCondition, page: () => const TermsAndConditionPage()),
      GetPage(name: yourPropertiesPage, page: () => const YourPropertiesPage()),
      GetPage(name: detailsYourProperties, page: () => const DetailsPage()),
      GetPage(name: bottomPages, page: () => const BottomNavigationPage()),
      GetPage(name: filterPage, page: () => const FilterPage()),
      GetPage(name: search, page: () => const SearchPage()),
      GetPage(name: checkInOutDatePage, page: () => const CheckinoutdatePage()),
      GetPage(name: bookingRequestPage, page: () => const BookingRequestPage()),
      GetPage(name: editProfilePage, page: () => const EditProfilePage()),
      GetPage(name: contactusPage, page: () => const ContactusPage()),
      GetPage(name: changePasswordPage, page: () => const ChangePasswordPage()),
      GetPage(name: feedbackPage, page: () => const FeedbackPage()),
      GetPage(name: aboutUsPage, page: () => const AboutUsPage()),
      GetPage(name: faqsPage, page: () => const FaqsPage()),
    ];
  }
}

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
  static const String traveling = "Traveling";
  static const String hosting = "Hosting";
  static const String additinalSettings = "Additional Settings";
  static const String contactUs = "Contact us";
  static const String changePassword = "Change Password";
  static const String fAQs = "FAQs";
  static const String legalAndPrivacy = "Legal & Privacy";
  static const String termsAndCondition = "Terms & Conditions";
  static const String feedBack = "Feedback";
  static const String aboutUs = "About us";
  static const String logOut = "Logout";
  static const String editProfile = "Edit Profile";
  static const String update = "Update";
  static const String message = "Message";
  static const String enterYourMessage = "Enter your message";
  static const String currentPassword = "Current password";
  static const String enterYourCurrentPassword = "Enter Current password";
  static const String errorYourCurrentPassword = "This current password is incorrect.";
  static const String save = "Save";
  static const String logOutMessage = "Are you sure you want to logout ?";
  static const String enterFeedBack = "Enter your feedback";
  static const String review = "Reviews";
  static const String listing = "Listing";
  static const String payoutDetails = "Payout Details";
}
import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFffffff);
  static const Color white = Color(0xFFffffff);
  static const Color baseWhite = Color(0xFFFAFAFA);
  static const Color black = Colors.black;
  static const Color baseBlack = Color(0xFF0A0A0B);
  static const Color buttonColor = Color(0xFF6C5AD2);
  static const Color greySecondary = Color(0xFFAAB9C5);
  static const Color whiteSmokeSuccess = Color(0xFFA4F4E7);
  static const Color warning = Color(0xFFF4C790);
  static const Color redAccent = Color(0xFFFC6565);
  static const Color primary100 = Color(0xFFE6E3F8);
  static const Color primary200 = Color(0xFFCEC8F0);
  static const Color primary300 = Color(0xFFB6ACE9);
  static const Color primary400 = Color(0xFF9D91E1);
  static const Color primary500 = Color(0xFF8576DA);
  static const Color primary600 = Color(0xFF513BCA);
  static const Color primary700 = Color(0xFF422FAE);
  static const Color primary800 = Color(0xFF37278F);
  static const Color primary900 = Color(0xFF2B1F70);
  static const Color primary1000 = Color(0xFF1F1652);
  static const Color texFiledColor = Color(0xffC4C8CB);
  static const Color greyText = Color(0xffB1B6B9);
  static const Color borderContainerGriedView = Color(0xffECEEF0);
  static const Color yellow = Color(0xffFCCC51);
  static const Color perpalContainer = Color(0xffF7F5FF);
  static const Color textAddProreties = Color(0xff101011);
  static const Color lightPerpul = Color(0xffE7E4FA);
  static const Color buttonEneble = Color(0xffBFB4FC);
  static const Color backgroundYourPropertiesPage = Color(0xfff0f2f6);
  static const Color approvedColor = Color(0xff3ACE3A);
  static const Color pendingColor = Color(0xffF4AC40);
  static const Color rejectedColor = Color(0xffFC6565);
  static const Color inactiveDotColor = Color(0xffE2E5E7);
  static const Color errorTextfieldColor = Color(0xffFF0000);
  static const Color selectContainerColor = Color(0xfff1eeff);
  static const Color editBackgroundColor = Color(0xfff7f9ff);
  static const Color deleteBackgroundColor = Color(0xfffef3f5);
  static const Color blueColor = Colors.blue;
  static const Color redColor = Colors.red;
  static const Color greyIconTravelingFlow = Color(0xffA2A2A2);
  static const Color bottomActiveColor = Color(0xFFE5E8F8);
  static const Color greyWelcomeToTravelbud = Color(0xffB6B6B6);
  static const Color searchIconColor = Color(0xff5C5EE9);
  static const Color searchTextColor = Color(0xff677191);
  static const Color bottomCloseDividerColor = Color(0xffD9D9D9);
  static const Color clearContainerColor = Color(0xffF5F5F6);
  static const Color datePickerBackgroundColor = Color(0xffF9F8FF);
  static const Color selectGuestDecColor = Color(0xffF4F2FF);
  static const Color divaideColor = Color(0xffF4F4F4);
  static const Color divaide2Color = Color(0xffE3E3E3);


}



