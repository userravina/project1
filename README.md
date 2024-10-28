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

import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import '../../../../../../generated/assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';


class PhotoUploadContainer extends StatelessWidget {
  final int index;
  final String? imagePath;
  final ValueChanged<String?> onImageSelected;
  final bool isSingleSelect;

  const PhotoUploadContainer({
    super.key,
    required this.index,
    this.imagePath,
    required this.onImageSelected,
    this.isSingleSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(AppRadius.radius10),
            image: imagePath != null
                ? DecorationImage(
              image: FileImage(File(imagePath!)),
              fit: BoxFit.fill,
            )
                : DecorationImage(
              image: AssetImage(Assets.imagesImageRectangle),
              fit: BoxFit.fill,
            ),
          ),
          child: imagePath != null
              ? SizedBox.shrink()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.imagesUploadImage,
                height: 30,
                width: 30,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.photoChooseDiscription,
                      style: FontManager.regular(10,
                          color: AppColors.greyText),
                    ),
                    TextSpan(
                      mouseCursor: SystemMouseCursors.click,
                      style: FontManager.regular(10,
                          color: AppColors.buttonColor),
                      text: Strings.chooseFile,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: !isSingleSelect,
                          );

                          if (result != null) {
                            if (isSingleSelect) {

                              String filePath = result.files.single.path!;
                              print("${Strings.fileExpection} $filePath for index $index");
                              onImageSelected(filePath);
                            } else {
                              List<String> paths = result.paths
                                  .where((path) => path != null)
                                  .map((path) => path!)
                                  .toList();
                              print("${Strings.fileExpection} Selected paths for index $index: $paths");

                              onImageSelected(paths.join(","));
                            }
                          } else {
                            print(Strings.noFileSelectedExpection);
                          }
                        },
                    ),
                    TextSpan(
                      style: FontManager.regular(10,
                          color: AppColors.greyText),
                      text: Strings.to,
                    ),
                    TextSpan(
                      style: FontManager.regular(10,
                          color: AppColors.greyText),
                      text: Strings.upload,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isSingleSelect == true && imagePath != null
            ? Padding(
          padding: EdgeInsets.only(top: 2.h, right: 2.w),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  Assets.imagesEditCoverImage,
                  height: 12,
                  width: 12,
                ),
              ),
            ),
          ),
        )
            : SizedBox.shrink(),
      ],
    );
  }
}
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/custom_photo_upload_image.dart';
import '../../controller/add_properties_controller.dart';

class PhotoPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PhotoPage({super.key, required this.onNext, required this.onBack});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.5.h),
          Text(
            Strings.coverPhoto,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          SizedBox(height: 10),
          PhotoUploadContainer(
            index: 0,
            imagePath: controller.coverImagePaths.isNotEmpty
                ? controller.coverImagePaths[0]
                : null,
            onImageSelected: (path) {
              setState(() {
                if (path != null) {
                  controller.coverImagePaths.value = [path];
                }
              });
            },
            isSingleSelect: true,
          ),
          const SizedBox(height: 30),
          Text(
            Strings.homestayPhotos,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          SizedBox(height: 2.h),
          photoUploadRows(),
          SizedBox(height: 7.h),
        ],
      ),
    );
  }

  Widget photoUploadRows() {
    int imagesPerRow = 2;
    int totalImages = controller.imagePaths.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: imagesPerRow,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: totalImages,
      itemBuilder: (context, index) {
        int uploadedImages =
            controller.imagePaths.where((paths) => paths.isNotEmpty).length;

        return GestureDetector(
          onTap: () async {
            var result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              allowMultiple: true,
            );

            if (result != null && result.paths.isNotEmpty) {
              List<String> selectedPaths =
                  result.paths.map((path) => path!).toList();
              if (selectedPaths.length > 5) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('You can only select up to 5 images.')),
                );
                return;
              }

              setState(() {
                controller.imagePaths[index] = selectedPaths;
              });
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              PhotoUploadContainer(
                index: index,
                imagePath: controller.imagePaths[index].isNotEmpty
                    ? controller.imagePaths[index].first
                    : null,
                onImageSelected: (paths) {
                  setState(() {
                    controller.imagePaths[index] = paths!.split(",");
                  });
                },
                isSingleSelect: false,
              ),
              if (controller.imagePaths[index].isNotEmpty)
                CircularPercentIndicator(
                  radius: 23,
                  lineWidth: 2.0,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: controller.imagePaths[index].length / 5,
                  center: Text(
                    "${(controller.imagePaths[index].length / 5 * 100).toStringAsFixed(0)}%",
                    style: FontManager.regular(13, color: AppColors.white),
                  ),
                  progressColor: AppColors.white,
                  footer: Text(
                    Strings.uploadingImage,
                    style: FontManager.regular(12, color: AppColors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
  var coverImagePaths = <String?>[null].obs;
  var imagePaths = List<List<String?>>.filled(6, []).obs;
