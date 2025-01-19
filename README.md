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


import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import '../assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;

  const CustomAppBar({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: Image.asset(
            Assets.images.menu_png,
            fit: BoxFit.contain,
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Text(AppStrings(context).openFashion,style: FontManager.bodoniModaBoldItalic(16),),
      centerTitle: true,
      surfaceTintColor: backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Image.asset(
            Assets.images.search_png,
            height: 24,
            width: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 23),
          child: Image.asset(
            Assets.images.shopping_bag_png,
            height: 24,
            width: 24,
          ),
        ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'common_view_end.dart';
import 'custom_drawer.dart';
import '../theme/app_color.dart';

class BasePageLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget webBody;
  final bool showDrawer;
  final bool listSwitch;
  final Color backgroundColor;
  final PreferredSizeWidget? customAppBar;

  const BasePageLayout({
    
    super.key,
    required this.mobileBody,
    required this.webBody,
    this.showDrawer = true,
    this.listSwitch = false,
    this.backgroundColor = AppColor.white,
    this.customAppBar,
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
            if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
              return Column(
                children: [
                  Expanded(child: webBody),
                  const CommonViewEnd(),
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  mobileBody,
                  const CommonViewEnd(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
} 

import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../assets.dart';
import '../routes/app_route.dart';

class CommonViewEnd extends StatelessWidget {
  const CommonViewEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            Image.asset(
              Assets.images.twitter_png,
              height: 24,
              width: 24,
            ),
            SizedBox(
              width: 15.w,
            ),
            Image.asset(
              Assets.images.instagram_png,
              height: 24,
              width: 24,
            ),
            SizedBox(
              width: 15.w,
            ),
            Image.asset(
              Assets.images.youTube_png,
              height: 24,
              width: 24,
            ),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 2.5.h,
        ),
        Image.asset(
          Assets.images.n3_png,
          width: 30.w,
        ),
        SizedBox(
          height: 2.5.h,
        ),
        Text(
          AppStrings(context).email,
          style: FontManager.tenorSansRegular(16, color: AppColor.blackGrey),
        ),
        Text(
          AppStrings(context).number,
          style: FontManager.tenorSansRegular(16, color: AppColor.blackGrey),
        ),
        Text(
          AppStrings(context).everyDayOpen,
          style: FontManager.tenorSansRegular(16, color: AppColor.blackGrey),
        ),
        SizedBox(
          height: 2.5.h,
        ),
        Image.asset(
          Assets.images.n3_png,
          width: 30.w,
        ),
        SizedBox(
          height: 2.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            Text(
              AppStrings(context).about,
              style: FontManager.tenorSansRegular(16, color: AppColor.black),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              AppStrings(context).contact,
              style: FontManager.tenorSansRegular(16, color: AppColor.black),
            ),
            SizedBox(
              width: 15.w,
            ),
            InkWell(onTap: () {
              context.goNamed(AppRoutes.blogPage);
            },
              child: Text(
                AppStrings(context).blog,
                style: FontManager.tenorSansRegular(16, color: AppColor.black),
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 3.h,),
        Text(
          AppStrings(context).copyrightOpenUIAllRightsReserved,
          style: FontManager.tenorSansRegular(12, color: AppColor.blackGreyText),
        ),
        SizedBox(height: 1.h,),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../assets.dart';
import '../bloc/localization/localization_bloc.dart';
import '../bloc/localization/localization_event.dart';
import '../routes/app_route.dart';
import '../theme/app_color.dart';
import '../utils/app_strings.dart';
import '../utils/text_style.dart';

class CustomDrawer extends StatefulWidget {
  final bool listSwitch;

  const CustomDrawer({super.key, this.listSwitch = false});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        backgroundColor: AppColor.white,
        child: Column(
          children: [
            _buildDrawerHeader(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCategoryList('Women'),
                  _buildCategoryList('Men'),
                  _buildCategoryList('Kids'),
                ],
              ),
            ),
            _buildBottomSection(context),
            SizedBox(height: 2.5.h,),
            Image.asset(
              Assets.images.n3_png,
              width: 30.w,
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Image.asset(
                  Assets.images.twitter_png,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Image.asset(
                  Assets.images.instagram_png,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Image.asset(
                  Assets.images.youTube_png,
                  height: 24,
                  width: 24,
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 2.5.h,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image.asset(
                  Assets.images.close_png,
                  height: 24,
                  width: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColor.black,
      labelStyle: FontManager.tenorSansRegular(14,),
      unselectedLabelColor: AppColor.greyText,
      indicatorColor: AppColor.warning,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(text: 'Women',),
        Tab(text: 'Men'),
        Tab(text: 'Kids'),
      ],
    );
  }

  Widget _buildCategoryList(String section) {
    final categories = [
      'New',
      'Apparel',
      'Bag',
      'Shoes',
      'Beauty',
      'Accessories',
    ];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryItem(context, categories[index], section);
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, String category, String section) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: FontManager.tenorSansRegular(16, color: AppColor.black),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColor.black,
          ),
        ],
      ),
      onTap: () {
        Navigator.pop(context);
        context.goNamed(
          AppRoutes.categoryPage,
          queryParameters: {
            'section': section,
            'category': category,
          },
        );
      },
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        _buildLanguageSection(context),
        if (widget.listSwitch) _buildViewToggle(context),
      ],
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            AppStrings(context).changeLanguage,
            style: FontManager.tenorSansRegular(16),
          ),
        ),
        _buildLanguageOption(context, "English", 'en'),
        _buildLanguageOption(context, "Hindi", 'hi'),
        _buildLanguageOption(context, "Arabic", 'ar'),
      ],
    );
  }

  Widget _buildLanguageOption(BuildContext context, String label, String code) {
    return ListTile(
      title: Text(
        label,
        style: FontManager.tenorSansRegular(14),
      ),
      onTap: () {
        context.read<LocalizationBloc>().add(ChangeLanguageEvent(code));
        Navigator.pop(context);
      },
    );
  }

  Widget _buildViewToggle(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            "Change View",
            style: FontManager.tenorSansRegular(16),
          ),
          const Spacer(),
          Switch(
            value: false,
            onChanged: (value) {
              // Handle view toggle
            },
          ),
        ],
      ),
    );
  }
} 

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_color.dart';
import '../utils/text_style.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productPrice;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          width: double.infinity,
          height: 25.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 0.5.h),
        Text(
          productName,
          style: FontManager.tenorSansRegular(
            12,
            color: AppColor.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 1.h),
        Text(
          productPrice,
          style: FontManager.tenorSansRegular(
            15,
            color: AppColor.warning,
          ),
        ),
      ],
    );
  }
}
{
  "luxuryFashionAccessories": "الفخامة \n الموضة \nوالإكسسوارات",
  "exploreCollection": "استكشاف المجموعة",
  "changeLanguage": "تغيير اللغة",
  "newArrival": "وصول جديد",
  "all": "الكل",
  "apparel": "الملابس",
  "dress": "فستان",
  "tShirt": "تي شيرت",
  "bag": "حقيبة",
  "reversibleAngoraCardigan": "كارديجان أنغورا قابل للعكس 21WN",
  "exploreMore": "استكشاف المزيد",
  "rupees": "١٢٠ دولارًا",
  "blog": "مدونة",
  "fashion": "موضة",
  "promo": "عرض",
  "policy": "السياسة",
  "lookbook": "دليل الأنماط",
  "sale": "تخفيضات",
  "styleGuide": "دليل الأنماط لعام 2021: أكبر اتجاهات الخريف",
  "fashion2": "#موضة",
  "tips": "#نصائح",
  "daysAgo": "منذ ٤ أيام",
  "openFashion": "   افتح\nالموضة",
  "number": "+60 825 876",
  "everyDayOen": "08:00 - 22:00 - يومياً",
  "email": "الدعم@openui.design",
  "about": "عن",
  "contact": "اتصل",
  "copyrightOpenUIAllRightsReserved" : "حقوق النشر© OpenUI جميع الحقوق محفوظة."
}
{
  "luxuryFashionAccessories": "Luxury \n Fashion \n& Accessories",
  "exploreCollection": "Explore Collection",
  "changeLanguage": "Change Language",
  "newArrival": "NEW ARRIVAL",
  "all": "All",
  "apparel": "Apparel",
  "dress": "Dress",
  "tShirt": "Tshirt",
  "bag": "Bag",
  "reversibleAngoraCardigan": "21WN reversible angora cardigan",
  "exploreMore": "Explore More",
  "rupees": "$120",
  "blog": "Blog",
  "fashion": "Fashion",
  "promo": "Promo",
  "policy": "Policy",
  "lookbook": "Lookbook",
  "sale": "Sale",
  "styleGuide": "2021 Style Guide: The Biggest Fall Trends",
  "fashion2": "#Fashion",
  "tips": "#Tips",
  "daysAgo": "4 days ago",
  "openFashion": "   Open\nFashion",
  "number": "+60 825 876",
  "everyDayOen": "08:00 - 22:00 - Everyday",
  "email": "support@openui.design",
  "about": "About",
  "contact": "Contact",
  "copyrightOpenUIAllRightsReserved": "Copyright© OpenUI All Rights Reserved."
}
{
  "luxuryFashionAccessories": "लक्ज़री \n फैशन \nऔर एक्सेसरीज़",
  "exploreCollection": "संग्रह का अन्वेषण करें",
  "changeLanguage": "भाषा बदलें",
  "newArrival": "नया आगमन",
  "all": "सभी",
  "apparel": "कपड़े",
  "dress": "पोशाक",
  "tShirt": "टीशर्ट",
  "bag": "बैग",
  "reversibleAngoraCardigan": "21WN रिवर्सिबल अंगोरा कार्डिगन",
  "exploreMore": "और अधिक जानें",
  "rupees": "₹120",
  "blog": "ब्लॉग",
  "fashion": "फैशन",
  "promo": "प्रोमो",
  "policy": "नीति",
  "lookbook": "लुकबुक",
  "sale": "बिक्री",
  "styleGuide": "2021 स्टाइल गाइड: सबसे बड़े शरद ऋतु के रुझान",
  "fashion2": "#फैशन",
  "tips": "#टिप्स",
  "daysAgo": "4 दिन पहले",
  "openFashion": "   ओपन\nफैशन",
  "number": "+60 825 876",
  "everyDayOen": "08:00 - 22:00 - हर दिन",
  "email": "सपोर्ट@openui.design",
  "about": "के बारे में",
  "contact": "संपर्क करें",
  "copyrightOpenUIAllRightsReserved" : "कॉपीराइट© OpenUI सभी अधिकार सुरक्षित।"
}
class AppRoutes {
  static const String splashPage = "/";
  static const String homePage = "/home";
  static const String blogPage = "/blog";
  static const String categoryPage = "/category";
  static const String blogDetailsPage = "/blog/details";
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/blog_flow/view/blog_details_page.dart';
import '../screens/blog_flow/view/blog_page.dart';
import '../screens/category_product_page/view/category_product_page.dart';
import '../screens/home_flow/view/home_screen.dart';
import '../screens/splash_flow/view/splash_screen.dart';
import 'app_route.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splashPage,
        builder: (context, state) => const SplashScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            name: AppRoutes.homePage,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
            routes: [
              GoRoute(
                path: 'category',
                name: AppRoutes.categoryPage,
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const CategoryProductPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              ),
              GoRoute(
                path: 'blog',
                name: AppRoutes.blogPage,
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const BlogPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              ),
              GoRoute(
                path: 'blog/details',
                name: AppRoutes.blogDetailsPage,
                pageBuilder: (context, state) {
                  // final blogData = state.extra as Map<String, dynamic>;
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: BlogDetailsPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlogViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends BlogViewEvent {}


abstract class BlogViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GridState extends BlogViewState {}

class ListState extends BlogViewState {}


class BlogViewBloc extends Bloc<BlogViewEvent, BlogViewState> {
  BlogViewBloc() : super(GridState()) {
    on<ToggleViewEvent>((event, emit) {
      if (state is GridState) {
        emit(ListState());
      } else {
        emit(GridState());
      }
    });
  }
}

import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../assets.dart';
import '../../../../components/appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';

class BlogDetailMobile extends StatelessWidget {
  const BlogDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            backgroundColor: AppColor.white,
          ),
          SizedBox(height: 4.h),
          Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.rectangle_434_png),
              ),
            ),
          ),
          SizedBox(height: 0.5.h,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Text("2021 Style Guide: The Biggest Fall Trends",style: FontManager.tenorSansRegular(14,color: AppColor.black),),
          ),
          SizedBox(height: 0.5.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Text("You guys know how much I love mixing high and low-end – it’s the best way to get the most bang for your buck while still elevating your wardrobe. The same goes for handbags! And honestly they are probably the best pieces to mix and match. I truly think the key to completing a look is with a great bag and I found so many this year that I wanted to share a round-up of my most worn handbags.",
              style: FontManager.tenorSansRegular(12,color: AppColor.blackGrey),),
          ),
          SizedBox(height: 0.5.h,),
          Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.rectangle_434_png),
              ),
            ),
          ),
          SizedBox(height: 0.5.h,),
          SmoothPageIndicator(
            controller: PageController(initialPage: 1),
            count: 3,
            effect: CustomizableEffect(
              dotDecoration: DotDecoration(
                color: Colors.transparent,
                rotationAngle: 45,
                height:  7.0,
                width: 7.0,
                dotBorder: DotBorder(color: AppColor.backgroundColor),
              ),
              activeDotDecoration: DotDecoration(
                color: AppColor.backgroundColor,
                rotationAngle: 45,
                height: 7.0 ,
                width:  7.0 ,
                dotBorder: DotBorder(color: AppColor.backgroundColor),
              ),
            ),
          ),
          SizedBox(height: 0.5.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Text("I found this Saint Laurent canvas handbag this summer and immediately fell in love. The neutral fabrics are so beautiful and I like how this handbag can also carry into fall. The mini Fendi bucket bag with the sheer fabric is so fun and such a statement bag. Also this DeMellier off white bag is so cute to carry to a dinner with you or going out, it’s small but not too small to fit your phone and keys still.",
              style: FontManager.tenorSansRegular(12,color: AppColor.blackGrey),),
          ),
          SizedBox(height: 2.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Text("Posted by OpenFashion | 3 Days ago",style: FontManager.tenorSansRegular(14,color: AppColor.black),),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyWhite),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    AppStrings(context).fashion,
                    style: FontManager.tenorSansRegular(12,
                        color: AppColor.greyScale),
                  ),
                ),
                SizedBox(width: 3.w),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyWhite),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    AppStrings(context).tips,
                    style: FontManager.tenorSansRegular(12,
                        color: AppColor.greyScale),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BlogDetailWeb extends StatelessWidget {

  const BlogDetailWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../components/appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../../../utils/app_strings.dart';
import '../../../../assets.dart';
import '../../bloc/blog_bloc.dart';
import '../widgets/category_row_blog.dart';
import '../widgets/grid_view_blog.dart';
import '../widgets/list_view_blog.dart';

class BlogMobile extends StatelessWidget {
  const BlogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor.white,
          ),
          SizedBox(height: 4.h),
          Text(
            AppStrings(context).blog,
            style: FontManager.tenorSansRegular(18,
                color: AppColor.black, letterSpacing: 1.5),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Image.asset(
            Assets.images.n3_png,
            width: 30.w,
          ),
          SizedBox(height: 4.h),
          SizedBox(
            height: 5.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryRowBlog(
                  text: AppStrings(context).fashion,
                  isSelected: true,
                  onTap: () {},
                ),
                CategoryRowBlog(
                  text: AppStrings(context).promo,
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryRowBlog(
                  text: AppStrings(context).policy,
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryRowBlog(
                  text: AppStrings(context).lookbook,
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryRowBlog(
                  text: AppStrings(context).sale,
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 4.5.h),
          BlocBuilder<BlogViewBloc, BlogViewState>(
            builder: (context, state) {
              if (state is GridState) {
                return GridViewBlog();
              } else {
                return ListViewBlog();
              }
            },
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

}

import 'package:flutter/material.dart';

class BlogWeb extends StatelessWidget {
  const BlogWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}

import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class CategoryRowBlog extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryRowBlog({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          onEnter: (_) {},
          onExit: (_) {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColor.grey,
            ),
            child: Center(
              child: Text(
                text,
                style: FontManager.tenorSansRegular(
                  14,
                  color: AppColor.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';
import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/text_style.dart';

class GridViewBlog extends StatelessWidget {
  const GridViewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 1.h,
          childAspectRatio: 1.35,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {
            context.pushNamed(
              AppRoutes.blogDetailsPage,
            );
          },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.images.rectangle_434_png),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              color: AppColor.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  // ignore: deprecated_member_use
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1.h,
                          left: 2.w,
                          right: 2.w,
                          child: Text(
                            'Blog Item ${AppStrings(context).styleGuide}',
                            style: FontManager.tenorSansRegular(14,
                                color: AppColor.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.greyWhite),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        AppStrings(context).fashion,
                        style: FontManager.tenorSansRegular(12,
                            color: AppColor.greyScale),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.greyWhite),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        AppStrings(context).tips,
                        style: FontManager.tenorSansRegular(12,
                            color: AppColor.greyScale),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      AppStrings(context).daysAgo,
                      style: FontManager.tenorSansRegular(12,
                          color: AppColor.greyScale),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class ListViewBlog extends StatelessWidget {
  const ListViewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 155,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.rectangle_433_png),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "2021 Style Guide:  The Biggest Fall Trends",
                      style: FontManager.tenorSansRegular(
                          14,
                          color: AppColor.black,
                          letterSpacing: 2
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "The excitement of fall fashion is here and I’m already loving some of the trend forecasts",
                      style: FontManager.tenorSansRegular(14,
                          color: AppColor.blackGrey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "4 days ago",
                      style: FontManager.tenorSansRegular(12,
                          color: AppColor.greyScale),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:e_commerce/screens/blog_flow/view/responsive_view/blog_detail_mobile.dart';
import 'package:e_commerce/screens/blog_flow/view/responsive_view/blog_detail_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/base_page_layout.dart';
import '../bloc/blog_bloc.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogViewBloc(),
      child: BasePageLayout(
        listSwitch: true,
        mobileBody: const BlogDetailMobile(),
        webBody: const BlogDetailWeb(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/base_page_layout.dart';
import '../bloc/blog_bloc.dart';
import 'responsive_view/blog_mobile.dart';
import 'responsive_view/blog_web.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogViewBloc>(
      create: (context) => BlogViewBloc(),
      child: BasePageLayout(
        listSwitch: true,
        mobileBody: const BlogMobile(),
        webBody: const BlogWeb(),
      ),
    );
  }
}


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends CategoryEvent {}


abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GridState extends CategoryState {}

class ListState extends CategoryState {}


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(GridState()) {
    on<ToggleViewEvent>((event, emit) {
      if (state is GridState) {
        emit(ListState());
      } else {
        emit(GridState());
      }
    });
  }
}

import 'package:flutter/material.dart';

class CategoryMobile extends StatelessWidget {
  const CategoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Category Mobile View'),
    );
  }
}

import 'package:flutter/material.dart';

class CategoryWeb extends StatelessWidget {
  const CategoryWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [

    ],);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/appbar.dart';
import '../../../components/base_page_layout.dart';
import '../../../theme/app_color.dart';
import '../bloc/category_product_bloc.dart';
import 'responsive_view/category_web.dart';
import 'responsive_view/category_mobile.dart';

class CategoryProductPage extends StatelessWidget {
  const CategoryProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: BasePageLayout(
        listSwitch: true,
        customAppBar: const CustomAppBar(
          backgroundColor: AppColor.white,
        ),
        mobileBody: const CategoryMobile(),
        webBody: const CategoryWeb(),
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeFetchBloc extends Bloc<HomeFetchEvent, HomeFetchState> {
  final HomeRepository homeRepository;
  bool imagesFetched = false;
  List<String> cachedImageUrls = [];
  String currentCategory = '';

  HomeFetchBloc(SupabaseClient supabaseClient) 
      : homeRepository = HomeRepository(supabaseClient),
        super(ImageFetchInitialState()) {
    
    on<ImageFetchStartedEvent>((event, emit) async {
      emit(ImageFetchLoadingState());
      try {
        cachedImageUrls = await homeRepository.fetchImages();
        imagesFetched = true;
        emit(ImageFetchLoadedState(
          imageUrls: cachedImageUrls,
          selectedCategory: currentCategory,
        ));
      } catch (e) {
        emit(ImageFetchErrorState(e.toString()));
      }
    });

    on<CategorySelectedEvent>((event, emit) async {
      currentCategory = event.selectedCategory;
      
      if (event.shouldFetchImages && !imagesFetched) {
        emit(ImageFetchLoadingState());
        try {
          cachedImageUrls = await homeRepository.fetchImages();
          imagesFetched = true;
        } catch (e) {
          emit(ImageFetchErrorState(e.toString()));
          return;
        }
      }

      emit(ImageFetchLoadedState(
        imageUrls: cachedImageUrls,
        selectedCategory: currentCategory,
      ));
    });
  }
}
import 'package:equatable/equatable.dart';

abstract class HomeFetchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageFetchStartedEvent extends HomeFetchEvent {}

class CategorySelectedEvent extends HomeFetchEvent {
  final String selectedCategory;
  final bool shouldFetchImages;

  CategorySelectedEvent(this.selectedCategory, {this.shouldFetchImages = false});

  @override
  List<Object> get props => [selectedCategory, shouldFetchImages];
}
import 'package:equatable/equatable.dart';

abstract class HomeFetchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageFetchInitialState extends HomeFetchState {}

class ImageFetchLoadingState extends HomeFetchState {}

class ImageFetchLoadedState extends HomeFetchState {
  final List<String> imageUrls;
  final String selectedCategory;

  ImageFetchLoadedState({
    required this.imageUrls,
    this.selectedCategory = '',
  });

  @override
  List<Object?> get props => [imageUrls, selectedCategory];
}

class ImageFetchErrorState extends HomeFetchState {
  final String errorMessage;

  ImageFetchErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepository {
  final SupabaseClient client;

  HomeRepository(this.client);

  Future<List<String>> fetchImages() async {
    try {
      final List<FileObject> files = await client.storage
          .from('fashion-accessories-images')
          .list();

      final List<String> imageUrls = files.map((file) {
        return client.storage
            .from('fashion-accessories-images')
            .getPublicUrl(file.name);
      }).toList();

      if (imageUrls.isEmpty) {
        return [
          client.storage.from('fashion-accessories-images').getPublicUrl("image_10-removebg-preview.png"),
          client.storage.from('fashion-accessories-images').getPublicUrl("image_15-removebg-preview.png"),
          client.storage.from('fashion-accessories-images').getPublicUrl("image_10-removebg-preview.png"),
          client.storage.from('fashion-accessories-images').getPublicUrl("image_15-removebg-preview.png"),
        ];
      }

      return imageUrls;
    } catch (e) {
      throw Exception('Failed to fetch images: $e');
    }
  }
} 
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../assets.dart';
import '../../../../components/common_view_end.dart';
import '../../../../components/product_card.dart';
import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../widgets/category_item_row.dart';
import '../widgets/image_caousel.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<HomeFetchBloc, HomeFetchState>(builder: (context, state) {
            if (state is ImageFetchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ImageFetchErrorState) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            if (state is ImageFetchLoadedState) {
              return SizedBox(
                height: 65.h,
                child: ImageCarousel(
                  imageUrls: state.imageUrls,
                  isMobile: true,
                ),
              );
            }
            return const Center(child: Text('No images available'));
          }),
          SizedBox(height: 4.h),
          Text(
            AppStrings(context).newArrival,
            style: FontManager.tenorSansRegular(18,
                color: AppColor.black, letterSpacing: 1.5),
          ),
          Image.asset(
            Assets.images.n3_png,
            width: 30.w,
          ),
          SizedBox(height: 1.5.h),
          BlocBuilder<HomeFetchBloc, HomeFetchState>(
            builder: (context, state) {
              String selectedCategory = '';
              if (state is ImageFetchLoadedState) {
                selectedCategory = state.selectedCategory;
              }

              return SizedBox(
                height: 7.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildCategoryItem(context, AppStrings(context).all, selectedCategory),
                    buildCategoryItem(context, AppStrings(context).apparel, selectedCategory),
                    buildCategoryItem(context, AppStrings(context).dress, selectedCategory),
                    buildCategoryItem(context, AppStrings(context).tShirt, selectedCategory),
                    buildCategoryItem(context, AppStrings(context).bag, selectedCategory),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 1.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.w,
                mainAxisSpacing: 1.h,
                childAspectRatio: 0.61,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl: Assets.images.rectangle_325_png,
                  productName: 'Product Name $index',
                  productPrice: '\$29.99',
                );
              },
            ),
          ),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () {
              context.goNamed(AppRoutes.categoryPage);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings(context).exploreMore,
                  style: FontManager.tenorSansRegular(16, color: AppColor.black),
                ),
                SizedBox(width: 4.w,),
                Image.asset(Assets.images.forward_arrow_png,width: 18,height: 18,),
              ],
            ),
          ),
          SizedBox(height: 1.5.h,),
          Image.asset(
            Assets.images.n3_png,
            width: 30.w,
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, String categoryName, String selectedCategory) {
    return CategoryItem(
      text: categoryName,
      isSelected: selectedCategory == categoryName,
      onTap: () {
        context.read<HomeFetchBloc>().add(
          CategorySelectedEvent(
            categoryName,
            shouldFetchImages: !context.read<HomeFetchBloc>().imagesFetched,
          ),
        );  
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../widgets/category_item_row.dart';
import '../widgets/image_caousel.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: BlocBuilder<HomeFetchBloc, HomeFetchState>(
                builder: (context, state) {
                  if (state is ImageFetchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ImageFetchErrorState) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  }

                  if (state is ImageFetchLoadedState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ImageCarousel(imageUrls: state.imageUrls),
                    );
                  }
                  return const Center(child: Text('No images available'));
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings(context).newArrival,
                    style: FontManager.tenorSansRegular(18,
                        color: AppColor.black, letterSpacing: 1.5),
                  ),
                  Image.asset(
                    Assets.images.n3_png,
                    width: 30.w,
                  ),
                  SizedBox(height: 1.5.h),
                  BlocBuilder<HomeFetchBloc, HomeFetchState>(
                    builder: (context, state) {
                      String selectedCategory = '';
                      if (state is ImageFetchLoadedState) {
                        selectedCategory = state.selectedCategory;
                      }
                      return SizedBox(
                        height: 7.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            buildCategoryItem(
                                context, AppStrings(context).all, selectedCategory),
                            buildCategoryItem(
                                context, AppStrings(context).apparel, selectedCategory),
                            buildCategoryItem(
                                context, AppStrings(context).dress, selectedCategory),
                            buildCategoryItem(
                                context, AppStrings(context).tShirt, selectedCategory),
                            buildCategoryItem(
                                context, AppStrings(context).bag, selectedCategory),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCategoryItem(
      BuildContext context, String categoryName, String selectedCategory) {
    return CategoryItem(
      text: categoryName,
      isSelected: selectedCategory == categoryName,
      onTap: () {
        context.read<HomeFetchBloc>().add(CategorySelectedEvent(categoryName));

        if (!context.read<HomeFetchBloc>().imagesFetched) {
          context.read<HomeFetchBloc>().add(ImageFetchStartedEvent());
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class CategoryItem extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: FontManager.tenorSansRegular(
                    14,
                    color: widget.isSelected
                        ? AppColor.black
                        : isHovered
                            ? AppColor.black
                            : AppColor.greyText,
                    letterSpacing: 1.2,
                  ),
                ),
                if (widget.isSelected) ...[
                  SizedBox(height: 0.8.h),
                  Transform.rotate(
                    angle: 15,
                    child: Container(
                      height: 7.0,
                      width: 7.0,
                      decoration: const BoxDecoration(
                        color: AppColor.warning,
                      ),),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/text_style.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final bool isMobile;

  const ImageCarousel({
    super.key, 
    required this.imageUrls,
    this.isMobile = true,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController pageController;
  late Timer autoScrollTimer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    startAutoScroll();
  }

  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (pageController.hasClients) {
        if (currentPage < widget.imageUrls.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    autoScrollTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: widget.isMobile ? 65.h : constraints.maxHeight,
              color: AppColor.lightBlue,
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            // Text overlay
            Positioned(
              bottom: widget.isMobile ? constraints.maxHeight * 0.3 : constraints.maxHeight * 0.4,
              left: 0,
              right: widget.isMobile ? 20.w : 30.w,
              child: Padding(
                padding: EdgeInsets.only(left: widget.isMobile ? 4.w : 8.w),
                child: Text(
                  AppStrings(context).luxuryFashionAccessories,
                  style: FontManager.bodoniModaBoldItalic(
                    widget.isMobile ? 40 : 60,
                    color: AppColor.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Explore Collection button
            Positioned(
              bottom: widget.isMobile ? constraints.maxHeight * 0.1 : constraints.maxHeight * 0.15,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 15.w : 25.w),
                child: InkWell(
                  onTap: () {
                    // Add navigation logic here
                  },
                  child: Container(
                    height: widget.isMobile ? 5.5.h : 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.black.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings(context).exploreCollection,
                        style: FontManager.tenorSansRegular(
                          widget.isMobile ? 16 : 20,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Page indicator
            Positioned(
              bottom: widget.isMobile ? constraints.maxHeight * 0.02 : constraints.maxHeight * 0.05,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.imageUrls.length,
                  effect: CustomizableEffect(
                    dotDecoration: DotDecoration(
                      color: Colors.transparent,
                      rotationAngle: 45,
                      height: widget.isMobile ? 7.0 : 10.0,
                      width: widget.isMobile ? 7.0 : 10.0,
                      dotBorder: DotBorder(color: AppColor.backgroundColor),
                    ),
                    activeDotDecoration: DotDecoration(
                      color: AppColor.backgroundColor,
                      rotationAngle: 45,
                      height: widget.isMobile ? 7.0 : 10.0,
                      width: widget.isMobile ? 7.0 : 10.0,
                      dotBorder: DotBorder(color: AppColor.backgroundColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import '../../../components/base_page_layout.dart';
import '../../../theme/app_color.dart';
import 'responsive_view/home_mobile.dart';
import 'responsive_view/home_web.dart';
import '../../../components/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePageLayout(
      backgroundColor: AppColor.backgroundColor,
      customAppBar: CustomAppBar(
        backgroundColor: AppColor.lightBlue,
      ),
      mobileBody: HomeMobile(),
      webBody: HomeWeb(),
    );
  }
}
import 'package:flutter/material.dart';
class AppColor {

  static const Color backgroundColor = Color(0xFFfcfcfc);
  static const Color white = Colors.white;
  static const Color lightBlue = Color(0xFFE7EAEF);
  static const Color black = Colors.black;
  static const Color lightGrey = Color(0xff6a6a6c);
  static const Color grey = Color(0xFFF9F9F9);
  static const Color greyWhite = Color(0xFFF5F5F5);
  static const Color warning = Color(0xFFDD8560);
  static const Color greyScale = Color(0xFF888888);
  static const Color blackGrey = Color(0xFF333333);
  static const Color greyText = Color(0xFF9f9f9f);
  static const Color blackGreyText = Color(0xFF555555);
  static const Color primary500 = Color(0xFF8576DA);

}
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppStrings {
  final BuildContext context;

  AppStrings(this.context);

  String get changeLanguage => AppLocalizations.of(context)!.changeLanguage;
  String get luxuryFashionAccessories => AppLocalizations.of(context)!.luxuryFashionAccessories;
  String get exploreCollection => AppLocalizations.of(context)!.exploreCollection;
  String get newArrival => AppLocalizations.of(context)!.newArrival;
  String get all => AppLocalizations.of(context)!.all;
  String get apparel => AppLocalizations.of(context)!.apparel;
  String get dress => AppLocalizations.of(context)!.dress;
  String get tShirt => AppLocalizations.of(context)!.tShirt;
  String get bag => AppLocalizations.of(context)!.bag;
  String get reversibleAngoraCardigan => AppLocalizations.of(context)!.reversibleAngoraCardigan;
  String get exploreMore => AppLocalizations.of(context)!.exploreMore;
  String get rupees => AppLocalizations.of(context)!.rupees;
  String get blog => AppLocalizations.of(context)!.blog;
  String get fashion => AppLocalizations.of(context)!.fashion;
  String get promo => AppLocalizations.of(context)!.promo;
  String get policy => AppLocalizations.of(context)!.policy;
  String get lookbook => AppLocalizations.of(context)!.lookbook;
  String get sale => AppLocalizations.of(context)!.sale;
  String get styleGuide => AppLocalizations.of(context)!.styleGuide;
  String get tips => AppLocalizations.of(context)!.tips;
  String get daysAgo => AppLocalizations.of(context)!.daysAgo;
  String get openFashion => AppLocalizations.of(context)!.openFashion;
  String get email => AppLocalizations.of(context)!.email;
  String get number => AppLocalizations.of(context)!.number;
  String get everyDayOpen => AppLocalizations.of(context)!.everyDayOen;
  String get contact => AppLocalizations.of(context)!.contact;
  String get about => AppLocalizations.of(context)!.about;
  String get copyrightOpenUIAllRightsReserved => AppLocalizations.of(context)!.copyrightOpenUIAllRightsReserved;

}
// ignore_for_file: public_member_api_docs,constant_identifier_names,type=lint,unused_element,unused_field
import 'package:flutter/foundation.dart';

//
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// Generated by flutter-assets-generator extension for VS Code
// @mrasityilmaz
// **************************************************************************

@immutable
final class Assets {
  Assets._();
  static final _Fonts fonts = _Fonts._();
  static final _Images images = _Images._();


}

@immutable
final class _Fonts {
  _Fonts._();

  final String bodonimoda_28pt_semibolditalic_ttf = 'assets/fonts/BodoniModa_28pt-SemiBoldItalic.ttf';
  final String bodonimoda_48pt_black_ttf = 'assets/fonts/BodoniModa_48pt-Black.ttf';
  final String bodonimoda_48pt_blackitalic_ttf = 'assets/fonts/BodoniModa_48pt-BlackItalic.ttf';
  final String bodonimoda_48pt_bold_ttf = 'assets/fonts/BodoniModa_48pt-Bold.ttf';
  final String bodonimoda_48pt_bolditalic_ttf = 'assets/fonts/BodoniModa_48pt-BoldItalic.ttf';
  final String bodonimoda_48pt_extrabold_ttf = 'assets/fonts/BodoniModa_48pt-ExtraBold.ttf';
  final String bodonimoda_48pt_extrabolditalic_ttf = 'assets/fonts/BodoniModa_48pt-ExtraBoldItalic.ttf';
  final String bodonimoda_48pt_italic_ttf = 'assets/fonts/BodoniModa_48pt-Italic.ttf';
  final String bodonimoda_48pt_medium_ttf = 'assets/fonts/BodoniModa_48pt-Medium.ttf';
  final String bodonimoda_48pt_mediumitalic_ttf = 'assets/fonts/BodoniModa_48pt-MediumItalic.ttf';
  final String bodonimoda_48pt_regular_ttf = 'assets/fonts/BodoniModa_48pt-Regular.ttf';
  final String bodonimoda_48pt_semibold_ttf = 'assets/fonts/BodoniModa_48pt-SemiBold.ttf';
  final String bodonimoda_48pt_semibolditalic_ttf = 'assets/fonts/BodoniModa_48pt-SemiBoldItalic.ttf';
  final String bodonimoda_72pt_black_ttf = 'assets/fonts/BodoniModa_72pt-Black.ttf';
  final String bodonimoda_72pt_blackitalic_ttf = 'assets/fonts/BodoniModa_72pt-BlackItalic.ttf';
  final String bodonimoda_72pt_bold_ttf = 'assets/fonts/BodoniModa_72pt-Bold.ttf';
  final String bodonimoda_72pt_bolditalic_ttf = 'assets/fonts/BodoniModa_72pt-BoldItalic.ttf';
  final String bodonimoda_72pt_extrabold_ttf = 'assets/fonts/BodoniModa_72pt-ExtraBold.ttf';
  final String bodonimoda_72pt_extrabolditalic_ttf = 'assets/fonts/BodoniModa_72pt-ExtraBoldItalic.ttf';
  final String bodonimoda_72pt_italic_ttf = 'assets/fonts/BodoniModa_72pt-Italic.ttf';
  final String bodonimoda_72pt_medium_ttf = 'assets/fonts/BodoniModa_72pt-Medium.ttf';
  final String bodonimoda_72pt_mediumitalic_ttf = 'assets/fonts/BodoniModa_72pt-MediumItalic.ttf';
  final String bodonimoda_72pt_regular_ttf = 'assets/fonts/BodoniModa_72pt-Regular.ttf';
  final String bodonimoda_72pt_semibold_ttf = 'assets/fonts/BodoniModa_72pt-SemiBold.ttf';
  final String bodonimoda_72pt_semibolditalic_ttf = 'assets/fonts/BodoniModa_72pt-SemiBoldItalic.ttf';
  final String ofl_txt = 'assets/fonts/OFL.txt';
  final String tenorsans_regular_ttf = 'assets/fonts/TenorSans-Regular.ttf';

}

@immutable
final class _Images {
  _Images._();

  final String n3_png = 'assets/images/3.png';
  final String close_png = 'assets/images/Close.png';
  final String forward_arrow_png = 'assets/images/ForwardArrow.png';
  final String logo_png = 'assets/images/Logo.png';
  final String menu_png = 'assets/images/Menu.png';
  final String rectangle_325_png = 'assets/images/Rectangle325.png';
  final String rectangle_344_png = 'assets/images/Rectangle 344.png';
  final String rectangle_433_png = 'assets/images/Rectangle 433.png';
  final String rectangle_434_png = 'assets/images/Rectangle 434.png';
  final String search_png = 'assets/images/Search.png';
  final String shopping_bag_png = 'assets/images/shopping_bag.png';
  final String twitter_png = 'assets/images/Twitter.png';
  final String youTube_png = 'assets/images/YouTube.png';
  final String instagram_png = 'assets/images/Instagram.png';

}
