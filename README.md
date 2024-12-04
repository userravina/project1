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

class HomeTravelingHostingPropertiesModel {
  String? message;
  List<ReUsedDataModel>? homestaysData;
  int? totalHomestay;

  HomeTravelingHostingPropertiesModel({this.message, this.homestaysData, this.totalHomestay});

  HomeTravelingHostingPropertiesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['HomestayData'] != null) {
      homestaysData = <ReUsedDataModel>[];
      json['HomestayData'].forEach((v) {
        homestaysData!.add(ReUsedDataModel.fromJson(v));
      });
    } else if (json['HomestaysData'] != null) {
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
      data['HomestayData'] = homestaysData!.map((v) => v.toJson()).toList();
    }
    data['totalHomestay'] = totalHomestay;
    return data;
  }
}


class HostingHomeController extends GetxController {
  HomeTravelingHostingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  var hostingRepository = getIt<HostingRepository>();
  var apiHelper = getIt<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
    getUserName();
    if (propertiesList.isEmpty) {
      getHostingData();
    }
  }
  RxString? getUserId = ''.obs;
  void getUserName(){
    getUserId?.value = getIt<StorageServices>().getUserName()!;

  }

  Future<void> getHostingData() async {
    homeProperty = await hostingRepository.getHostingProperties();
    if (homeProperty != null && homeProperty!.homestaysData != null) {
      propertiesList = homeProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
    update();
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final String? singleFetchUserModel;
    isSearchingPage.value
        ? singleFetchUserModel = searchFilterList[index].sId
        : singleFetchUserModel = propertiesList[index].sId;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
          (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(
          Routes.hostingDetailsPage,
        );
      },
    );
  }

  HomeStaySingleFetchResponse? detailsProperty;
  ReUsedDataModel? detailsList;

  Future<void> getSingleYourProperties() async {
    detailsProperty = await hostingRepository.getSingleFetchProperties();
    if (detailsProperty != null && detailsProperty!.homestayData != null) {
      detailsList = detailsProperty!.homestayData!;
    } else {
      detailsList = null;
    }
    update();
  }

  void deleteProperties() {
    hostingRepository.deleteData().then(
          (value) async {
        homeProperty = await hostingRepository.getHostingProperties().then(
              (value) {
            Get.back();
            Get.back();
            return null;
          },
        );
      },
    );
    update();
  }

  Rx<HomeTravelingHostingPropertiesModel?> searchFilterProperty = Rx<HomeTravelingHostingPropertiesModel?>(null);
  RxList<ReUsedDataModel> searchFilterList = RxList<ReUsedDataModel>([]);
  RxBool isNoDataFound = false.obs;
  TextEditingController searchController = TextEditingController();
  // search location
  RxDouble sliderValue = 6.0.obs;
  RxBool isSearchingPage = false.obs;
  RxBool mapLoading = true.obs;
  RxBool isLocation = false.obs;

  // filter

  RxDouble minValue = 100.0.obs;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  RxDouble maxValue = 30000.0.obs;
  var showMore = false.obs;
  RxBool state = false.obs;

  void updateShowMore(var value) {
    showMore.value = value;
    update();
  }

  void updateSliderValues() {
    minValue.value = double.tryParse(minPriceController.text) ?? 0.0;
    maxValue.value = double.tryParse(maxPriceController.text) ?? 30000.0;
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

  RxList<bool> selectedAmenities = <bool>[].obs;

  List<String> allAmenities = [];

  void toggleAmenity(int index) {
    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
    }
    update();
  }

  RxList<bool> selectedRules = <bool>[].obs;

  List<String> allRules = [];

  void toggleRules(int index) {
    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
    }
    update();
  }

  RxInt selectedIndex = 0.obs;

  RxInt selectedSorting = 0.obs;
  var selectedTypeOfPlace = ''.obs;
  var selectedHomeStayType = ''.obs;

  void onSelectSoring(var index) {
    selectedSorting.value = index;
    update();
  }

  void onSelectHomeStayType(var index) {
    selectedHomeStayType.value = index;
  }

  void selectType(String value) {
    selectedTypeOfPlace.value = value;
  }

  Map<String, dynamic> getFilters(
      {bool isSearchPage = false, bool isSearchText = false}) {
    Map<String, dynamic> filters = {};

    if (isSearchPage || isSearchText) {
      if (isSearchText) {
        if (state.value == true) {
          filters['homestayName'] = searchController.text;
        }
      } else {
        if (state.value == true) filters['city'] = searchController.text;
      }
    } else {
      filters['minPrice'] = minPriceController.text;
      filters['maxPrice'] = maxPriceController.text;
      if (selectedHomeStayType.value.isNotEmpty) {
        filters['homestayType'] = selectedHomeStayType.value;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'entirePlace') {
        filters['entirePlace'] = true;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'privateRoom') {
        filters['privatePlace'] = true;
      }
      if (maxGuestsCount.value != 0) {
        filters['maxGuests'] = maxGuestsCount.value;
      }
      if (singleBedCount.value != 0) {
        filters['singleBed'] = singleBedCount.value;
      }
      if (doubleBedCount.value != 0) {
        filters['doubleBed'] = doubleBedCount.value;
      }
      if (extraFloorCount.value != 0) {
        filters['extraFloorMattress'] = extraFloorCount.value;
      }
      if (bathRoomsCount.value != 0) {
        filters['bathrooms'] = bathRoomsCount.value;
      }
      if (isKitchenAvailable.value != false) {
        filters['kitchenAvailable'] = isKitchenAvailable.value;
      }
      if (allAmenities.isNotEmpty) {
        filters['amenities'] = allAmenities.join(',');
      }

      if(selectedSorting.value != 0) filters['sortByPrice'] = selectedSorting.value == 1 ? 'Highest to Lowest' : 'Lowest to Highest';
      if (allRules.isNotEmpty) filters['houseRules'] = allRules.join(',');
    }
    return filters;
  }

  void updateSearch() {
    state.value = true;
    isNoDataFound.value = false;
    searchFilterList.clear();

    fetchFilteredProperties(
      isSearchPage: true,
      isSearchText: true,
    ).then((value) {
      if (searchController.text.isEmpty) {
        state.value = false;
        return;
      }
    }).catchError((error) {
      isNoDataFound.value = true;
    });
  }

  Future<void> fetchFilteredProperties(
      {bool isSearchPage = false, bool isSearchText = false}) async {
    Map<String, dynamic> filters =
    getFilters(isSearchPage: isSearchPage, isSearchText: isSearchText);
    isSearchPage == true
        ? searchFilterProperty.value =
    await hostingRepository.getFilterParams(queryParams: filters)
        : homeProperty =
    await hostingRepository.getFilterParams(queryParams: filters);
    if (isSearchPage) {
      if (searchFilterProperty.value != null &&
          searchFilterProperty.value!.homestaysData != null) {
        searchFilterList.value = searchFilterProperty.value!.homestaysData!;
        isSearchingPage.value = true;
      } else {
        searchFilterList.value = [];
      }
      update();
    } else {
      if (homeProperty != null && homeProperty!.homestaysData != null) {
        propertiesList = homeProperty!.homestaysData!;
        isSearchingPage.value = false;
      } else {
        propertiesList = [];
      }
    }
    update();
  }

  void clearFilters() {
    minPriceController.clear();
    maxPriceController.clear();
    minValue.value = 100.0;
    maxValue.value = 10000.0;
    maxGuestsCount.value = 0;
    singleBedCount.value = 0;
    bedroomsCount.value = 0;
    doubleBedCount.value = 0;
    extraFloorCount.value = 0;
    bathRoomsCount.value = 0;
    isKitchenAvailable.value = false;
    selectedAmenities.clear();
    allAmenities.clear();
    selectedRules.clear();
    selectedTypeOfPlace.value = '';
    selectedHomeStayType.value = '';
    selectedSorting.value = 1;

    update();
  }

  void homeStayAddDataLocally() async {
    getSingleYourProperties().then((value) {
      var homestayData = ReUsedDataModel(
        title: detailsList?.title ?? '',
        homestayType: detailsList?.homestayType ?? '',
        description: detailsList?.description ?? '',
        basePrice: detailsList?.basePrice ?? 0,
        weekendPrice: detailsList?.weekendPrice ?? 0,
        ownerContactNo: detailsList?.ownerContactNo ?? '',
        ownerEmailId: detailsList?.ownerEmailId ?? '',
        homestayContactNo: detailsList?.homestayContactNo ?? [],
        homestayEmailId: detailsList?.homestayEmailId ?? [],
        accommodationDetails: detailsList?.accommodationDetails,
        amenities: detailsList?.amenities ?? [],
        houseRules: detailsList?.houseRules ?? [],
        address: detailsList?.address ?? '',
        street: detailsList?.street ?? '',
        landmark: detailsList?.landmark ?? '',
        city: detailsList?.city ?? '',
        pinCode: detailsList?.pinCode ?? '',
        latitude: detailsList?.latitude ?? 0,
        longitude: detailsList?.longitude ?? 0,
        state: detailsList?.state ?? '',
        showSpecificLocation: detailsList?.showSpecificLocation ?? false,
        coverPhoto: detailsList?.coverPhoto ?? null,
        homestayPhotos: detailsList?.homestayPhotos ?? [],
        checkInTime: detailsList?.checkInTime ?? '',
        checkOutTime: detailsList?.checkOutTime ?? '',
        flexibleCheckIn: detailsList?.flexibleCheckIn ?? false,
        flexibleCheckOut: detailsList?.flexibleCheckOut ?? false,
      );

      Get.toNamed(
        Routes.addPropertiesScreen,
        arguments: {'index': 1, 'homestayData': homestayData},
      );
    },);
  }
}

class HostingRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingHostingPropertiesModel> getHostingProperties() async {
    String? getUserId = getIt<StorageServices>().getUserId();
    print("aaaaaaaaaa$getUserId");
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.hostingGetDataUrl}/$getUserId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingHostingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );

    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> deleteData() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.deleteData(
      "${apiURLs.baseUrl}${apiURLs.propertiesDelete}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return data;
  }

  Future<HomeTravelingHostingPropertiesModel> getFilterParams({
    required Map<String, dynamic> queryParams,
  }) async {
    String? getUserId = getIt<StorageServices>().getUserId();
    String queryString = queryParams.entries
        .map((entry) =>
            '${entry.key}=${Uri.encodeQueryComponent(entry.value.toString())}')
        .join('&');
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.fetchFilterUserUrl}/$getUserId?$queryString",
    );

    Map<String, dynamic> data = response!.data;
    return HomeTravelingHostingPropertiesModel.fromJson(data);
  }
}

class HomeHostingPage extends StatefulWidget {
  const HomeHostingPage({super.key});

  @override
  State<HomeHostingPage> createState() => _HomeHostingPageState();
}

class _HomeHostingPageState extends State<HomeHostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(
        init: HostingHomeController(),
        builder: (controller) => Column(
          children: [
            buildHeader(controller),
            const SizedBox(height: 26),
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
            controller.homeProperty == null
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 1.h),
                      itemCount: controller.propertiesList.length,
                      itemBuilder: (context, index) {
                        int reversedIndex = controller.propertiesList.length - 1 - index ;
                        return PropertyCard(
                          coverPhotoUrl: controller
                                  .propertiesList[reversedIndex].coverPhoto?.url ??
                              '',
                          homestayType:
                              controller.propertiesList[reversedIndex].homestayType!,
                          title: controller.propertiesList[reversedIndex].title!,
                          onTap: () {
                            if (controller.propertiesList[reversedIndex].status ==
                                Strings.draft) {
                              getIt<StorageServices>().setYourPropertiesId(
                                  controller.propertiesList[reversedIndex].sId!);
                              getIt<StorageServices>().getYourPropertiesId();
                            }
                            controller.propertiesList[reversedIndex].status ==
                                    Strings.draft
                                ? controller.homeStayAddDataLocally()
                                : controller.getDetails(reversedIndex);
                          },
                          location: controller.propertiesList[reversedIndex].city ?? '',
                          status: controller.propertiesList[reversedIndex].status!,
                          basePrice:
                              controller.propertiesList[reversedIndex].basePrice ?? 0,
                          weekendPrice:
                              controller.propertiesList[reversedIndex].weekendPrice ??
                                  0,
                          traveling: false,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(HostingHomeController controller) {
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
                    controller.getUserId?.value ?? '',
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
                      Get.toNamed(Routes.searchHosting);
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.filterHostingPage);
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

class SearchHostingPage extends StatefulWidget {
  const SearchHostingPage({super.key});

  @override
  State<SearchHostingPage> createState() => _SearchHostingPageState();
}

class _SearchHostingPageState extends State<SearchHostingPage> {
  double latitude = 51.5074;
  double longitude = -0.1278;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder<HostingHomeController>(
        init: HostingHomeController(),
        builder: (controller) => PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            controller.update();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 7.3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.update();
                          Get.back();
                        },
                        child: const Icon(Icons.keyboard_arrow_left_rounded,
                            size: 30)),
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
                            controller: controller.searchController,
                            onChanged: (value) {
                              if (controller.isLocation.value == true) {
                                if (controller.searchController.text.isEmpty) {
                                  controller.isLocation.value = false;
                                  controller.state.value = false;
                                  controller.mapLoading.value = true;
                                }
                              } else {
                                if (value.isNotEmpty) {
                                  controller.updateSearch();
                                } else {
                                  controller.state.value = false;
                                  controller.isNoDataFound.value = false;
                                }
                              }
                            },
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
                                  if (controller.isLocation.value == true) {
                                    controller.isLocation.value = false;
                                    controller.searchController.clear();
                                    controller.mapLoading.value = true;
                                  } else {
                                    controller.state.value = false;
                                    controller.isNoDataFound.value = false;
                                    controller.searchController.clear();
                                    controller.searchFilterList.clear();
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () => controller.isNoDataFound.value
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Homestay Data Found",
                              style: FontManager.regular(15,
                                  color: AppColors.greyText),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Obx(() => controller.isLocation.value == true
                            ? Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 2.h),
                                      Text(Strings.radius,
                                          style: FontManager.medium(18,
                                              color: AppColors.black)),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${Strings.within} ${controller.sliderValue.value.toInt()} ${Strings.kms}",
                                        style: FontManager.regular(14,
                                            color: AppColors.black),
                                      ),
                                      Obx(() {
                                        return SliderTheme(
                                          data: SliderThemeData(
                                            trackShape: CustomTrackShape(),
                                            thumbShape: const CircleThumbShape(
                                                thumbRadius: 6.5),
                                            trackHeight: 2.5,
                                          ),
                                          child: Slider(
                                            value: controller.sliderValue.value,
                                            min: 1,
                                            max: 20,
                                            activeColor: AppColors.buttonColor,
                                            inactiveColor:
                                                AppColors.sliderInactiveColor,
                                            onChanged: (double newValue) {
                                              controller.sliderValue.value =
                                                  newValue;
                                            },
                                            semanticFormatterCallback:
                                                (double newValue) {
                                              return '${newValue.round()}';
                                            },
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 10),
                                      CommonButton(
                                        backgroundColor: AppColors.lightPerpul,
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          String location = controller
                                              .searchController.text
                                              .trim();
                                          if (location.isNotEmpty) {
                                            try {
                                              List<Location> locations =
                                                  await locationFromAddress(
                                                      location);
                                              if (locations.isNotEmpty) {
                                                print("aaaaaaaaaaa${latitude}");
                                                print(
                                                    "aaaaaaaaaaa${longitude}");

                                                setState(() {
                                                  latitude =
                                                      locations.first.latitude;
                                                  longitude =
                                                      locations.first.longitude;
                                                  print(
                                                      "aaaaaaaaaaa111111${latitude}");
                                                  print(
                                                      "aaaaaaaaaaa111111${longitude}");
                                                });
                                              }
                                            } catch (e) {
                                              print("Error: $e");
                                            }
                                          }

                                          controller.mapLoading.value = false;
                                        },
                                        title: Strings.search,
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Obx(
                                            () => controller.mapLoading.value
                                                ? Center(child: Container())
                                                : FlutterMap(
                                                    options: MapOptions(
                                                      initialCenter:
                                                          LatLng.LatLng(
                                                              latitude,
                                                              longitude),
                                                      initialZoom: 10.0,
                                                    ),
                                                    children: [
                                                      TileLayer(
                                                        urlTemplate:
                                                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                        userAgentPackageName:
                                                            'com.example.app',
                                                      ),
                                                      MarkerLayer(
                                                        markers: [
                                                          Marker(
                                                            rotate: true,
                                                            point:
                                                                LatLng.LatLng(
                                                                    latitude,
                                                                    longitude),
                                                            child: const Icon(
                                                              Icons
                                                                  .location_pin,
                                                              size: 40.0,
                                                              color: AppColors
                                                                  .buttonColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : controller.state.value == true
                                ? controller.searchFilterList.isEmpty
                                    ? const Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      )
                                    : MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .searchFilterList.length,
                                            itemBuilder: (context, index) {
                                              int reversedIndex = controller.searchFilterList.length - 1 - index;

                                              return PropertyCard(
                                                coverPhotoUrl: controller
                                                    .searchFilterList[reversedIndex]
                                                    .coverPhoto?.url ?? '',
                                                homestayType: controller
                                                    .searchFilterList[reversedIndex]
                                                    .homestayType!,
                                                title: controller
                                                    .searchFilterList[reversedIndex]
                                                    .title!,
                                                onTap: () => controller
                                                    .getDetails(reversedIndex),
                                                location: controller.searchFilterList[reversedIndex].city ?? '',
                                                status: controller.searchFilterList[reversedIndex].status!,
                                                basePrice:
                                                controller.searchFilterList[reversedIndex].basePrice ?? 0,
                                                weekendPrice:
                                                controller.searchFilterList[reversedIndex].weekendPrice ??
                                                    0,
                                                traveling: false,
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                : controller.homeProperty == null
                                    ? Expanded(
                                        child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return CustomShimmer(
                                            height: 25.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 1.h),
                                          );
                                        },
                                      ))
                                    : Expanded(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 2.h),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.isLocation.value =
                                                      true;
                                                },
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        Assets
                                                            .imagesLocationIcon,
                                                        height: 22,
                                                        width: 22,
                                                        fit: BoxFit.contain),
                                                    SizedBox(width: 2.w),
                                                    Text(
                                                      Strings
                                                          .orUseMyCurrentLocation,
                                                      style:
                                                          FontManager.regular(
                                                              15.sp,
                                                              color: AppColors
                                                                  .buttonColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Strings.recentSearch,
                                                    style: FontManager.regular(
                                                        14,
                                                        color: AppColors
                                                            .greyWelcomeToTravelbud),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: Expanded(
                                                child: ListView.builder(
                                                  itemCount: controller
                                                      .propertiesList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                        int reversedIndex = controller.propertiesList.length - 1 - index;

                                                        return PropertyCard(
                                                          coverPhotoUrl: controller
                                                              .propertiesList[reversedIndex]
                                                              .coverPhoto?.url ?? '',
                                                          homestayType: controller
                                                              .propertiesList[reversedIndex]
                                                              .homestayType!,
                                                          title: controller
                                                              .propertiesList[reversedIndex]
                                                              .title!,
                                                          onTap: () => controller
                                                              .getDetails(reversedIndex),
                                                          location: controller.propertiesList[reversedIndex].city ?? '',
                                                          status: controller.propertiesList[reversedIndex].status!,
                                                          basePrice:
                                                          controller.propertiesList[reversedIndex].basePrice ?? 0,
                                                          weekendPrice:
                                                          controller.propertiesList[reversedIndex].weekendPrice ??
                                                              0,
                                                          traveling: false,
                                                        );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                        ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterHostingPage extends StatefulWidget {
  const FilterHostingPage({super.key});

  @override
  State<FilterHostingPage> createState() => _FilterHostingPageState();
}

class _FilterHostingPageState extends State<FilterHostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<HostingHomeController>(
        init: HostingHomeController(),
        builder: (controller) => Padding(
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
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
                SfRangeSliderTheme(
                  data: const SfRangeSliderThemeData(
                    tooltipBackgroundColor: AppColors.buttonColor,
                    activeTrackColor: AppColors.buttonColor,
                    inactiveTrackColor: AppColors.greyText,
                  ),
                  child: Obx(
                        () => SfRangeSlider(
                      thumbShape: CustomThumbShape(),
                      enableTooltip: true,
                      min: 0,
                      max: 30000,
                      stepSize: 10,
                      interval: 100,
                      values: SfRangeValues(
                          controller.minValue.value, controller.maxValue.value),
                      onChanged: (dynamic values) {
                        double start = values.start as double;
                        double end = values.end as double;
                        String startString = start.toInt().toString();
                        String endString = end.toInt().toString();
                        controller.minValue.value = start;
                        controller.maxValue.value = end;
                        controller.minPriceController.text = startString;
                        controller.maxPriceController.text = endString;
                      },
                    ),
                  ),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.minPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
                                      onFieldSubmitted: (value) {
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 0.0;
                                          controller.minValue.value = newValue;
                                          controller.updateSliderValues();
                                        }
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      controller: controller.maxPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
                                      onFieldSubmitted: (value) {
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 30000.0;
                                          controller.maxValue.value = newValue;
                                          controller.updateSliderValues();
                                        }
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
                  value: Strings.entirePlaceValue,
                  controller: controller,
                ),
                const SizedBox(height: 20),
                buildTypeOfPlace(
                  title: Strings.privateRoom,
                  subtitle:
                  Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
                  imageAsset: Assets.imagesPrivateRoom,
                  value: Strings.privateRoomValue,
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
                    controller.maxGuestsCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesBedRooms, Strings.singleBed,
                    controller.singleBedCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesSingleBed, Strings.bedRooms,
                    controller.bedroomsCount),
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
                      const Spacer(),
                      Obx(() => Checkbox(
                        activeColor: AppColors.buttonColor,
                        value: controller.isKitchenAvailable.value,
                        onChanged: (bool? newValue) {
                          controller.isKitchenAvailable.value =
                              newValue ?? false;
                        },
                        side: const BorderSide(
                            color: AppColors.texFiledColor),
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
                    if (controller.selectedAmenities.length < 5) {
                      controller.selectedAmenities.value =
                          List.generate(5, (_) => false);
                    }
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
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesHometherater,
                          title: Strings.homeTheater,
                          isSelected: controller.selectedAmenities[3],
                          onSelect: () => controller.toggleAmenity(3),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesMastrSuite,
                          title: Strings.masterSuiteBalcony,
                          isSelected: controller.selectedAmenities[4],
                          onSelect: () => controller.toggleAmenity(4),
                        ),
                      ],
                    );
                  },
                ),
                controller.showMore.value == true
                    ? Obx(
                      () {
                    if (controller.selectedRules.length < 4) {
                      controller.selectedRules.value =
                          List.generate(4, (_) => false);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.2.h,
                        ),
                        Text(
                          Strings.rules,
                          style: FontManager.medium(18,
                              color: AppColors.textAddProreties),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesNoSmoking,
                          title: Strings.noSmoking,
                          isSelected: controller.selectedRules[0],
                          onSelect: () => controller.toggleRules(0),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesNoDrinking,
                          title: Strings.noDrinking,
                          isSelected: controller.selectedRules[1],
                          onSelect: () => controller.toggleRules(1),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesNoPet,
                          title: Strings.noPet,
                          isSelected: controller.selectedRules[2],
                          onSelect: () => controller.toggleRules(2),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesDamageToProretiy,
                          title: Strings.damageToProperty,
                          isSelected: controller.selectedRules[3],
                          onSelect: () => controller.toggleRules(3),
                        ),
                      ],
                    );
                  },
                )
                    : const SizedBox.shrink(),
                SizedBox(height: 2.4.h),
                controller.showMore.value == false
                    ? InkWell(
                  onTap: () {
                    controller.updateShowMore(true);
                  },
                  child: const Text(Strings.showMore,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.buttonColor,
                        color: AppColors.buttonColor,
                      )),
                )
                    : const SizedBox.shrink(),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          LoadingProcessCommon().showLoading();
                          controller.clearFilters();
                          controller.getHostingData().then((value) {
                            LoadingProcessCommon().hideLoading();
                            Get.back();
                          },);
                        },
                        child: Container(
                          height: 5.9.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                            const BorderRadius.all(AppRadius.radius10),
                          ),
                          child: Center(
                            child: Text(
                              Strings.clearAll,
                              style: FontManager.medium(18,
                                  color: AppColors.buttonColor),
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
                          LoadingProcessCommon().showLoading();
                          controller.fetchFilteredProperties().then((value) {
                            LoadingProcessCommon().hideLoading();
                            Get.back();
                          },);
                        },
                        child: Container(
                          height: 5.9.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                            const BorderRadius.all(AppRadius.radius10),
                          ),
                          child: Center(
                            child: Text(
                              Strings.submit,
                              style: FontManager.medium(18,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
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
    required HostingHomeController controller,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {
        if (height == null) {
          controller.selectType(value);
        } else {
          controller.onSelectHomeStayType(value);
        }
      },
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
                            ? controller.selectType(newValue)
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

class TravelingHomeController extends GetxController {
  HomeTravelingHostingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  Rx<HomeTravelingHostingPropertiesModel?> searchFilterProperty = Rx<HomeTravelingHostingPropertiesModel?>(null);
  RxList<ReUsedDataModel> searchFilterList = RxList<ReUsedDataModel>([]);
  CityModel? cityProperty;
  RxBool isNoDataFound = false.obs;
  List<HomestayCity> cityPropertiesList = [];
  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();
  RxBool isLocation = false.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUserName();
    if (propertiesList.isEmpty || cityPropertiesList.isEmpty) {
      getTravelingData();
      getCityData();
    }
  }

  RxString? getUserId = ''.obs;
  void getUserName(){
    getUserId?.value = getIt<StorageServices>().getUserName()!;

  }

  Future<void> getTravelingData() async {
    homeProperty = await travelingRepository.getTravelingProperties(limit: 5);
    if (homeProperty != null && homeProperty!.homestaysData != null) {
      propertiesList = homeProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
    update();
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final String? singleFetchUserModel;
    isSearchingPage.value
        ? singleFetchUserModel = searchFilterList[index].sId
        : singleFetchUserModel = propertiesList[index].sId;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(
          Routes.travelingDetailsPage,
        );
      },
    );
  }

  Future<void> getCityData() async {
    cityProperty = await travelingRepository.getCity();
    if (cityProperty != null) {
      cityPropertiesList = cityProperty!.homestayCity;
    } else {
      cityPropertiesList = [];
    }
    update();
  }

  late HomeStaySingleFetchResponse detailsProperty;

  Future<void> getSingleYourProperties() async {
    detailsProperty = await travelingRepository.getSingleFetchProperties();
  }

  // search location
  RxDouble sliderValue = 6.0.obs;
  RxBool isSearchingPage = false.obs;
  RxBool mapLoading = true.obs;

  // filter

  RxDouble minValue = 100.0.obs;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  RxDouble maxValue = 30000.0.obs;
  var showMore = false.obs;
  RxBool state = false.obs;

  void updateShowMore(var value) {
    showMore.value = value;
    update();
  }

  void updateSliderValues() {
    print("sdfsdfsd${maxValue.value}");
    minValue.value = double.tryParse(minPriceController.text) ?? 0.0;
    maxValue.value = double.tryParse(maxPriceController.text) ?? 30000.0;
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

  RxList<bool> selectedAmenities = <bool>[].obs;

  List<String> allAmenities = [];

  void toggleAmenity(int index) {
    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
    }
    update();
  }

  RxList<bool> selectedRules = <bool>[].obs;

  List<String> allRules = [];

  void toggleRules(int index) {
    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
    }
    update();
  }

  RxInt selectedIndex = 0.obs;

  RxInt selectedSorting = 0.obs;
  var selectedTypeOfPlace = ''.obs;
  var selectedHomeStayType = ''.obs;

  void onSelectSoring(var index) {
    selectedSorting.value = index;
    update();
  }

  void onSelectHomeStayType(var index) {
    selectedHomeStayType.value = index;
  }

  void selectType(String value) {
    selectedTypeOfPlace.value = value;
  }

  Map<String, dynamic> getFilters(
      {bool isSearchPage = false, bool isSearchText = false}) {
    Map<String, dynamic> filters = {};

    if (isSearchPage || isSearchText) {
      if (isSearchText) {
        if (state.value == true)
          filters['homestayName'] = searchController.text;
        print("asassssssssssssssssssssssssss${state.value}");
      } else {
        if (state.value == true) filters['city'] = searchController.text;
        print("aaaaaaaaaaaaaa${state.value}");
      }
    } else {
      filters['minPrice'] = minPriceController.text;
      filters['maxPrice'] = maxPriceController.text;
      if (selectedHomeStayType.value.isNotEmpty) {
        filters['homestayType'] = selectedHomeStayType.value;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'entirePlace') {
        filters['entirePlace'] = true;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'privateRoom') {
        filters['privatePlace'] = true;
      }
      if (maxGuestsCount.value != 0) {
        filters['maxGuests'] = maxGuestsCount.value;
      }
      if (singleBedCount.value != 0) {
        filters['singleBed'] = singleBedCount.value;
      }
      if (doubleBedCount.value != 0) {
        filters['doubleBed'] = doubleBedCount.value;
      }
      if (extraFloorCount.value != 0) {
        filters['extraFloorMattress'] = extraFloorCount.value;
      }
      if (bathRoomsCount.value != 0) {
        filters['bathrooms'] = bathRoomsCount.value;
      }
      if (isKitchenAvailable.value != false) {
        filters['kitchenAvailable'] = isKitchenAvailable.value;
      }
      if (allAmenities.isNotEmpty) {
        filters['amenities'] = allAmenities.join(',');
      }

     if(selectedSorting.value != 0) filters['sortByPrice'] = selectedSorting.value == 1 ? 'Highest to Lowest' : 'Lowest to Highest';
      if (allRules.isNotEmpty) filters['houseRules'] = allRules.join(',');
    }
    return filters;
  }

  void updateSearch() {
    state.value = true;
    isNoDataFound.value = false;
    searchFilterList.clear();

    fetchFilteredProperties(
      isSearchPage: true,
      isSearchText: true,
    ).then((value) {
      if (searchController.text.isEmpty) {
        state.value = false;
        return;
      }
    }).catchError((error) {
      print("Error fetching data22: $error");
      isNoDataFound.value = true;
    });
  }

  Future<void> fetchFilteredProperties(
      {bool isSearchPage = false, bool isSearchText = false}) async {
    Map<String, dynamic> filters =
        getFilters(isSearchPage: isSearchPage, isSearchText: isSearchText);
    isSearchPage == true
        ? searchFilterProperty.value =
            await travelingRepository.getFilterParams(queryParams: filters)
        : homeProperty =
            await travelingRepository.getFilterParams(queryParams: filters);

    if (isSearchPage) {
      if (searchFilterProperty.value != null &&
          searchFilterProperty.value!.homestaysData != null) {
        searchFilterList.value = searchFilterProperty.value!.homestaysData!;
        isSearchingPage.value = true;
      } else {
        searchFilterList.value = [];
      }
      update();
    } else {
      if (homeProperty != null && homeProperty!.homestaysData != null) {
        propertiesList = homeProperty!.homestaysData!;
        isSearchingPage.value = false;
      } else {
        propertiesList = [];
      }
    }
    update();
  }

  void clearFilters() {
    minPriceController.clear();
    maxPriceController.clear();
    minValue.value = 100.0;
    maxValue.value = 10000.0;
    maxGuestsCount.value = 0;
    singleBedCount.value = 0;
    bedroomsCount.value = 0;
    doubleBedCount.value = 0;
    extraFloorCount.value = 0;
    bathRoomsCount.value = 0;
    isKitchenAvailable.value = false;
    selectedAmenities.clear();
    allAmenities.clear();
    selectedRules.clear();
    selectedTypeOfPlace.value = '';
    selectedHomeStayType.value = '';
    selectedSorting.value = 1;
    //  state.value = '';
    update();
  }
}

class TravelingRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingHostingPropertiesModel> getTravelingProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingHostingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<HomeTravelingHostingPropertiesModel> getFilterParams({
    required Map<String, dynamic> queryParams,
  }) async {
    String queryString = queryParams.entries
        .map((entry) =>
            '${entry.key}=${Uri.encodeQueryComponent(entry.value.toString())}')
        .join('&');
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}?$queryString",
    );

    Map<String, dynamic> data = response!.data;
    return HomeTravelingHostingPropertiesModel.fromJson(data);
  }

  Future<CityModel> getCity() async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.cityGetUrl}",
    );
    Map<String, dynamic> data = response!.data;
    return CityModel.fromJson(data);
  }

  Future<BookingCreateModel> bookingCreate(
      {required Map<String, dynamic> bookingData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.bookingCreateUrl}",
      data: bookingData,
    );
    Map<String, dynamic> data = response?.data;
    return BookingCreateModel.fromJson(data);
  }

  Future<BookingModel> bookingRead() async {
    String? bookingId = getIt<StorageServices>().getBookingId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.bookingUrl}/$bookingId",
    );
    Map<String, dynamic> data = response!.data;
    return BookingModel.fromJson(data);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import '../generated/assets.dart';
import '../screen/reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/app_string.dart';
import '../utils/font_manager.dart';
import 'common_button.dart';
import 'common_properti_card.dart';
import 'custom_circle_thumb_shape.dart';
import 'custom_track_shape.dart';

class CommonSearchPageWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final double latitude;
  final double longitude;
  final bool isLoading;
  final double minValue;
  final double maxValue;
  final RxBool isNoDataFound;
  final double currentValue;
  final RxBool isLocation;
  final String within;
  final RxDouble sliderValue;
  final RxBool mapLoading;
  final RxBool state;
  final void Function() onPressedButton;
  final void Function()? onTapPropertiCard;
  final RxList<ReUsedDataModel> searchFilterList;
  final ValueChanged<double> onChangedSlider;

  const CommonSearchPageWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.state,
    required this.onChangedSlider,
    required this.latitude,
    required this.longitude,
    required this.onPressedButton,
    required this.isLoading,
    required this.isNoDataFound,
    required this.mapLoading,
    required this.isLocation,
    required this.sliderValue,
    required this.within,
    required this.searchFilterList,
    required this.onTapPropertiCard,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // controller.update();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 7.3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 30,
                  ),
                ),
                SizedBox(width: 1.w),
                Flexible(
                 flex: 20,
                  child: Container(
                    height: 6.h,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(AppRadius.radius10),
                      color: AppColors.white,
                    ),
                    child: Center(
                      child: TextField(
                        controller: controller,
                        onChanged: onChanged,
                        cursorColor: AppColors.greyText,
                        decoration: InputDecoration(
                          hintText: Strings.search,
                          hintStyle: FontManager.regular(
                              16.sp, color: AppColors.searchTextColor),
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
                            onPressed: onClear,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
                () => isNoDataFound.value
                ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Homestay Data Found",
                    style: FontManager.regular(15,
                        color: AppColors.greyText),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                : Obx(() => isLocation.value == true
                ? Expanded(
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text(Strings.radius,
                        style: FontManager.medium(18,
                            color: AppColors.black)),
                    const SizedBox(height: 2),
                    Text(
                      within,
                      style: FontManager.regular(14,
                          color: AppColors.black),
                    ),
                    Obx(() {
                      return SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                          thumbShape: const CircleThumbShape(
                              thumbRadius: 6.5),
                          trackHeight: 2.5,
                        ),
                        child: Slider(
                          value: sliderValue.value,
                          min: 1,
                          max: 20,
                          activeColor: AppColors.buttonColor,
                          inactiveColor:
                          AppColors.sliderInactiveColor,
                          onChanged: (double newValue) {
                           sliderValue.value = newValue;
                          },
                          semanticFormatterCallback:
                              (double newValue) {
                            return '${newValue.round()}';
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    CommonButton(
                      backgroundColor: AppColors.lightPerpul,
                      onPressed: onPressedButton,
                      title: Strings.search,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)),
                        child: Obx(
                              () => mapLoading.value
                              ? Center(child: Container())
                              : FlutterMap(
                            options: MapOptions(
                              initialCenter:
                              LatLng(
                                  latitude,
                                  longitude),
                              initialZoom: 10.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName:
                                'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    rotate: true,
                                    point:
                                    LatLng(
                                        latitude,
                                        longitude),
                                    child: const Icon(
                                      Icons
                                          .location_pin,
                                      size: 40.0,
                                      color: AppColors
                                          .buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : state.value == true
                ? searchFilterList.isEmpty
                ? const Expanded(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
                : MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:searchFilterList.length,
                  itemBuilder: (context, index) {
                    return PropertyCard(
                      coverPhotoUrl:searchFilterList[index]
                          .coverPhoto!
                          .url!,
                      homestayType: searchFilterList[index]
                          .homestayType!,
                      title: searchFilterList[index]
                          .title!,
                      onTap: onTapPropertiCard,
                      location: Strings.newYorkUSA,
                      status: searchFilterList[index]
                          .status!,
                      basePrice: searchFilterList[index]
                          .basePrice!,
                      weekendPrice: searchFilterList[index]
                          .weekendPrice!,
                      traveling: true,
                    );
                  },
                ),
              ),
            )
                : controller.homeProperty == null
                ? Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CustomShimmer(
                      height: 25.h,
                      margin: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.h),
                    );
                  },
                ))
                : Expanded(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w),
                    child: GestureDetector(
                      onTap: () {
                        controller.isLocation.value =
                        true;
                      },
                      child: Row(
                        children: [
                          Image.asset(
                              Assets
                                  .imagesLocationIcon,
                              height: 22,
                              width: 22,
                              fit: BoxFit.contain),
                          SizedBox(width: 2.w),
                          Text(
                            Strings
                                .orUseMyCurrentLocation,
                            style:
                            FontManager.regular(
                                15.sp,
                                color: AppColors
                                    .buttonColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.recentSearch,
                          style: FontManager.regular(
                              14,
                              color: AppColors
                                  .greyWelcomeToTravelbud),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: controller
                            .propertiesList.length,
                        itemBuilder:
                            (context, index) {
                          return PropertyCard(
                            coverPhotoUrl: controller
                                .propertiesList[index]
                                .coverPhoto!
                                .url!,
                            homestayType: controller
                                .propertiesList[index]
                                .homestayType!,
                            title: controller
                                .propertiesList[index]
                                .title!,
                            onTap: () => controller
                                .getDetails(index),
                            location:
                            Strings.newYorkUSA,
                            status: controller
                                .propertiesList[index]
                                .status!,
                            basePrice: controller
                                .propertiesList[index]
                                .basePrice!,
                            weekendPrice: controller
                                .propertiesList[index]
                                .weekendPrice!,
                            traveling: true,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )

            ),
          )
        ],
      ),
    );
  }
}
