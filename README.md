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

// name store
  static String userName = "userName";

 getIt<StorageServices>().setUserName(loginModel.user?.name ?? '');
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

controller.getUserId?.value ?? ''
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

  // bottom change tab 
    @override
  void onInit() {
    super.onInit();
    ever(profileCtrl.isTraveling, (bool isTraveling) {
      if (!isTraveling || isTraveling) {
        selectedIndex.value = 0;
      }
    });
  }

  // propertiy card 
  
class PropertyCard extends StatelessWidget {
  final String coverPhotoUrl;
  final String homestayType;
  final String status;
  final String title;
  final String location;
  final int basePrice;
  final int weekendPrice;
  final bool traveling;
  final void Function()? onTap;

  const PropertyCard({
    super.key,
    required this.coverPhotoUrl,
    required this.homestayType,
    required this.status,
    required this.title,
    required this.location,
    required this.basePrice,
    required this.weekendPrice,
    required this.traveling,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 33.2.h,
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
                  height: 20.h,
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
                    traveling == true
                        ? Text(
                      "₹ $basePrice - $weekendPrice",
                      style: FontManager.semiBold(
                        12,
                        color: AppColors.buttonColor,
                      ),
                    )
                        : Text(
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
                padding: const EdgeInsets.only(left: 8.0, top: 3),
                child: Text(
                  title,
                  style:
                  FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 6, left: 4.0, bottom: 8.0, right: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      location,
                      style: FontManager.regular(12, color: AppColors.greyText),
                    ),
                    const Spacer(),
                    traveling == true
                        ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "4k",
                            style: FontManager.regular(12,
                                color: AppColors.greyText),
                          ),
                          TextSpan(
                            style: FontManager.regular(10,
                                color: AppColors.greyText),
                            text: "m away",
                          ),
                        ],
                      ),
                    )
                        : const SizedBox.shrink(),
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

