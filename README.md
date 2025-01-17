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
import 'package:e_commerce/bloc/localization_state.dart';
import 'package:e_commerce/screens/home_page/bloc/home_event.dart';
import 'package:e_commerce/screens/home_page/data/repository/home_repository.dart';
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
import 'screens/routes/routes.dart';
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
            HomeFetchBloc(HomeRepository(Supabase.instance.client))..add(ImageFetchStartedEvent()),
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
          );
        }),
      ),
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
  static const Color whiteSmokeSuccess = Color(0xFFA4F4E7);
  static const Color warning = Color(0xFFDD8560);
  static const Color primary100 = Color(0xFFE6E3F8);
  static const Color primary200 = Color(0xFFCEC8F0);
  static const Color primary300 = Color(0xFFB6ACE9);
  static const Color primary400 = Color(0xFF9D91E1);
  static const Color primary500 = Color(0xFF8576DA);

}

import 'package:e_commerce/screens/routes/app_route.dart';
import 'package:go_router/go_router.dart';
import '../blog_page/view/blog_page.dart';
import '../home_page/view/home_page.dart';
import '../splash_page/view/splash_page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splashPage,
        builder: (context, state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.homePage,
            name: AppRoutes.homePage,
            builder: (context, state) {
              return const HomePage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.blogPage,
                name: AppRoutes.blogPage,
                builder: (context, state) {
                  return const BlogPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
class AppRoutes {
  static const String splashPage = "/";
  static const String homePage = "/home";
  static const String blogPage = "/blog";
}
import 'package:e_commerce/common_components/custom_appbar.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_mobile.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_web.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common_components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            backgroundColor: AppColor.lightBlue,
          ),
          drawer: CustomDrawer(),
          body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return HomeWeb();
              }
              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile ||
                  sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                return HomeMobile();
              }
              return const SizedBox();
            },
          ),
        ));
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

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  // ignore: library_private_types_in_public_api
  _ImageCarouselState createState() => _ImageCarouselState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double carouselHeight = constraints.maxHeight;
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: carouselHeight,
              color: AppColor.lightBlue,
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: carouselHeight * 0.3,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 4.w),
                      child: Text(
                        AppStrings(context).luxuryFashionAccessories,
                        style: FontManager.bodoniModaBoldItalic(40, color: AppColor.lightGrey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: carouselHeight * 0.1,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    height: 5.5.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.black,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings(context).exploreCollection,
                        style: FontManager.tenorSansRegular(16, color: AppColor.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: carouselHeight * 0.02,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.imageUrls.length,
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
              ),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class CategoryItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          onEnter: (_) {},
          onExit: (_) {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    text,
                    style: FontManager.tenorSansRegular(
                      14,
                      color: isSelected ? AppColor.warning : AppColor.black,
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  if(isSelected)
                    Transform.rotate(
                      angle: 15,
                      child: Container(
                        height: 7.0,
                        width: 7.0,
                        decoration: BoxDecoration(
                          color: AppColor.warning,
                        ),
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
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

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
import 'package:e_commerce/assets.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../routes/app_route.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';
import '../../bloc/home_event.dart';
import '../widgets/categoryItemRow.dart';
import '../widgets/imageCarousel.dart';
import '../widgets/productCard.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<HomeFetchBloc, HomeFetchState>(builder: (context, state) {
            if (state is ImageFetchLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ImageFetchErrorState) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            if (state is ImageFetchLoadedState) {
              return SizedBox(
                height: 65.h,
                child: ImageCarousel(imageUrls: state.imageUrls),
              );
            }
            return Center(child: Text('No images available'));
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
          BlocBuilder<HomeFetchBloc, HomeFetchState>(builder: (context, state) {
            String selectedCategory =
            (state is CategorySelectedState) ? state.selectedCategory : '';

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
          }),
          SizedBox(height: 1.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
              context.goNamed(AppRoutes.blogPage);
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
        context.read<HomeFetchBloc>().add(ImageFetchStartedEvent());
        // context.read<HomeFetchBloc>().add(CategorySelectedEvent(categoryName));

        if (!context.read<HomeFetchBloc>().imagesFetched) {
          context.read<HomeFetchBloc>().add(ImageFetchStartedEvent());
        }
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
import '../widgets/categoryItemRow.dart';
import '../widgets/imageCarousel.dart';


class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: BlocBuilder<HomeFetchBloc, HomeFetchState>(
            builder: (context, state) {
              if (state is ImageFetchLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is ImageFetchErrorState) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              if (state is ImageFetchLoadedState) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ImageCarousel(imageUrls: state.imageUrls),
                );
              }
              return Center(child: Text('No images available'));
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
                  String selectedCategory =
                  (state is CategorySelectedState) ? state.selectedCategory : '';

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

import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepository {
  final SupabaseClient supabaseClient;

  HomeRepository(this.supabaseClient);

  Future<List<String>> fetchImageUrls() async {
    try {
      // final url1 = await supabaseClient.storage
      //     .from('fashion-accessories-images')
      //     .getPublicUrl("s4.jpg");
      // final url2 = await supabaseClient.storage
      //     .from('fashion-accessories-images')
      //     .getPublicUrl("s3.jpg");
      // final url3 = await supabaseClient.storage
      //     .from('fashion-accessories-images')
      //     .getPublicUrl("s3.avif");
      // final url4 = await supabaseClient.storage
      //     .from('fashion-accessories-images')
      //     .getPublicUrl("image_10-removebg-preview.png");
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      return [

        "https://exzhxtmqdlyfriwjeuti.supabase.co/storage/v1/object/public/fashion-accessories-images/image_10-removebg-preview.png",
        "https://exzhxtmqdlyfriwjeuti.supabase.co/storage/v1/object/public/fashion-accessories-images/image_10-removebg-preview.png",

        "https://exzhxtmqdlyfriwjeuti.supabase.co/storage/v1/object/public/fashion-accessories-images/image_10-removebg-preview.png",

        "https://exzhxtmqdlyfriwjeuti.supabase.co/storage/v1/object/public/fashion-accessories-images/image_10-removebg-preview.png",
      ];
    } catch (e) {
      throw Exception('Failed to load images: $e');
    }
  }
}
import 'package:equatable/equatable.dart';

abstract class HomeFetchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageFetchStartedEvent extends HomeFetchEvent {}

class CategorySelectedEvent extends HomeFetchEvent {
  final String categoryName;

  CategorySelectedEvent(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}
import 'package:e_commerce/screens/home_page/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeFetchBloc extends Bloc<HomeFetchEvent, HomeFetchState> {
  final HomeRepository homeRepository;
  bool imagesFetched = false;

  HomeFetchBloc(this.homeRepository) : super(ImageFetchInitialState()) {
    on<ImageFetchStartedEvent>((event, emit) async {
      if (!imagesFetched) {
        try {
          emit(ImageFetchLoadingState());
          final imageUrls = await homeRepository.fetchImageUrls();
          imagesFetched = true;
          emit(ImageFetchLoadedState(imageUrls));
        } catch (e) {
          emit(ImageFetchErrorState('Failed to load images: $e'));
        }
      }
    });


    on<CategorySelectedEvent>((event, emit) {
      print("aaaaaaaaaa111111111${state}");
      emit(CategorySelectedState(event.categoryName));
    });
  }
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

  ImageFetchLoadedState(this.imageUrls);

  @override
  List<Object?> get props => [imageUrls];
}

class ImageFetchErrorState extends HomeFetchState {
  final String errorMessage;

  ImageFetchErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CategorySelectedState extends HomeFetchState {
  final String selectedCategory;

  CategorySelectedState(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';

class CategoryBlog extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryBlog({
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
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.grey,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    text,
                    style: FontManager.tenorSansRegular(
                      14,
                      color: isSelected ? AppColor.warning : AppColor.black,
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
}
import 'package:e_commerce/common_components/custom_appbar.dart';
import 'package:e_commerce/screens/blog_page/view/responsive_view/bloc_mobile.dart';
import 'package:e_commerce/screens/blog_page/view/responsive_view/bloc_web.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_mobile.dart';
import 'package:e_commerce/screens/home_page/view/responsive_view/home_web.dart';
import 'package:e_commerce/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common_components/custom_drawer.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: CustomAppBar(
            backgroundColor: AppColor.white,
          ),
          drawer: CustomDrawer(),
          body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return BlogWeb();
              }
              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile ||
                  sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                return BlogMobile();
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
import 'package:flutter/material.dart';

class BlogWeb extends StatelessWidget {
  const BlogWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../assets.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/text_style.dart';
import '../widgets/categoryBlog.dart';

// Today's update :
//- property card create home page ui and Blog page ui set setting manage listview and gridview in e-commerce app
class BlogMobile extends StatelessWidget {
  const BlogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            Text(
              AppStrings(context).blog,
              style: FontManager.tenorSansRegular(18,
                  color: AppColor.black, letterSpacing: 1.5),
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
                  CategoryBlog(
                    text: AppStrings(context).fashion,
                    isSelected: true,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: AppStrings(context).promo,
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: AppStrings(context).policy,
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: AppStrings(context).lookbook,
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: AppStrings(context).sale,
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 1.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.images.rectangle_434_png),
                        fit: BoxFit.contain,
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
                            width: double.infinity,
                            height: 5.h,
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              'Blog Item ${AppStrings(context).styleGuide}',
                              style: FontManager.tenorSansRegular(16,
                                  color: AppColor.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

