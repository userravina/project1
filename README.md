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
if (kIsWeb) {
      // Replace splash with home in history
      html.window.history.replaceState(null, '', '/home');
      
      // Add an extra entry to prevent going back
      html.window.history.pushState(null, '', '/home');
      
      _subscription = html.window.onPopState.listen((event) {
        // If user clicks back, push two new states
        html.window.history.pushState(null, '', '/home');
        html.window.history.pushState(null, '', '/home');
      });
    }


import 'package:auto_route/auto_route.dart';
import 'package:me/routes/app_route_path.dart';
import 'package:me/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override 
  final List<AutoRoute> routes = [
    AutoRoute(
      path: AppRoutePath.splash,
      page: SplashRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: AppRoutePath.home,
      page: HomeRoute.page,
    ),
    AutoRoute(
      path: AppRoutePath.dashboard,
      page: DashboardRoute.page,
      children: [
        AutoRoute(
          path: AppRoutePath.users,
          page: UserListRoute.page,
        ),
      ],
    ),
  ];
} 

class AppRoutePath {
  static const String splash = '/';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String users = 'users';
} 

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../services/navigation_service.dart';
import '../../../../routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      await context.router.replace(HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/logo.png'),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:me/routes/app_router.gr.dart';
import '../widgets/workout_card.dart';
import '../widgets/exercise_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children:  [
          InkWell(onTap: () {
              context.pushRoute(DashboardRoute());
          },child: WorkoutCard()),
          ExerciseCard(),
        ],
      ),
    );
  }
} 

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  setPathUrlStrategy();

  GetIt.I.registerSingleton<AppRouter>(AppRouter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = GetIt.I<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_color.dart';
import '../utils/text_style.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productPrice;
  final bool category;
  final String shortDesc;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    this.category = false,
    this.shortDesc = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: category == true
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          height: 25.h,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.contain)),
          child: category
              ?  Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.w,bottom: 0.5.h),
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColor.warning,
                    ),
                  ),
                )
              : SizedBox.shrink(),
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
        if (category)
          Column(
            children: [
              Text(
                shortDesc,
                style: FontManager.tenorSansRegular(
                  12,
                  color: AppColor.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 1.h),
            ],
          ),
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

import 'package:e_commerce/common_components/common_view_end.dart';
import 'package:e_commerce/common_components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../assets.dart';
import '../routes/app_route.dart';
import '../theme/app_color.dart';
import '../utils/app_strings.dart';
import '../utils/text_style.dart';

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
              Assets.images.youtube_png,
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
import '../assets.dart';
import '../utils/app_strings.dart';
import '../utils/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;

  const CustomAppBar({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: Image.asset(
          Assets.images.menu_png,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        AppStrings(context).openFashion,
        style: FontManager.bodoniModaBoldItalic(16),
      ),
      centerTitle: true,
      surfaceTintColor: backgroundColor,
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.images.search_png,
            height: 24,
            width: 24,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(
            Assets.images.shopping_bag_png,
            height: 24,
            width: 24,
          ),
          onPressed: () {},
        ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/bloc/localization_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../assets.dart';
import '../bloc/localization_event.dart';
import '../../screens/blog_page/bloc/blog_bloc.dart';
import '../routes/app_route.dart';
import '../screens/blog_page/bloc/blog_event.dart';
import '../screens/blog_page/bloc/blog_state.dart';

class CustomDrawer extends StatefulWidget {
  final bool listSwitch;

  const CustomDrawer({super.key, this.listSwitch = false});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
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
            Column(
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
            ),
            TabBar(
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
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(3, (index) {
                  final section = ['Women', 'Men', 'Kids'][index];
                  final categories = ['New', 'Apparel', 'Bag', 'Shoes', 'Beauty', 'Accessories'];
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories[index],
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
                            queryParameters: {'section': section, 'category': categories[index]},
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ),
            Column(
              children: [
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        AppStrings(context).changeLanguage,
                        style: FontManager.tenorSansRegular(16),
                      ),
                    ),
                    ...['English', 'Hindi', 'Arabic'].map((label) => ListTile(
                      title: Text(label, style: FontManager.tenorSansRegular(14)),
                      onTap: () {
                        context.read<LocalizationBloc>().add(ChangeLanguageEvent(label.toLowerCase().substring(0, 2) as Locale));
                        Navigator.pop(context);
                      },
                    )),
                  ],
                ),
                if (widget.listSwitch)
                  ListTile(
                    title: Row(
                      children: [
                        Text("Change View", style: FontManager.tenorSansRegular(16)),
                        const Spacer(),
                        BlocBuilder<BlogViewBloc, BlogViewState>(
                          builder: (context, state) {
                            bool isListView = state is ListState;

                            return Switch(
                              value: isListView,
                              onChanged: (value) {
                                context.read<BlogViewBloc>().add(ToggleViewEvent());
                              },
                            );
                          },
                        ),

                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.5.h),
            Image.asset(Assets.images.n3_png, width: 30.w),
            SizedBox(height: 2.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Image.asset(Assets.images.twitter_png, height: 24, width: 24),
                SizedBox(width: 15.w),
                Image.asset(Assets.images.instagram_png, height: 24, width: 24),
                SizedBox(width: 15.w),
                Image.asset(Assets.images.youtube_png, height: 24, width: 24),
                Spacer(),
              ],
            ),
            SizedBox(height: 2.5.h),
          ],
        ),
      ),
    );
  }
}
///This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class Assets {
  Assets._();

  static const String blocBlogBloc = 'lib/screens/blog_page/bloc/blog_bloc.dart';
  static const String blocBlogEvent = 'lib/screens/blog_page/bloc/blog_event.dart';
  static const String blocBlogState = 'lib/screens/blog_page/bloc/blog_state.dart';
  static const String blocCategoryBloc = 'lib/screens/category_product_page/bloc/category_bloc.dart';
  static const String blocCategoryEvent = 'lib/screens/category_product_page/bloc/category_event.dart';
  static const String blocCategoryState = 'lib/screens/category_product_page/bloc/category_state.dart';
  static const String blocHomeBloc = 'lib/screens/home_page/bloc/home_bloc.dart';
  static const String blocHomeEvent = 'lib/screens/home_page/bloc/home_event.dart';
  static const String blocHomeState = 'lib/screens/home_page/bloc/home_state.dart';
  static const String blocLocalizationBloc = 'lib/bloc/localization_bloc.dart';
  static const String blocLocalizationEvent = 'lib/bloc/localization_event.dart';
  static const String blocLocalizationState = 'lib/bloc/localization_state.dart';
  static const String blocSplashBloc = 'lib/screens/splash_page/data/bloc/splash_bloc.dart';
  static const String blocSplashEvent = 'lib/screens/splash_page/data/bloc/splash_event.dart';
  static const String blocSplashState = 'lib/screens/splash_page/data/bloc/splash_state.dart';
  static const String commonComponentsBasePageLayout = 'lib/common_components/base_page_layout.dart';
  static const String commonComponentsCommonViewEnd = 'lib/common_components/common_view_end.dart';
  static const String commonComponentsCustomAppbar = 'lib/common_components/custom_appbar.dart';
  static const String commonComponentsCustomDrawer = 'lib/common_components/custom_drawer.dart';
  static const String commonComponentsProductCard = 'lib/common_components/product_card.dart';
  static const String fontsBodoniModa28ptSemiBoldItalic = 'assets/fonts/BodoniModa_28pt-SemiBoldItalic.ttf';
  static const String fontsBodoniModa48ptBlack = 'assets/fonts/BodoniModa_48pt-Black.ttf';
  static const String fontsBodoniModa48ptBlackItalic = 'assets/fonts/BodoniModa_48pt-BlackItalic.ttf';
  static const String fontsBodoniModa48ptBold = 'assets/fonts/BodoniModa_48pt-Bold.ttf';
  static const String fontsBodoniModa48ptBoldItalic = 'assets/fonts/BodoniModa_48pt-BoldItalic.ttf';
  static const String fontsBodoniModa48ptExtraBold = 'assets/fonts/BodoniModa_48pt-ExtraBold.ttf';
  static const String fontsBodoniModa48ptExtraBoldItalic = 'assets/fonts/BodoniModa_48pt-ExtraBoldItalic.ttf';
  static const String fontsBodoniModa48ptItalic = 'assets/fonts/BodoniModa_48pt-Italic.ttf';
  static const String fontsBodoniModa48ptMedium = 'assets/fonts/BodoniModa_48pt-Medium.ttf';
  static const String fontsBodoniModa48ptMediumItalic = 'assets/fonts/BodoniModa_48pt-MediumItalic.ttf';
  static const String fontsBodoniModa48ptRegular = 'assets/fonts/BodoniModa_48pt-Regular.ttf';
  static const String fontsBodoniModa48ptSemiBold = 'assets/fonts/BodoniModa_48pt-SemiBold.ttf';
  static const String fontsBodoniModa48ptSemiBoldItalic = 'assets/fonts/BodoniModa_48pt-SemiBoldItalic.ttf';
  static const String fontsBodoniModa72ptBlack = 'assets/fonts/BodoniModa_72pt-Black.ttf';
  static const String fontsBodoniModa72ptBlackItalic = 'assets/fonts/BodoniModa_72pt-BlackItalic.ttf';
  static const String fontsBodoniModa72ptBold = 'assets/fonts/BodoniModa_72pt-Bold.ttf';
  static const String fontsBodoniModa72ptBoldItalic = 'assets/fonts/BodoniModa_72pt-BoldItalic.ttf';
  static const String fontsBodoniModa72ptExtraBold = 'assets/fonts/BodoniModa_72pt-ExtraBold.ttf';
  static const String fontsBodoniModa72ptExtraBoldItalic = 'assets/fonts/BodoniModa_72pt-ExtraBoldItalic.ttf';
  static const String fontsBodoniModa72ptItalic = 'assets/fonts/BodoniModa_72pt-Italic.ttf';
  static const String fontsBodoniModa72ptMedium = 'assets/fonts/BodoniModa_72pt-Medium.ttf';
  static const String fontsBodoniModa72ptMediumItalic = 'assets/fonts/BodoniModa_72pt-MediumItalic.ttf';
  static const String fontsBodoniModa72ptRegular = 'assets/fonts/BodoniModa_72pt-Regular.ttf';
  static const String fontsBodoniModa72ptSemiBold = 'assets/fonts/BodoniModa_72pt-SemiBold.ttf';
  static const String fontsBodoniModa72ptSemiBoldItalic = 'assets/fonts/BodoniModa_72pt-SemiBoldItalic.ttf';
  static const String fontsOFL = 'assets/fonts/OFL.txt';
  static const String fontsTenorSansRegular = 'assets/fonts/TenorSans-Regular.ttf';
  static const String generatedAssets = 'lib/generated/assets.dart';
  static const String images3 = 'assets/images/3.png';
  static const String imagesBleach = 'assets/images/bleach.png';
  static const String imagesClose = 'assets/images/Close.png';
  static const String imagesFilter = 'assets/images/Filter.png';
  static const String imagesForwardArrow = 'assets/images/ForwardArrow.png';
  static const String imagesGridView = 'assets/images/gridView.png';
  static const String imagesHeart = 'assets/images/Heart.png';
  static const String imagesInstagram = 'assets/images/Instagram.png';
  static const String imagesListview = 'assets/images/Listview.png';
  static const String imagesLogo = 'assets/images/Logo.png';
  static const String imagesMenu = 'assets/images/Menu.png';
  static const String imagesPlus = 'assets/images/Plus.png';
  static const String imagesRectangle325 = 'assets/images/Rectangle325.png';
  static const String imagesRectangle433 = 'assets/images/Rectangle433.png';
  static const String imagesRectangle434 = 'assets/images/Rectangle434.png';
  static const String imagesSearch = 'assets/images/Search.png';
  static const String imagesShoppingBag = 'assets/images/shopping_bag.png';
  static const String imagesTemperature = 'assets/images/temperature.png';
  static const String imagesTop = 'assets/images/top.png';
  static const String imagesTumle = 'assets/images/tumle.png';
  static const String imagesTwitter = 'assets/images/Twitter.png';
  static const String imagesWash = 'assets/images/wash.png';
  static const String imagesYouTube = 'assets/images/YouTube.png';
  static const String l10nIntlAr = 'lib/l10n/intl_ar.arb';
  static const String l10nIntlEn = 'lib/l10n/intl_en.arb';
  static const String l10nIntlHi = 'lib/l10n/intl_hi.arb';
  static const String libAssets = 'lib/assets.dart';
  static const String libBlocObserver = 'lib/bloc_observer.dart';
  static const String libMain = 'lib/main.dart';
  static const String modelBlogModel = 'lib/screens/blog_page/data/model/blog_model.dart';
  static const String repositoryBlogRepository = 'lib/screens/blog_page/data/repository/blog_repository.dart';
  static const String repositoryHomeRepository = 'lib/screens/home_page/data/repository/home_repository.dart';
  static const String responsiveViewBlogDetailsMobile = 'lib/screens/blog_page/view/responsive_view/blog_details_mobile.dart';
  static const String responsiveViewBlogDetailsWeb = 'lib/screens/blog_page/view/responsive_view/blog_details_web.dart';
  static const String responsiveViewBlogMobile = 'lib/screens/blog_page/view/responsive_view/blog_mobile.dart';
  static const String responsiveViewBlogWeb = 'lib/screens/blog_page/view/responsive_view/blog_web.dart';
  static const String responsiveViewCategoryMobile = 'lib/screens/category_product_page/view/responsive_view/category_mobile.dart';
  static const String responsiveViewCategoryWeb = 'lib/screens/category_product_page/view/responsive_view/category_web.dart';
  static const String responsiveViewHomeMobile = 'lib/screens/home_page/view/responsive_view/home_mobile.dart';
  static const String responsiveViewHomeWeb = 'lib/screens/home_page/view/responsive_view/home_web.dart';
  static const String responsiveViewProductDetailMobile = 'lib/screens/product_detail_flow.dart/view/responsive_view/product_detail_mobile.dart';
  static const String responsiveViewProductDetailWeb = 'lib/screens/product_detail_flow.dart/view/responsive_view/product_detail_web.dart';
  static const String routesAppRoute = 'lib/routes/app_route.dart';
  static const String routesRoutes = 'lib/routes/routes.dart';
  static const String servicesStorageServices = 'lib/services/storage_services.dart';
  static const String themeAppColor = 'lib/theme/app_color.dart';
  static const String themeAppTheme = 'lib/theme/app_theme.dart';
  static const String utilsAppStrings = 'lib/utils/app_strings.dart';
  static const String utilsTextStyle = 'lib/utils/text_style.dart';
  static const String viewBlogDetailPage = 'lib/screens/blog_page/view/blog_detail_page.dart';
  static const String viewBlogPage = 'lib/screens/blog_page/view/blog_page.dart';
  static const String viewCategoryProductPage = 'lib/screens/category_product_page/view/category_product_page.dart';
  static const String viewHomePage = 'lib/screens/home_page/view/home_page.dart';
  static const String viewProductDetailPage = 'lib/screens/product_detail_flow.dart/view/product_detail_page.dart';
  static const String viewSplashPage = 'lib/screens/splash_page/view/splash_page.dart';
  static const String widgetsCategoryItemRow = 'lib/screens/home_page/view/widgets/category_item_row.dart';
  static const String widgetsCategoryRowBlog = 'lib/screens/blog_page/view/widgets/category_row_blog.dart';
  static const String widgetsGridView = 'lib/screens/blog_page/view/widgets/grid_view.dart';
  static const String widgetsGridViewCategory = 'lib/screens/category_product_page/view/widgets/grid_view_category.dart';
  static const String widgetsImageCarousel = 'lib/screens/home_page/view/widgets/image_carousel.dart';
  static const String widgetsListView = 'lib/screens/blog_page/view/widgets/list_view.dart';
  static const String widgetsListViewCategory = 'lib/screens/category_product_page/view/widgets/list_view_category.dart';

}