// shimeer add travellery home page

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomShimmer({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.borderRadius = 10.0,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

class HomeTravelingPage extends StatefulWidget {
  const HomeTravelingPage({super.key});

  @override
  State<HomeTravelingPage> createState() => _HomeTravelingPageState();
}

class _HomeTravelingPageState extends State<HomeTravelingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(
        init: TravelingHomeController(),
        builder: (controller) => Column(
          children: [
            buildHeader(controller),
            const SizedBox(height: 26),

            controller.cityProperty == null
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 14),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 9.4.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(AppRadius.radius10),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 10,
                            width: 50,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: controller.cityPropertiesList.map((data) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 14, bottom: 14),
                          child: GestureDetector(
                            onTap: () async {
                              controller.searchController.text = data.city;
                              controller.state.value = true;
                              controller.searchFilterList.clear();
                              controller.isSearchingPage.value = false;
                              controller.isNoDataFound.value = false;
                              controller.isLocation.value = false;
                              controller.mapLoading.value = true;
                              LoadingProcessCommon().showLoading();
                              await controller
                                  .fetchFilteredProperties(isSearchPage: true)
                                  .catchError((error) {
                                LoadingProcessCommon().hideLoading();
                                Get.toNamed(Routes.search);
                                controller.isNoDataFound.value = true;
                              });
                              LoadingProcessCommon().hideLoading();
                              Get.toNamed(Routes.search);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 9.4.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        AppRadius.radius10),
                                    image: DecorationImage(
                                      image: NetworkImage(data.image.url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  data.city,
                                  style: FontManager.regular(12,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

            SizedBox(height: 1.h),

            // Property heading
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
            SizedBox(height: 1.h),

            Expanded(
              child: controller.homeProperty == null
                  ? ListView.builder(
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
              )
                  : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.propertiesList.length,
                itemBuilder: (context, index) {
                  return PropertyCard(
                    coverPhotoUrl: controller.propertiesList[index].coverPhoto!.url!,
                    homestayType: controller.propertiesList[index].homestayType!,
                    title: controller.propertiesList[index].title!,
                    onTap: () => controller.getDetails(index),
                    location: controller.propertiesList[index].city!,
                    status: controller.propertiesList[index].status!,
                    basePrice: controller.propertiesList[index].basePrice!,
                    weekendPrice: controller.propertiesList[index].weekendPrice!,
                    traveling: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(TravelingHomeController controller) {
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.searchController.clear();
                      controller.isLocation.value = false;
                      controller.isNoDataFound.value = false;
                      controller.state.value = false;
                      controller.searchFilterList.clear();
                      controller.isSearchingPage.value = false;
                      controller.mapLoading.value = true;
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
              GestureDetector(
                onTap: () {
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


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double latitude = 51.5074;
  double longitude = -0.1278;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder<TravelingHomeController>(
        init: TravelingHomeController(),
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
                        return PropertyCard(
                          coverPhotoUrl: controller
                              .searchFilterList[index]
                              .coverPhoto!
                              .url!,
                          homestayType: controller
                              .searchFilterList[index]
                              .homestayType!,
                          title: controller
                              .searchFilterList[index]
                              .title!,
                          onTap: () => controller
                              .getDetails(index),
                          location: Strings.newYorkUSA,
                          status: controller
                              .searchFilterList[index]
                              .status!,
                          basePrice: controller
                              .searchFilterList[index]
                              .basePrice!,
                          weekendPrice: controller
                              .searchFilterList[index]
                              .weekendPrice!,
                          traveling: true,
                        );
                      },
                    ),
                  ),
                )
                    : controller.homeProperty == null
                    ?Expanded(
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

                  // Obx(
                  //   () => controller.isSearching.value == false
                  //       ? Expanded(
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 8),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Image.asset(
                  //                   Assets.imagesLocationsearchicon,
                  //                   height: 112,
                  //                   width: 112,
                  //                 ),
                  //                 SizedBox(height: 2.h),
                  //                 Text(
                  //                   Strings.sorryWeCouldnFindAnyStaysNearLocation,
                  //                   style: FontManager.regular(14,
                  //                       color: AppColors.textAddProreties),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //                 SizedBox(height: 1.h),
                  //                 Text(
                  //                   Strings.locationHelpYou,
                  //                   style: FontManager.regular(14,
                  //                       color: AppColors.greyText),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// storage


class StorageServices {
  static String userToken = "userToken";
  static String userId = "userId";
  static String userName = "userName";
  static String yourPropertiesId = "YourPropertiesId";

  static GetStorage storage = GetStorage();

  setUserToken(String? token) {
    storage.write(userToken, token);
  }

  String? getUserData() {
    return storage.read(userToken);
  }

  String getUserToken() {

    String? userData = getUserData();
    print('================ userData=== $userData ========================');
    if (userData != null) {
      print('================ token === $userData ========================');
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

  // add login name
  setUserName(String name) {
    storage.write(userName, name);
  }

  String? getName() {
    return storage.read(userName);
  }
  String? getUserName() {
    String? userName = getName();
    if (userName != null) {
      print('================ id === $userName ========================');
      return userName;
    }
    return "";
  }

  setYourPropertiesId(String id) {
    storage.write(yourPropertiesId, id);
  }

  String? getYourPropertiesIdData() {
    return storage.read(yourPropertiesId);
  }
  String? getYourPropertiesId() {
    String? userData = getYourPropertiesIdData();
    if (userData != null) {
      print('================ yourPropertiesId === $userData ========================');
      return userData;
    }
    return "";
  }
}

// propertiycardWidget

class PropertyCardWidget extends StatelessWidget {
  final double statusBarHeight;
  final String title;
  final String status;
  final String dataTitle;
  final TabController tabController;
  final int basePrice;
  final int weekendPrice;
  final List homestayPhotos;
  final String ownerContactNumber;
  final String ownerEmail;
  final List<HomestayContactNo> homestayContactNoList;
  final List<HomestayEmailId> homestayEmailIdList;
  final String homestayType;
  final String accommodationType;
  final String checkInTime;
  final String checkOutTime;
  final bool flexibleCheckIn;
  final bool flexibleCheckOut;
  final String address;
  final String description;
  final String street;
  final String landmark;
  final String city;
  final String pinCode;
  final String state;
  final String location;
  final bool showSpecificLocation;
  final int maxGuests;
  final int bedrooms;
  final int singleBed;
  final int doubleBed;
  final int extraFloorMattress;
  final int bathrooms;
  final bool kitchenAvailable;
  final void Function()? onPressed;
  final void Function()? onDeleteDetails;
  final bool? detailsHosting;
  final void Function()? onPressedEdit;

  const PropertyCardWidget({
    super.key,
    required this.statusBarHeight,
    required this.title,
    required this.homestayPhotos,
    required this.status,
    required this.dataTitle,
    required this.basePrice,
    required this.weekendPrice,
    required this.tabController,
    required this.ownerContactNumber,
    required this.ownerEmail,
    required this.homestayContactNoList,
    required this.homestayEmailIdList,
    required this.homestayType,
    required this.accommodationType,
    required this.checkOutTime,
    required this.checkInTime,
    required this.location,
    required this.flexibleCheckIn,
    required this.flexibleCheckOut,
    required this.address,
    required this.description,
    required this.maxGuests,
    required this.bedrooms,
    required this.singleBed,
    required this.doubleBed,
    required this.extraFloorMattress,
    required this.bathrooms,
    required this.kitchenAvailable,
    required this.street,
    required this.landmark,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.showSpecificLocation,
    required this.onPressed,
    this.onDeleteDetails,
    this.detailsHosting,
    this.onPressedEdit
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviewPropertiesController());
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.w, statusBarHeight + 3.2.h, 4.w, 10),
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
                  title,
                  style: FontManager.medium(20, color: AppColors.black),
                ),
                const Spacer(),
                if (title == Strings.details) ...[
                  PopupMenuButton<String>(
                    color: AppColors.backgroundColor,
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.textAddProreties,
                    ),
                    onSelected: (value) {
                      if (value == Strings.edit) {
                        detailsHosting == true
                            ? onPressedEdit!()
                            : print("bvbcxvxnbcvbnxcvn");
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
                          onResendPressed: onDeleteDetails,
                          onChangeEmailPressed: () {}, title: '',
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        buildPopupMenuItem(Assets.imagesEdit, Strings.edit,
                            AppColors.editBackgroundColor, AppColors.blueColor),
                        buildPopupMenuItem(
                            Assets.imagesDeleteVector,
                            Strings.delete,
                            AppColors.deleteBackgroundColor,
                            AppColors.redColor),
                      ];
                    },
                  )
                ],
                if (title == Strings.homeStayDetails)
                  Image.asset(
                    Assets.imagesShare,
                    height: 5.h,
                    width: 7.w,
                  ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
            child: Column(
              children: [
                CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        controller.updateCarouselIndex(index);
                      },
                      padEnds: false,
                      disableCenter: true,
                      aspectRatio: 1.6,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                    ),
                    carouselController: controller.carouselController,
                    items: homestayPhotos.map((imagePath) {
                      return ClipRRect(
                        borderRadius:
                        const BorderRadius.all(AppRadius.radius10),
                        child: null != imagePath.url
                            ? (title != Strings.details &&
                            title != Strings.homeStayDetails)
                            ? Image.file(
                          File(imagePath.url!),
                          fit: BoxFit.cover,
                        )
                            : Image.network(imagePath.url!,
                            fit: BoxFit.cover)
                            : Container(
                          color: Colors.grey[300],
                        ),
                      );
                    }).toList()),
                SizedBox(
                  height: 1.5.h,
                ),
                Obx(
                      () => AnimatedSmoothIndicator(
                    count: homestayPhotos.length,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.buttonColor,
                        dotColor: AppColors.inactiveDotColor,
                        spacing: 2,
                        dotHeight: 3.5,
                        dotWidth: 4),
                    onDotClicked: (index) {
                      controller.carouselController.jumpToPage(index);
                    },
                    activeIndex: controller.carouselIndex.value,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                title == Strings.details
                    ? Container(
                  height: 2.7.h,
                  width: 19.6.w,
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(AppRadius.radius4),
                      color: status == "Pending Approval"
                          ? AppColors.pendingColor
                          : status == "Approved"
                          ? AppColors.approvedColor
                          : AppColors.greyText),
                  child: Center(
                    child: Text(
                      status,
                      style:
                      FontManager.regular(12, color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
                title == Strings.details
                    ? const SizedBox(
                  height: 12,
                )
                    : const SizedBox.shrink(),
                Text(
                  dataTitle,
                  style: FontManager.semiBold(28,
                      color: AppColors.textAddProreties),
                ),
                SizedBox(height: 0.2.h),
                Text(
                  location,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
                SizedBox(height: 1.h),
                Text(
                  '\$${NumberFormat("#,###").format(basePrice)} - \$${NumberFormat("#,###").format(weekendPrice)}',
                  style:
                  FontManager.medium(20, color: AppColors.textAddProreties),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 1.h,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
              unselectedLabelColor: AppColors.greyText,
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 0.7.w,
              padding: EdgeInsets.only(top: 2.h),
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              unselectedLabelStyle: FontManager.regular(14),
              labelStyle: FontManager.regular(14, color: AppColors.buttonColor),
              tabs: const [
                Tab(text: Strings.details),
                Tab(text: Strings.contact),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 150.h,
            child: TabBarView(
              controller: tabController,
              children: [
                buildDetailsView(),
                buildContactView(),
              ],
            ),
          ),
        )
      ],
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
                height: 4.h,
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
                      homestayType,
                      style:
                      FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 4.h,
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
                      accommodationType,
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
                        "$bedrooms ${Strings.bedRooms} ",
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
                        "$maxGuests ${Strings.guest} ",
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
                        "$doubleBed ${Strings.doubleBed} ",
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
                        "$singleBed ${Strings.singleBed} ",
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
                        "$bathrooms ${Strings.bathRooms} ",
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
                        "$extraFloorMattress ${Strings.extraFloorMattress} ",
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
                    text: description,
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
          buildTimeSection(),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(),
          SizedBox(height: 2.h),
          CommonButton(
            title: title == Strings.homeStayDetails
                ? Strings.reserve
                : Strings.done,
            onPressed: onPressed,
          ),
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
                  text: description,
                  style: FontManager.regular(12, color: AppColors.black)),
              // TextSpan(
              //   text: Strings.readMore,
              //   style: FontManager.regular(12, color: AppColors.buttonColor),
              //   recognizer: TapGestureRecognizer()
              //     ..onTap = () => Get.toNamed(''),
              // ),
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
            borderRadius: const BorderRadius.all(AppRadius.radius10),
            border: Border.all(color: AppColors.borderContainerGriedView),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTimeItem(Assets.imagesClock, Strings.checkInTime,
                  flexibleCheckIn == true ? Strings.flexible : checkInTime),
              buildTimeSeparator(),
              buildTimeItem(Assets.imagesClock, Strings.checkOutTime,
                  flexibleCheckOut == true ? Strings.flexible : checkOutTime),
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
        Text(address, style: FontManager.regular(12, color: AppColors.black)),
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
          buildContactRow(Assets.imagesCallicon, ownerContactNumber),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon, ownerEmail),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          ...buildContactList(
            homestayContactNoList,
            Assets.imagesCallicon,
          ),
          ...buildContactList(
            homestayEmailIdList,
            Assets.imagesEmailicon,
          ),
          SizedBox(height: 4.h),
          CommonButton(
            title: Strings.done,
            onPressed: onPressed,
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  List<Widget> buildContactList(List<dynamic> contactList, String iconPath) {
    return contactList.map<Widget>((contact) {
      if (contact is HomestayContactNo) {
        return Column(
          children: [
            buildContactRow(iconPath, contact.contactNo!),
            SizedBox(height: 1.h),
          ],
        );
      } else if (contact is HomestayEmailId) {
        return Column(
          children: [
            buildContactRow(iconPath, contact.emailId!),
            SizedBox(height: 1.h),
          ],
        );
      } else {
        return const SizedBox();
      }
    }).toList();
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

// check in checkout controller

class CheckInOutDateController extends GetxController {
  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  var totalNights = 0.obs;

  void updateDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;

    if (start != null && end != null) {
      totalNights.value = end.difference(start).inDays;
    } else {
      totalNights.value = 0;
    }
    update();
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

  void bookingCreatedData() {
    // LoadingProcessCommon().showLoading();
    String? userDetailId = getIt<StorageServices>().getUserId();
    String? homestayDetailId = getIt<StorageServices>().getYourPropertiesId();
    print("aaaaaaaaaaaaaaaaaaaaaaaa${userDetailId}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${homestayDetailId}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${ startDate.value}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${endDate.value}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${adultCount.value}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${childCount.value}");
    print("aaaaaaaaaaaaaaaaaaaaaaaa${infantCount.value}");
    //
    // Map<String, dynamic> data = {
    //   "userDetail": userDetailId,
    //   "homestayDetail": homestayDetailId,
    //   "checkInDate": startDate.value?.toIso8601String(),
    //   "checkOutDate": endDate.value?.toIso8601String(),
    //   "adults": adultCount.value,
    //   "children": childCount.value,
    //   "infants": infantCount.value,
    //   "totalDaysOrNightsPrice": 200000,
    //   "taxes": 500,
    //   "serviceFee": 10000,
    //   "totalAmount": 210500,
    //   "paymentMethod": "CREDIT_CARD",
    //   "paymentStatus": "SUCCESS",
    //   "reservationConfirmed": true,
    // };
    //
    // travelingRepository.bookingCreate(bookingData: data).then(
    //       (value) {
        Get.toNamed(Routes.bookingRequestPage);
        // Get.snackbar("", "Booking Created Successfully!", colorText: AppColors.white);
    //   },
    // );
  }
}

class CheckinoutdatePage extends StatefulWidget {
  const CheckinoutdatePage({super.key});

  @override
  State<CheckinoutdatePage> createState() => _CheckinoutdatePageState();
}

class _CheckinoutdatePageState extends State<CheckinoutdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<CheckInOutDateController>(
        init: CheckInOutDateController(),
        builder: (controller) => Padding(
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
              SizedBox(
                height: 3.h,
              ),
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
              controller.startDate.value == null &&
                      controller.endDate.value == null
                  ? SizedBox.shrink()
                  : Obx(
                      () {
                        String formatDate(DateTime? date) {
                          if (date == null) return '';
                          return DateFormat('dd MMM,yy').format(date);
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.totalNights.value} Nights",
                              style: FontManager.regular(14,
                                  color: AppColors.black),
                            ),
                            Text(
                              "${formatDate(controller.startDate.value)} - ${formatDate(controller.endDate.value)}",
                              style: FontManager.regular(12,
                                  color: AppColors.greyText),
                            ),
                          ],
                        );
                      },
                    ),
              SizedBox(height: 3.8.h),
              Text(
                Strings.selectGuest,
                style:
                    FontManager.semiBold(16, color: AppColors.textAddProreties),
              ),
              SizedBox(height: 1.8.h),
              createGuestRow(
                  Strings.adults, Strings.ages14orAbove, controller.adultCount),
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
                  controller.bookingCreatedData();

                },
              ),
            ],
          ),
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
                decoration: BoxDecoration(
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
// booking controller

class BookingController extends GetxController{

  var travelingRepository = getIt<TravelingRepository>();
  late HomeStaySingleFetchResponse detailsProperty;

  @override
  void onInit() {
    super.onInit();
    getSingleYourProperties();

  }

  Future<void> getSingleYourProperties() async {
    detailsProperty = await travelingRepository.getSingleFetchProperties();
  }


}

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({super.key});

  @override
  State<BookingRequestPage> createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<BookingController>(init: BookingController(),builder: (controller) =>  Padding(
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
                controller.detailsProperty.value!.homestayData == null ? Column() :   Card(
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
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(AppRadius.radius10),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${controller.detailsProperty.value!.homestayData?.coverPhoto?.url}',),
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
                              "${controller.detailsProperty.value!.homestayData?.title}",
                              style: FontManager.semiBold(16,
                                  color: AppColors.textAddProreties),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${controller.detailsProperty.value!.homestayData?.city}",
                                  style: FontManager.regular(12,
                                      color: AppColors.divaide2Color),
                                ),
                                SizedBox(width: 1.4.w),
                                const Icon(Icons.location_on,
                                    color: AppColors.buttonColor),
                              ],
                            ),
                            Text(
                                controller.detailsProperty.value!.homestayData!.accommodationDetails!.entirePlace ==
                                    true
                                    ? Strings.entirePlace
                                    : Strings.privateRoom,
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
                  "{controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : ''} - {controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : ''}",
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
                      "{controller.adultCount.value} ${Strings.adults}",
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
                      "{controller.childCount.value} ${Strings.children}",
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
                      "{controller.infantCount.value} ${Strings.infants}",
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
      ),
    );
  }
}

