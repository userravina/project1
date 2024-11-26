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

class APIUrls{

  String baseUrl = "https://travellery-backend.onrender.com";
  String signupUrl = "/user/signup";
  String loginUrl = "/user/login";
  String googleRegisterUrl = "/user/google-registration/";
  String forgePasswordUrl = "/user/forgot-password";
  String userGetUrl = "/user";
  String verifyUrl = "/user/verfify-otp";
  String resetPasswordUrl = "/user/reset-password";
  String homeStayCreateUrl = "/homestay/create";
  String homeStayUrl = "/homestay";
  String propertiesDelete = "/homestay/DeleteHomestay";
  String hostingGetDataUrl = "/homestay/UserHomestay";
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
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  title,
                  style:
                      FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0,right: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      location,
                      style: FontManager.regular(12, color: AppColors.greyText),
                    ),
Spacer(),
                    traveling == true ?    RichText(
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
                    ):SizedBox.shrink(),
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

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../generated/assets.dart';
import '../screen/preview_properties_screen/controller/preview_properties_controller.dart';
import '../screen/reuseble_flow/data/model/homestay_reused_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/app_string.dart';
import '../utils/font_manager.dart';
import 'common_button.dart';
import 'common_dialog.dart';

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
                            ? print("sdbfshdfgshgdfghjdgfsdgfhsgdf")
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
                          onChangeEmailPressed: () {},
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
                  Strings.newYorkUSA,
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

import 'package:flutter/material.dart';
import 'package:travellery_mobile/utils/app_colors.dart';

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = AppColors.sliderInactiveColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.buttonColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
    // TODO: implement paint
  }
}

import 'package:flutter/material.dart';

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile/screen/traveling_flow/data/repository/traveling_repository.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../common_widgets/common_loading_process.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/home_properties_model.dart';

class TravelingHomeController extends GetxController {
  HomeTravelingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  Rx<HomeTravelingPropertiesModel?> searchFilterProperty =
      Rx<HomeTravelingPropertiesModel?>(null);
  RxList<ReUsedDataModel> searchFilterList = RxList<ReUsedDataModel>([]);
  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();
  RxBool isLocation = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (propertiesList.isEmpty) {
      getTravelingData();
    }
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
        ? singleFetchUserModel = searchFilterList[index].id
        : singleFetchUserModel = propertiesList[index].id;
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
  RxDouble maxValue = 10000.0.obs;
  var showMore = false.obs;
  RxString state = ''.obs;