class AppRoutes {
  static const String splashPage = "/";
  static const String homePage = "/home";
  static const String blogPage = "/blog";
  static const String categoryPage = "/category";
  static const String blogDetailsPage = "/blog/details";
  static const String productDetailsPage = "/product/details";
}

import 'package:e_commerce/screens/product_detail_flow.dart/view/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/blog_page/view/blog_detail_page.dart';
import '../screens/blog_page/view/blog_page.dart';
import '../screens/category_product_page/view/category_product_page.dart';
import '../screens/home_page/view/home_page.dart';
import '../screens/splash_page/view/splash_page.dart';
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
              GoRoute(
                path: 'category/details',
                name: AppRoutes.productDetailsPage,
                pageBuilder: (context, state) {
                  // final blogData = state.extra as Map<String, dynamic>;
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: ProductDetailPage(),
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
import 'package:e_commerce/screens/blog_page/bloc/blog_event.dart';
import 'package:e_commerce/screens/blog_page/bloc/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/blog_repository.dart';

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
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc(this.blogRepository) : super(LoadingState()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchBlogPostsEvent>(_onFetchBlogPosts);
    on<FetchBlogDetailsEvent>(_onFetchBlogDetails);
  }

  Future<void> _onFetchCategories(FetchCategoriesEvent event, Emitter<BlogState> emit) async {
    try {
      emit(LoadingState());
      final categories = await blogRepository.fetchCategories();
      if (categories.isEmpty) {
        emit(BlogErrorState("No categories available"));
      } else {
        emit(CategoriesLoadedState(categories));
      }
    } catch (e) {
      emit(BlogErrorState("Failed to fetch categories: ${e.toString()}"));
    }
  }

  Future<void> _onFetchBlogPosts(FetchBlogPostsEvent event, Emitter<BlogState> emit) async {
    try {
      emit(LoadingState());
      final blogPosts = await blogRepository.fetchBlogPosts(event.categoryId ?? -1);
      if (blogPosts.isEmpty) {
        emit(BlogErrorState("No blog posts available"));
      } else {
        emit(BlogPostsLoadedState(blogPosts));
      }
    } catch (e) {
      emit(BlogErrorState("Failed to fetch blog posts: ${e.toString()}"));
    }
  }

  Future<void> _onFetchBlogDetails(FetchBlogDetailsEvent event, Emitter<BlogState> emit) async {
    try {
      emit(LoadingState());
      // You need to implement fetching the blog details based on postId
      final blogDetails = await blogRepository.fetchBlogDetails(event.postId);
      emit(BlogDetailsLoadedState(blogDetails));
    } catch (e) {
      emit(BlogErrorState("Failed to fetch blog details: ${e.toString()}"));
    }
  }
}

import 'package:equatable/equatable.dart';

abstract class BlogViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends BlogViewEvent {}


abstract class BlogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends BlogEvent {}

class FetchBlogPostsEvent extends BlogEvent {
  final int categoryId;

  FetchBlogPostsEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class FetchBlogDetailsEvent extends BlogEvent {
  final int postId;

  FetchBlogDetailsEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}


import 'package:equatable/equatable.dart';

abstract class BlogViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GridState extends BlogViewState {}

class ListState extends BlogViewState {}


abstract class BlogState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesLoadedState extends BlogState {
  final List<Map<String, dynamic>> categories;

  CategoriesLoadedState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class BlogPostsLoadedState extends BlogState {
  final List<Map<String, dynamic>> blogPosts;

  BlogPostsLoadedState(this.blogPosts);

  @override
  List<Object?> get props => [blogPosts];
}

class BlogDetailsLoadedState extends BlogState {
  final Map<String, dynamic> blogDetails;

  BlogDetailsLoadedState(this.blogDetails);

  @override
  List<Object?> get props => [blogDetails];
}

class BlogErrorState extends BlogState {
  final String error;

  BlogErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class LoadingState extends BlogState {}

import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRepository {
  final SupabaseClient _supabaseClient;

  BlogRepository(this._supabaseClient);

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await _supabaseClient.from('blog_category').select();
    print("aaaaaaaaaaaaaaaaaa${response}");
    // if (response != null) {
    //   throw response;
    // }
    //
    // final data = response;
    // return List<Map<String, dynamic>>.from(response);
    // if (response.error != null) {
    //   throw response.error!;
    // }
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchBlogPosts(int categoryId) async {
    final PostgrestList response;
    if(categoryId == -1) {
      response = await _supabaseClient
          .from('blog_post')
          .select();
    } else{
      response = await _supabaseClient
          .from('blog_post')
          .select()
          .eq('category_id', categoryId);
      print("pppppppppppppp${response}");
    }

    // if (response.error != null) {
    //   throw response.error!;
    // }
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> fetchBlogDetails(int postId) async {
    final response = await _supabaseClient
        .from('blog_post_details')
        .select()
        .eq('blog_post_id', postId);
    // if (response.error != null) {
    //   throw response.error!;
    // }
    return Map<String, dynamic>.from(response[0]);
  }
}
import 'package:e_commerce/screens/blog_page/bloc/blog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common_components/custom_appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/text_style.dart';

class BlogDetailMobile extends StatelessWidget {
  const BlogDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is BlogDetailsLoadedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: AssetImage(state.blogDetails['first_image_url']),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    state.blogDetails['title'],
                    style:
                    FontManager.tenorSansRegular(14, color: AppColor.black),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    state.blogDetails['long_description_first'],
                    style: FontManager.tenorSansRegular(12,
                        color: AppColor.blackGrey),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(state.blogDetails['second_image_url']),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                SmoothPageIndicator(
                  controller: PageController(initialPage: 1),
                  count: 3,
                  effect: CustomizableEffect(
                    dotDecoration: DotDecoration(
                      color: Colors.transparent,
                      rotationAngle: 45,
                      height: 7.0,
                      width: 7.0,
                      dotBorder: DotBorder(color: AppColor.backgroundColor),
                    ),
                    activeDotDecoration: DotDecoration(
                      color: AppColor.backgroundColor,
                      rotationAngle: 45,
                      height: 7.0,
                      width: 7.0,
                      dotBorder: DotBorder(color: AppColor.backgroundColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    state.blogDetails['long_description_second'],
                    style: FontManager.tenorSansRegular(12,
                        color: AppColor.blackGrey),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    "Posted by OpenFashion | 3 Days ago",
                    style:
                    FontManager.tenorSansRegular(14, color: AppColor.black),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9.0, vertical: 7.0),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9.0, vertical: 7.0),
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
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          );
        }
        return Container();
      },
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
import 'package:e_commerce/screens/blog_page/view/widgets/grid_view.dart';
import 'package:e_commerce/screens/blog_page/view/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../common_components/custom_appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../bloc/blog_bloc.dart';
import '../../bloc/blog_event.dart';
import '../../bloc/blog_state.dart';
import '../widgets/category_row_blog.dart';

class BlogMobile extends StatelessWidget {
  const BlogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(backgroundColor: AppColor.white),
          SizedBox(height: 4.h),
          SizedBox(
            height: 5.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryRowBlog(
                  text: AppStrings(context).all,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(-1));
                  },
                ),
                CategoryRowBlog(
                  text: AppStrings(context).fashion,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(1));
                  },
                ),
                CategoryRowBlog(
                  text: AppStrings(context).promo,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(2));
                  },
                ),
                CategoryRowBlog(
                  text: AppStrings(context).policy,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(3));
                  },
                ),
                CategoryRowBlog(
                  text: AppStrings(context).lookbook,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(4));
                  },
                ),
                CategoryRowBlog(
                  text: AppStrings(context).sale,
                  isSelected: true,
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogPostsEvent(5));
                  },
                ),
                // Other categories
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
import 'package:e_commerce/screens/blog_page/bloc/blog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/blog_bloc.dart';
import '../../bloc/blog_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class GridViewBlog extends StatelessWidget {
  const GridViewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogPostsLoadedState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 4.w,
                mainAxisSpacing: 1.h,
                childAspectRatio: 1.35,
              ),
              itemCount: state.blogPosts.length,
              itemBuilder: (context, index) {
                final blogPost = state.blogPosts[index];
                return InkWell(
                  onTap: () {
                    context.read<BlogBloc>().add(FetchBlogDetailsEvent(index));
                    context.pushNamed(
                      AppRoutes.blogDetailsPage,
                    );
                  },
                  child: BlogPostItem(
                    imageUrl: blogPost['image_url'],
                    title: blogPost['title'],
                    category: blogPost['category_id'].toString(),
                    date: blogPost['published_at'],
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class BlogPostItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String date;

  const BlogPostItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime publishedDate = DateTime.parse(date);
    String formattedDate = timeago.format(publishedDate);

    return Column(
      children: [
        Expanded(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
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
                    title,
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
        SizedBox(height: 1.h),
        Row(
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(category, style: FontManager.tenorSansRegular(12,
                  color: AppColor.greyScale),),
            ),
            Spacer(),
            Text(formattedDate,  style: FontManager.tenorSansRegular(12,
                color: AppColor.greyScale),),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../assets.dart';
import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/blog_state.dart';

class ListViewBlog extends StatelessWidget {
  const ListViewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is BlogPostsLoadedState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.blogPosts.length,
            itemBuilder: (context, index) {
              final blogPost = state.blogPosts[index];
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.blogDetailsPage,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                  child: Row(
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
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${blogPost['short_description']}",
                              style: FontManager.tenorSansRegular(14,
                                  color: AppColor.black, letterSpacing: 2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "${blogPost['long_description']}",
                              style: FontManager.tenorSansRegular(14,
                                  color: AppColor.blackGrey),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "${blogPost['published_at']}",
                              style: FontManager.tenorSansRegular(12,
                                  color: AppColor.greyScale),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

import 'package:e_commerce/screens/blog_page/bloc/blog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common_components/base_page_layout.dart';
import '../bloc/blog_bloc.dart';
import '../data/repository/blog_repository.dart';
import 'responsive_view/blog_details_mobile.dart';
import 'responsive_view/blog_details_web.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocProvider<BlogBloc>(
      create: (context) => BlogBloc(BlogRepository(Supabase.instance.client))
        ..add(FetchBlogDetailsEvent(-1)),
      child: BlocProvider<BlogViewBloc>(
        create: (context) => BlogViewBloc(),
        child: BasePageLayout(
          listSwitch: true,
          mobileBody: const BlogDetailMobile(),
          webBody: const BlogDetailWeb(),
        ),
      ),
    );
  }
}

import 'package:e_commerce/screens/blog_page/bloc/blog_bloc.dart';
import 'package:e_commerce/screens/blog_page/view/responsive_view/blog_mobile.dart';
import 'package:e_commerce/screens/blog_page/view/responsive_view/blog_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common_components/base_page_layout.dart';
import '../bloc/blog_event.dart';
import '../data/repository/blog_repository.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogBloc>(
      create: (context) => BlogBloc(BlogRepository(Supabase.instance.client))
        ..add(FetchBlogPostsEvent(-1)),
      child: BlocProvider<BlogViewBloc>(
        create: (context) => BlogViewBloc(),
        child: BasePageLayout(
          listSwitch: true,
          mobileBody: const BlogMobile(),
          webBody: const BlogWeb(),
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';

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

import 'package:equatable/equatable.dart';


abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GridState extends CategoryState {}

class ListState extends CategoryState {}

import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends CategoryEvent {}
import 'package:e_commerce/screens/category_product_page/bloc/category_event.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../assets.dart';
import '../../bloc/category_bloc.dart';
import '../../bloc/category_state.dart';
import '../widgets/grid_view_category.dart';
import '../widgets/list_view_category.dart';

class CategoryMobile extends StatelessWidget {
  const CategoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4500 APPAREL",
                style:
                FontManager.tenorSansRegular(14, color: AppColor.blackGrey),
              ),
              Spacer(),
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      color: AppColor.containerGreyBackground),
                  child: Text(
                    "New",
                    style: FontManager.tenorSansRegular(13,
                        color: AppColor.blackGreyText),
                  )),
              SizedBox(
                width: 2.w,
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  bool isListView = state is ListState;

                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(ToggleViewEvent());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: AppColor.containerGreyBackground),
                      child: Image.asset(
                        isListView
                            ? Assets.images.gridview_png
                            : Assets.images.listview_png,
                        height: 20,
                        width: 20,
                        color: AppColor.greyIcon,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 2.w,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: AppColor.containerGreyBackground),
                child: Image.asset(
                  Assets.images.filter_png,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: AppColor.containerGreyBorder, width: 1)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "All",
                    style: FontManager.tenorSansRegular(14,
                        color: AppColor.blackGrey),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Image.asset(
                    Assets.images.close_png,
                    height: 16,
                    width: 16,
                  )
                ],
              )),
          SizedBox(
            height: 1.h,
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is GridState) {
                return const GridViewCategory();
              } else {
                return const ListViewCategory();
              }
            },
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
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
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';
import '../../../../common_components/product_card.dart';
import '../../../../routes/app_route.dart';

class GridViewCategory extends StatelessWidget {
  const GridViewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 1.h,
        childAspectRatio: 0.55,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(onTap: () {
          context.pushNamed(
            AppRoutes.productDetailsPage,
          );
        },
          child: ProductCard(
            category: true,
            imageUrl: Assets.images.top_png,
            productName: 'Product Name $index',
            shortDesc: 'reversible angora cardigan',
            productPrice: '\$29.99',
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';
import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class ListViewCategory extends StatelessWidget {
  const ListViewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return InkWell(onTap: () {
          context.pushNamed(
            AppRoutes.productDetailsPage,
          );
        },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.top_png),
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
                        "lamerei",
                        style: FontManager.tenorSansRegular(
                          14,
                          color: AppColor.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "Recycle Boucle Knit Cardigan Pink",
                        style: FontManager.tenorSansRegular(
                          12,
                          color: AppColor.blackGreyText,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "\$120",
                        style: FontManager.tenorSansRegular(
                          15,
                          color: AppColor.warning,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColor.warning,
                            size: 16,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            "4.8 Ratings",
                            style: FontManager.tenorSansRegular(12,
                                color: AppColor.blackGreyText),
                          )
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Text(
                            "Size",
                            style: FontManager.tenorSansRegular(12,
                                color: AppColor.greyScale),
                          ),
                          SizedBox(
                            width: 1.5.w,
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
                              child: Text(
                                "S",
                                style: FontManager.tenorSansRegular(10,
                                    color: AppColor.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.5.w,
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
                              child: Text(
                                "M",
                                style: FontManager.tenorSansRegular(10,
                                    color: AppColor.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.5.w,
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
                              child: Text(
                                "L",
                                style: FontManager.tenorSansRegular(10,
                                    color: AppColor.black),
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.favorite_border,
                            color: AppColor.warning,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:e_commerce/screens/category_product_page/view/responsive_view/category_mobile.dart';
import 'package:e_commerce/screens/category_product_page/view/responsive_view/category_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_components/base_page_layout.dart';
import '../../../common_components/custom_appbar.dart';
import '../../../theme/app_color.dart';
import '../bloc/category_bloc.dart';

class CategoryProductPage extends StatelessWidget {
  const CategoryProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: BasePageLayout(
        customAppBar: const CustomAppBar(
          backgroundColor: AppColor.white,
        ),
        mobileBody: const CategoryMobile(),
        webBody: const CategoryWeb(),
      ),
    );
  }
}
import 'package:e_commerce/screens/home_page/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
import 'package:e_commerce/assets.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../common_components/product_card.dart';
import '../../../../routes/app_route.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';
import '../../bloc/home_event.dart';
import '../widgets/category_item_row.dart';
import '../widgets/image_carousel.dart';

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
                  imageUrl: Assets.images.rectangle325_png,
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
                Image.asset(Assets.images.forwardarrow_png,width: 18,height: 18,),
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
import '../widgets/image_carousel.dart';

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
import 'package:e_commerce/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/theme/app_color.dart';
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
              bottom: widget.isMobile
                  ? constraints.maxHeight * 0.3
                  : constraints.maxHeight * 0.4,
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
              bottom: widget.isMobile
                  ? constraints.maxHeight * 0.1
                  : constraints.maxHeight * 0.15,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 15.w : 25.w),
                child: InkWell(
                  onTap: () {
                    // Add navigation logic here
                  },
                  child: Container(
                    height: widget.isMobile ? 5.5.h : 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // ignore: deprecated_member_use
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
              bottom: widget.isMobile
                  ? constraints.maxHeight * 0.02
                  : constraints.maxHeight * 0.05,
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
import 'package:e_commerce/common_components/custom_appbar.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_mobile.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_web.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:flutter/material.dart';
import '../../../common_components/base_page_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      backgroundColor: AppColor.backgroundColor,
      customAppBar: CustomAppBar(
        backgroundColor: AppColor.lightBlue,
      ),
      mobileBody: HomeMobile(),
      webBody: HomeWeb(),
    );
  }
}

import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../assets.dart';

class ProductDetailMobile extends StatelessWidget {
  const ProductDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.top_png),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MOHAN",
                style: FontManager.tenorSansRegular(16, color: AppColor.black),
              ),
              Image.asset(
                Assets.images.menu_png,
                height: 16,
                width: 16,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Text(
            "Recycle Boucle Knit Cardigan Pink",
            style: FontManager.tenorSansRegular(
              16,
              color: AppColor.blackGreyText,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(height: 0.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Text(
            "\$120",
            style: FontManager.tenorSansRegular(
              18,
              color: AppColor.warning,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Color",
                      style: FontManager.tenorSansRegular(12,
                          color: AppColor.greyScale),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: AppColor.black,
                        border: Border.all(
                            color: AppColor.containerGreyBorder, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: AppColor.warning,
                        border: Border.all(
                            color: AppColor.containerGreyBorder, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: AppColor.grey,
                        border: Border.all(
                            color: AppColor.containerGreyBorder, width: 1),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Size",
                      style: FontManager.tenorSansRegular(12,
                          color: AppColor.greyScale),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: AppColor.blackGrey,
                          border: Border.all(
                              color: AppColor.containerGreyBorder, width: 1)),
                      child: Center(
                        child: Text(
                          "S",
                          style: FontManager.tenorSansRegular(10,
                              color: AppColor.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(
                              color: AppColor.containerGreyBorder, width: 1)),
                      child: Center(
                        child: Text(
                          "M",
                          style: FontManager.tenorSansRegular(10,
                              color: AppColor.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(
                              color: AppColor.containerGreyBorder, width: 1)),
                      child: Center(
                        child: Text(
                          "L",
                          style: FontManager.tenorSansRegular(10,
                              color: AppColor.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          height: 8.h,
          width: double.infinity,
          color: AppColor.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.images.plus_png,
                  height: 20,
                  width: 20,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  "Add to basket",
                  style: FontManager.tenorSansRegular(14,
                      color: AppColor.backgroundColor),
                ),
                Spacer(),
                Image.asset(Assets.images.heart_png)
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 1.5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Column(
            children: [
              Text(
                "MATERIALS",
                style: FontManager.tenorSansRegular(14, color: AppColor.black),
              ),
              Text(
                "We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products. ",
                style: FontManager.tenorSansRegular(14,
                    color: AppColor.blackGreyText),
              ),
              Text(
                "CARE",
                style: FontManager.tenorSansRegular(14, color: AppColor.black),
              ),
              Text(
                "To keep your jackets and coats clean, you only need to freshen them up and go over them with a cloth or a clothes brush. If you need to dry clean a garment, look for a dry cleaner that uses technologies that are respectful of the environment.",
                style: FontManager.tenorSansRegular(14,
                    color: AppColor.blackGreyText),
              ),
              Row(children: [
                Image.asset(Assets.images.bleach_png,height: 24,width: 24,),
                SizedBox(width: 2.w,),
                Text("Do not use bleach",style: FontManager.tenorSansRegular(14,color: AppColor.blackGreyText),)
              ],),
              Row(children: [
                Image.asset(Assets.images.tumle_png,height: 24,width: 24,),
                SizedBox(width: 2.w,),
                Text("Do not tumble dry",style: FontManager.tenorSansRegular(14,color: AppColor.blackGreyText),)
              ],),
              Row(children: [
                Image.asset(Assets.images.temperature_png,height: 24,width: 24,),
                SizedBox(width: 2.w,),
                Text("Dry clean with tetrachloroethylene",style: FontManager.tenorSansRegular(14,color: AppColor.blackGreyText),)
              ],),
              Row(children: [
                Image.asset(Assets.images.temperature_png,height: 24,width: 24,),
                SizedBox(width: 2.w,),
                Text("Iron at a maximum of 110ºC/230ºF",style: FontManager.tenorSansRegular(14,color: AppColor.blackGreyText),)
              ],),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class ProductDetailWeb extends StatelessWidget {
  const ProductDetailWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [

    ],);
  }
}
import 'package:e_commerce/screens/product_detail_flow.dart/view/responsive_view/product_detail_mobile.dart';
import 'package:e_commerce/screens/product_detail_flow.dart/view/responsive_view/product_detail_web.dart';
import 'package:flutter/material.dart';
import '../../../common_components/base_page_layout.dart';
import '../../../common_components/custom_appbar.dart';
import '../../../theme/app_color.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      backgroundColor: AppColor.backgroundColor,
      customAppBar: CustomAppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      mobileBody: ProductDetailMobile(),
      webBody: ProductDetailWeb(),
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
  static const Color greyIcon = Color(0xFF878792);
  static const Color containerGreyBackground = Color(0xFFf9f9f9);
  static const Color containerGreyBorder = Color(0xFFdedede);


}
import 'package:flutter/widgets.dart';
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
  final String bleach_png = 'assets/images/bleach.png';
  final String close_png = 'assets/images/Close.png';
  final String filter_png = 'assets/images/Filter.png';
  final String forwardarrow_png = 'assets/images/ForwardArrow.png';
  final String gridview_png = 'assets/images/gridView.png';
  final String heart_png = 'assets/images/Heart.png';
  final String instagram_png = 'assets/images/Instagram.png';
  final String listview_png = 'assets/images/Listview.png';
  final String logo_png = 'assets/images/Logo.png';
  final String menu_png = 'assets/images/Menu.png';
  final String plus_png = 'assets/images/Plus.png';
  final String rectangle325_png = 'assets/images/Rectangle325.png';
  final String rectangle433_png = 'assets/images/Rectangle433.png';
  final String rectangle434_png = 'assets/images/Rectangle434.png';
  final String search_png = 'assets/images/Search.png';
  final String shopping_bag_png = 'assets/images/shopping_bag.png';
  final String temperature_png = 'assets/images/temperature.png';
  final String top_png = 'assets/images/top.png';
  final String tumle_png = 'assets/images/tumle.png';
  final String twitter_png = 'assets/images/Twitter.png';
  final String wash_png = 'assets/images/wash.png';
  final String youtube_png = 'assets/images/YouTube.png';

}
import 'package:e_commerce/bloc/localization_state.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/screens/home_page/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'bloc/localization_bloc.dart';
import 'bloc/localization_event.dart';
import 'bloc_observer.dart';
import 'screens/home_page/bloc/home_bloc.dart';
import 'screens/splash_page/data/bloc/splash_bloc.dart';
import 'screens/splash_page/data/bloc/splash_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://exzhxtmqdlyfriwjeuti.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4emh4dG1xZGx5ZnJpd2pldXRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY1NjkyODEsImV4cCI6MjA1MjE0NTI4MX0.Ey1W1LtqATaOPhKUGRlXcsZY5jOl4dPKhK3SdEsBQhU',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = ChatObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()..add(SplashStartEvent())),
          BlocProvider(
            create: (_) =>
            HomeFetchBloc(Supabase.instance.client)..add(ImageFetchStartedEvent()),
          ),
          BlocProvider(
            create: (_) => LocalizationBloc()..add(GetLanguageEvent()),
          )
        ],
        child: BlocBuilder<LocalizationBloc,LocalizationState>(builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: state.selectedLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // theme: AppTheme.darkTheme(),
            routerConfig: Routes.router,
            // routerDelegate: Routes.router.routerDelegate,
            // routeInformationProvider: Routes.router.routeInformationProvider,
            // routeInformationParser: Routes.router.routeInformationParser,
          );
        }),
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


