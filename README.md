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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bloc/blog_bloc.dart';
import '../widgets/categoryBlog.dart';

class BlogMobile extends StatelessWidget {
  const BlogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 4.h),
            Image.asset(
              "assets/images/3.png",
              width: 30.w,
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 5.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryBlog(
                    text: "AppStrings(context).fashion",
                    isSelected: true,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: "AppStrings(context).promo",
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: "AppStrings(context).policy",
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: "AppStrings(context).lookbook",
                    isSelected: false,
                    onTap: () {},
                  ),
                  CategoryBlog(
                    text: "AppStrings(context).sale",
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            BlocBuilder<BlogViewBloc, BlogViewState>(
              builder: (context, state) {
                if (state is GridState) {
                  return _buildGridView();
                } else {
                  return _buildListView();
                }
              },
            ),
            SizedBox(height: 3.h),
          ],
        ),
      );
  }

  Widget _buildGridView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 1.h,
          childAspectRatio: 1.35,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Rectangle 434.png"),
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
                          'Blog Item ${"AppStrings(context).styleGuide"}',
                          style: FontManager.tenorSansRegular(16,
                              color: AppColor.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fashion",
                      style: FontManager.tenorSansRegular(14, color: AppColor.black),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Tips",
                      style: FontManager.tenorSansRegular(12, color: AppColor.black),
                    ),
                    Spacer(),
                    Text(
                      "4 days ago",
                      style: FontManager.tenorSansRegular(12, color: AppColor.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5, // Adjust the item count as needed
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side: Image
              Container(
                width: 25.w,
                height: 15.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Rectangle 434.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 3.w),
              // Right Side: Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "2021 Style Guide: The Biggest Fall Trends",
                      style: FontManager.tenorSansRegular(14,
                          color: AppColor.black, ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "The excitement of fall fashion is here and I’m already loving some of the trend forecasts",
                      style: FontManager.tenorSansRegular(12, color: AppColor.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "4 days ago",
                      style: FontManager.tenorSansRegular(10, color: AppColor.grey),
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
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class BlogViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleViewEvent extends BlogViewEvent {}

// States
abstract class BlogViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GridState extends BlogViewState {}

class ListState extends BlogViewState {}

// Bloc
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

