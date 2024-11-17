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



class PropertyCardWidget extends StatelessWidget {
  final double statusBarHeight;
  final String title;
  final String status;
  final String dataTitle;
  final TabController tabController;
  final int basePrice;
  final int weekendPrice;
  final List homestayPhotos;
  final String ownerContactNo;
  final String ownerEmailId;
  final List homestayContactNo;
  final List homestayEmailId;
  final String homestayType;
  final String accommodationType;
  final String checkInTime;
  final String checkOutTime;
  final bool flexibleCheckIn;
  final bool flexibleCheckOut;
  final String address;
  final String description;

  const PropertyCardWidget(
      {super.key,
      required this.statusBarHeight,
      required this.title,
      required this.homestayPhotos,
      required this.status,
      required this.dataTitle,
      required this.basePrice,
      required this.weekendPrice,
      required this.tabController,
      required this.ownerContactNo,
      required this.ownerEmailId,
      required this.homestayContactNo,
      required this.homestayEmailId,
      required this.homestayType,
      required this.accommodationType,
      required this.checkOutTime,
      required this.checkInTime,
      required this.flexibleCheckIn,
      required this.flexibleCheckOut,
      required this.address,
      required this.description});

  @override
  Widget build(BuildContext context) {
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
                if (title == "Details") ...[
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
                        // CustomDialog.showCustomDialog(
                        //   context: context,
                        //   message: Strings.deleteDesc,
                        //   imageAsset: Assets.imagesDeletedialog,
                        //   buttonLabel: Strings.resend,
                        //   changeEmailLabel: Strings.changeEmail,
                        //   onResendPressed: () {
                        //     print("xxzzzzzzzzzzzz");
                        //     controller.deleteProperties();
                        //
                        //   },
                        //   onChangeEmailPressed: () {},
                        // );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        //
                        // buildPopupMenuItem(
                        //     Assets.imagesEdit,
                        //     Strings.edit,
                        //     AppColors.editBackgroundColor,
                        //     AppColors.blueColor),
                        // buildPopupMenuItem(
                        //     Assets.imagesDeleteVector,
                        //     Strings.delete,
                        //     AppColors.deleteBackgroundColor,
                        //     AppColors.redColor),
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
                        // previewController.updateCarouselIndex(index);
                      },
                      padEnds: false,
                      disableCenter: true,
                      aspectRatio: 1.6,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                    ),
                    // carouselController: previewController.carouselController,
                    items: homestayPhotos.map((imagePath) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(AppRadius.radius10),
                        child: null != imagePath.url
                            ? Image.network(imagePath.url!, fit: BoxFit.cover)
                            : Container(
                                color: Colors.grey[300],
                              ),
                      );
                    }).toList()),
                SizedBox(
                  height: 1.5.h,
                ),
                // Obx(
                //       () => AnimatedSmoothIndicator(
                //     count: homestayPhotos.length,
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
                title == "Details"
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
                title == "Details"
                    ? const SizedBox(
                        height: 12,
                      )
                    : const SizedBox.shrink(),
                Text(
                  dataTitle,
                  style: FontManager.semiBold(28,
                      color: AppColors.textAddProreties),
                ),
                SizedBox(height: 1.5.h),
                Text(
                  Strings.newYorkUSA,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
                SizedBox(height: 1.5.h),
                Text('$basePrice - $weekendPrice',
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
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 0.5.w,
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
                // buildDetailsView(controller),
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                height: 5.h,
                width: 35.w,
                decoration: BoxDecoration(
                  color: AppColors.lightPerpul,
                  borderRadius: BorderRadius.all(AppRadius.radius24),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      Assets.imagesSingleBed,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      homestayType,
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 5.h,
                width: 35.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius24),
                    border: Border.all(color: AppColors.lightPerpul)),
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      Assets.imagesSingleBed,
                      height: 2.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      accommodationType,
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    Spacer(),
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
                        Assets.imagesSingleBed,
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
                        Assets.imagesSingleBed,
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
                        Assets.imagesSingleBed,
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
              Spacer(),
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
                        Assets.imagesSingleBed,
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
                        Assets.imagesSingleBed,
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
              Spacer(),
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
          buildDescription(),
          SizedBox(height: 2.h),
          buildTimeSection(),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(),
          SizedBox(height: 7.h),
          CommonButton(
            title: Strings.done,
            onPressed: () => Get.toNamed(Routes.termsAndCondition),
          ),
          SizedBox(height: 5.h),
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
          // buildContactRow(Assets.imagesCallicon,
          //     ownerContactNo),
          SizedBox(height: 1.h),
          // buildContactRow(Assets.imagesEmailicon,
          //    ownerEmailId),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          ...homestayContactNo.map((contact) {
            return Column(
              children: [
                // buildContactRow(Assets.imagesCallicon, contact.contactNo!),
                // SizedBox(height: 1.h),
              ],
            );
          }),
          SizedBox(height: 1.h),
          ...homestayEmailId.map((email) {
            return Column(
              children: [
                // buildContactRow(Assets.imagesEmailicon, email.emailId!),
                SizedBox(height: 1.h),
              ],
            );
          }),
          SizedBox(height: 5.h),
          CommonButton(
            title: Strings.done,
            onPressed: () => title == "Details"
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


