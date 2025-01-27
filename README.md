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
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}
class ToggleThemeEvent extends ThemeEvent {}

abstract class ThemeState {
  final bool isDark;
  const ThemeState(this.isDark);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.isDark);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(false)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeInitial(!state.isDark));
    });
  }
} 
import 'package:e_commerce/utils/app_strings.dart';
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import '../assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;

  const CustomAppBar({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      leading: IconButton(
        icon: Image.asset(
          Assets.images.menu_png,
          height: 24,
          width: 24,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Text(
        AppStrings(context).openFashion,
        style: FontManager.bodoniModaBoldItalic(
          16,
          color: theme.colorScheme.onSurface,
        ),
      ),
      centerTitle: true,
      surfaceTintColor: backgroundColor,
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.images.search_png,
            height: 24,
            width: 24,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(
            Assets.images.shopping_bag_png,
            height: 24,
            width: 24,
            color: theme.colorScheme.onSurface,
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../assets.dart';
import '../bloc/localization/localization_bloc.dart';
import '../bloc/localization/localization_event.dart';
import '../routes/app_route.dart';
import '../screens/blog_flow/bloc/blog_bloc.dart';
import '../theme/app_color.dart';
import '../utils/app_strings.dart';
import '../utils/text_style.dart';
import '../bloc/theme/theme_bloc.dart';

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
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        backgroundColor: theme.colorScheme.surface,
        child: Column(
          children: [
            Container(
              color: theme.colorScheme.surface,
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: theme.colorScheme.onSurface,
              labelStyle: FontManager.tenorSansRegular(14,),
              unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.6),
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
                              style: FontManager.tenorSansRegular(16, color: theme.colorScheme.onSurface),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: theme.colorScheme.onSurface,
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
                Divider(color: Theme.of(context).dividerColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        AppStrings(context).changeLanguage,
                        style: FontManager.tenorSansRegular(16, color: theme.colorScheme.onSurface),
                      ),
                    ),
                    ...['English', 'Hindi', 'Arabic'].map((label) => ListTile(
                      title: Text(label, style: FontManager.tenorSansRegular(14, color: theme.colorScheme.onSurface)),
                      onTap: () {
                        context.read<LocalizationBloc>().add(ChangeLanguageEvent(label.toLowerCase().substring(0, 2) as String));
                        Navigator.pop(context);
                      },
                    )),
                  ],
                ),
                if (widget.listSwitch)
                  ListTile(
                    title: Row(
                      children: [
                        Text("Change View", style: FontManager.tenorSansRegular(16, color: theme.colorScheme.onSurface)),
                        const Spacer(),
                        BlocBuilder<BlogBloc, BlogState>(
                          builder: (context, state) {
                            return Switch(
                              value: !state.isGridView,
                              onChanged: (value) {
                                context.read<BlogBloc>().add(ToggleViewEvent());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return ListTile(
                      leading: Icon(
                        themeState.isDark ? Icons.light_mode : Icons.dark_mode,
                        color: theme.primaryColor,
                      ),
                      title: Text(
                        Theme.of(context).brightness == Brightness.dark ? 'Light Mode' : 'Dark Mode',
                        style: FontManager.tenorSansRegular(
                          14,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      onTap: () {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    );
                  },
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/blog_flow/bloc/blog_bloc.dart';
import '../screens/blog_flow/view/blog_details_page.dart';
import '../screens/blog_flow/view/blog_page.dart';
import '../screens/category_product_page/view/category_product_page.dart';
import '../screens/home_flow/view/home_screen.dart';
import '../screens/product_detail_flow/view/product_details_page.dart';
import '../screens/splash_flow/view/splash_screen.dart';
import 'app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      position: animation.drive(
                        Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                      ),
                      child: child,
                    );
                  },
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    name: AppRoutes.blogDetailsPage,
                    pageBuilder: (context, state) {
                      final postId = state.extra as int;
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: BlocProvider.value(
                          value: context.read<BlogBloc>()..add(FetchBlogDetailsEvent(postId)),
                          child: BlogDetailsPage(postId: postId),
                        ),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                            ),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                ],
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

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository_bloc.dart';

// Combined Events
abstract class BlogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends BlogEvent {}

class FetchCategoriesEvent extends BlogEvent {}

class FetchBlogPostsEvent extends BlogEvent {
  final int? categoryId;

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

class RestorePreviousStateEvent extends BlogEvent {}

// Combined States
abstract class BlogState extends Equatable {
  final bool isGridView;
  final int? selectedCategoryId;
  
  const BlogState({
    this.isGridView = true,
    this.selectedCategoryId = -1,
  });
  
  @override
  List<Object?> get props => [isGridView, selectedCategoryId];
}

class LoadingState extends BlogState {
  const LoadingState({super.isGridView, super.selectedCategoryId});
}

class CategoriesLoadedState extends BlogState {
  final List<Map<String, dynamic>> categories;
  const CategoriesLoadedState(this.categories, {
    super.isGridView,
    super.selectedCategoryId,
  });
  
  @override
  List<Object?> get props => [categories, isGridView, selectedCategoryId];
}

class BlogPostsLoadedState extends BlogState {
  final List<Map<String, dynamic>> blogPosts;
  const BlogPostsLoadedState(
    this.blogPosts, {
    super.isGridView,
    super.selectedCategoryId,
  });
  
  @override
  List<Object?> get props => [blogPosts, isGridView, selectedCategoryId];
}

class BlogDetailsLoadedState extends BlogState {
  final Map<String, dynamic> blogDetails;
  const BlogDetailsLoadedState(this.blogDetails, {
    super.isGridView,
    super.selectedCategoryId,
  });
  
  @override
  List<Object?> get props => [blogDetails, isGridView, selectedCategoryId];
}

class BlogErrorState extends BlogState {
  final String error;
  const BlogErrorState(this.error, {
    super.isGridView,
    super.selectedCategoryId,
  });
  
  @override
  List<Object?> get props => [error, isGridView, selectedCategoryId];
}

// Combined BLoC
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;
  bool _isGridView = true;
  List<Map<String, dynamic>>? _cachedCategories;
  List<Map<String, dynamic>>? _cachedPosts;
  Map<int, Map<String, dynamic>>? _cachedBlogDetails;
  static BlogBloc? _instance;
  BlogState? _previousState;

  factory BlogBloc(BlogRepository repository) {
    if (_instance == null) {
      _instance = BlogBloc._internal(repository);
      // Initialize with both categories and posts
      _instance!._initializeData();
    }
    return _instance!;
  }

  BlogBloc._internal(this.blogRepository) : super(const LoadingState()) {
    on<ToggleViewEvent>(_onToggleView);
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchBlogPostsEvent>(_onFetchBlogPosts);
    on<FetchBlogDetailsEvent>(_onFetchBlogDetails);
    on<RestorePreviousStateEvent>(_onRestorePreviousState);
  }

  void _initializeData() {
    // Use events instead of direct emit
    add(FetchCategoriesEvent());
    add(FetchBlogPostsEvent(-1));
  }

  void _onToggleView(ToggleViewEvent event, Emitter<BlogState> emit) {
    _isGridView = !_isGridView;
    if (state is BlogPostsLoadedState) {
      emit(BlogPostsLoadedState(
        (state as BlogPostsLoadedState).blogPosts,
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));
    }
  }

  Future<void> _onFetchCategories(FetchCategoriesEvent event, Emitter<BlogState> emit) async {
    try {
      if (_cachedCategories != null) {
        emit(CategoriesLoadedState(
          _cachedCategories!, 
          isGridView: _isGridView,
          selectedCategoryId: state.selectedCategoryId,
        ));
        // Load posts after categories if needed
        if (_cachedPosts == null) {
          add(FetchBlogPostsEvent(-1));
        }
        return;
      }

      emit(LoadingState(isGridView: _isGridView, selectedCategoryId: state.selectedCategoryId));
      final categories = await blogRepository.fetchCategories();
      _cachedCategories = categories;
      emit(CategoriesLoadedState(
        categories, 
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));
      
      // Load posts after categories
      add(FetchBlogPostsEvent(-1));
    } catch (e) {
      emit(BlogErrorState(
        "Failed to fetch categories: ${e.toString()}", 
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));
    }
  }

  Future<void> _onFetchBlogPosts(FetchBlogPostsEvent event, Emitter<BlogState> emit) async {
    final selectedId = event.categoryId ?? -1;
    try {
      // Use cached data if available for all posts
      if (_cachedPosts != null && selectedId == -1) {
        emit(BlogPostsLoadedState(
          _cachedPosts!,
          isGridView: _isGridView,
          selectedCategoryId: selectedId,
        ));
        return;
      }

      emit(LoadingState(isGridView: _isGridView, selectedCategoryId: selectedId));
      final blogPosts = await blogRepository.fetchBlogPosts(selectedId);
      
      // Cache all posts
      if (selectedId == -1) {
        _cachedPosts = blogPosts;
      }

      emit(BlogPostsLoadedState(
        blogPosts,
        isGridView: _isGridView,
        selectedCategoryId: selectedId,
      ));
    } catch (e) {
      emit(BlogErrorState(
        "Failed to fetch blog posts: ${e.toString()}", 
        isGridView: _isGridView,
        selectedCategoryId: selectedId,
      ));
    }
  }

  Future<void> _onFetchBlogDetails(FetchBlogDetailsEvent event, Emitter<BlogState> emit) async {
    try {
      // Store current state before loading details
      if (state is! BlogDetailsLoadedState) {
        _previousState = state;
      }
      
      // Use cached details if available
      if (_cachedBlogDetails?.containsKey(event.postId) ?? false) {
        emit(BlogDetailsLoadedState(
          _cachedBlogDetails![event.postId]!,
          isGridView: _isGridView,
          selectedCategoryId: state.selectedCategoryId,
        ));
        return;
      }

      emit(LoadingState(isGridView: _isGridView, selectedCategoryId: state.selectedCategoryId));
      final blogDetails = await blogRepository.fetchBlogDetails(event.postId);
      
      // Cache the details
      _cachedBlogDetails ??= {};
      _cachedBlogDetails![event.postId] = blogDetails;

      emit(BlogDetailsLoadedState(
        blogDetails,
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));
    } catch (e) {
      emit(BlogErrorState(
        "Failed to fetch details: ${e.toString()}",
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));
    }
  }

  void _onRestorePreviousState(RestorePreviousStateEvent event, Emitter<BlogState> emit) {
    if (_previousState != null) {
      emit(_previousState!);
      _previousState = null;
    } else if (_cachedPosts != null) {
      // Fallback to showing all posts
      emit(BlogPostsLoadedState(
        _cachedPosts!,
        isGridView: _isGridView,
        selectedCategoryId: -1,
      ));
    }
  }

  void restorePreviousState() {
    add(RestorePreviousStateEvent());
  }

  @override
  Future<void> close() {
    if (_instance == this) {
      _instance = null;
      _cachedPosts = null;
      _cachedCategories = null;
      _cachedBlogDetails = null;
      _previousState = null;
    }
    return super.close();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRepository {
  final SupabaseClient _supabaseClient;

  BlogRepository(this._supabaseClient);

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await _supabaseClient
        .from('blog_category')
        .select()
        .order('id');
    
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchBlogPosts(int categoryId) async {
    var query = _supabaseClient
        .from('blog_post')
        .select('''
          *,
          blog_category (
            name
          )
        ''');

    if (categoryId != -1) {
      query = query.eq('category_id', categoryId);
    }

    final response = await query.order('published_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> fetchBlogDetails(int postId) async {
    final response = await _supabaseClient
        .from('blog_post_details')
        .select('''
          *,
          blog_post (
            title,
            published_at,
            category_id,
            blog_category (
              name
            )
          )
        ''')
        .eq('blog_post_id', postId)
        .single();

    return response;
  }
}
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../components/appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../bloc/blog_bloc.dart';

class BlogDetailMobile extends StatelessWidget {
  const BlogDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogDetailsLoadedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                  backgroundColor: AppColor.white,
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.blogDetails['first_image_url']),
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
                      image: NetworkImage(state.blogDetails['second_image_url']),
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/blog_bloc.dart';

class BlogDetailWeb extends StatelessWidget {
  const BlogDetailWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BlogDetailsLoadedState) {
          final blogDetails = state.blogDetails;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left content area
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blogDetails['title'] ?? '',
                        style: FontManager.tenorSansRegular(24),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(blogDetails['image_url'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right content area
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blogDetails['long_description'] ?? '',
                        style: FontManager.tenorSansRegular(16),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Category: ${blogDetails['blog_category']?['name'] ?? ''}',
                        style: FontManager.tenorSansRegular(14, color: AppColor.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is BlogErrorState) {
          return Center(child: Text(state.error));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../components/appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../bloc/blog_bloc.dart';
import '../widgets/category_row_blog.dart';
import '../widgets/grid_view_blog.dart';
import '../widgets/list_view_blog.dart';
import '../widgets/blog_shimmer.dart';

class BlogMobile extends StatelessWidget {
  const BlogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(backgroundColor: AppColor.white),
              SizedBox(height: 4.h),
              SizedBox(
                height: 5.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryRowBlog(
                      text: AppStrings(context).all,
                      isSelected: state.selectedCategoryId == -1,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(-1)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).fashion,
                      isSelected: state.selectedCategoryId == 1,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(1)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).promo,
                      isSelected: state.selectedCategoryId == 2,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(2)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).policy,
                      isSelected: state.selectedCategoryId == 3,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(3)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).lookbook,
                      isSelected: state.selectedCategoryId == 4,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(4)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).sale,
                      isSelected: state.selectedCategoryId == 5,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(5)),
                    ),
                    // Other categories
                  ],
                ),
              ),
              SizedBox(height: 4.5.h),
              if (state is LoadingState)
                const BlogShimmer()
              else if (state is BlogPostsLoadedState)
                state.isGridView ? const GridViewBlog() : const ListViewBlog()
              else if (state is BlogErrorState)
                Center(child: Text(state.error)),
              SizedBox(height: 3.h),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../components/appbar.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/app_strings.dart';
import '../../bloc/blog_bloc.dart';
import '../widgets/blog_shimmer.dart';
import '../widgets/category_row_blog.dart';
import '../widgets/grid_view_blog.dart';
import '../widgets/list_view_blog.dart';

class BlogWeb extends StatelessWidget {
  const BlogWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left sidebar with categories
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
                    CategoryRowBlog(
                      text: AppStrings(context).all,
                      isSelected: state.selectedCategoryId == -1,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(-1)),
                    ),
                    CategoryRowBlog(
                      text: AppStrings(context).fashion,
                      isSelected: state.selectedCategoryId == 1,
                      onTap: () => context.read<BlogBloc>().add(FetchBlogPostsEvent(1)),
                    ),
                    // Add other categories...
                  ],
                ),
              ),
            ),
            // Main content area
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomAppBar(backgroundColor: AppColor.white),
                    SizedBox(height: 4.h),
                    if (state is LoadingState)
                      const BlogShimmer()
                    else if (state is BlogPostsLoadedState)
                      state.isGridView 
                        ? const GridViewBlog() 
                        : const ListViewBlog()
                    else if (state is BlogErrorState)
                      Center(child: Text(state.error)),
                    SizedBox(height: 3.h),
                  ],
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
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BlogShimmer extends StatelessWidget {
  const BlogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  width: 40.w,
                  height: 2.h,
                  color: Colors.white,
                ),
                SizedBox(height: 0.5.h),
                Container(
                  width: 70.w,
                  height: 1.5.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? AppColor.black : AppColor.grey,
          ),
          child: Center(
            child: Text(
              text,
              style: FontManager.tenorSansRegular(
                14,
                color: isSelected ? AppColor.white : AppColor.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../routes/app_route.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/blog_bloc.dart';
import 'list_view_blog.dart';

class GridViewBlog extends StatelessWidget {
  const GridViewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogPostsLoadedState) {
          if (!state.isGridView) {
            return const ListViewBlog();
          }
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
                    final blogId = blogPost['id'] as int;
                    context.pushNamed(
                      AppRoutes.blogDetailsPage,
                      extra: blogId,
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
        return const Center(child: CircularProgressIndicator());
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
import '../../bloc/blog_bloc.dart';

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
import 'package:e_commerce/screens/blog_flow/view/responsive_view/blog_detail_mobile.dart';
import 'package:e_commerce/screens/blog_flow/view/responsive_view/blog_detail_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/base_page_layout.dart';
import '../bloc/blog_bloc.dart';

class BlogDetailsPage extends StatelessWidget {
  final int postId;
  
  const BlogDetailsPage({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<BlogBloc>().restorePreviousState();
        return true;
      },
      child: BasePageLayout(
        listSwitch: false,
        mobileBody: const BlogDetailMobile(),
        webBody: const BlogDetailWeb(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../components/base_page_layout.dart';
import 'responsive_view/blog_mobile.dart';
import 'responsive_view/blog_web.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePageLayout(
      listSwitch: true,
      mobileBody: BlogMobile(),
      webBody: BlogWeb(),
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
import 'package:e_commerce/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../assets.dart';
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
import '../../../../components/product_card.dart';
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
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 100.h,
          color: AppColor.lightBlue,
          child: BlocBuilder<HomeFetchBloc, HomeFetchState>(
            builder: (context, state) {
              if (state is ImageFetchLoadedState) {
                return ImageCarousel(
                  imageUrls: state.imageUrls,
                  isMobile: false,
                );
              }
              return const SizedBox();
            },
          ),
        ),

        // Right Side - Products Section
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings(context).newArrival,
                  style: FontManager.tenorSansRegular(
                    24,
                    color: theme.colorScheme.onBackground,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 4.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 3.h,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl: Assets.images.rectangle325_png,
                      productName: 'Product Name $index',
                      productPrice: '\$29.99',
                    );
                  },
                ),
                SizedBox(height: 4.h),
                Center(
                  child: Image.asset(
                    Assets.images.n3_png,
                    width: 15.w,
                  ),
                ),
              ],
            ),
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
              color: Theme.of(context).colorScheme.surface,
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
                    color: Theme.of(context).colorScheme.onSurface,
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
                      color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings(context).exploreCollection,
                        style: FontManager.tenorSansRegular(
                          widget.isMobile ? 16 : 20,
                          color: Theme.of(context).colorScheme.onSurface,
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
import 'package:e_commerce/theme/app_color.dart';
import 'package:flutter/material.dart';
import '../../../components/appbar.dart';
import '../../../components/base_page_layout.dart';
import 'responsive_view/home_mobile.dart';
import 'responsive_view/home_web.dart';

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
import 'package:flutter/material.dart';
class AppColor {

  // Light Theme Colors
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
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1D1D1D);
  static const Color darkCard = Color(0xFF252525);
  static const Color darkText = Color(0xFFF5F5F5);
  static const Color darkGreyText = Color(0xFFBDBDBD);
  static const Color darkDivider = Color(0xFFF5F5F5);
  static const Color darkContainerBackground = Color(0xFFF5F5F5);
  static const Color darkContainerBorder = Color(0xFFF5F5F5);
  static const Color darkIconColor = Color(0xFFE0E0E0);
  static const Color darkSecondaryText = Color(0xFFAAAAAA);
  static const Color darkHoverColor = Color(0xFF353535);
  static const Color darkShadow = Color(0xFF0A0A0A);

}
import 'package:flutter/material.dart';
import 'app_color.dart';

class ThemeProvider {
  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: AppColor.black,
    secondary: AppColor.warning,
    background: AppColor.backgroundColor,
    surface: AppColor.white,
    onPrimary: AppColor.white,
    onSecondary: AppColor.white,
    onSurface: AppColor.black,
    onBackground: AppColor.black,
  );

  static ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: AppColor.darkText,
    secondary: AppColor.warning,
    background: AppColor.darkBackground,
    surface: AppColor.darkSurface,
    onPrimary: AppColor.darkBackground,
    onSecondary: AppColor.darkBackground,
    onSurface: AppColor.darkText,
    onBackground: AppColor.darkText,
  );

  static ThemeData get lightTheme => _buildTheme(lightColorScheme);
  static ThemeData get darkTheme => _buildTheme(darkColorScheme);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    bool isDark = colorScheme.brightness == Brightness.dark;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: colorScheme.background,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(color: colorScheme.onSurface),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: isDark ? AppColor.darkCard : AppColor.white,
        elevation: 0,
      ),
      
      // Icon Theme
      iconTheme: IconThemeData(
        color: isDark ? AppColor.darkIconColor : AppColor.black,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colorScheme.onBackground),
        bodyMedium: TextStyle(
          color: isDark ? AppColor.darkGreyText : AppColor.greyText,
        ),
        titleLarge: TextStyle(color: colorScheme.onBackground),
        titleMedium: TextStyle(color: colorScheme.onBackground),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        fillColor: isDark ? AppColor.darkContainerBackground : AppColor.containerGreyBackground,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? AppColor.darkContainerBorder : AppColor.containerGreyBorder,
          ),
        ),
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: isDark ? AppColor.darkDivider : AppColor.containerGreyBorder,
      ),
      
      // Container Theme Colors
      extensions: [
        CustomThemeExtension(
          containerBackground: isDark ? AppColor.darkContainerBackground : AppColor.containerGreyBackground,
          containerBorder: isDark ? AppColor.darkContainerBorder : AppColor.containerGreyBorder,
          secondaryText: isDark ? AppColor.darkSecondaryText : AppColor.greyText,
        ),
      ],
    );
  }
}

// Custom Theme Extension for additional colors
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color containerBackground;
  final Color containerBorder;
  final Color secondaryText;

  CustomThemeExtension({
    required this.containerBackground,
    required this.containerBorder,
    required this.secondaryText,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? containerBackground,
    Color? containerBorder,
    Color? secondaryText,
  }) {
    return CustomThemeExtension(
      containerBackground: containerBackground ?? this.containerBackground,
      containerBorder: containerBorder ?? this.containerBorder,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    covariant ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      containerBackground: Color.lerp(containerBackground, other.containerBackground, t)!,
      containerBorder: Color.lerp(containerBorder, other.containerBorder, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
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