  void updateShowMore(var value) {
    showMore.value = value;
    update();
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

  RxInt selectedSorting = 1.obs;
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

  Map<String, dynamic> getFilters({bool isSearchPage = false}) {
    Map<String, dynamic> filters = {};

    if (isSearchPage) {
      if (state.isNotEmpty) filters['city'] = state.value;
    } else {
      filters['minPrice'] = minPriceController.text;
      filters['maxPrice'] = maxPriceController.text;
      if (selectedHomeStayType.value.isNotEmpty)
        filters['homestayType'] = selectedHomeStayType.value;
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'entirePlace')
        filters['entirePlace'] = true;
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'privateRoom')
        filters['privatePlace'] = true;
      if (maxGuestsCount.value != 0)
        filters['maxGuests'] = maxGuestsCount.value;
      if (singleBedCount.value != 0)
        filters['singleBed'] = singleBedCount.value;
      if (doubleBedCount.value != 0)
        filters['doubleBed'] = doubleBedCount.value;
      if (extraFloorCount.value != 0)
        filters['extraFloorMattress'] = extraFloorCount.value;
      if (bathRoomsCount.value != 0)
        filters['bathrooms'] = bathRoomsCount.value;
      if (isKitchenAvailable.value != false)
        filters['kitchenAvailable'] = isKitchenAvailable.value;
      if (allAmenities.isNotEmpty)
        filters['amenities'] = allAmenities.join(',');
      filters['sortBy'] = selectedSorting.value == 1
          ? 'Highest to Lowest'
          : 'Lowest to Highest';
      if (allRules.isNotEmpty) filters['houseRules'] = allRules.join(',');
      if (state.isNotEmpty) filters['city'] = state.value;
    }
    return filters;
  }

  Future<void> fetchFilteredProperties({bool isSearchPage = false}) async {
    Map<String, dynamic> filters = getFilters(isSearchPage: isSearchPage);
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
    //
    // state.value = '';

    update();
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
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/api_uri.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../services/storage_services.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import 'package:dio/dio.dart' as dio;
import '../model/home_properties_model.dart';

class TravelingRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingPropertiesModel> getTravelingProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<HomeTravelingPropertiesModel> getFilterParams({
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
    return HomeTravelingPropertiesModel.fromJson(data);
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
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.mumbai,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.goa,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.jaipur,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.kerela,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.uttarakhand,
    },
  ];

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: destinations.map((destination) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 14),
                    child: GestureDetector(
                      onTap: () {
                        controller.state.value = destination['label']!;
                        print("zzzzzzzzzzz${controller.state.value}");
                        Get.toNamed(Routes.search,
                            arguments: controller.state.value);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 9.4.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(AppRadius.radius10),
                              image: DecorationImage(
                                image: NetworkImage(destination['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            destination['label']!,
                            style:
                                FontManager.regular(12, color: AppColors.black),
                          ),
                        ],
                      ),
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
            controller.homeProperty == null
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
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
                          basePrice:
                              controller.propertiesList[index].basePrice!,
                          weekendPrice:
                              controller.propertiesList[index].weekendPrice!,
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.searchController.clear();
                      controller.isLocation.value = false;

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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../common_widgets/common_properti_card.dart';
import '../../../../common_widgets/custom_circle_thumb_shape.dart';
import '../../../../common_widgets/custom_track_shape.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../your_properties_screen/view/your_properties_page.dart';
import '../../controller/home_controller.dart';
import '../../controller/traveling_flow_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TravelingHomeController controller = Get.put(TravelingHomeController());
  String? state = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (state != null) {
      controller.searchController.text = state!;
      controller.fetchFilteredProperties(isSearchPage: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          controller.searchFilterList.clear();
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
                        controller.searchFilterList.clear();
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
                            if (value.isNotEmpty) {
                              state = null;
                              controller.searchFilterList.clear();
                              controller.update();
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
                                state = null;
                                controller.searchController.clear();
                                controller.searchFilterList.clear();
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
            Obx(
              () => controller.isLocation.value == true
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Text(Strings.radius,
                              style: FontManager.medium(18,
                                  color: AppColors.black)),
                          const SizedBox(height: 2),
                          Text(
                              "${Strings.within} ${controller.sliderValue.value.toInt()} ${Strings.kms}",
                              style: FontManager.regular(14,
                                  color: AppColors.black)),
                          Obx(() {
                            return SliderTheme(
                              data: SliderThemeData(
                                trackShape: CustomTrackShape(),
                                thumbShape:
                                    const CircleThumbShape(thumbRadius: 6.5),
                                trackHeight: 2.5,
                              ),
                              child: Slider(
                                  value: controller.sliderValue.value,
                                  min: 1,
                                  max: 20,
                                  activeColor: AppColors.buttonColor,
                                  inactiveColor: AppColors.sliderInactiveColor,
                                  onChanged: (double newValue) {
                                    controller.sliderValue.value = newValue;
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()}';
                                  }),
                            );
                          }),
                          const SizedBox(height: 10),
                          CommonButton(
                            onPressed: () {},
                            title: Strings.search,
                          ),
                          const SizedBox(height: 10),
                          // Expanded(
                          //   child: ClipRRect(
                          //     borderRadius: const BorderRadius.all(
                          //       Radius.circular(10),
                          //     ),
                          //     child: Obx(
                          //       () => controller.mapLoading.value
                          //           ? const Center(
                          //               child: CircularProgressIndicator(),
                          //             )
                          //           : Container(),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  : state != null
                      ? controller.searchFilterList.isEmpty
                          ? const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: controller.searchFilterList.length,
                                itemBuilder: (context, index) {
                                  return PropertyCard(
                                    coverPhotoUrl: controller
                                        .searchFilterList[index]
                                        .coverPhoto!
                                        .url!,
                                    homestayType: controller
                                        .searchFilterList[index].homestayType!,
                                    title: controller
                                        .searchFilterList[index].title!,
                                    onTap: () => controller.getDetails(index),
                                    location: Strings.newYorkUSA,
                                    status: controller
                                        .searchFilterList[index].status!,
                                    basePrice: controller
                                        .searchFilterList[index].basePrice!,
                                    weekendPrice: controller
                                        .searchFilterList[index].weekendPrice!,
                                    traveling: true,
                                  );
                                },
                              ),
                            )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            children: [
                              SizedBox(height: 2.h),
                              GestureDetector(
                                onTap: () {
                                  controller.isLocation.value = true;
                                },
                                child: Row(
                                  children: [
                                    Image.asset(Assets.imagesLocationIcon,
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.contain),
                                    SizedBox(width: 2.w),
                                    Text(Strings.orUseMyCurrentLocation,
                                        style: FontManager.regular(15.sp,
                                            color: AppColors.buttonColor)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.recentSearch,
                                      style: FontManager.regular(14,
                                          color: AppColors
                                              .greyWelcomeToTravelbud)),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              const SizedBox(height: 15.3),
                            ],
                          ),
                        ),
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
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:travellery_mobile/screen/traveling_flow/controller/home_controller.dart';
import 'package:travellery_mobile/screen/traveling_flow/view/filter/widget/custom_rage_silder_thumb.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_loading_process.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../../utils/font_manager.dart';
import '../../../add_properties_screen/add_properties_steps/view/common_widget/amenities_and_houserules_custom.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder(
        init: TravelingHomeController(),
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
                      max: 10000,
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
                                      controller: controller.minPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.maxPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
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
                          controller.getTravelingData().then((value) {
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
    required TravelingHomeController controller,
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
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.mumbai,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.goa,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.jaipur,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.kerela,
    },
    {
      'image':
          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      'label': Strings.uttarakhand,
    },
  ];
// today's update:- city and searching According filter done and profile contact us api called and started set location

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
                ? const SizedBox.shrink()
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
                                await controller.fetchFilteredProperties(isSearchPage: true).catchError((error){
                                  print("Error fetching data: $error");
                                  Get.toNamed(Routes.search);
                                  controller.isNoDataFound.value = true;
                                });
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
                                const SizedBox(
                                  height: 14,
                                ),
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
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
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
                          basePrice:
                              controller.propertiesList[index].basePrice!,
                          weekendPrice:
                              controller.propertiesList[index].weekendPrice!,
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.searchController.clear();
                      controller.isLocation.value = false;
                      controller.isNoDataFound.value = false;
                      controller.state.value = false;
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:travellery_mobile/screen/traveling_flow/controller/home_controller.dart';
import 'package:travellery_mobile/screen/traveling_flow/view/filter/widget/custom_rage_silder_thumb.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_loading_process.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../../utils/font_manager.dart';
import '../../../add_properties_screen/add_properties_steps/view/common_widget/amenities_and_houserules_custom.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder(
        init: TravelingHomeController(),
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
                                        // controller.amenities[index] = value;
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 0.0;
                                          controller.minValue.value = newValue;
                                          // Update the slider when the user changes the text input
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
                                        // controller.amenities[index] = value;
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 30000.0;
                                          controller.maxValue.value = newValue;
                                          // Update the slider when the user changes the text input
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
                          controller.getTravelingData().then((value) {
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
    required TravelingHomeController controller,
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../common_widgets/common_properti_card.dart';
import '../../../../common_widgets/custom_circle_thumb_shape.dart';
import '../../../../common_widgets/custom_track_shape.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../common_widgets/accommondation_details.dart';
import '../../../your_properties_screen/view/your_properties_page.dart';
import '../../controller/home_controller.dart';
import '../../controller/traveling_flow_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TravelingHomeController controller = Get.put(TravelingHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          controller.searchFilterList.clear();
          controller.isSearchingPage.value = false;

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
                        controller.isSearchingPage.value = false;
                        controller.searchFilterList.clear();
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
                            if (value.isNotEmpty) {
                              controller.state.value = false;
                              if(controller.searchController.text.isEmpty){

                              }
                              controller.searchFilterList.clear();
                              controller.update();
                            }else{
                              controller.isNoDataFound.value = false;
                              print("nxbncmbxcnvb");
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
                                controller.state.value = false;
                                controller.isNoDataFound.value = false;
                                controller.searchController.clear();
                                controller.searchFilterList.clear();
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
                  : Obx(
                      () => controller.isLocation.value == true
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 2.h),
                                  Text(Strings.radius,
                                      style: FontManager.medium(18,
                                          color: AppColors.black)),
                                  const SizedBox(height: 2),
                                  Text(
                                      "${Strings.within} ${controller.sliderValue.value.toInt()} ${Strings.kms}",
                                      style: FontManager.regular(14,
                                          color: AppColors.black)),
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
                                          }),
                                    );
                                  }),
                                  const SizedBox(height: 10),
                                  CommonButton(
                                    onPressed: () {},
                                    title: Strings.search,
                                  ),
                                  const SizedBox(height: 10),
                                  // Expanded(
                                  //   child: ClipRRect(
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(10),
                                  //     ),
                                  //     child: Obx(
                                  //       () => controller.mapLoading.value
                                  //           ? const Center(
                                  //               child: CircularProgressIndicator(),
                                  //             )
                                  //           : Container(),
                                  //     ),
                                  //   ),
                                  // )
                                ],
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
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            controller.searchFilterList.length,
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
                                                .searchFilterList[index].title!,
                                            onTap: () =>
                                                controller.getDetails(index),
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
                                    )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 2.h),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isLocation.value = true;
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                Assets.imagesLocationIcon,
                                                height: 22,
                                                width: 22,
                                                fit: BoxFit.contain),
                                            SizedBox(width: 2.w),
                                            Text(Strings.orUseMyCurrentLocation,
                                                style: FontManager.regular(
                                                    15.sp,
                                                    color:
                                                        AppColors.buttonColor)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(Strings.recentSearch,
                                              style: FontManager.regular(14,
                                                  color: AppColors
                                                      .greyWelcomeToTravelbud)),
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      const SizedBox(height: 15.3),
                                    ],
                                  ),
                                ),
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
import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String message;
  List<HomestayCity> homestayCity;
  List<dynamic> homestayCityData;
  int totalHomestayCityData;

  CityModel({
    required this.message,
    required this.homestayCity,
    required this.homestayCityData,
    required this.totalHomestayCityData,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    message: json["message"],
    homestayCity: List<HomestayCity>.from(json["homestayCity"].map((x) => HomestayCity.fromJson(x))),
    homestayCityData: List<dynamic>.from(json["homestayCityData"].map((x) => x)),
    totalHomestayCityData: json["totalHomestayCityData"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "homestayCity": List<dynamic>.from(homestayCity.map((x) => x.toJson())),
    "homestayCityData": List<dynamic>.from(homestayCityData.map((x) => x)),
    "totalHomestayCityData": totalHomestayCityData,
  };
}

class HomestayCity {
  Image image;
  String id;
  String city;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  HomestayCity({
    required this.image,
    required this.id,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HomestayCity.fromJson(Map<String, dynamic> json) => HomestayCity(
    image: Image.fromJson(json["image"]),
    id: json["_id"],
    city: json["city"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "image": image.toJson(),
    "_id": id,
    "city": city,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Image {
  String publicId;
  String url;

  Image({
    required this.publicId,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicId: json["public_id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "public_id": publicId,
    "url": url,
  };
}import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile/screen/traveling_flow/data/repository/traveling_repository.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../common_widgets/common_loading_process.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/city_model.dart';
import '../data/model/home_properties_model.dart';

class TravelingHomeController extends GetxController {
  HomeTravelingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  Rx<HomeTravelingPropertiesModel?> searchFilterProperty =
      Rx<HomeTravelingPropertiesModel?>(null);
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
    if (propertiesList.isEmpty || cityPropertiesList.isEmpty) {
      getTravelingData();
      getCityData();
    }
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
        ? singleFetchUserModel = searchFilterList[index].id
        : singleFetchUserModel = propertiesList[index].id;
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

  Map<String, dynamic> getFilters({bool isSearchPage = false}) {
    Map<String, dynamic> filters = {};

    if (isSearchPage) {
      if (state.value == true) filters['city'] = searchController.text;
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
      // filters['sortBy'] = selectedSorting.value == 1
      //     ? 'Highest to Lowest'
      //     : 'Lowest to Highest';
      if (allRules.isNotEmpty) filters['houseRules'] = allRules.join(',');
      if (state.value == true) filters['city'] = state.value;
    }
    return filters;
  }

  Future<void> fetchFilteredProperties({bool isSearchPage = false}) async {
    Map<String, dynamic> filters = getFilters(isSearchPage: isSearchPage);
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
    //
    // state.value = '';

    update();
  }
}
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/api_uri.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../services/storage_services.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import 'package:dio/dio.dart' as dio;
import '../model/city_model.dart';
import '../model/home_properties_model.dart';

class TravelingRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingPropertiesModel> getTravelingProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<HomeTravelingPropertiesModel> getFilterParams({
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
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<CityModel> getCity() async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.cityGetUrl}",
    );
    Map<String, dynamic> data = response!.data;
    return CityModel.fromJson(data);
  }
}

