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

class AppRoutes {
  static const String splashPage = "/";
  static const String homePage = "/home";
  static const String blogPage = "/blog";
  static const String categoryPage = "/category";
  static const String blogDetailsPage = "/blog/details";
  static const String productDetailsPage = "/product/details";
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/blog_flow/bloc/blog_bloc.dart';
import '../screens/blog_flow/data/repository_bloc.dart';
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
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
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
                        child: BlocProvider(
                          create: (context) => BlogBloc(BlogRepository(Supabase.instance.client)),
                          child: BlogDetailsPage(postId: postId),
                        ),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
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
  static BlogBloc? _instance;
  BlogState? _previousState;

  factory BlogBloc(BlogRepository repository) {
    if (_instance == null) {
      _instance = BlogBloc._internal(repository);
      // Load categories first, then posts
      _instance!.add(FetchCategoriesEvent());
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
      // Use cache for all posts if available
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
      
      // Cache only all posts
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
      // Keep previous state for back navigation
      final previousState = state;
      
      emit(LoadingState(isGridView: _isGridView, selectedCategoryId: state.selectedCategoryId));
      final blogDetails = await blogRepository.fetchBlogDetails(event.postId);
      emit(BlogDetailsLoadedState(
        blogDetails, 
        isGridView: _isGridView,
        selectedCategoryId: state.selectedCategoryId,
      ));

      // Store the previous state for back navigation
      _previousState = previousState;
    } catch (e) {
      emit(BlogErrorState(
        "Failed to fetch blog details: ${e.toString()}", 
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
      // Use cached posts if no previous state
      emit(BlogPostsLoadedState(
        _cachedPosts!,
        isGridView: _isGridView,
        selectedCategoryId: -1,
      ));
    } else {
      // Fallback to fetching new data
      add(FetchBlogPostsEvent(-1));
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
    return BlocProvider.value(
      value: context.read<BlogBloc>()..add(FetchBlogDetailsEvent(postId)),
      child: WillPopScope(
        onWillPop: () async {
          context.read<BlogBloc>().restorePreviousState();
          return true;
        },
        child: BasePageLayout(
          listSwitch: false,
          mobileBody: const BlogDetailMobile(),
          webBody: const BlogDetailWeb(),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../components/base_page_layout.dart';
import '../bloc/blog_bloc.dart';
import '../data/repository_bloc.dart';
import 'responsive_view/blog_mobile.dart';
import 'responsive_view/blog_web.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(BlogRepository(Supabase.instance.client)),
      child: const BlogPageContent(),
    );
  }
}

class BlogPageContent extends StatelessWidget {
  const BlogPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      listSwitch: true,
      mobileBody: const BlogMobile(),
      webBody: const BlogWeb(),
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


