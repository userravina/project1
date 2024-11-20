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

https://github.com/kaushik072/travellery_app_mobile
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/generated/assets.dart';
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
  final LocalHomestaydataModel homestayData;

  const PreviewPage({super.key, required this.selectedIndex,required this.homestayData});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> with SingleTickerProviderStateMixin {
  final PreviewPropertiesController previewController = Get.put(PreviewPropertiesController());
  final YourPropertiesController controller = Get.put(YourPropertiesController());

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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(5.w, statusBarHeight + 3.2.h, 4.w, 10),
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
                    if (widget.selectedIndex == 1) ...[
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
                    //       ? controller.property.homestayData!.homestayPhotos!.map((imagePath) {
                    //           return ClipRRect(
                    //             borderRadius:
                    //                 const BorderRadius.all(AppRadius.radius10),
                    //             child: null != imagePath.url
                    //                 ? Image.network(imagePath.url!,
                    //                     fit: BoxFit.cover)
                    //                 : Container(
                    //                     color: Colors.grey[300],
                    //                   ),
                    //           );
                    //         }).toList()
                    //       : widget.homestayData.homestayPhotos!
                    //           .map((imagePath) {
                    //           return ClipRRect(
                    //             borderRadius:
                    //                 const BorderRadius.all(AppRadius.radius10),
                    //             child: null != imagePath.url
                    //                 ? Image.file(File(imagePath.url!),
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
                    // Obx(
                    //   () => AnimatedSmoothIndicator(
                    //     count: widget.selectedIndex == 1
                    //         ? controller
                    //             .property.homestayData!.homestayPhotos!.length
                    //         : widget.homestayData.homestayPhotos!.length,
                    //     effect: const ExpandingDotsEffect(
                    //         activeDotColor: AppColors.buttonColor,
                    //         dotColor: AppColors.inactiveDotColor,
                    //         spacing: 2,
                    //         dotHeight: 5,
                    //         dotWidth: 5),
                    //     onDotClicked: (index) {
                    //       previewController.carouselController
                    //           .jumpToPage(index);
                    //     },
                    //     activeIndex: previewController.carouselIndex.value,
                    //   ),
                    // ),
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
                          : widget.homestayData.title,
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
                        widget.selectedIndex == 1
                            ? '${controller.property.homestayData!.basePrice} - ${controller.property.homestayData!.weekendPrice}'
                            : '${widget.homestayData.basePrice} - ${widget.homestayData.weekendPrice}',
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
            buildTabBarView(controller, widget.homestayData),
          ],
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

  SliverToBoxAdapter buildTabBarView(YourPropertiesController controller,
      LocalHomestaydataModel homestayData) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150.h,
        child: TabBarView(
          controller: _tabController,
          children: [
            buildDetailsView(controller, homestayData),
            buildContactView(controller, homestayData),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsView(YourPropertiesController controller,
      LocalHomestaydataModel homestayData) {
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
                      widget.selectedIndex == 1
                          ? controller.property.homestayData!.homestayType!
                          : homestayData.homestayType,
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
                      widget.selectedIndex == 1
                          ? controller.property.homestayData!
                                      .accommodationDetails!.entirePlace ==
                                  true
                              ? Strings.entirePlace
                              : Strings.privateRoom
                          : homestayData.accommodationDetails.entirePlace ==
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.bedrooms} ${Strings.bedRooms}"
                            : "${homestayData.accommodationDetails.bedrooms} ${Strings.bedRooms}",
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.maxGuests} ${Strings.guest}"
                            : "${homestayData.accommodationDetails.maxGuests} ${Strings.guest}",
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.doubleBed} ${Strings.doubleBed}"
                            : "${homestayData.accommodationDetails.doubleBed} ${Strings.doubleBed}",
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.singleBed} ${Strings.singleBed}"
                            : "${homestayData.accommodationDetails.singleBed} ${Strings.singleBed}",
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.bathrooms} ${Strings.bathRooms}"
                            : "${homestayData.accommodationDetails.bathrooms} ${Strings.bathRooms}",
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
                        widget.selectedIndex == 1
                            ? "${controller.property.homestayData!.accommodationDetails!.extraFloorMattress} ${Strings.extraFloorMattress}"
                            : "${homestayData.accommodationDetails.extraFloorMattress} ${Strings.extraFloorMattress}",
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
                    text: widget.selectedIndex == 1
                        ? controller.property.homestayData!.description
                        : homestayData.description,
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
          buildTimeSection(controller, homestayData),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(controller, homestayData),
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

  Widget buildTimeSection(YourPropertiesController controller,
      LocalHomestaydataModel homestayData) {
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
                  widget.selectedIndex == 1
                      ? controller.property.homestayData!.flexibleCheckIn ==
                              true
                          ? Strings.flexible
                          : controller.property.homestayData!.checkInTime!
                      : homestayData.flexibleCheckIn == true
                          ? Strings.flexible
                          : homestayData.checkInTime),
              buildTimeSeparator(),
              buildTimeItem(
                  Assets.imagesClock,
                  Strings.checkOutTime,
                  widget.selectedIndex == 1
                      ? controller.property.homestayData!.flexibleCheckOut ==
                              true
                          ? Strings.flexible
                          : controller.property.homestayData!.checkOutTime!
                      : homestayData.flexibleCheckOut == true
                          ? Strings.flexible
                          : homestayData.checkOutTime),
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

  Widget buildAddress(YourPropertiesController controller,
      LocalHomestaydataModel homestayData) {
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
            widget.selectedIndex == 1
                ? "${controller.property.homestayData!.address}"
                : homestayData.address,
            style: FontManager.regular(12, color: AppColors.black)),
      ],
    );
  }

  Widget buildContactView(YourPropertiesController controller,
      LocalHomestaydataModel homestayData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Text(Strings.ownerDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          buildContactRow(
              Assets.imagesCallicon,
              widget.selectedIndex == 1
                  ? controller.property.homestayData!.ownerContactNo!
                  : homestayData.ownerContactNo),
          SizedBox(height: 1.h),
          buildContactRow(
              Assets.imagesEmailicon,
              widget.selectedIndex == 1
                  ? controller.property.homestayData!.ownerEmailId!
                  : homestayData.ownerEmailId),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          // ...buildContactList(
          //   widget.selectedIndex == 1
          //       ? controller.property.homestayData!.homestayContactNo!
          //       : homestayData.homestayContactNo,
          //   Assets.imagesCallicon,
          // ),
          // SizedBox(height: 1.h),
          // ...buildContactList(
          //   widget.selectedIndex == 1
          //       ? controller.property.homestayData!.homestayEmailId!
          //       : homestayData.homestayEmailId,
          //   Assets.imagesEmailicon,
          // ),
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

  List<Widget> buildContactList(List<dynamic> contactList, String iconPath) {
    return contactList.map<Widget>((contact) {
      return Column(
        children: [
          buildContactRow(iconPath, contact.contactNo ?? contact.emailId),
          SizedBox(height: 1.h),
        ],
      );
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
import 'package:get/get.dart';
import 'package:travellery_mobile/common_widgets/common_loading_process.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/yourproperties_model.dart';
import '../data/repository/your_properties_repository.dart';

class YourPropertiesController extends GetxController {
  var yourPropertiesRepository = getIt<YourPropertiesRepository>();
  var apiHelper = getIt<ApiHelper>();
  YourPropertiesModel? yourProperty;
  List<ReUsedDataModel> propertiesList = [];
  @override
  void onInit() {
    super.onInit();
    getYourPropertiesData();
  }

  init() async {
    await getYourPropertiesData();
    await getSingleYourProperties();
    update();
  }

  Future<void> getYourPropertiesData() async {
    yourProperty = await yourPropertiesRepository.getYourProperties(limit: 5);
    if (yourProperty != null && yourProperty!.homestaysData != null) {
      propertiesList = yourProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final singleFetchUserModel = propertiesList[index].id;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(
          Routes.previewPage,
          arguments: {
            'index': 1,
          },
        );
      },
    );
  }

  late HomeStaySingleFetchResponse property;
  Future<void> getSingleYourProperties() async {
    property = await yourPropertiesRepository.getSingleFetchYourProperties();
  }

  void deleteProperties() {
    print("qqqqq=============");
    yourPropertiesRepository.deleteData().then((value) async {
      print("Delete=============");
      yourProperty = await yourPropertiesRepository.getYourProperties(limit: 5).then((value) {
        Get.back();
        Get.back();
        return null;
      },);
    },);
    update();
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
import 'package:dio/dio.dart' as dio;
import '../../../../../api_helper/api_helper.dart';
import '../../../../../api_helper/api_uri.dart';
import '../../../../../api_helper/getit_service.dart';
import '../../../../services/storage_services.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../model/yourproperties_model.dart';

class YourPropertiesRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<YourPropertiesModel> getYourProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return YourPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchYourProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> deleteData() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.propertiesDelete}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return data;
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
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';

class YourPropertiesModel {
  String? message;
  List<ReUsedDataModel>? homestaysData;
  int? totalHomestay;

  YourPropertiesModel({this.message, this.homestaysData, this.totalHomestay});

  YourPropertiesModel.fromJson(Map<String, dynamic> json) {
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
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/utils/app_colors.dart';
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
    return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 7.2.h),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.keyboard_arrow_left, size: 30,),
              ),
              const SizedBox(width: 8),
              Text(
                Strings.termsAndConditions,
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
        );
  }
}
 import 'package:get/get.dart';
import 'package:travellery_mobile/common_widgets/common_loading_process.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../data/model/yourproperties_model.dart';
import '../data/repository/your_properties_repository.dart';

class YourPropertiesController extends GetxController {
  var yourPropertiesRepository = getIt<YourPropertiesRepository>();
  var apiHelper = getIt<ApiHelper>();
  YourPropertiesModel? yourProperty;
  List<ReUsedDataModel> propertiesList = [];
  @override
  void onInit() {
    super.onInit();
    getYourPropertiesData();
  }

  init() async {
    await getYourPropertiesData();
    await getSingleYourProperties();
    update();
  }

  Future<void> getYourPropertiesData() async {
    yourProperty = await yourPropertiesRepository.getYourProperties(limit: 5);
    if (yourProperty != null && yourProperty!.homestaysData != null) {
      propertiesList = yourProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final singleFetchUserModel = propertiesList[index].id;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(
          Routes.previewPage,
          arguments: {
            'index': 1,
          },
        );
      },
    );
  }

  late HomeStaySingleFetchResponse property;
  Future<void> getSingleYourProperties() async {
    property = await yourPropertiesRepository.getSingleFetchYourProperties();
  }

  void deleteProperties() {
    print("qqqqq=============");
    yourPropertiesRepository.deleteData().then((value) async {
      print("Delete=============");
      yourProperty = await yourPropertiesRepository.getYourProperties(limit: 5).then((value) {
        Get.back();
        Get.back();
        return null;
      },);
    },);
    update();
  }
}
import 'package:dio/dio.dart' as dio;
import '../../../../../api_helper/api_helper.dart';
import '../../../../../api_helper/api_uri.dart';
import '../../../../../api_helper/getit_service.dart';
import '../../../../services/storage_services.dart';
import '../../../reuseble_flow/data/model/single_fetch_homestay_model.dart';
import '../model/yourproperties_model.dart';

class YourPropertiesRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<YourPropertiesModel> getYourProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return YourPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchYourProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStaySingleFetchUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> deleteData() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.propertiesDelete}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return data;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/screen/your_properties_screen/controller/your_properties_controller.dart';
import '../../../common_widgets/common_properti_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';

