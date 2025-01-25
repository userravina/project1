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
import 'package:e_commerce/common_components/base_page_layout.dart';
import 'package:e_commerce/screens/check_out/view/responsive_view/check_out_mobile.dart';
import 'package:e_commerce/screens/check_out/view/responsive_view/check_out_web.dart';
import 'package:flutter/material.dart';
import '../../../common_components/custom_appbar.dart';
import '../../../theme/app_color.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      backgroundColor: AppColor.backgroundColor,
      customAppBar: CustomAppBar(
        backgroundColor: AppColor.lightBlue,
      ),
      mobileBody: CheckOutMobile(),
      webBody: CheckOutWeb(),
      bottomShow: true,
      commonViewEnd: false,
    );
  }
}
import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';

class CheckOutMobile extends StatelessWidget {
  const CheckOutMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            AppStrings(context).checkOut,
            style: FontManager.tenorSansRegular(18,
                color: AppColor.black, letterSpacing: 1.5),
          ),
          Image.asset(
            Assets.images.n3_png,
            width: 30.w,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 155,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.images.rectangle434_png),
                        fit: BoxFit.contain,
                      ),
                    ),
                    // today's update :
                       -
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings(context).lamerei,
                          style: FontManager.tenorSansRegular(14,
                              color: AppColor.black, letterSpacing: 2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          AppStrings(context).recycleBoucleKnitCardiganPink,
                          style: FontManager.tenorSansRegular(12,
                              color: AppColor.blackGrey),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                    color: AppColor.containerGreyBorder,
                                    width: 1),
                              ),
                              child: Center(
                                child: Image.asset(
                                  Assets.images.decrease_png,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Center(
                              child: Text(
                                "1",
                                style: FontManager.tenorSansRegular(14,
                                    color: AppColor.black),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: AppColor.containerGreyBorder,
                                      width: 1)),
                              child: Center(
                                child: Image.asset(
                                  Assets.images.plus_png,
                                  height: 16,
                                  width: 16,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          AppStrings(context).rupeesCheckOut,
                          style: FontManager.tenorSansRegular(15,
                              color: AppColor.warning),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Divider(
            color: AppColor.dividerColor,
            thickness: 1.5,
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Image.asset(
                Assets.images.temperature_png,
                height: 24,
                width: 24,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                AppStrings(context).addPromoCode,
                style:
                    FontManager.tenorSansRegular(14,color: AppColor.blackGrey),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: AppColor.dividerColor,
            thickness: 1.5,
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Image.asset(
                Assets.images.temperature_png,
                height: 24,
                width: 24,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                AppStrings(context).delivery,
                style:
                    FontManager.tenorSansRegular(14, color: AppColor.blackGrey),
              ),
              Spacer(),
              Text(
                AppStrings(context).free,
                style: FontManager.tenorSansRegular(14,
                    color: AppColor.blackGreyText),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: AppColor.dividerColor,
            thickness: 1.5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings(context).totalEst,
                  style: FontManager.tenorSansRegular(14,
                      color: AppColor.blackGrey),
                ),
                Text(
                  AppStrings(context).rupeesCheckOut,
                  style:
                      FontManager.tenorSansRegular(14, color: AppColor.warning),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/widgets.dart';

class CheckOutWeb extends StatelessWidget {
  const CheckOutWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
import 'package:e_commerce/common_components/common_view_end.dart';
import 'package:e_commerce/common_components/custom_drawer.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import '../assets.dart';
import '../theme/app_color.dart';

class BasePageLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget webBody;
  final bool showDrawer;
  final bool listSwitch;
  final Color backgroundColor;
  final PreferredSizeWidget? customAppBar;
  final bool bottomShow;
  final bool commonViewEnd;

  const BasePageLayout({
    super.key,
    required this.mobileBody,
    required this.webBody,
    this.showDrawer = true,
    this.listSwitch = false,
    this.backgroundColor = AppColor.white,
    this.customAppBar,
    this.bottomShow = false,
    this.commonViewEnd = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar,
      drawer: showDrawer ? CustomDrawer(listSwitch: listSwitch) : null,
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType ==
                DeviceScreenType.desktop) {
              return Column(
                children: [
                  Expanded(child: webBody),
             commonViewEnd ? const CommonViewEnd() : SizedBox.shrink(),
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  mobileBody,
                   commonViewEnd ? const CommonViewEnd() : SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: bottomShow
          ? Container(
              height: 6.h,
              width: double.infinity,
              color: AppColor.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.shopping_bag_png,
                    height: 20,
                    width: 20,
                    color: AppColor.white,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    AppStrings(context).checkOut,
                    style: FontManager.tenorSansRegular(16,
                        color: AppColor.backgroundColor),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class ProfileCardPainter extends CustomPainter {
  ProfileCardPainter({required this.color, required this.avatarRadius});

  final Color color;
  final double avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final backgroundPath = Path();
    final cornerRadius = size.height / 2;
    final curveHeight = size.height * 0.3;
    backgroundPath.moveTo(0, size.height / 2);

    backgroundPath.arcToPoint(
      Offset(cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    final halfWidth = size.width / 2;
    final halfSpace = size.width * 0.15;
    
    backgroundPath.lineTo(halfWidth - halfSpace, 0);

    backgroundPath.cubicTo(
      halfWidth - halfSpace * 0.6, 0,
      halfWidth - halfSpace * 0.4, curveHeight,
      halfWidth, curveHeight,
    );
    
    backgroundPath.cubicTo(
      halfWidth + halfSpace * 0.4, curveHeight,
      halfWidth + halfSpace * 0.6, 0,
      halfWidth + halfSpace, 0,
    );

    backgroundPath.lineTo(size.width - cornerRadius, 0);
    backgroundPath.arcToPoint(
      Offset(size.width, size.height / 2),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    backgroundPath.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    backgroundPath.lineTo(cornerRadius, size.height);
    backgroundPath.arcToPoint(
      Offset(0, size.height / 2),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    backgroundPath.close();
    canvas.drawPath(backgroundPath, paint);
    final reflectionPath = Path();
    final reflectionWidth = size.width * 0.1;
    final reflectionHeight = curveHeight * 0.8;
    
    reflectionPath.moveTo(halfWidth - reflectionWidth, curveHeight * 0.3);
    reflectionPath.cubicTo(
      halfWidth - reflectionWidth * 0.5, curveHeight * 0.3,
      halfWidth - reflectionWidth * 0.3, reflectionHeight,
      halfWidth, reflectionHeight
    );
    reflectionPath.cubicTo(
      halfWidth + reflectionWidth * 0.3, reflectionHeight,
      halfWidth + reflectionWidth * 0.5, curveHeight * 0.3,
      halfWidth + reflectionWidth, curveHeight * 0.3
    );

    final reflectionPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.005;

    canvas.drawPath(reflectionPath, reflectionPaint);
  }

  @override
  bool shouldRepaint(ProfileCardPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navBarHeight = 80.0;
    final totalHeight = navBarHeight + bottomPadding + 50;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: totalHeight),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text('Home Page'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: totalHeight,
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: bottomPadding + 10,
              child: Container(
                width: screenWidth - 32,
                height: navBarHeight,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomPaint(
                  size: Size(screenWidth - 32, navBarHeight),
                  painter: ProfileCardPainter(
                    color: Colors.black,
                    avatarRadius: 10,
                  ),
                ),
              ),
            ),

            Positioned(
              top: -5,
              child: Material(
                color: Colors.transparent,
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: bottomPadding + 25,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 70,
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 70,
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.safety_check_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



CREATE TABLE blog_category (
    id SERIAL PRIMARY KEY,   -- Auto incrementing ID
    name VARCHAR(255) NOT NULL -- Category name (e.g., fashion, promo)
);

CREATE TABLE blog_post (
    id SERIAL PRIMARY KEY,   -- Auto incrementing ID
    category_id INT NOT NULL,   -- Foreign key to blog_category
    image_url TEXT,  -- URL to the main image of the blog post
    short_description TEXT,   -- Short description of the blog post
    long_description TEXT,    -- Full description of the blog post
    title VARCHAR(255) NOT NULL,  -- Title of the blog post
    published_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP, -- When the post was published
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES blog_category (id)
        ON DELETE CASCADE -- If a category is deleted, all related blog posts are deleted
);

CREATE TABLE blog_post_details (
    id SERIAL PRIMARY KEY,    -- Auto incrementing ID
    blog_post_id INT NOT NULL,   -- Foreign key to blog_post
    first_image_url TEXT,   -- URL for the first detailed image
    title VARCHAR(255) NOT NULL,  -- Title for the detailed blog content
    long_description_first TEXT,  -- First part of the detailed description
    second_image_url TEXT,  -- URL for the second detailed image
    long_description_second TEXT, -- Second part of the detailed description
    CONSTRAINT fk_blog_post
        FOREIGN KEY (blog_post_id)
        REFERENCES blog_post (id)
        ON DELETE CASCADE  -- If a blog post is deleted, its details are also deleted
);

INSERT INTO blog_post (category_id, image_url, short_description, long_description, title)
VALUES (1, 'http://example.com/image.jpg', 'This is a short description', 'This is a long description', 'Fashion Trends 2025');