class YourPropertiesPage extends StatelessWidget {
  const YourPropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder<YourPropertiesController>(
        init: YourPropertiesController(),
        builder: (controller) {
          if (controller.yourProperty == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              buildHeader(),
              SizedBox(height: 1.h),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.propertiesList.length,
                  itemBuilder: (context, index) {
                    return buildPropertyCard(controller, index);
                  },
                ),
              ),
              SizedBox(height: 3.h),
            ],
          );
        },
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 12.7.h,
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
              Text(
                Strings.yourProperties,
                style: FontManager.medium(20, color: AppColors.white),
              ),
              const Spacer(),
              GestureDetector(onTap: () {
                // Get.toNamed(Routes.addPropertiesScreen);
              },
                child: const Icon(
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
      GetPage(name: verificationPage, page: () => const VerificationCodeScreen()),
      GetPage(name: resetPage, page: () => const ResetPasswordScreen()),
      GetPage(name: listHomestayPage1, page: () => const ListHomestayPages()),
      GetPage(
          name: addPropertiesScreen,
          page: () => AddPropertiesScreen(index: Get.arguments['index'] ?? 0)),
      GetPage(name: newamenities, page: () => const NewAmenitiesPages()),
      GetPage(name: newRules, page: () => const NewRulesPages()),
      GetPage(name: location, page: () => const LocationView()),
      GetPage(
        name: Routes.previewPage,
        page: () {
          final arguments = Get.arguments;
          final selectedIndex = arguments['index'] ?? 0;
          final homestayData = arguments['homestayData'] as LocalHomestaydataModel;

          return PreviewPage(
            selectedIndex: selectedIndex,
            homestayData: homestayData,
          );
        },
      ),
      GetPage(name: termsAndCondition, page: () => const TermsAndConditionPage()),
      GetPage(name: yourPropertiesPage, page: () => const YourPropertiesPage()),
      GetPage(name: bottomPages, page: () => const Bottom()),
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  });
  runApp(
    Sizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        getPages: Routes.routes,
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



