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
  dart: ">=3.5.3 <4.0.0"
  flutter: ">=3.24.0"

 
class ApiHelper {
  final Dio dio;
  ApiHelper(this.dio);
  var apiURLs = getIt<APIUrls>();

  Future postFormData(String url, {required FormData data}) async {
    try {
      dio.options.headers["Authorization"];
      final response = await dio.post(
        url,
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }


  Future postData(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future putDataForm(String url, {required FormData data}) async {
    try {
      final response = await dio.put(url, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future putData(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(url, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future getData(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(url, queryParameters: params);
      return response;
    } catch (error) {
       rethrow;
    }
  }

  Future deleteData(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(url, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}

class APIUrls{

  String baseUrl = "https://travellery-backend.onrender.com";
  String signupUrl = "/user/signup";
  String loginUrl = "/user/login";
  String googleRegisterUrl = "/user/google-registration/";
  String forgePasswordUrl = "/user/forgot-password";
  String userGetUrl = "/user";
  String verifyUrl = "/user/verfify-otp";
  String resetPasswordUrl = "/user/reset-password";
  String homeStayCreateUrl = "/homestay/create";
  String homeStayUrl = "/homestay";
  String propertiesDelete = "/homestay/DeleteHomestay";
  String homeStayEditUrl = "//homestay/UpdateHomestay";
  String hostingGetDataUrl = "/homestay/UserHomestay";
  String changePasswordUrl = "/user/change-password";
  String contactUsUrl = "/contactus";
  String cityGetUrl = "/homestaycity";
  String feedBackUrl = "/feedback";
  String bookingCreateUrl = "/booking/create";
}
final getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<APIUrls>(() => APIUrls());
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getDioInstance()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<HomeStayRepository>(() => HomeStayRepository());
  getIt.registerLazySingleton<StorageServices>(() => StorageServices());
  getIt.registerLazySingleton<YourPropertiesRepository>(() => YourPropertiesRepository());
  getIt.registerLazySingleton<TravelingRepository>(() => TravelingRepository());
  getIt.registerLazySingleton<HostingRepository>(() => HostingRepository());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
}

Widget buildAccommodationOption({
  required String title,
  required String subtitle,
  required String imageAsset,
  required String value,
  required AddPropertiesController controller,
}) {
  return GestureDetector(
    onTap: () {},
    child: Obx(() {
      bool isSelected = controller.selectedAccommodation.value == value;
      return Container(
        width: double.infinity,
        height: 10.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectContainerColor : Colors.white,
          borderRadius: const BorderRadius.all(AppRadius.radius10),
          border: Border.all(
            color: isSelected
                ? AppColors.buttonColor
                : AppColors.borderContainerGriedView,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imageAsset,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1.h),
                  Text(
                    title,
                    style: FontManager.regular(16, color: AppColors.black),
                  ),
                  const SizedBox(height: 2),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      subtitle,
                      style:
                      FontManager.regular(12, color: AppColors.greyText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Obx(() => Radio(
                value: value,
                groupValue: controller.selectedAccommodation.value,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.selectAccommodation(newValue,imageAsset);
                  }
                },
              )),
            ),
          ],
        ),
      );
    }),
  );
}

class CusttomContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final RxInt count;

  const CusttomContainer({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 7.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 0.w),
          Image.asset(
            imageAsset,
            height: 26,
            width: 26,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: FontManager.regular(14, color: AppColors.black),
            textScaler: const TextScaler.linear(1),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.put(AddPropertiesController()).decrement(count);
                },
                child: Image.asset(
                  Assets.imagesDividecircle,
                  height: 20.sp,
                ),
              ),
              SizedBox(width: 1.w),
              Container(
                width: 11.w,
                height: 4.h,
                decoration: const BoxDecoration(
                  color: AppColors.perpalContainer,
                  borderRadius: BorderRadius.all(AppRadius.radius4),
                ),
                child: Obx(() {
                  return TextField(
                    controller: TextEditingController(text: count.value.toString()),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 16),
                    ),
                    style: FontManager.regular(14),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      count.value = int.tryParse(value) ?? 0;
                    },
                  );
                }),
              ),
              SizedBox(width: 1.w),
              GestureDetector(
                onTap: () {
                  Get.put(AddPropertiesController()).increment(count);
                },
                child: Image.asset(
                  Assets.imagesPluscircle,
                  height: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = AppColors.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 6.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(AppRadius.radius10),
        ),
        child: Center(
          child: Text(
            title,
            style: FontManager.regular(20, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelbud/theme/app_color.dart';
import 'package:travelbud/utils/text_styles.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String btnName;
  final bool? isLoading;
  final bool isEnable;

  const CommonButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    required this.btnName,
    this.isLoading = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: (isLoading ?? false)
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.blueColor.value,
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  isEnable
                      ? appColors.blueColor.value
                      : appColors.mediumBlueColor.value,
                ),
              ),
              onPressed: isEnable ? onPressed : null,
              child: Text(
                btnName,
                maxLines: 1,
                style: TextStyles.bodyMedium?.copyWith(
                  color: appColors.whiteColor.value,
                ),
              ),
            ),
    );
  }
}

class CommonOutlinedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? iconSize;
  final double? height;
  final String btnName;
  final String icon;
  final bool? isLoading;
  final bool isEnable;

  const CommonOutlinedButtonWithIcon({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    required this.btnName,
    this.isLoading = false,
    this.isEnable = true,
    required this.icon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: (isLoading ?? false)
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.blueColor.value,
              ),
            )
          : OutlinedButton.icon(
              icon: Image.asset(
                icon,
                height: iconSize,
                width: iconSize,
                fit: BoxFit.cover,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: appColors.blueColor.value,
                  width: 1,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: onPressed,
              label: Text(
                btnName,
                maxLines: 1,
                style: TextStyles.bodyMedium?.copyWith(
                  color: appColors.blueColor.value,
                ),
              ),
            ),
    );
  }
}

class CommonOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String btnName;
  final bool? isLoading;
  final bool isEnable;

  const CommonOutlinedButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    required this.btnName,
    this.isLoading = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: (isLoading ?? false)
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.blueColor.value,
              ),
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: appColors.blueColor.value,
                  width: 1,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: isEnable ? onPressed : null,
              child: Text(
                btnName,
                maxLines: 1,
                style: TextStyles.bodyMedium?.copyWith(
                  color: appColors.blueColor.value,
                ),
              ),
            ),
    );
  }
}

class CommonTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String btnName;
  final bool? isLoading;
  final bool isEnable;

  const CommonTextButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    required this.btnName,
    this.isLoading = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? double.infinity,
        height: height ?? 45,
        child: Center(
          child: (isLoading ?? false)
              ? CircularProgressIndicator(
                  color: appColors.blueColor.value,
                )
              : InkWell(
                  onTap: onPressed,
                  child: Text(
                    btnName,
                    style: TextStyles.bodyMedium?.copyWith(
                      color: appColors.blueColor.value,
                    ),
                  ),
                ),
        ));
  }
}

class CustomDialog {
  static void showCustomDialog({
    BuildContext? context,
    String? title,
    required String message,
    required String imageAsset,
    required String buttonLabel,
    String? changeEmailLabel,
    VoidCallback? onResendPressed,
    VoidCallback? onChangeEmailPressed,
  }) {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          contentPadding: const EdgeInsets.all(8.0),
          title: Column(
            children: [
              buttonLabel == Strings.yes
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon:
                            const Icon(Icons.close, color: AppColors.greyText),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: 12.h,
                child: Image.asset(imageAsset),
              ),
              SizedBox(height: 1.h),
              title != null
                  ? Text(
                      title,
                      style: FontManager.semiBold(20),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          content: Padding(
            padding: title != null
                ? const EdgeInsets.only(left: 20, right: 20)
                : const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: title != null
                  ? FontManager.regular(13.sp, color: AppColors.greyText)
                  : FontManager.regular(14.sp, color: AppColors.black),
            ),
          ),
          buttonPadding: const EdgeInsets.all(10),
          actions: [
            SizedBox(height: 3.h),
            (title != null || buttonLabel == Strings.ok)
                ? buttonLabel == Strings.ok
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonButton(
                          title: buttonLabel,
                          onPressed: () {
                            Get.back();
                            if (onResendPressed != null) {
                              onResendPressed();
                            }
                          },
                        ),
                      )
                    : CommonButton(
                        title: buttonLabel,
                        onPressed: () {
                          Get.back();
                          if (onResendPressed != null) {
                            onResendPressed();
                          }
                        },
                      )
                : const SizedBox.shrink(),
            SizedBox(height: 1.5.h),
            (title != null || buttonLabel == Strings.ok)
                ? (changeEmailLabel != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (onChangeEmailPressed != null) {
                                onChangeEmailPressed();
                              }
                              Get.back();
                            },
                            child: Text(
                              changeEmailLabel,
                              textAlign: TextAlign.center,
                              style: FontManager.regular(14,
                                  color: AppColors.buttonColor),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onResendPressed,
                          child: Container(
                            height: 4.5.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius:
                                  BorderRadius.all(AppRadius.radius10),
                            ),
                            child: Center(
                              child: Text(
                                buttonLabel == Strings.yes
                                    ? Strings.yes
                                    : Strings.delete,
                                style: FontManager.regular(16,
                                    color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 4.5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              border: Border.all(color: AppColors.buttonColor),
                              borderRadius:
                                  const BorderRadius.all(AppRadius.radius10),
                            ),
                            child: Center(
                              child: Text(
                                changeEmailLabel == Strings.no
                                    ? Strings.no
                                    : Strings.cancel,
                                style: FontManager.regular(16,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        );
      },
    );
  }
}

class CommonHomestayTitleWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String titleLabel;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  const CommonHomestayTitleWidget({
    super.key,
    required this.controller,
    required this.titleLabel,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          Text(titleLabel, style: FontManager.regular(14)),
          SizedBox(height: 0.5.h),
          CustomTextField(
            controller: controller,
            maxLength: 100,
            hintText: Strings.enterTitle,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.enterTitle;
              }
              return null;
            },
            onSaved: (value) => onSaved!(value),
            onChanged: (value) => onChanged!(value),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class ImagePickerCommon {
  final ImagePicker _picker = ImagePicker();

  Future<CroppedFile?> pickImage({
    required ImageSource source,
    bool isSingleSelect = false,
    int? index,
  }) async {
print("111111111111111111");
    var imageSource = await Get.bottomSheet<ImageSource>(
      Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

if (imageSource == null) {
  print("No image source selected.");
  return null;
}
    if (imageSource != null) {
      final XFile? pickedFile = await _picker.pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPresetCustom(),
              ],
            ),
          ],
        );

        if (croppedFile != null) {
          final compressedImage = await FlutterImageCompress.compressWithFile(
            croppedFile.path,
            minWidth: 800,
            minHeight: 800,
            quality: 100,
          );

          if (compressedImage != null) {
            final compressedFilePath = croppedFile.path;
            final File compressedFile = File(compressedFilePath);
            await compressedFile.writeAsBytes(compressedImage);

            if (isSingleSelect) {
              return CroppedFile(compressedFile.path);
            } else if (index != null) {
              return CroppedFile(compressedFile.path);
            }
          }
        }
      }
    }
    return null;
  }
}


class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

class LoadingProcessCommon   {

  var isLoading = false;
  static Widget loadingDialog() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.greyText,),
    );
  }

  void showLoading() {
    isLoading = true;
    Get.dialog(
      PopScope(canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: loadingDialog(),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    isLoading = false;
    Get.back();
  }

}

class PropertyCard extends StatelessWidget {
  final String coverPhotoUrl;
  final String homestayType;
  final String status;
  final String title;
  final String location;
  final int basePrice;
  final int weekendPrice;
  final bool traveling;
  final void Function()? onTap;

  const PropertyCard({
    super.key,
    required this.coverPhotoUrl,
    required this.homestayType,
    required this.status,
    required this.title,
    required this.location,
    required this.basePrice,
    required this.weekendPrice,
    required this.traveling,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 259,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 157,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(AppRadius.radius10),
                    image: DecorationImage(
                      image: NetworkImage(coverPhotoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      homestayType,
                      style:
                          FontManager.regular(12, color: AppColors.buttonColor),
                    ),
                    traveling == true
                        ? Text(
                            "₹ $basePrice - $weekendPrice",
                            style: FontManager.semiBold(
                              12,
                              color: AppColors.buttonColor,
                            ),
                          )
                        : Text(
                            status,
                            style: FontManager.regular(
                              12,
                              color: status == "Pending Approval"
                                  ? AppColors.pendingColor
                                  : status == "Approved"
                                      ? AppColors.approvedColor
                                      : AppColors.greyText,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  title,
                  style:
                      FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 6, left: 4.0, bottom: 8.0, right: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      location,
                      style: FontManager.regular(12, color: AppColors.greyText),
                    ),
                    const Spacer(),
                    traveling == true
                        ? RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "4k",
                                  style: FontManager.regular(12,
                                      color: AppColors.greyText),
                                ),
                                TextSpan(
                                  style: FontManager.regular(10,
                                      color: AppColors.greyText),
                                  text: "m away",
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyCardWidget extends StatelessWidget {
  final double statusBarHeight;
  final String title;
  final String status;
  final String dataTitle;
  final TabController tabController;
  final int basePrice;
  final int weekendPrice;
  final List homestayPhotos;
  final String ownerContactNumber;
  final String ownerEmail;
  final List<HomestayContactNo> homestayContactNoList;
  final List<HomestayEmailId> homestayEmailIdList;
  final String homestayType;
  final String accommodationType;
  final String checkInTime;
  final String checkOutTime;
  final bool flexibleCheckIn;
  final bool flexibleCheckOut;
  final String address;
  final String description;
  final String street;
  final String landmark;
  final String city;
  final String pinCode;
  final String state;
  final bool showSpecificLocation;
  final int maxGuests;
  final int bedrooms;
  final int singleBed;
  final int doubleBed;
  final int extraFloorMattress;
  final int bathrooms;
  final bool kitchenAvailable;
  final void Function()? onPressed;
  final void Function()? onDeleteDetails;
  final bool? detailsHosting;
  final void Function()? onPressedEdit;

  const PropertyCardWidget({
    super.key,
    required this.statusBarHeight,
    required this.title,
    required this.homestayPhotos,
    required this.status,
    required this.dataTitle,
    required this.basePrice,
    required this.weekendPrice,
    required this.tabController,
    required this.ownerContactNumber,
    required this.ownerEmail,
    required this.homestayContactNoList,
    required this.homestayEmailIdList,
    required this.homestayType,
    required this.accommodationType,
    required this.checkOutTime,
    required this.checkInTime,
    required this.flexibleCheckIn,
    required this.flexibleCheckOut,
    required this.address,
    required this.description,
    required this.maxGuests,
    required this.bedrooms,
    required this.singleBed,
    required this.doubleBed,
    required this.extraFloorMattress,
    required this.bathrooms,
    required this.kitchenAvailable,
    required this.street,
    required this.landmark,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.showSpecificLocation,
    required this.onPressed,
    this.onDeleteDetails,
    this.detailsHosting,
    this.onPressedEdit
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviewPropertiesController());
    double statusBarHeight = MediaQuery.of(context).padding.top;
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
                if (title == Strings.details) ...[
                  PopupMenuButton<String>(
                    color: AppColors.backgroundColor,
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.textAddProreties,
                    ),
                    onSelected: (value) {
                      if (value == Strings.edit) {
                        detailsHosting == true
                            ? onPressedEdit!()
                            : print("bvbcxvxnbcvbnxcvn");
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
                          onResendPressed: onDeleteDetails,
                          onChangeEmailPressed: () {},
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        buildPopupMenuItem(Assets.imagesEdit, Strings.edit,
                            AppColors.editBackgroundColor, AppColors.blueColor),
                        buildPopupMenuItem(
                            Assets.imagesDeleteVector,
                            Strings.delete,
                            AppColors.deleteBackgroundColor,
                            AppColors.redColor),
                      ];
                    },
                  )
                ],
                if (title == Strings.homeStayDetails)
                  Image.asset(
                    Assets.imagesShare,
                    height: 5.h,
                    width: 7.w,
                  ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
            child: Column(
              children: [
                CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        controller.updateCarouselIndex(index);
                      },
                      padEnds: false,
                      disableCenter: true,
                      aspectRatio: 1.6,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                    ),
                    carouselController: controller.carouselController,
                    items: homestayPhotos.map((imagePath) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(AppRadius.radius10),
                        child: null != imagePath.url
                            ? (title != Strings.details &&
                                    title != Strings.homeStayDetails)
                                ? Image.file(
                                    File(imagePath.url!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(imagePath.url!,
                                    fit: BoxFit.cover)
                            : Container(
                                color: Colors.grey[300],
                              ),
                      );
                    }).toList()),
                SizedBox(
                  height: 1.5.h,
                ),
                Obx(
                  () => AnimatedSmoothIndicator(
                    count: homestayPhotos.length,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.buttonColor,
                        dotColor: AppColors.inactiveDotColor,
                        spacing: 2,
                        dotHeight: 3.5,
                        dotWidth: 4),
                    onDotClicked: (index) {
                      controller.carouselController.jumpToPage(index);
                    },
                    activeIndex: controller.carouselIndex.value,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                title == Strings.details
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
                title == Strings.details
                    ? const SizedBox(
                        height: 12,
                      )
                    : const SizedBox.shrink(),
                Text(
                  dataTitle,
                  style: FontManager.semiBold(28,
                      color: AppColors.textAddProreties),
                ),
                SizedBox(height: 0.2.h),
                Text(
                  Strings.newYorkUSA,
                  style: FontManager.regular(14, color: AppColors.greyText),
                ),
                SizedBox(height: 1.h),
                Text(
                  '\$${NumberFormat("#,###").format(basePrice)} - \$${NumberFormat("#,###").format(weekendPrice)}',
                  style:
                      FontManager.medium(20, color: AppColors.textAddProreties),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 1.h,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
              unselectedLabelColor: AppColors.greyText,
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 0.7.w,
              padding: EdgeInsets.only(top: 2.h),
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              unselectedLabelStyle: FontManager.regular(14),
              labelStyle: FontManager.regular(14, color: AppColors.buttonColor),
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
                buildDetailsView(),
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
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                height: 4.h,
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
                      homestayType,
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 4.h,
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
                      accommodationType,
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
                        "$bedrooms ${Strings.bedRooms} ",
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
                        "$maxGuests ${Strings.guest} ",
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
                        "$doubleBed ${Strings.doubleBed} ",
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
                        "$singleBed ${Strings.singleBed} ",
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
                        "$bathrooms ${Strings.bathRooms} ",
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
                        "$extraFloorMattress ${Strings.extraFloorMattress} ",
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
                    text: description,
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
          buildTimeSection(),
          SizedBox(height: 2.h),
          buildAmenities(),
          SizedBox(height: 2.h),
          buildHouseRules(),
          SizedBox(height: 2.h),
          buildAddress(),
          SizedBox(height: 2.h),
          CommonButton(
            title: title == Strings.homeStayDetails
                ? Strings.reserve
                : Strings.done,
            onPressed: onPressed,
          ),
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
          buildContactRow(Assets.imagesCallicon, ownerContactNumber),
          SizedBox(height: 1.h),
          buildContactRow(Assets.imagesEmailicon, ownerEmail),
          SizedBox(height: 2.h),
          Text(Strings.homeStayDetails,
              style: FontManager.medium(18, color: AppColors.textAddProreties)),
          SizedBox(height: 2.h),
          ...buildContactList(
            homestayContactNoList,
            Assets.imagesCallicon,
          ),
          ...buildContactList(
            homestayEmailIdList,
            Assets.imagesEmailicon,
          ),
          SizedBox(height: 4.h),
          CommonButton(
            title: Strings.done,
            onPressed: onPressed,
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  List<Widget> buildContactList(List<dynamic> contactList, String iconPath) {
    return contactList.map<Widget>((contact) {
      if (contact is HomestayContactNo) {
        return Column(
          children: [
            buildContactRow(iconPath, contact.contactNo!),
            SizedBox(height: 1.h),
          ],
        );
      } else if (contact is HomestayEmailId) {
        return Column(
          children: [
            buildContactRow(iconPath, contact.emailId!),
            SizedBox(height: 1.h),
          ],
        );
      } else {
        return const SizedBox();
      }
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

class CommonTermAndConditionWidget extends StatelessWidget {
  final bool? isChecked;
  final void Function()? onPressed;
  final ValueChanged<bool?> onChanged;

  const CommonTermAndConditionWidget({
    super.key,
    required this.isChecked,
    required this.onPressed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  ),
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
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: AppColors.buttonColor,
                  value: isChecked,
                  onChanged: onChanged,
                  side: const BorderSide(color: AppColors.texFiledColor),
                ),
                SizedBox(width: 2.w),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text(
                      Strings.term1desc,
                      style: FontManager.regular(14,
                          color: AppColors.texFiledColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            CommonButton(
              backgroundColor: isChecked == false
                  ? AppColors.lightPerpul
                  : AppColors.buttonColor,
              title: Strings.submit,
              onPressed: () {
                if (isChecked == true) {
                  onPressed!();
                }
              },
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = AppColors.sliderInactiveColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.buttonColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
    // TODO: implement paint
  }
}
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

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
  static const Color datePickerBackgroundColor = Color(0xffF9F8FF);
  static const Color selectGuestDecColor = Color(0xffF4F2FF);
  static const Color divaideColor = Color(0xffF4F4F4);
  static const Color divaide2Color = Color(0xffE3E3E3);
  static const Color sliderInactiveColor = Color(0xffE0E0E0);



}
class AppRadius {
  static const Radius radius0 = Radius.circular(0);
  static const Radius radius2 = Radius.circular(2);
  static const Radius radius4 = Radius.circular(4);
  static const Radius radius6 = Radius.circular(6);
  static const Radius radius10 = Radius.circular(10);
  static const Radius radius16 = Radius.circular(16);
  static const Radius radius24 = Radius.circular(24);
  static const Radius radius36 = Radius.circular(36);
  static const Radius radius999 = Radius.circular(999);

  // Named sizes
  static const Radius radiusXXS = radius2;
  static const Radius radiusXS = radius4;
  static const Radius radiusS = radius6;
  static const Radius radiusSM = radius10;
  static const Radius radiusM = radius16;
  static const Radius radiusML = radius24;
  static const Radius radiusLG = radius36;
  static const Radius radiusXL = radius999;
}
class Strings {

  static const String onboardingTitle1 = "Book with ease, travel with joy";
  static const String onboardingTitle2 =
      "Discover and find your perfect healing place";
  static const String onboardingTitle3 = "Giving the best deal just for you";

  static const String onboardingDescription1 =
      '"Discover a seamless booking experience with our user-friendly interface and exclusive deals."';
  static const String onboardingDescription2 =
      '"Escape to a world of tranquility and rejuvenation. Discover our curated selection of wellness retreats and healing spaces."';
  static const String onboardingDescription3 =
      '"Get exclusive offers and discounts on hotels, flights, and packages, curated just for your travel style."';


  static const String nextButton = "Next";


  static const String welcome = "Welcome";
  static const String gladToSeeYou = "Glad to see you!";


  static const String rememberMe = "Remember me";
  static const String forgetPassword = "Forget password?";
  static const String loginButton = "Login";
  static const String dontHaveAccount = "Don’t have an account?";


  static const String emailEmpty = 'The email field is required.';
  static const String invalidEmail = 'Invalid email. Please enter your registered email';
  static const String passwordEmpty = 'Please enter your password';
  static const String shortPassword = 'Password must be at least 6 characters';

  static const String nameHint = 'Enter your name';
  static const String mobileNumberHint = 'Enter your Mobile Number';
  static const String emailHint = 'Enter Your Email';
  static const String passwordHint = 'Enter your Password';
  static const String confirmPasswordHint = 'Confirm Password';
  static const String addProfileImage = 'Add Profile Image';

  static const String createAccount = 'Create Account';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String nameLabel = 'Name';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String emailLabel = 'Email';
  static const String signUp = ' Sign Up';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String login = 'Login';

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
  static const String privateRoomValue = "privateRoom";
  static const String guestsSleepInPrivateRoomButSomeAreasAreShared = "Guests sleep in private room but some areas are shared";
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
  static const String editAmenities = 'Edit Amenities';
  static const String editRules = 'Edit Rules';
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
  static const String flexibleWithCheckOutTime = 'Flexible with Check-out time';
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
  static const String ok = 'Ok';

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
  static const String editSuccessMsg =
      ' Properties details updated successfully ';
  static const String updateAndExit = 'Update and Exit ';
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String trips = 'Trips';
  static const String helloJhon = 'Hello Jhon!';
  static const String welcomeToTravelbud = 'Welcome to Travelbud.';
  static const String search = 'Search';
  static const String mumbai = 'mumbai';
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
  static const String totalEarnings = "Total Earnings :";
  static const String pendingPayoutes = "Pending Payouts :";
  static const String payout = "Payout";
  static const String sorryWeCouldnFindAnyStaysNearLocation = "Sorry,\n We couldn’t find any stays near location.";
  static const String locationHelpYou = "Please contact us at info@travelbud.in\nto help you";
  static const String radius = "Radius";
  static const String within = "within";
  static const String kms = "kms";
}
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import 'app_string.dart';

class AppValidation {

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.nameError;
    }
    return null;
  }

  static String? validateMobile(String? value) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (value == null || value.isEmpty) {
      return Strings.mobileNumberError;
    } else if (!phoneRegex.hasMatch(value)) {
      return Strings.mobileNumberLengthError;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.emailEmpty;
    } else if (!GetUtils.isEmail(value)) {
      return Strings.emailFormatError;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.passwordError;
    } else if (value.length < 8) {
      return Strings.passwordLengthError;
    }
    return null;
  }
  //
  // static String? validateConfirmPassword(String? value, String password) {
  //   if (value != password) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }
}
import 'package:flutter/material.dart';

class FontManager {
  static const String fontFamily = 'Poppins';

  static TextStyle thin(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w100,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle extraLight(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w200,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle light(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle regular(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle medium(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle semiBold(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle bold(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle extraBold(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w800,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle black(double size, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
      fontSize: size,
      color: color,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIconData;
  final Image? prefixIconImage;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool showSuffixIcon;
  final Widget? suffixIconImage;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLength;
  final int maxLines;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isForgetPage;
  final bool isValidating;
  final bool borderColor;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIconData,
    this.prefixIconImage,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.showSuffixIcon = false,
    this.suffixIconImage,
    this.onSuffixIconPressed,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.textStyle,
    this.controller,
    this.isForgetPage = false,
    this.isValidating = false,
    this.borderColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      style: textStyle ?? FontManager.regular(14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: FontManager.regular(12, color: AppColors.texFiledColor),
        // Conditional borderSide for full line
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ? AppColors.borderContainerGriedView : AppColors.texFiledColor,
          ),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        prefixIcon: prefixIconImage != null
            ? Padding(
          padding: const EdgeInsets.only(left: 0, top: 13, bottom: 13),
          child: prefixIconImage,
        )
            : prefixIconData != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(prefixIconData, color: AppColors.texFiledColor),
        )
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ? AppColors.borderContainerGriedView : AppColors.texFiledColor,
          ),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ? AppColors.borderContainerGriedView : AppColors.texFiledColor,
          ),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorTextfieldColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorTextfieldColor),
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        errorStyle: FontManager.regular(10, color: AppColors.errorTextfieldColor),
        suffixIcon: (isForgetPage && isValidating)
            ? const Icon(
          Icons.error_outline,
          weight: 0.2,
          color: AppColors.errorTextfieldColor,
        )
            : (showSuffixIcon
            ? (suffixIconImage != null
            ? Padding(
          padding: const EdgeInsets.all(14),
          child: suffixIconImage,
        )
            : IconButton(
          icon: obscureText
              ? Image.asset(
            Assets.imagesEyesDisable,
            height: 20,
            width: 20,
          )
              : Image.asset(
            Assets.imagesEyesEneble,
            height: 20,
            width: 20,
          ),
          onPressed: onSuffixIconPressed,
        ))
            : null),
      ),
    );
  }
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJ4ECrV8qXSxxRA4faJ2q32GUff4UfWFU',
    appId: '1:724548592992:android:f74502a24b3431f5faea05',
    messagingSenderId: '724548592992',
    projectId: 'travellery-app',
    storageBucket: 'travellery-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAChhTqltcBOHjqPAS76DAjSgRTQRgLq-c',
    appId: '1:724548592992:ios:c64d28bf71bfbfe1faea05',
    messagingSenderId: '724548592992',
    projectId: 'travellery-app',
    storageBucket: 'travellery-app.firebasestorage.app',
    iosBundleId: 'com.app.travellery',
  );
}
{
  "project_info": {
    "project_number": "724548592992",
    "project_id": "travellery-app",
    "storage_bucket": "travellery-app.firebasestorage.app"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:724548592992:android:f74502a24b3431f5faea05",
        "android_client_info": {
          "package_name": "com.app.travellery"
        }
      },
      "oauth_client": [],
      "api_key": [
        {
          "current_key": "AIzaSyBJ4ECrV8qXSxxRA4faJ2q32GUff4UfWFU"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
class BottomNavigationController extends GetxController {
  ProfileController profileCtrl = Get.put(ProfileController());

  var selectedIndex = 0.obs;

  void selectedUpdate(int index) {
    selectedIndex.value = index;
    update();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/app_colors.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_string.dart';
import '../../../utils/font_manager.dart';
import '../../hosting_flow/view/Home_page/home_page.dart';
import '../../hosting_flow/view/listing_page/listing_page.dart';
import '../../profile_pages/view/profile_page.dart';
import '../../traveling_flow/view/home_pages/home_page.dart';
import '../controller/bottom_controller.dart';
import '../../traveling_flow/view/trip_pages/trips_page.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller =
        Get.put(BottomNavigationController());

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            controller.profileCtrl.isTraveling.value == false
                ? const HomeHostingPage()
                : const HomeTravelingPage(),
            controller.profileCtrl.isTraveling.value == false
                ? const ListingPage()
                : const TripsPage(),
            const ProfilePage(),
          ],
        );
      }),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Obx(
              () => buildNavItem(
                index: 0,
                imagePath: controller.selectedIndex.value == 0
                    ? Assets.imagesHomeVector
                    : Assets.imagesBottomHome2,
                label: Strings.home,
                onTap: () => controller.selectedUpdate(0),
              ),
            ),
            Obx(
              () => buildNavItem(
                index: 1,
                imagePath: controller.profileCtrl.isTraveling.value == true
                    ? controller.selectedIndex.value == 1
                        ? Assets.imagesBottomlisting2
                        : Assets.imagesBottomlisting
                    : controller.selectedIndex.value == 1
                        ? Assets.imagesBottomTrip2
                        : Assets.imagesBottomTrip,
                label: controller.profileCtrl.isTraveling.value == false ? Strings.listing : Strings.trips,
                onTap: () => controller.selectedUpdate(1),
              ),
            ),
            Obx(
              () => buildNavItem(
                index: 2,
                imagePath: controller.selectedIndex.value == 2
                    ? Assets.imagesBottomProfile2
                    : Assets.imagesBottomProfile,
                label: Strings.profile,
                onTap: () => controller.selectedUpdate(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.4.h,
        width: 111,
        decoration: BoxDecoration(
          color: index ==
                  Get.find<BottomNavigationController>().selectedIndex.value
              ? AppColors.bottomActiveColor
              : Colors.transparent,
          borderRadius: const BorderRadius.all(AppRadius.radius36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 21.sp,
              height: 21.sp,
            ),
            SizedBox(width: 2.w),
            if (index ==
                Get.find<BottomNavigationController>().selectedIndex.value)
              Text(
                label,
                style:
                    FontManager.semiBold(14.sp, color: AppColors.buttonColor),
              ),
          ],
        ),
      ),
    );
  }
}

class StorageServices {
  static String userToken = "userToken";
  static String userId = "userId";
  static String homeStayId = "homeStayId";
  static String yourPropertiesId = "YourPropertiesId";

  static GetStorage storage = GetStorage();

  setUserToken(String? token) {
    storage.write(userToken, token);
  }

  String? getUserData() {
    return storage.read(userToken);
  }

  String getUserToken() {

    String? userData = getUserData();
    print('================ userData=== $userData ========================');
    if (userData != null) {
      print('================ token === $userData ========================');
      return userData;
    }
    return "";
  }

  clearUserData() {
    return storage.remove(userToken);
  }

  cleanLocalStorage() {
    storage.remove(userToken);
  }

  setUserId(String id) {
    storage.write(userId, id);
  }

  String? getUserId2() {
    return storage.read(userId);
  }
  String? getUserId() {
    String? userData = getUserId2();
    if (userData != null) {
      print('================ id === $userData ========================');
      return userData;
    }
    return "";
  }


  setHomeStayId(String id) {
    storage.write(homeStayId, id);
  }

  String? getHomeStayData() {
    return storage.read(homeStayId);
  }
  String? getHomeStayId() {
    String? userData = getHomeStayData();
    if (userData != null) {
      print('================ homeStayId === $userData ========================');
      return userData;
    }
    return "";
  }

  setYourPropertiesId(String id) {
    storage.write(yourPropertiesId, id);
  }

  String? getYourPropertiesIdData() {
    return storage.read(yourPropertiesId);
  }
  String? getYourPropertiesId() {
    String? userData = getYourPropertiesIdData();
    if (userData != null) {
      print('================ yourPropertiesId === $userData ========================');
      return userData;
    }
    return "";
  }
}

class CheckInOutDateController extends GetxController{

  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void updateDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
  }

  var adultCount = 1.obs;
  var childCount = 1.obs;
  var infantCount = 1.obs;

  void incrementAdult() => adultCount.value++;
  void decrementAdult() {
    if (adultCount.value > 0) adultCount.value--;
  }

  void incrementChild() => childCount.value++;
  void decrementChild() {
    if (childCount.value > 0) childCount.value--;
  }

  void incrementInfant() => infantCount.value++;
  void decrementInfant() {
    if (infantCount.value > 0) infantCount.value--;
  }


  void bookingCreatedData() {
    // LoadingProcessCommon().showLoading();
    String? userDetailId = getIt<StorageServices>().getUserId();
   String? homestayDetailId = getIt<StorageServices>().getYourPropertiesId();
    Map<String, dynamic> data = {
      "userDetail": userDetailId,
      "homestayDetail": homestayDetailId,
      "checkInDate":  startDate.value,
      "checkOutDate": endDate.value,
      "adults": adultCount.value,
      "children": childCount.value,
      "infants": infantCount.value,
      // "totalDaysOrNightsPrice": newPasswordController.text,
      // "taxes": confirmPasswordController.text,
      // "serviceFee": confirmPasswordController.text,
      // "totalAmount": currentPasswordController.text,
      // "paymentMethod": newPasswordController.text,
      // "paymentStatus": confirmPasswordController.text,
      // "reservationConfirmed": confirmPasswordController.text,

    };

    travelingRepository.bookingCreate(bookingData: data).then(
          (value) {
       // LoadingProcessCommon().hideLoading();
        Get.back();
        Get.snackbar("", "Password Changed Successfully !",
            colorText: AppColors.white);
      },
    );
  }

}

class TravelingHomeController extends GetxController {
  HomeTravelingPropertiesModel? homeProperty;
  List<ReUsedDataModel> propertiesList = [];
  Rx<HomeTravelingPropertiesModel?> searchFilterProperty =
      Rx<HomeTravelingPropertiesModel?>(null);
  RxList<ReUsedDataModel> searchFilterList = RxList<ReUsedDataModel>([]);
  CityModel? cityProperty;
  RxBool isNoDataFound = false.obs;
  List<HomestayCity> cityPropertiesList = [];
  var travelingRepository = getIt<TravelingRepository>();
  var apiHelper = getIt<ApiHelper>();
  RxBool isLocation = false.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (propertiesList.isEmpty || cityPropertiesList.isEmpty) {
      getTravelingData();
      getCityData();
    }
  }

  Future<void> getTravelingData() async {
    homeProperty = await travelingRepository.getTravelingProperties(limit: 5);
    if (homeProperty != null && homeProperty!.homestaysData != null) {
      propertiesList = homeProperty!.homestaysData!;
    } else {
      propertiesList = [];
    }
    update();
  }

  void getDetails(index) {
    LoadingProcessCommon().showLoading();
    final String? singleFetchUserModel;
    isSearchingPage.value
        ? singleFetchUserModel = searchFilterList[index].id
        : singleFetchUserModel = propertiesList[index].id;
    getIt<StorageServices>().setYourPropertiesId(singleFetchUserModel!);
    getIt<StorageServices>().getYourPropertiesId();
    getSingleYourProperties().then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.toNamed(
          Routes.travelingDetailsPage,
        );
      },
    );
  }

  Future<void> getCityData() async {
    cityProperty = await travelingRepository.getCity();
    if (cityProperty != null) {
      cityPropertiesList = cityProperty!.homestayCity;
    } else {
      cityPropertiesList = [];
    }
    update();
  }

  late HomeStaySingleFetchResponse detailsProperty;

  Future<void> getSingleYourProperties() async {
    detailsProperty = await travelingRepository.getSingleFetchProperties();
  }

  // search location
  RxDouble sliderValue = 6.0.obs;
  RxBool isSearchingPage = false.obs;
  RxBool mapLoading = true.obs;

  // filter

  RxDouble minValue = 100.0.obs;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  RxDouble maxValue = 30000.0.obs;
  var showMore = false.obs;
  RxBool state = false.obs;

  void updateShowMore(var value) {
    showMore.value = value;
    update();
  }

  void updateSliderValues() {
    print("sdfsdfsd${maxValue.value}");
    minValue.value = double.tryParse(minPriceController.text) ?? 0.0;
    maxValue.value = double.tryParse(maxPriceController.text) ?? 30000.0;
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

  RxList<bool> selectedAmenities = <bool>[].obs;

  List<String> allAmenities = [];

  void toggleAmenity(int index) {
    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
    }
    update();
  }

  RxList<bool> selectedRules = <bool>[].obs;

  List<String> allRules = [];

  void toggleRules(int index) {
    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
    }
    update();
  }

  RxInt selectedIndex = 0.obs;

  RxInt selectedSorting = 0.obs;
  var selectedTypeOfPlace = ''.obs;
  var selectedHomeStayType = ''.obs;

  void onSelectSoring(var index) {
    selectedSorting.value = index;
    update();
  }

  void onSelectHomeStayType(var index) {
    selectedHomeStayType.value = index;
  }

  void selectType(String value) {
    selectedTypeOfPlace.value = value;
  }

  Map<String, dynamic> getFilters(
      {bool isSearchPage = false, bool isSearchText = false}) {
    Map<String, dynamic> filters = {};

    if (isSearchPage || isSearchText) {
      if (isSearchText) {
        if (state.value == true)
          filters['homestayName'] = searchController.text;
        print("asassssssssssssssssssssssssss${state.value}");
      } else {
        if (state.value == true) filters['city'] = searchController.text;
        print("aaaaaaaaaaaaaa${state.value}");
      }
    } else {
      filters['minPrice'] = minPriceController.text;
      filters['maxPrice'] = maxPriceController.text;
      if (selectedHomeStayType.value.isNotEmpty) {
        filters['homestayType'] = selectedHomeStayType.value;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'entirePlace') {
        filters['entirePlace'] = true;
      }
      if (selectedTypeOfPlace.value.isNotEmpty &&
          selectedTypeOfPlace.value == 'privateRoom') {
        filters['privatePlace'] = true;
      }
      if (maxGuestsCount.value != 0) {
        filters['maxGuests'] = maxGuestsCount.value;
      }
      if (singleBedCount.value != 0) {
        filters['singleBed'] = singleBedCount.value;
      }
      if (doubleBedCount.value != 0) {
        filters['doubleBed'] = doubleBedCount.value;
      }
      if (extraFloorCount.value != 0) {
        filters['extraFloorMattress'] = extraFloorCount.value;
      }
      if (bathRoomsCount.value != 0) {
        filters['bathrooms'] = bathRoomsCount.value;
      }
      if (isKitchenAvailable.value != false) {
        filters['kitchenAvailable'] = isKitchenAvailable.value;
      }
      if (allAmenities.isNotEmpty) {
        filters['amenities'] = allAmenities.join(',');
      }

     if(selectedSorting.value != 0) filters['sortByPrice'] = selectedSorting.value == 1 ? 'Highest to Lowest' : 'Lowest to Highest';
      if (allRules.isNotEmpty) filters['houseRules'] = allRules.join(',');
    }
    return filters;
  }

  void updateSearch() {
    state.value = true;
    isNoDataFound.value = false;
    searchFilterList.clear();

    fetchFilteredProperties(
      isSearchPage: true,
      isSearchText: true,
    ).then((value) {
      if (searchController.text.isEmpty) {
        state.value = false;
        return;
      }
    }).catchError((error) {
      print("Error fetching data22: $error");
      isNoDataFound.value = true;
    });
  }

  Future<void> fetchFilteredProperties(
      {bool isSearchPage = false, bool isSearchText = false}) async {
    Map<String, dynamic> filters =
        getFilters(isSearchPage: isSearchPage, isSearchText: isSearchText);
    isSearchPage == true
        ? searchFilterProperty.value =
            await travelingRepository.getFilterParams(queryParams: filters)
        : homeProperty =
            await travelingRepository.getFilterParams(queryParams: filters);

    if (isSearchPage) {
      if (searchFilterProperty.value != null &&
          searchFilterProperty.value!.homestaysData != null) {
        searchFilterList.value = searchFilterProperty.value!.homestaysData!;
        isSearchingPage.value = true;
      } else {
        searchFilterList.value = [];
      }
      update();
    } else {
      if (homeProperty != null && homeProperty!.homestaysData != null) {
        propertiesList = homeProperty!.homestaysData!;
        isSearchingPage.value = false;
      } else {
        propertiesList = [];
      }
    }
    update();
  }

  void clearFilters() {
    minPriceController.clear();
    maxPriceController.clear();
    minValue.value = 100.0;
    maxValue.value = 10000.0;
    maxGuestsCount.value = 0;
    singleBedCount.value = 0;
    bedroomsCount.value = 0;
    doubleBedCount.value = 0;
    extraFloorCount.value = 0;
    bathRoomsCount.value = 0;
    isKitchenAvailable.value = false;
    selectedAmenities.clear();
    allAmenities.clear();
    selectedRules.clear();
    selectedTypeOfPlace.value = '';
    selectedHomeStayType.value = '';
    selectedSorting.value = 1;
    //
    // state.value = '';

    update();
  }
}

class TravelingFlow extends GetxController{

  RxInt selectedIndex = 0.obs;

  RxInt  selectedSorting = 1.obs;
  var selectedTypeOfPlace = ''.obs;
  var selectedTypeOfPlaceImage = ''.obs;
  var selectedHomeStayType = ''.obs;

  void onSelectSoring(var index) {
    selectedSorting.value = index;
    update();
  }

  void onSelectHomeStayType(var index) {
    selectedHomeStayType.value = index;
  }

  void selectType(String value,String image) {
    selectedTypeOfPlace.value = value;
    selectedTypeOfPlaceImage.value = image;
  }

   RxList<Property> properties = [

    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.hiltonViewVilla,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller,
      statusColor: AppColors.buttonColor,
      tag: Strings.ecoFriendly,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.mumbai,
      status: Strings.defultDoller1,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.jaipur,
      status: Strings.defultDoller2,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.uttarakhand,
      status: Strings.defultDoller3,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.kerela,
      status: Strings.defultDoller4,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.goa,
      status: Strings.defultDoller5,
      statusColor: AppColors.buttonColor,
      tag: Strings.urban,
      tagColor: AppColors.buttonColor,
    ),
    Property(
      imageUrl:
      "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: Strings.evolveBackCoorg,
      location: Strings.newYorkUSA,
      status: Strings.defultDoller6,
      statusColor: AppColors.buttonColor,
      tag: Strings.luxury,
      tagColor: AppColors.buttonColor,
    ),
  ].obs;
   RxList<Property> filteredProperties = RxList<Property>();
   RxBool isSearching = false.obs;

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void updateDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
  }

  var adultCount = 1.obs;
  var childCount = 1.obs;
  var infantCount = 1.obs;

  void incrementAdult() => adultCount.value++;
  void decrementAdult() {
    if (adultCount.value > 0) adultCount.value--;
  }

  void incrementChild() => childCount.value++;
  void decrementChild() {
    if (childCount.value > 0) childCount.value--;
  }

  void incrementInfant() => infantCount.value++;
  void decrementInfant() {
    if (infantCount.value > 0) infantCount.value--;
  }
}

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String message;
  List<HomestayCity> homestayCity;
  List<dynamic> homestayCityData;
  int totalHomestayCityData;

  CityModel({
    required this.message,
    required this.homestayCity,
    required this.homestayCityData,
    required this.totalHomestayCityData,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    message: json["message"],
    homestayCity: List<HomestayCity>.from(json["homestayCity"].map((x) => HomestayCity.fromJson(x))),
    homestayCityData: List<dynamic>.from(json["homestayCityData"].map((x) => x)),
    totalHomestayCityData: json["totalHomestayCityData"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "homestayCity": List<dynamic>.from(homestayCity.map((x) => x.toJson())),
    "homestayCityData": List<dynamic>.from(homestayCityData.map((x) => x)),
    "totalHomestayCityData": totalHomestayCityData,
  };
}

class HomestayCity {
  Image image;
  String id;
  String city;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  HomestayCity({
    required this.image,
    required this.id,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HomestayCity.fromJson(Map<String, dynamic> json) => HomestayCity(
    image: Image.fromJson(json["image"]),
    id: json["_id"],
    city: json["city"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "image": image.toJson(),
    "_id": id,
    "city": city,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Image {
  String publicId;
  String url;

  Image({
    required this.publicId,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicId: json["public_id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "public_id": publicId,
    "url": url,
  };
}

class HomeTravelingPropertiesModel {
  String? message;
  List<ReUsedDataModel>? homestaysData;
  int? totalHomestay;

  HomeTravelingPropertiesModel({this.message, this.homestaysData, this.totalHomestay});

  HomeTravelingPropertiesModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class TravelingRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeTravelingPropertiesModel> getTravelingProperties(
      {int limit = 0, int skip = 0}) async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/?limit=$limit&skip=$skip",
    );
    Map<String, dynamic> data = response!.data;
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<HomeTravelingPropertiesModel> getFilterParams({
    required Map<String, dynamic> queryParams,
  }) async {
    String queryString = queryParams.entries
        .map((entry) =>
            '${entry.key}=${Uri.encodeQueryComponent(entry.value.toString())}')
        .join('&');
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}?$queryString",
    );

    Map<String, dynamic> data = response!.data;
    return HomeTravelingPropertiesModel.fromJson(data);
  }

  Future<CityModel> getCity() async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.cityGetUrl}",
    );
    Map<String, dynamic> data = response!.data;
    return CityModel.fromJson(data);
  }


  Future<Map<String, dynamic>> bookingCreate(
      {required Map<String, dynamic> bookingData}) async {
    String? getUserId = getIt<StorageServices>().getUserId();
    dio.Response? response = await apiProvider.putData(
      "${apiURLs.baseUrl}${apiURLs.changePasswordUrl}/$getUserId",
      data: bookingData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/common_widgets/common_loading_process.dart';
import 'package:travellery_mobile/screen/traveling_flow/controller/home_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_properti_card.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_radius.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';

class HomeTravelingPage extends StatefulWidget {
  const HomeTravelingPage({super.key});

  @override
  State<HomeTravelingPage> createState() => _HomeTravelingPageState();
}

class _HomeTravelingPageState extends State<HomeTravelingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(
        init: TravelingHomeController(),
        builder: (controller) => Column(
          children: [
            buildHeader(controller),
            const SizedBox(height: 26),
            controller.cityProperty == null
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: controller.cityPropertiesList.map((data) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 14, bottom: 14),
                          child: GestureDetector(
                            onTap: () async {
                              controller.searchController.text = data.city;
                              controller.state.value = true;
                              controller.searchFilterList.clear();
                              controller.isSearchingPage.value = false;
                              controller.isNoDataFound.value = false;
                              controller.isLocation.value = false;
                              controller.mapLoading.value = true;
                              LoadingProcessCommon().showLoading();
                              await controller
                                  .fetchFilteredProperties(isSearchPage: true)
                                  .catchError((error) {
                                print("Error fetching data: $error");
                                LoadingProcessCommon().hideLoading();
                                Get.toNamed(Routes.search);
                                controller.isNoDataFound.value = true;
                              });
                              LoadingProcessCommon().hideLoading();
                              Get.toNamed(Routes.search);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 9.4.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        AppRadius.radius10),
                                    image: DecorationImage(
                                      image: NetworkImage(data.image.url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  data.city,
                                  style: FontManager.regular(12,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    Strings.properties,
                    style: FontManager.semiBold(20.sp, color: AppColors.black),
                  ),
                ),
              ],
            ),
            controller.homeProperty == null
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: controller.propertiesList.length,
                      itemBuilder: (context, index) {
                        return PropertyCard(
                          coverPhotoUrl:
                              controller.propertiesList[index].coverPhoto!.url!,

                          homestayType:
                              controller.propertiesList[index].homestayType!,
                          title: controller.propertiesList[index].title!,
                          onTap: () => controller.getDetails(index),
                          location: controller.propertiesList[index].city!,
                          status: controller.propertiesList[index].status!,
                          basePrice:
                              controller.propertiesList[index].basePrice!,
                          weekendPrice:
                              controller.propertiesList[index].weekendPrice!,
                          traveling: true,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(TravelingHomeController controller) {
    return Container(
      height: 190,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.helloJhon,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                  Text(
                    Strings.welcomeToTravelbud,
                    style: FontManager.regular(14,
                        color: AppColors.greyWelcomeToTravelbud),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                Assets.imagesTv,
                width: 42,
                height: 36,
              ),
              SizedBox(width: 4.6.w),
            ],
          ),
          SizedBox(height: 4.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Container(
                height: 6.h,
                width: 75.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius10),
                  color: AppColors.white,
                ),
                child: Center(
                  child: TextField(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.searchController.clear();
                      controller.isLocation.value = false;
                      controller.isNoDataFound.value = false;
                      controller.state.value = false;
                      controller.searchFilterList.clear();
                      controller.isSearchingPage.value = false;
                      controller.mapLoading.value = true;
                      Get.toNamed(Routes.search);
                    },
                    cursorColor: AppColors.greyText,
                    decoration: InputDecoration(
                      hintText: Strings.search,
                      hintStyle: FontManager.regular(16.sp,
                          color: AppColors.searchTextColor),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.searchIconColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.filterPage);
                },
                child: Container(
                  height: 6.h,
                  width: 15.w,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.imagesFilterslines,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:travellery_mobile/routes_app/all_routes_app.dart';

import '../../../../common_widgets/common_propertis_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../controller/home_controller.dart';

class HomeStayDetailsPage extends StatefulWidget {
  const HomeStayDetailsPage({super.key});

  @override
  State<HomeStayDetailsPage> createState() => _HomeStayDetailsPageState();
}

class _HomeStayDetailsPageState extends State<HomeStayDetailsPage>
    with SingleTickerProviderStateMixin {
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
      body: GetBuilder(
        init: TravelingHomeController(),
        builder: (controller) => PropertyCardWidget(
          title: Strings.homeStayDetails,
          homestayType:
          controller.detailsProperty.homestayData!.homestayType ?? '',
          accommodationType: controller.detailsProperty.homestayData!
              .accommodationDetails!.entirePlace ==
              true
              ? Strings.entirePlace
              : Strings.privateRoom,
          address: controller.detailsProperty.homestayData!.address ?? '',
          basePrice: controller.detailsProperty.homestayData!.basePrice ?? 0,
          checkInTime:
          controller.detailsProperty.homestayData!.checkInTime ?? '',
          checkOutTime:
          controller.detailsProperty.homestayData!.checkOutTime ?? '',
          statusBarHeight: statusBarHeight,
          homestayPhotos:
          controller.detailsProperty.homestayData!.homestayPhotos ?? [],
          status: controller.detailsProperty.homestayData!.status ?? '',
          ownerContactNumber:
          controller.detailsProperty.homestayData!.ownerContactNo ?? '',
          ownerEmail:
          controller.detailsProperty.homestayData!.ownerEmailId ?? '',
          dataTitle: controller.detailsProperty.homestayData!.title ?? '',
          description:
          controller.detailsProperty.homestayData!.description ?? '',
          flexibleCheckIn:
          controller.detailsProperty.homestayData!.flexibleCheckIn ?? false,
          flexibleCheckOut:
          controller.detailsProperty.homestayData!.flexibleCheckOut ??
              false,
          homestayContactNoList:
          controller.detailsProperty.homestayData!.homestayContactNo ?? [],
          homestayEmailIdList:
          controller.detailsProperty.homestayData!.homestayEmailId ?? [],
          tabController: _tabController,
          weekendPrice:
          controller.detailsProperty.homestayData!.weekendPrice ?? 0,
          bathrooms: controller.detailsProperty.homestayData!
              .accommodationDetails!.bathrooms ??
              0,
          bedrooms: controller.detailsProperty.homestayData!
              .accommodationDetails!.bedrooms ??
              0,
          city: controller.detailsProperty.homestayData!.city ?? '',
          doubleBed: controller.detailsProperty.homestayData!
              .accommodationDetails!.doubleBed ??
              0,
          extraFloorMattress: controller.detailsProperty.homestayData!
              .accommodationDetails!.extraFloorMattress ??
              0,
          kitchenAvailable: controller.detailsProperty.homestayData!
              .accommodationDetails!.kitchenAvailable ??
              false,
          landmark: controller.detailsProperty.homestayData!.landmark ?? '',
          pinCode: controller.detailsProperty.homestayData!.pinCode ?? '',
          state: controller.detailsProperty.homestayData!.state ?? '',
          street: controller.detailsProperty.homestayData!.street ?? '',
          maxGuests: controller.detailsProperty.homestayData!
              .accommodationDetails!.maxGuests ??
              0,
          singleBed: controller.detailsProperty.homestayData!
              .accommodationDetails!.singleBed ??
              0,
          showSpecificLocation:
          controller.detailsProperty.homestayData!.showSpecificLocation ??
              false,
          onPressed: () {
            Get.toNamed(Routes.checkInOutDatePage);
          },
          onDeleteDetails: () {
             // controller.deleteProperties();
          },
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double latitude = 51.5074;
  double longitude = -0.1278;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder<TravelingHomeController>(
        init: TravelingHomeController(),
        builder: (controller) => PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            controller.update();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 7.3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.update();
                          Get.back();
                        },
                        child: const Icon(Icons.keyboard_arrow_left_rounded,
                            size: 30)),
                    SizedBox(width: 1.w),
                    Flexible(
                      flex: 20,
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(AppRadius.radius10),
                          color: AppColors.white,
                        ),
                        child: Center(
                          child: TextField(
                            controller: controller.searchController,
                            onChanged: (value) {
                              if (controller.isLocation.value == true) {
                                if (controller.searchController.text.isEmpty) {
                                  controller.isLocation.value = false;
                                  controller.state.value = false;
                                  controller.mapLoading.value = true;
                                }
                              } else {
                                if (value.isNotEmpty) {
                                  controller.updateSearch();
                                } else {
                                  controller.state.value = false;
                                  controller.isNoDataFound.value = false;
                                }
                              }
                            },
                            cursorColor: AppColors.greyText,
                            decoration: InputDecoration(
                              hintText: Strings.search,
                              hintStyle: FontManager.regular(16.sp,
                                  color: AppColors.searchTextColor),
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                icon: Image.asset(
                                  Assets.imagesSearchIcon,
                                  height: 15,
                                  width: 15,
                                ),
                                onPressed: () {},
                              ),
                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  Assets.imagesCloseIcon,
                                  height: 22,
                                  width: 22,
                                ),
                                onPressed: () {
                                  if (controller.isLocation.value == true) {
                                    controller.isLocation.value = false;
                                    controller.searchController.clear();
                                    controller.mapLoading.value = true;
                                  } else {
                                    controller.state.value = false;
                                    controller.isNoDataFound.value = false;
                                    controller.searchController.clear();
                                    controller.searchFilterList.clear();
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () => controller.isNoDataFound.value
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Homestay Data Found",
                              style: FontManager.regular(15,
                                  color: AppColors.greyText),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Obx(() => controller.isLocation.value == true
                            ? Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 2.h),
                                      Text(Strings.radius,
                                          style: FontManager.medium(18,
                                              color: AppColors.black)),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${Strings.within} ${controller.sliderValue.value.toInt()} ${Strings.kms}",
                                        style: FontManager.regular(14,
                                            color: AppColors.black),
                                      ),
                                      Obx(() {
                                        return SliderTheme(
                                          data: SliderThemeData(
                                            trackShape: CustomTrackShape(),
                                            thumbShape: const CircleThumbShape(
                                                thumbRadius: 6.5),
                                            trackHeight: 2.5,
                                          ),
                                          child: Slider(
                                            value: controller.sliderValue.value,
                                            min: 1,
                                            max: 20,
                                            activeColor: AppColors.buttonColor,
                                            inactiveColor:
                                                AppColors.sliderInactiveColor,
                                            onChanged: (double newValue) {
                                              controller.sliderValue.value =
                                                  newValue;
                                            },
                                            semanticFormatterCallback:
                                                (double newValue) {
                                              return '${newValue.round()}';
                                            },
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 10),
                                      CommonButton(
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          String location = controller
                                              .searchController.text
                                              .trim();
                                          if (location.isNotEmpty) {
                                            try {
                                              List<Location> locations =
                                                  await locationFromAddress(
                                                      location);
                                              if (locations.isNotEmpty) {
                                                print("aaaaaaaaaaa${latitude}");
                                                print(
                                                    "aaaaaaaaaaa${longitude}");

                                                setState(() {
                                                  latitude =
                                                      locations.first.latitude;
                                                  longitude =
                                                      locations.first.longitude;
                                                  print(
                                                      "aaaaaaaaaaa111111${latitude}");
                                                  print(
                                                      "aaaaaaaaaaa111111${longitude}");
                                                });
                                              }
                                            } catch (e) {
                                              print("Error: $e");
                                            }
                                          }

                                          controller.mapLoading.value = false;
                                        },
                                        title: Strings.search,
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Obx(
                                            () => controller.mapLoading.value
                                                ? Center(child: Container())
                                                : FlutterMap(
                                                    options: MapOptions(
                                                      initialCenter:
                                                          LatLng.LatLng(
                                                              latitude,
                                                              longitude),
                                                      initialZoom: 10.0,
                                                    ),
                                                    children: [
                                                      TileLayer(
                                                        urlTemplate:
                                                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                        userAgentPackageName:
                                                            'com.example.app',
                                                      ),
                                                      MarkerLayer(
                                                        markers: [
                                                          Marker(
                                                            rotate: true,
                                                            point:
                                                                LatLng.LatLng(
                                                                    latitude,
                                                                    longitude),
                                                            child: const Icon(
                                                              Icons
                                                                  .location_pin,
                                                              size: 40.0,
                                                              color: AppColors
                                                                  .buttonColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : controller.state.value == true
                                ? controller.searchFilterList.isEmpty
                                    ? const Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      )
                                    : MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .searchFilterList.length,
                                            itemBuilder: (context, index) {
                                              return PropertyCard(
                                                coverPhotoUrl: controller
                                                    .searchFilterList[index]
                                                    .coverPhoto!
                                                    .url!,
                                                homestayType: controller
                                                    .searchFilterList[index]
                                                    .homestayType!,
                                                title: controller
                                                    .searchFilterList[index]
                                                    .title!,
                                                onTap: () => controller
                                                    .getDetails(index),
                                                location: Strings.newYorkUSA,
                                                status: controller
                                                    .searchFilterList[index]
                                                    .status!,
                                                basePrice: controller
                                                    .searchFilterList[index]
                                                    .basePrice!,
                                                weekendPrice: controller
                                                    .searchFilterList[index]
                                                    .weekendPrice!,
                                                traveling: true,
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                : controller.homeProperty == null
                                    ? const Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 2.h),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.isLocation.value =
                                                      true;
                                                },
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        Assets
                                                            .imagesLocationIcon,
                                                        height: 22,
                                                        width: 22,
                                                        fit: BoxFit.contain),
                                                    SizedBox(width: 2.w),
                                                    Text(
                                                      Strings
                                                          .orUseMyCurrentLocation,
                                                      style:
                                                          FontManager.regular(
                                                              15.sp,
                                                              color: AppColors
                                                                  .buttonColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Strings.recentSearch,
                                                    style: FontManager.regular(
                                                        14,
                                                        color: AppColors
                                                            .greyWelcomeToTravelbud),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: Expanded(
                                                child: ListView.builder(
                                                  itemCount: controller
                                                      .propertiesList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return PropertyCard(
                                                      coverPhotoUrl: controller
                                                          .propertiesList[index]
                                                          .coverPhoto!
                                                          .url!,
                                                      homestayType: controller
                                                          .propertiesList[index]
                                                          .homestayType!,
                                                      title: controller
                                                          .propertiesList[index]
                                                          .title!,
                                                      onTap: () => controller
                                                          .getDetails(index),
                                                      location:
                                                          Strings.newYorkUSA,
                                                      status: controller
                                                          .propertiesList[index]
                                                          .status!,
                                                      basePrice: controller
                                                          .propertiesList[index]
                                                          .basePrice!,
                                                      weekendPrice: controller
                                                          .propertiesList[index]
                                                          .weekendPrice!,
                                                      traveling: true,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                        // Obx(
                        //   () => controller.isSearching.value == false
                        //       ? Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(horizontal: 8),
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Image.asset(
                        //                   Assets.imagesLocationsearchicon,
                        //                   height: 112,
                        //                   width: 112,
                        //                 ),
                        //                 SizedBox(height: 2.h),
                        //                 Text(
                        //                   Strings.sorryWeCouldnFindAnyStaysNearLocation,
                        //                   style: FontManager.regular(14,
                        //                       color: AppColors.textAddProreties),
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //                 SizedBox(height: 1.h),
                        //                 Text(
                        //                   Strings.locationHelpYou,
                        //                   style: FontManager.regular(14,
                        //                       color: AppColors.greyText),
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         )
                        //
                        // ),
                        ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPropertyCard(Property property, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 35.h,
          width: 100.w,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 21.h,
              //     width: 100.w,
              //     decoration: BoxDecoration(
              //       borderRadius: const BorderRadius.all(AppRadius.radius10),
              //       image: DecorationImage(
              //         image: controller.imagePaths[index] != null
              //             ? FileImage(File(controller.imagePaths[index]!))
              //             : NetworkImage(property.imageUrl),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.tag,
                      style: FontManager.regular(12, color: property.tagColor),
                    ),
                    Text(
                      property.status,
                      style: FontManager.semiBold(14.sp,
                          color: property.statusColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 7.0),
                child: Text(
                  property.title,
                  style:
                      FontManager.medium(16, color: AppColors.textAddProreties),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4.0, bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.buttonColor),
                    SizedBox(width: 1.4.w),
                    Text(
                      property.location,
                      style: FontManager.regular(12, color: AppColors.greyText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeOfPlace({
    required String title,
    String? subtitle,
    required String imageAsset,
    required String value,
    required TravelingFlow controller,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Obx(() {
        bool isSelected;
        height == null
            ? isSelected = controller.selectedTypeOfPlace.value == value
            : isSelected = controller.selectedHomeStayType.value == value;

        return Container(
          width: double.infinity,
          height: height ?? 9.3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectContainerColor : Colors.white,
            borderRadius: const BorderRadius.all(AppRadius.radius10),
            border: Border.all(
              color: isSelected
                  ? AppColors.buttonColor
                  : AppColors.borderContainerGriedView,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imageAsset,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color:
                      isSelected ? AppColors.buttonColor : AppColors.greyText,
                ),
              ),
              subtitle == null
                  ? const SizedBox(
                      width: 2.5,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      title,
                      style: FontManager.regular(16,
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.black),
                    ),
                    const SizedBox(height: 2),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              subtitle,
                              style: FontManager.regular(12,
                                  color: AppColors.greyText),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => Radio(
                    value: value,
                    groupValue: height == null
                        ? controller.selectedTypeOfPlace.value
                        : controller.selectedHomeStayType.value,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        height == null
                            ? controller.selectType(newValue, imageAsset)
                            : controller.onSelectHomeStayType(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }
}

class TripCard extends StatelessWidget {
  final String name;
  final String status;
  final String bookingDate;
  final String requestId;
  final String totalAmount;
  final String requestDate;
  final String imageUrl;
  final String description;
  final String adults;
  final String children;
  final String infants;

  const TripCard({
    super.key,
    required this.name,
    required this.status,
    required this.bookingDate,
    required this.requestId,
    required this.totalAmount,
    required this.requestDate,
    required this.imageUrl,
    required this.description,
    required this.adults,
    required this.children,
    required this.infants,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                ProfileSection(name: name, status: status),
                SizedBox(height: 2.h),
                Text(
                  "Hilton View Villa",
                  style: FontManager.medium(14),
                ),
                SizedBox(height: 1.h),
                Text(
                  "P123456",
                  style: FontManager.regular(10, color: AppColors.buttonColor),
                ),
                SizedBox(height: 2.h),
                ImageSection(imageUrl: imageUrl),
                SizedBox(height: 0.h),
                DetailsSection(
                  bookingDate: bookingDate,
                  requestId: requestId,
                  totalAmount: totalAmount,
                  requestDate: requestDate,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Free Cancellation upto 48 hours before check-in",
                  style: FontManager.regular(12, color: AppColors.buttonColor),
                ),
                SizedBox(height: 1.h),
                Text(
                  description,
                  style: FontManager.regular(10, color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String name;
  final String status;

  const ProfileSection({super.key, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ClipOval(
          child: Image(
            image: AssetImage(Assets.imagesProfile),
            height: 40,
            width: 40,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: FontManager.regular(12),
                  ),
                  const Spacer(),
                  Text(
                    status,
                    style: FontManager.regular(10,
                        color: status == "pending"
                            ? AppColors.pendingColor
                            : status == "Cancel"
                                ? AppColors.redAccent
                                : AppColors.buttonColor),
                  ),
                ],
              ),
              const Row(
                children: [
                  InfoText("2 ${Strings.adults}"),
                  Divider(),
                  InfoText("2 ${Strings.children}"),
                  Divider(),
                  InfoText("2 ${Strings.infants}"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: FontManager.regular(10, color: AppColors.greyText),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.3.h,
      child: Container(
        width: 1.5,
        height: 1.5.h,
        decoration: const BoxDecoration(
          color: AppColors.buttonColor,
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imageUrl;

  const ImageSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 157,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadius.radius10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  final String bookingDate;
  final String requestId;
  final String totalAmount;
  final String requestDate;

  const DetailsSection({
    super.key,
    required this.bookingDate,
    required this.requestId,
    required this.totalAmount,
    required this.requestDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsColumn(
          title: "Booking Date",
          value: bookingDate,
        ),
        DetailsColumn(
          title: "Request ID",
          value: requestId,
        ),
        DetailsColumn(
          title: "Total Booking Amount",
          value: totalAmount,
        ),
        DetailsColumn(
          title: "Request Date",
          value: requestDate,
        ),
      ],
    );
  }
}

class DetailsColumn extends StatelessWidget {
  final String title;
  final String value;

  const DetailsColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          title,
          style: FontManager.regular(12, color: AppColors.black),
        ),
        Text(
          value,
          style: FontManager.regular(10, color: AppColors.greyText),
        ),
        SizedBox(height: 1.5.h),
      ],
    );
  }
}
  
class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            headerTrip(),
            const SizedBox(height: 26),
            TabBar(
              unselectedLabelColor: AppColors.black,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              unselectedLabelStyle: FontManager.regular(14),
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              labelStyle: FontManager.regular(14, color: AppColors.buttonColor),
              indicatorWeight: 0.5.w,
              tabs: const [
                Tab(text: Strings.upcoming),
                Tab(text: Strings.cancelRefund),
                Tab(text: Strings.completed),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 530,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          2, (index) => customCardTrip("panding")),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children:
                          List.generate(2, (index) => customCardTrip("Cancel")),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          2, (index) => customCardTrip("Completed")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customCardTrip(String? status) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const ClipOval(
                      child: Image(
                        image: AssetImage(Assets.imagesProfile),
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kristin Martine",
                                style: FontManager.regular(12),
                              ),
                              const Spacer(),
                              Text(
                                status!,
                                style: FontManager.regular(10,
                                    color: status == "panding"
                                        ? AppColors.pendingColor
                                        : status == "Cancel"
                                            ? AppColors.redAccent
                                            : AppColors.buttonColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "2 ${Strings.adults}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                              SizedBox(width: 1.3.h),
                              Container(
                                width: 1.5,
                                height: 1.5.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              SizedBox(width: 1.3.h),
                              Text(
                                "2 ${Strings.children}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                              SizedBox(width: 1.3.h),
                              Container(
                                width: 1.5,
                                height: 1.5.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              SizedBox(width: 1.3.h),
                              Text(
                                "2 ${Strings.infants}",
                                style: FontManager.regular(10,
                                    color: AppColors.greyText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  "Hilton View Villa",
                  style: FontManager.medium(14),
                ),
                SizedBox(height: 1.h),
                Text(
                  "P123456",
                  style: FontManager.regular(10, color: AppColors.buttonColor),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 157,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          "Booking Date",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "04 April 24 06:00 PM",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "Request ID",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "ABCD1234",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Booking Amount",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "\$ 6,66,666",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "Request Date",
                          style:
                              FontManager.regular(12, color: AppColors.black),
                        ),
                        Text(
                          "24 Nov 24 06:00 PM",
                          style: FontManager.regular(10,
                              color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  "Free Cancellation upto 48 hours before check-in",
                  style: FontManager.regular(12, color: AppColors.buttonColor),
                ),
                SizedBox(height: 1.h),
                Text(
                  Strings.descriptionReadMore,
                  style: FontManager.regular(10, color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerTrip() {
    return Container(
      height: 99,
      width: double.infinity,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.trips,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

class CustomThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final Path path = Path();
    path.addOval(
      Rect.fromCenter(
        width: 18,
        height: 18,
        center: Offset(center.dx, center.dy),
      ),
    );
    path.close();

    context.canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.buttonColor
        ..style = PaintingStyle.fill,
    );

    final Path path1 = Path();
    path1.addOval(
      Rect.fromCenter(
        width: 10,
        height: 10,
        center: Offset(center.dx, center.dy),
      ),
    );
    path1.close();

    context.canvas.drawPath(
      path1,
      Paint()
        ..color = AppColors.greyText
        ..style = PaintingStyle.fill,
    );
  }
}

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder(
        init: TravelingHomeController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7.3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.sp),
                      child: Text(
                        Strings.filter,
                        style: FontManager.medium(19.4.sp,
                            color: AppColors.textAddProreties),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: AppColors.greyText,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.9.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.priceRange,
                      style: FontManager.medium(18,
                          color: AppColors.textAddProreties),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                SfRangeSliderTheme(
                  data: const SfRangeSliderThemeData(
                    tooltipBackgroundColor: AppColors.buttonColor,
                    activeTrackColor: AppColors.buttonColor,
                    inactiveTrackColor: AppColors.greyText,
                  ),
                  child: Obx(
                    () => SfRangeSlider(
                      thumbShape: CustomThumbShape(),
                      enableTooltip: true,
                      min: 0,
                      max: 30000,
                      stepSize: 10,
                      interval: 100,
                      values: SfRangeValues(
                          controller.minValue.value, controller.maxValue.value),
                      onChanged: (dynamic values) {
                        double start = values.start as double;
                        double end = values.end as double;
                        String startString = start.toInt().toString();
                        String endString = end.toInt().toString();
                        controller.minValue.value = start;
                        controller.maxValue.value = end;
                        controller.minPriceController.text = startString;
                        controller.maxPriceController.text = endString;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.minimum,
                            style: FontManager.regular(16.1.sp,
                                color: AppColors.textAddProreties),
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            width: 110.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: AppColors.borderContainerGriedView),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.minPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
                                      onFieldSubmitted: (value) {
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 0.0;
                                          controller.minValue.value = newValue;
                                          controller.updateSliderValues();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 3.5.w),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.maximum,
                            style: FontManager.regular(16.1.sp,
                                color: AppColors.textAddProreties),
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            width: 110.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: AppColors.borderContainerGriedView),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      controller: controller.maxPriceController,
                                      style: FontManager.regular(16,
                                          color: AppColors.textAddProreties),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "\u{20B9}"),
                                      onFieldSubmitted: (value) {
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          double newValue = double.tryParse(value) ?? 30000.0;
                                          controller.maxValue.value = newValue;
                                          controller.updateSliderValues();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 3.5.w),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Strings.sortByPrice,
                  style:
                      FontManager.medium(18, color: AppColors.textAddProreties),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesAny,
                    title: Strings.any,
                    isSelected: controller.selectedSorting.value == 0,
                    onSelect: () => controller.onSelectSoring(0),
                  ),
                ),
                SizedBox(height: 2.h),
                Obx(
                  () => AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesLtohighest,
                    title: Strings.lowestToHighest,
                    isSelected: controller.selectedSorting.value == 1,
                    onSelect: () => controller.onSelectSoring(1),
                  ),
                ),
                SizedBox(height: 2.h),
                Obx(
                  () => AmenityAndHouseRulesContainer(
                    imageAsset: Assets.imagesHToLowest,
                    title: Strings.highestToLowest,
                    isSelected: controller.selectedSorting.value == 2,
                    onSelect: () => controller.onSelectSoring(2),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Strings.typeOfPlace,
                  style:
                      FontManager.medium(18, color: AppColors.textAddProreties),
                ),
                SizedBox(
                  height: 2.h,
                ),
                buildTypeOfPlace(
                  title: Strings.entirePlace,
                  subtitle: Strings.wholePlacetoGuests,
                  imageAsset: Assets.imagesTraditional,
                  value: Strings.entirePlaceValue,
                  controller: controller,
                ),
                const SizedBox(height: 20),
                buildTypeOfPlace(
                  title: Strings.privateRoom,
                  subtitle:
                      Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
                  imageAsset: Assets.imagesPrivateRoom,
                  value: Strings.privateRoomValue,
                  controller: controller,
                ),
                SizedBox(
                  height: 3.2.h,
                ),
                Text(
                  Strings.homestayType,
                  style:
                      FontManager.medium(18, color: AppColors.textAddProreties),
                ),
                SizedBox(
                  height: 2.h,
                ),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesTraditional,
                  title: Strings.traditional,
                  controller: controller,
                  value: 'traditional',
                  height: 7.6.h,
                ),
                SizedBox(height: 2.h),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesBedAndBreakfast2,
                  title: Strings.bedAndBreakfast,
                  controller: controller,
                  value: 'bedAndBreakfast',
                  height: 7.6.h,
                ),
                SizedBox(height: 2.h),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesUrban2,
                  title: Strings.urban,
                  controller: controller,
                  value: 'urban',
                  height: 7.6.h,
                ),
                SizedBox(height: 2.h),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesEcoFriendly2,
                  title: Strings.ecoFriendly,
                  controller: controller,
                  value: 'ecoFriendly',
                  height: 7.6.h,
                ),
                SizedBox(height: 2.h),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesAdvanture2,
                  title: Strings.adventure,
                  controller: controller,
                  value: 'adventure',
                  height: 7.6.h,
                ),
                SizedBox(height: 2.h),
                buildTypeOfPlace(
                  imageAsset: Assets.imagesLuxury2,
                  title: Strings.luxury,
                  controller: controller,
                  value: 'luxury',
                  height: 7.6.h,
                ),
                SizedBox(
                  height: 3.2.h,
                ),
                Text(
                  Strings.accommodationDetails,
                  style:
                      FontManager.medium(18, color: AppColors.textAddProreties),
                ),
                SizedBox(
                  height: 2.h,
                ),
                buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
                    controller.maxGuestsCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesBedRooms, Strings.singleBed,
                    controller.singleBedCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesSingleBed, Strings.bedRooms,
                    controller.bedroomsCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed,
                    controller.doubleBedCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesExtraFloor,
                    Strings.extraFloorMattress, controller.extraFloorCount),
                SizedBox(height: 2.h),
                buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms,
                    controller.bathRoomsCount),
                SizedBox(height: 2.h),
                Container(
                  width: 100.w,
                  height: 7.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.borderContainerGriedView,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 0.w),
                      Image.asset(
                        Assets.imagesKitchen,
                        height: 26,
                        width: 26,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        Strings.kitchenAvailable,
                        style: FontManager.regular(14, color: AppColors.black),
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      Obx(() => Checkbox(
                            activeColor: AppColors.buttonColor,
                            value: controller.isKitchenAvailable.value,
                            onChanged: (bool? newValue) {
                              controller.isKitchenAvailable.value =
                                  newValue ?? false;
                            },
                            side: const BorderSide(
                                color: AppColors.texFiledColor),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.2.h,
                ),
                Text(
                  Strings.amenities,
                  style:
                      FontManager.medium(18, color: AppColors.textAddProreties),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () {
                    if (controller.selectedAmenities.length < 5) {
                      controller.selectedAmenities.value =
                          List.generate(5, (_) => false);
                    }
                    return Column(
                      children: [
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesWiFi,
                          title: Strings.wiFi,
                          isSelected: controller.selectedAmenities[0],
                          onSelect: () => controller.toggleAmenity(0),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesAirCondioner,
                          title: Strings.airConditioner,
                          isSelected: controller.selectedAmenities[1],
                          onSelect: () => controller.toggleAmenity(1),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesFirAlarm,
                          title: Strings.fireAlarm,
                          isSelected: controller.selectedAmenities[2],
                          onSelect: () => controller.toggleAmenity(2),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesHometherater,
                          title: Strings.homeTheater,
                          isSelected: controller.selectedAmenities[3],
                          onSelect: () => controller.toggleAmenity(3),
                        ),
                        SizedBox(height: 2.h),
                        AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesMastrSuite,
                          title: Strings.masterSuiteBalcony,
                          isSelected: controller.selectedAmenities[4],
                          onSelect: () => controller.toggleAmenity(4),
                        ),
                      ],
                    );
                  },
                ),
                controller.showMore.value == true
                    ? Obx(
                        () {
                          if (controller.selectedRules.length < 4) {
                            controller.selectedRules.value =
                                List.generate(4, (_) => false);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3.2.h,
                              ),
                              Text(
                                Strings.rules,
                                style: FontManager.medium(18,
                                    color: AppColors.textAddProreties),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              AmenityAndHouseRulesContainer(
                                imageAsset: Assets.imagesNoSmoking,
                                title: Strings.noSmoking,
                                isSelected: controller.selectedRules[0],
                                onSelect: () => controller.toggleRules(0),
                              ),
                              SizedBox(height: 2.h),
                              AmenityAndHouseRulesContainer(
                                imageAsset: Assets.imagesNoDrinking,
                                title: Strings.noDrinking,
                                isSelected: controller.selectedRules[1],
                                onSelect: () => controller.toggleRules(1),
                              ),
                              SizedBox(height: 2.h),
                              AmenityAndHouseRulesContainer(
                                imageAsset: Assets.imagesNoPet,
                                title: Strings.noPet,
                                isSelected: controller.selectedRules[2],
                                onSelect: () => controller.toggleRules(2),
                              ),
                              SizedBox(height: 2.h),
                              AmenityAndHouseRulesContainer(
                                imageAsset: Assets.imagesDamageToProretiy,
                                title: Strings.damageToProperty,
                                isSelected: controller.selectedRules[3],
                                onSelect: () => controller.toggleRules(3),
                              ),
                            ],
                          );
                        },
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: 2.4.h),
                controller.showMore.value == false
                    ? InkWell(
                        onTap: () {
                          controller.updateShowMore(true);
                        },
                        child: const Text(Strings.showMore,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.buttonColor,
                              color: AppColors.buttonColor,
                            )),
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          LoadingProcessCommon().showLoading();
                          controller.clearFilters();
                          controller.getTravelingData().then((value) {
                            LoadingProcessCommon().hideLoading();
                            Get.back();
                          },);
                        },
                        child: Container(
                          height: 5.9.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                                const BorderRadius.all(AppRadius.radius10),
                          ),
                          child: Center(
                            child: Text(
                              Strings.clearAll,
                              style: FontManager.medium(18,
                                  color: AppColors.buttonColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          LoadingProcessCommon().showLoading();
                          controller.fetchFilteredProperties().then((value) {
                            LoadingProcessCommon().hideLoading();
                            Get.back();
                          },);
                        },
                        child: Container(
                          height: 5.9.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                                const BorderRadius.all(AppRadius.radius10),
                          ),
                          child: Center(
                            child: Text(
                              Strings.submit,
                              style: FontManager.medium(18,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }

  Widget buildTypeOfPlace({
    required String title,
    String? subtitle,
    required String imageAsset,
    required String value,
    required TravelingHomeController controller,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {
        if (height == null) {
          controller.selectType(value);
        } else {
          controller.onSelectHomeStayType(value);
        }
      },
      child: Obx(() {
        bool isSelected;
        height == null
            ? isSelected = controller.selectedTypeOfPlace.value == value
            : isSelected = controller.selectedHomeStayType.value == value;

        return Container(
          width: double.infinity,
          height: height ?? 9.3.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectContainerColor : Colors.white,
            borderRadius: const BorderRadius.all(AppRadius.radius10),
            border: Border.all(
              color: isSelected
                  ? AppColors.buttonColor
                  : AppColors.borderContainerGriedView,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imageAsset,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color:
                      isSelected ? AppColors.buttonColor : AppColors.greyText,
                ),
              ),
              subtitle == null
                  ? const SizedBox(
                      width: 2.5,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      title,
                      style: FontManager.regular(16,
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.black),
                    ),
                    const SizedBox(height: 2),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              subtitle,
                              style: FontManager.regular(12,
                                  color: AppColors.greyText),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => Radio(
                    value: value,
                    groupValue: height == null
                        ? controller.selectedTypeOfPlace.value
                        : controller.selectedHomeStayType.value,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        height == null
                            ? controller.selectType(newValue)
                            : controller.onSelectHomeStayType(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CheckinoutdatePage extends StatefulWidget {
  const CheckinoutdatePage({super.key});

  @override
  State<CheckinoutdatePage> createState() => _CheckinoutdatePageState();
}

class _CheckinoutdatePageState extends State<CheckinoutdatePage> {
  final TravelingFlow controller = Get.put(TravelingFlow());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.3.h),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.keyboard_arrow_left_rounded,
                        size: 30)),
                SizedBox(width: 1.w),
                Text(
                  Strings.checkInOutDate,
                  style: FontManager.medium(20, color: AppColors.black),
                )
              ],
            ),
            SizedBox(height: 3.h,),
            SizedBox(
              height: 260,
              child: SfDateRangePicker(
                backgroundColor: AppColors.datePickerBackgroundColor,
                rangeSelectionColor: AppColors.selectContainerColor,
                startRangeSelectionColor: AppColors.buttonColor,
                endRangeSelectionColor: AppColors.buttonColor,
                selectionColor: AppColors.buttonColor,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.datePickerBackgroundColor,
                  textStyle: FontManager.regular(16, color: AppColors.black),
                ),
                onSelectionChanged: (args) {
                  if (args.value is PickerDateRange) {
                    final PickerDateRange range = args.value;
                    controller.updateDateRange(
                        range.startDate, range.endDate);
                  }
                },
                selectionMode: DateRangePickerSelectionMode.extendableRange,
                initialSelectedRanges: [
                  PickerDateRange(
                    DateTime.now(),
                    DateTime.now().add(const Duration(days: 1)),
                  ),
                ],
                minDate: DateTime(2020),
                maxDate: DateTime(2025),
              ),
            ),
            SizedBox(height: 1.8.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.defult5Night,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "${controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : ''} - ${controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : ''}",
                    style: FontManager.regular(12, color: AppColors.greyText),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.8.h),
            Text(
              Strings.selectGuest,
              style:
                  FontManager.semiBold(16, color: AppColors.textAddProreties),
            ),
            SizedBox(height: 1.8.h),
            createGuestRow(Strings.adults, Strings.ages14orAbove,
                controller.adultCount),
            SizedBox(height: 1.8.h),
            createDivider(),
            SizedBox(height: 1.8.h),
            createGuestRow(
                Strings.children, Strings.ages2to13, controller.childCount),
            SizedBox(height: 1.8.h),
            createDivider(),
            SizedBox(height: 1.8.h),
            createGuestRow(
                Strings.infants, Strings.under2, controller.infantCount),
            SizedBox(
              height: 6.h,
            ),
            CommonButton(
              title: Strings.nextStep,
              onPressed: () {
                Get.toNamed(Routes.bookingRequestPage);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createGuestRow(String title, String subtitle, RxInt count) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    FontManager.regular(16, color: AppColors.textAddProreties)),
            Text(subtitle,
                style: FontManager.regular(11, color: AppColors.greyText)),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => count.value > 0 ? count.value-- : null,
              child: Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius6),
                  color: AppColors.selectGuestDecColor,
                ),
                child:
                    Center(child: Image.asset(Assets.imagesMinus, width: 15)),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Text("${count.value}")),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => count.value++,
              child: Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius6),
                  color: AppColors.buttonColor,
                ),
                child: const Icon(Icons.add, color: AppColors.white, size: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget createDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      decoration: const BoxDecoration(color: AppColors.greyText),
    );
  }
}

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({super.key});

  @override
  State<BookingRequestPage> createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final TravelingFlow controller = Get.put(TravelingFlow());
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.3.h),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.keyboard_arrow_left_rounded,
                          size: 30)),
                  SizedBox(width: 1.w),
                  Text(
                    Strings.checkInOutDate,
                    style: FontManager.medium(20, color: AppColors.black),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Card(
                color: AppColors.white,
                elevation: 3,
                shadowColor: const Color(0xffEEEEEE),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 90,
                        height: 73,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(AppRadius.radius10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.hiltonViewVilla,
                            style: FontManager.semiBold(16,
                                color: AppColors.textAddProreties),
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.newYorkUSA,
                                style: FontManager.regular(12,
                                    color: AppColors.divaide2Color),
                              ),
                              SizedBox(width: 1.4.w),
                              const Icon(Icons.location_on,
                                  color: AppColors.buttonColor),
                            ],
                          ),
                          Text(
                            Strings.entirePlace,
                            style: FontManager.regular(10,
                                color: AppColors.buttonColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.yourBookingDetails,
                style:
                    FontManager.semiBold(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.date,
                style:
                    FontManager.medium(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Text(
                "${controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : ''} - ${controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : ''}",
                style: FontManager.regular(14, color: AppColors.greyText),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.guest,
                style:
                    FontManager.medium(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Row(
                children: [
                  Text(
                    "${controller.adultCount.value} ${Strings.adults}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Container(
                    width: 1.5,
                    height: 3.h,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Text(
                    "${controller.childCount.value} ${Strings.children}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Container(
                    width: 1.5,
                    height: 3.h,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 1.3.h,
                  ),
                  Text(
                    "${controller.infantCount.value} ${Strings.infants}",
                    style: FontManager.regular(14, color: AppColors.greyText),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.priceDetails,
                style:
                    FontManager.semiBold(16, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.defult5Night,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "6,000",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.taxes,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "60",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.serviceFee,
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                  Text(
                    "600",
                    style: FontManager.regular(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaideColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.total,
                    style: FontManager.semiBold(14, color: AppColors.black),
                  ),
                  Text(
                    "6,660",
                    style: FontManager.semiBold(14, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.mealsIncluded,
                style:
                    FontManager.semiBold(18, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.freeBreakfastLunchDinner,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.cancellationPolicy,
                style:
                    FontManager.semiBold(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.freeCancellationUntil,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(color: AppColors.divaide2Color),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRules,
                style:
                    FontManager.semiBold(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRulesDes,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Strings.houseRulesDes2,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                Strings.houseRulesDes3,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.buttonColor,
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
                      });
                    },
                    side: const BorderSide(color: AppColors.texFiledColor),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    flex: 2,
                    child: Text(
                      Strings.confirmPaymentDesc,
                      style: FontManager.regular(10,
                          color: AppColors.texFiledColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              CommonButton(
                title: Strings.confirmPayment,
                onPressed: () {},
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
import 'package:travellery_mobile/screen/hosting_flow/data/model/hosting_model.dart';
import 'package:travellery_mobile/screen/hosting_flow/data/repository/hosting_repository.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../common_widgets/common_loading_process.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../reuseble_flow/data/model/single_fetch_homestay_model.dart';

class HostingHomeController extends GetxController {
  HomeHostingPropertiesModel? homeProperty;
  List<HomestayData> propertiesList = [];
  var hostingRepository = getIt<HostingRepository>();
  var apiHelper = getIt<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
    if (propertiesList.isEmpty) {
      getHostingData();
    }
  }

  Future<void> getHostingData() async {
    homeProperty = await hostingRepository.getHostingProperties();
    if (homeProperty != null && homeProperty!.homestayData != null) {
      propertiesList = homeProperty!.homestayData!;
    } else {
      propertiesList = [];
    }
    update();
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
          Routes.hostingDetailsPage,
        );
      },
    );
  }

  late HomeStaySingleFetchResponse detailsProperty;

  Future<void> getSingleYourProperties() async {
    detailsProperty = await hostingRepository.getSingleFetchProperties();
  }

  void deleteProperties() {
    hostingRepository.deleteData().then(
      (value) async {
        homeProperty = await hostingRepository.getHostingProperties().then(
          (value) {
            Get.back();
            Get.back();
            return null;
          },
        );
      },
    );
    update();
  }

  void homeStayAddDataLocally() async {
    var homestayData = ReUsedDataModel(
      title: detailsProperty.homestayData?.title ?? '',
      homestayType: detailsProperty.homestayData?.homestayType ?? '',
      description: detailsProperty.homestayData?.description ?? '',
      basePrice: detailsProperty.homestayData?.basePrice ?? 0,
      weekendPrice: detailsProperty.homestayData?.weekendPrice ?? 0,
      ownerContactNo: detailsProperty.homestayData?.ownerContactNo ?? '',
      ownerEmailId: detailsProperty.homestayData?.ownerEmailId ?? '',
      homestayContactNo: detailsProperty.homestayData?.homestayContactNo,
      homestayEmailId: detailsProperty.homestayData?.homestayEmailId,
      accommodationDetails: detailsProperty.homestayData?.accommodationDetails!,
      amenities: detailsProperty.homestayData?.amenities!,
      houseRules: detailsProperty.homestayData?.houseRules!,
      address: detailsProperty.homestayData?.address ?? '',
      street: detailsProperty.homestayData?.street ?? '',
      landmark: detailsProperty.homestayData?.landmark ?? '',
      city: detailsProperty.homestayData?.city ?? '',
      pinCode: detailsProperty.homestayData?.pinCode ?? '',
      latitude: detailsProperty.homestayData?.latitude ?? 0,
      longitude: detailsProperty.homestayData?.latitude,
      state: detailsProperty.homestayData?.state ?? '',
      showSpecificLocation:
          detailsProperty.homestayData?.showSpecificLocation ?? false,
      coverPhoto: detailsProperty.homestayData!.coverPhoto!,
      homestayPhotos: detailsProperty.homestayData!.homestayPhotos ?? [],
      checkInTime: detailsProperty.homestayData?.checkInTime ?? '',
      checkOutTime: detailsProperty.homestayData?.checkOutTime ?? '',
      flexibleCheckIn: detailsProperty.homestayData?.flexibleCheckIn ?? false,
      flexibleCheckOut: detailsProperty.homestayData?.flexibleCheckOut ?? false,
    );

    Get.toNamed(
      Routes.addPropertiesScreen,
      arguments: {'index': 1, 'homestayData': homestayData},
    );
  }
}
import '../../../reuseble_flow/data/model/homestay_reused_model.dart';

class HomeHostingPropertiesModel {
  String? message;
  List<HomestayData>? homestayData;
  int? totalHomestay;

  HomeHostingPropertiesModel(
      {this.message, this.homestayData, this.totalHomestay});

  HomeHostingPropertiesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['HomestayData'] != null) {
      homestayData = <HomestayData>[];
      json['HomestayData'].forEach((v) {
        homestayData!.add(HomestayData.fromJson(v));
      });
    }
    totalHomestay = json['totalHomestay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (homestayData != null) {
      data['HomestayData'] = homestayData!.map((v) => v.toJson()).toList();
    }
    data['totalHomestay'] = totalHomestay;
    return data;
  }
}

class HomestayData {
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
  int? iV;

  HomestayData(
      {this.accommodationDetails,
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
      this.iV});

  HomestayData.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
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
    data['__v'] = iV;
    return data;
  }
}

class AccommodationDetails {
  bool? entirePlace;
  bool? privateRoom;
  int? maxGuests;
  int? bedrooms;
  int? singleBed;
  int? doubleBed;
  int? extraFloorMattress;
  int? bathrooms;
  bool? kitchenAvailable;

  AccommodationDetails(
      {this.entirePlace,
      this.privateRoom,
      this.maxGuests,
      this.bedrooms,
      this.singleBed,
      this.doubleBed,
      this.extraFloorMattress,
      this.bathrooms,
      this.kitchenAvailable});

  AccommodationDetails.fromJson(Map<String, dynamic> json) {
    entirePlace = json['entirePlace'];
    privateRoom = json['privateRoom'];
    maxGuests = json['maxGuests'];
    bedrooms = json['bedrooms'];
    singleBed = json['singleBed'];
    doubleBed = json['doubleBed'];
    extraFloorMattress = json['extraFloorMattress'];
    bathrooms = json['bathrooms'];
    kitchenAvailable = json['kitchenAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entirePlace'] = entirePlace;
    data['privateRoom'] = privateRoom;
    data['maxGuests'] = maxGuests;
    data['bedrooms'] = bedrooms;
    data['singleBed'] = singleBed;
    data['doubleBed'] = doubleBed;
    data['extraFloorMattress'] = extraFloorMattress;
    data['bathrooms'] = bathrooms;
    data['kitchenAvailable'] = kitchenAvailable;
    return data;
  }
}

class CoverPhoto {
  String? publicId;
  String? url;

  CoverPhoto({this.publicId, this.url});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}

class Amenities {
  String? name;
  bool? isChecked;
  bool? isNewAdded;
  String? sId;

  Amenities({this.name, this.isChecked, this.isNewAdded, this.sId});

  Amenities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
    isNewAdded = json['isNewAdded'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    data['isNewAdded'] = isNewAdded;
    data['_id'] = sId;
    return data;
  }
}

class HomestayPhotos {
  String? publicId;
  String? url;
  String? sId;

  HomestayPhotos({this.publicId, this.url, this.sId});

  HomestayPhotos.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}

class HomestayContactNo {
  String? contactNo;
  String? sId;

  HomestayContactNo({this.contactNo, this.sId});

  HomestayContactNo.fromJson(Map<String, dynamic> json) {
    contactNo = json['contactNo'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactNo'] = contactNo;
    data['_id'] = sId;
    return data;
  }
}

class HomestayEmailId {
  String? emailId;
  String? sId;

  HomestayEmailId({this.emailId, this.sId});

  HomestayEmailId.fromJson(Map<String, dynamic> json) {
    emailId = json['EmailId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmailId'] = emailId;
    data['_id'] = sId;
    return data;
  }
}

class CreatedBy {
  ProfileImage? profileImage;
  String? sId;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? deviceToken;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreatedBy(
      {this.profileImage,
      this.sId,
      this.name,
      this.mobile,
      this.email,
      this.password,
      this.deviceToken,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class HostingRepository{

  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<HomeHostingPropertiesModel> getHostingProperties() async {

    String? getUserId = getIt<StorageServices>().getUserId();
    print("aaaaaaaaaa$getUserId");
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.hostingGetDataUrl}/$getUserId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeHostingPropertiesModel.fromJson(data);
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchProperties() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$yourPropertiesId",
    );

    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> deleteData() async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    dio.Response? response = await apiProvider.deleteData(
      "${apiURLs.baseUrl}${apiURLs.propertiesDelete}/$yourPropertiesId",
    );
    Map<String, dynamic> data = response!.data;
    return data;
  }

}

class HostingDetailsPage extends StatefulWidget {
  const HostingDetailsPage({super.key});

  @override
  State<HostingDetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<HostingDetailsPage>
    with SingleTickerProviderStateMixin {
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
      body: GetBuilder(
        init: HostingHomeController(),
        builder: (controller) => PropertyCardWidget(
          title: Strings.details,
          homestayType:
              controller.detailsProperty.homestayData!.homestayType ?? '',
          accommodationType: controller.detailsProperty.homestayData!
                      .accommodationDetails!.entirePlace ==
                  true
              ? Strings.entirePlace
              : Strings.privateRoom,
          address: controller.detailsProperty.homestayData!.address ?? '',
          basePrice: controller.detailsProperty.homestayData!.basePrice ?? 0,
          checkInTime:
              controller.detailsProperty.homestayData!.checkInTime ?? '',
          checkOutTime:
              controller.detailsProperty.homestayData!.checkOutTime ?? '',
          statusBarHeight: statusBarHeight,
          homestayPhotos:
              controller.detailsProperty.homestayData!.homestayPhotos ?? [],
          status: controller.detailsProperty.homestayData!.status ?? '',
          ownerContactNumber:
              controller.detailsProperty.homestayData!.ownerContactNo ?? '',
          ownerEmail:
              controller.detailsProperty.homestayData!.ownerEmailId ?? '',
          dataTitle: controller.detailsProperty.homestayData!.title ?? '',
          description:
              controller.detailsProperty.homestayData!.description ?? '',
          flexibleCheckIn:
              controller.detailsProperty.homestayData!.flexibleCheckIn ?? false,
          flexibleCheckOut:
              controller.detailsProperty.homestayData!.flexibleCheckOut ??
                  false,
          homestayContactNoList:
              controller.detailsProperty.homestayData!.homestayContactNo ?? [],
          homestayEmailIdList:
              controller.detailsProperty.homestayData!.homestayEmailId ?? [],
          tabController: _tabController,
          weekendPrice:
              controller.detailsProperty.homestayData!.weekendPrice ?? 0,
          bathrooms: controller.detailsProperty.homestayData!
                  .accommodationDetails!.bathrooms ??
              0,
          bedrooms: controller.detailsProperty.homestayData!
                  .accommodationDetails!.bedrooms ??
              0,
          city: controller.detailsProperty.homestayData!.city ?? '',
          doubleBed: controller.detailsProperty.homestayData!
                  .accommodationDetails!.doubleBed ??
              0,
          extraFloorMattress: controller.detailsProperty.homestayData!.accommodationDetails!.extraFloorMattress ?? 0,
          kitchenAvailable: controller.detailsProperty.homestayData!.accommodationDetails!.kitchenAvailable ?? false,
          landmark: controller.detailsProperty.homestayData!.landmark ?? '',
          pinCode: controller.detailsProperty.homestayData!.pinCode ?? '',
          state: controller.detailsProperty.homestayData!.state ?? '',
          street: controller.detailsProperty.homestayData!.street ?? '',
          maxGuests: controller.detailsProperty.homestayData!.accommodationDetails!.maxGuests ?? 0,
          singleBed: controller.detailsProperty.homestayData!.accommodationDetails!.singleBed ?? 0,
          showSpecificLocation: controller.detailsProperty.homestayData!.showSpecificLocation ?? false,
          onPressed: () {},
          onDeleteDetails: () {
            controller.deleteProperties();
          },
          detailsHosting: true,
          onPressedEdit: () {
            controller.homeStayAddDataLocally();
          },
        ),
      ),
    );
  }
}

class HomeHostingPage extends StatefulWidget {
  const HomeHostingPage({super.key});

  @override
  State<HomeHostingPage> createState() => _HomeHostingPageState();
}

class _HomeHostingPageState extends State<HomeHostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(
        init: HostingHomeController(),
        builder: (controller) => Column(
          children: [
            buildHeader(),
            const SizedBox(height: 26),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    Strings.properties,
                    style: FontManager.semiBold(20.sp, color: AppColors.black),
                  ),
                ),
              ],
            ),
            controller.propertiesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Flexible(
                    child: ListView.builder(
                      itemCount: controller.propertiesList.length,
                      itemBuilder: (context, index) {
                        return PropertyCard(
                          coverPhotoUrl:
                              controller.propertiesList[index].coverPhoto!.url!,
                          homestayType:
                              controller.propertiesList[index].homestayType!,
                          title: controller.propertiesList[index].title!,
                          onTap: () =>
                              controller.propertiesList[index].status! ==
                                      Strings.draft
                                  ? controller.homeStayAddDataLocally()

                                  :  controller.getDetails(index),
                          location: controller.propertiesList[index].city!,
                          status: controller.propertiesList[index].status!,
                          basePrice:
                              controller.propertiesList[index].basePrice!,
                          weekendPrice:
                              controller.propertiesList[index].weekendPrice!,
                          traveling: false,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 190,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.helloJhon,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                  Text(
                    Strings.welcomeToTravelbud,
                    style: FontManager.regular(14,
                        color: AppColors.greyWelcomeToTravelbud),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                Assets.imagesTv,
                width: 42,
                height: 36,
              ),
              SizedBox(width: 4.6.w),
            ],
          ),
          SizedBox(height: 4.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Container(
                height: 6.h,
                width: 75.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(AppRadius.radius10),
                  color: AppColors.white,
                ),
                child: Center(
                  child: TextField(
                    onTap: () {
                      Get.toNamed(Routes.search);
                    },
                    cursorColor: AppColors.greyText,
                    decoration: InputDecoration(
                      hintText: Strings.search,
                      hintStyle: FontManager.regular(16.sp,
                          color: AppColors.searchTextColor),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.searchIconColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.filterPage);
                },
                child: Container(
                  height: 6.h,
                  width: 15.w,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.imagesFilterslines,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            headerTrip(),
            const SizedBox(height: 26),
            TabBar(
              unselectedLabelColor: AppColors.black,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              unselectedLabelStyle: FontManager.regular(14),
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              labelStyle: FontManager.regular(14, color: AppColors.buttonColor),
              indicatorWeight: 0.5.w,
              tabs: const [
                Tab(text: Strings.properties),
                Tab(text: Strings.payoutDetails),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 530,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(2, (index) => customCardTrip()),
                    ),
                  ),
                  SingleChildScrollView(
                    child: paymentCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customCardTrip() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.all(AppRadius.radius10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "P123456",
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                    Text(
                      "Calendar Availability",
                      style:
                          FontManager.regular(10, color: AppColors.buttonColor),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 157,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Eco - Friendly",
                        style: FontManager.regular(12,
                            color: AppColors.buttonColor),
                      ),
                      Text(
                        "Pending",
                        style: FontManager.regular(
                          10,
                          color: AppColors.pendingColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    "Hilton View Villa",
                    style: FontManager.medium(16,
                        color: AppColors.textAddProreties),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.buttonColor),
                      SizedBox(width: 1.4.w),
                      Text(
                        "New York, USA",
                        style:
                            FontManager.regular(12, color: AppColors.greyText),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.6.h),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$ 12,000 night',
                              style: FontManager.medium(14,
                                  color: AppColors.buttonColor),
                            ),
                            TextSpan(
                              style: FontManager.regular(12,
                                  color: AppColors.buttonColor),
                              text: '( Base Price )',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    "Located in this sahyadri mountain range within the 320-acre shillim Estate, Hilton shillim Estate Ratreat...",
                    style: FontManager.regular(10, color: AppColors.black),
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5.w),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(AppRadius.radius10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.totalEarnings,
                            style:
                                FontManager.medium(14, color: AppColors.black),
                          ),
                          TextSpan(
                            style: FontManager.regular(12,
                                color: AppColors.buttonColor),
                            text: '  \$50,000',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.pendingPayoutes,
                            style:
                                FontManager.medium(14, color: AppColors.black),
                          ),  
                          TextSpan(
                            style: FontManager.regular(12,
                                color: AppColors.buttonColor),
                            text: '  \$30,000',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            Strings.payout,
            style: FontManager.semiBold(20),
          )
        ],
      ),
    );
  }

  Widget headerTrip() {
    return Container(
      height: 99,
      width: double.infinity,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.listing,
                    style: FontManager.medium(20, color: AppColors.white),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.listHomestayPage1);
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

class AddPropertiesController extends GetxController {
  final int? index;
  final ReUsedDataModel? homestayData;

  AddPropertiesController({this.index, this.homestayData});

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

  Future<void> editHomeStayDataAll(Homestay homestay) async {
    Homestay homestayData = homestay;

    LoadingProcessCommon().showLoading();
    String? userId = getIt<StorageServices>().getUserId();
    List<Map<String, dynamic>> amenitiesJson =
        homestayData.amenities!.map((amenity) {
      return {
        "name": amenity.name,
        "isChecked": amenity.isChecked,
        "isNewAdded": amenity.isNewAdded,
      };
    }).toList();
    List<Map<String, dynamic>> houseRulesJson =
        homestayData.houseRules!.map((rule) {
      return {
        "name": rule.name,
        "isChecked": rule.isChecked,
        "isNewAdded": rule.isNewAdded,
      };
    }).toList();

    dio.FormData formData = dio.FormData.fromMap({
      "title": homestayData.title,
      "homestayType": homestayData.homestayType,
      "accommodationDetails": jsonEncode({
        "entirePlace": homestayData.accommodationDetails!.entirePlace,
        "privateRoom": homestayData.accommodationDetails!.privateRoom,
        "maxGuests": homestayData.accommodationDetails!.maxGuests,
        "bedrooms": homestayData.accommodationDetails!.bedrooms,
        "singleBed": homestayData.accommodationDetails!.singleBed,
        "doubleBed": homestayData.accommodationDetails!.doubleBed,
        "extraFloorMattress":
            homestayData.accommodationDetails!.extraFloorMattress,
        "bathrooms": homestayData.accommodationDetails!.bathrooms,
        "kitchenAvailable": homestayData.accommodationDetails!.kitchenAvailable,
      }),
      "amenities": jsonEncode(amenitiesJson),
      "houseRules": jsonEncode(houseRulesJson),
      "checkInTime": homestayData.checkInTime,
      "checkOutTime": homestayData.checkOutTime,
      "flexibleCheckIn": homestayData.flexibleCheckIn,
      "flexibleCheckOut": homestayData.flexibleCheckOut,
      "longitude": "72.88692069643963",
      "latitude": "21.245049600735083",
      "address": homestayData.address,
      "street": homestayData.street,
      "landmark": homestayData.landmark,
      "city": homestayData.city,
      "pinCode": homestayData.pinCode,
      "state": homestayData.state,
      "showSpecificLocation": homestayData.showSpecificLocation,
      "description": homestayData.description,
      "basePrice": homestayData.basePrice,
      "weekendPrice": homestayData.weekendPrice,
      "ownerContactNo": homestayData.ownerContactNo,
      "ownerEmailId": homestayData.ownerEmailId,
      "homestayContactNo": jsonEncode(homestayData.homestayContactNo!
          .map((contact) => {
                "contactNo": contact.contactNo,
              })
          .toList()),
      "homestayEmailId": jsonEncode(homestayData.homestayEmailId!
          .map((email) => {
                "EmailId": email.emailId,
              })
          .toList()),
      "status": "Pending Approval",
      "createdBy": userId,
    });
    if (homestayData.coverPhoto != null) {
      formData.files.add(MapEntry(
          "coverPhoto",
          await dio.MultipartFile.fromFile(homestayData.coverPhoto!.url!,
              filename: "coverPhoto.jpg")));
    }

    if (homestayData.homestayPhotos != null &&
        homestayData.homestayPhotos!.isNotEmpty) {
      for (int index = 0;
          index < homestayData.homestayPhotos!.length;
          index++) {
        formData.files.add(MapEntry(
            "homestayPhotos",
            await dio.MultipartFile.fromFile(
                homestayData.homestayPhotos![index].url!,
                filename: "photo_$index.jpg")));
      }
    }

    homeStayRepository.editHomeStayData(formData: formData).then(
      (value) {
        Get.snackbar('', 'Homestay Data created successfully!');
        Get.back();
      },
    );
  }

  void nextPage() {
    // print("nnnnnnnnnooopppppeeeeeeennnnnnnnn");
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
        if (index == 1) {
          CustomDialog.showCustomDialog(
            context: Get.context,
            message: Strings.editSuccessMsg,
            imageAsset: Assets.imagesSuccessedit,
            buttonLabel: Strings.ok,
            onResendPressed: () {
              print("jshdfj");
            },
            onChangeEmailPressed: () {},
          );
        } else {
          homeStayAddDataLocally();
        }
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
      if (Navigator.canPop(Get.context!)) {
        Get.back();
      } else {
        print("No previous page to go back to.");
      }
    }
  }

  // homestayTitle Page Logic
  TextEditingController homeStayTitleController = TextEditingController();

  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }

  RxInt selectedIndex = 0.obs;

  // homestayType Page Logic
  void selectHomeStayType(String type, String image) {
    selectedType.value = type;
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
    if (index != 0) {
      editGetData();
    }
    super.onInit();
    selectedAmenities
        .addAll(List.generate(customAmenities.length, (_) => false));
    selectedRules.addAll(List.generate(customRules.length, (_) => false));
    createAllAmenities();
    createAllRules();
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

  RxDouble longitude = 72.88692069643963.obs;
  RxDouble latitude = 21.245049600735083.obs;

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
    update();
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

  void editGetData() {
    print("homestayData?.homestayType ${homestayData?.homestayType}");
    homeStayTitleController.text = homestayData?.title ?? "";
    homestayTitle.value = homestayData?.title ?? "";
    selectedType.value = homestayData?.homestayType ?? "";
    selectedAccommodation.value =
        homestayData?.accommodationDetails!.privateRoom == true
            ? Strings.privateRoomValue
            : Strings.entirePlaceValue;
    maxGuestsCount.value = homestayData?.accommodationDetails!.maxGuests ?? 0;
    singleBedCount.value = homestayData?.accommodationDetails!.singleBed ?? 0;
    bedroomsCount.value = homestayData?.accommodationDetails!.bedrooms ?? 0;
    doubleBedCount.value = homestayData?.accommodationDetails!.doubleBed ?? 0;
    extraFloorCount.value =
        homestayData?.accommodationDetails!.extraFloorMattress ?? 0;
    bathRoomsCount.value = homestayData?.accommodationDetails!.bathrooms ?? 0;
    isKitchenAvailable.value =
        homestayData?.accommodationDetails!.kitchenAvailable ?? false;
    if (homestayData?.amenities != null) {
      for (var amenityData in homestayData!.amenities!) {
        bool isChecked = amenityData.isChecked ?? false;
        String amenityName = amenityData.name ?? "";
        bool isNewAdded = amenityData.isNewAdded ?? false;

        if (isNewAdded) {
          addAmenities.add(amenityName);
          textControllers.add(TextEditingController(text: amenityName));
        }

        selectedAmenities.add(isChecked);
      }
    }
    if (homestayData?.houseRules != null) {
      for (var rulesData in homestayData!.houseRules!) {
        bool isChecked = rulesData.isChecked ?? false;
        String amenityName = rulesData.name ?? "";
        bool isNewAdded = rulesData.isNewAdded ?? false;

        if (isNewAdded) {
          addRules.add(amenityName);
          rulesTextControllers.add(TextEditingController(text: amenityName));
        }

        selectedRules.add(isChecked);
      }
    }

    checkInTime.value = DateFormat('hh:mm a')
        .parse(homestayData!.checkInTime!.replaceAll(" : ", ":").trim());
    checkOutTime.value = DateFormat('hh:mm a')
        .parse(homestayData!.checkOutTime!.replaceAll(" : ", ":").trim());
    flexibleWithCheckInTime.value = homestayData!.flexibleCheckIn ?? false;
    flexibleWithCheckInOut.value = homestayData!.flexibleCheckOut ?? false;
    longitude.value = homestayData!.longitude!;
    latitude.value = homestayData!.latitude!;
    addressController.text = homestayData!.address!;
    streetAddressController.text = homestayData!.street!;
    landmarkController.text = homestayData!.landmark!;
    cityTownController.text = homestayData!.city!;
    pinCodeController.text = homestayData!.pinCode!;
    stateController.text = homestayData!.state!;
    address.value = homestayData!.address!;
    streetAddress.value = homestayData!.street!;
    landmark.value = homestayData!.landmark!;
    city.value = homestayData!.city!;
    pinCode.value = homestayData!.pinCode!;
    state.value = homestayData!.state!;
    isSpecificLocation.value = homestayData!.showSpecificLocation!;
    coverImagePaths.add(homestayData!.coverPhoto!.url!);
    if (homestayData?.homestayPhotos != null) {
      for (var photo in homestayData!.homestayPhotos!) {
        imagePaths.add(photo.url);
      }
    }
    descriptionController.text = homestayData!.description!;
    description.value = homestayData!.description!;
    basePriceController.text = homestayData!.basePrice?.toString() ?? '';
    basePrice.value = homestayData!.basePrice?.toString() ?? '';
    weekendPriceController.text = homestayData!.weekendPrice?.toString() ?? '';
    weekendPrice.value = homestayData!.weekendPrice?.toString() ?? '';
    ownerContactNumberController.text = homestayData!.ownerContactNo ?? '';
    ownerContactNumber.value = homestayData!.ownerContactNo ?? '';
    ownerEmailController.text = homestayData!.ownerEmailId ?? '';
    ownerEmail.value = homestayData!.ownerEmailId ?? '';
    for (var contact in homestayData!.homestayContactNo!) {
      homeStayContactNumbers.add(contact.contactNo ?? '');
    }
    for (var email in homestayData!.homestayEmailId!) {
      homeStayEmails.add(email.emailId ?? '');
    }

    createAllRules();
    createAllAmenities();

    update();
  }

  // api add data

  Future<void> saveAndExitData() async {
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
      "longitude": longitude,
      "latitude": latitude,
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
      "status": "Draft",
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

    if (index == 1) {
      homeStayRepository.editHomeStayData(formData: formData).then(
        (value) {
          LoadingProcessCommon().hideLoading();
          Get.snackbar('', 'Homestay Data Edit!');
          Get.back();
        },
      );
    } else {
      homeStayRepository.homeStayData(formData: formData).then(
        (value) {
          LoadingProcessCommon().hideLoading();
          Get.snackbar('', 'Homestay Data saved exit!');
          Get.toNamed(
            Routes.bottomPages,
          );
        },
      );
    }
  }

  Future<void> homeStayAddDataLocally() async {
    List<HomestayPhotos> homestayPhotosList = imagePaths
        .where((path) => path != null)
        .map((path) => HomestayPhotos(url: path))
        .toList();

    Homestay homestayData = Homestay(
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
          isNewAdded: selectedAmenities.length > customAmenities.length &&
              index >= customAmenities.length,
        );
      }).toList(),
      houseRules: allRules.map((rules) {
        int index = allRules.indexOf(rules);
        return HouseRules(
          name: rules,
          isChecked: selectedRules[index],
          isNewAdded: selectedRules.length > customRules.length &&
              index >= customRules.length,
        );
      }).toList(),
      checkInTime: DateFormat('hh:mm a').format(checkInTime.value),
      checkOutTime: DateFormat('hh:mm a').format(checkOutTime.value),
      flexibleCheckIn: flexibleWithCheckInTime.value,
      flexibleCheckOut: flexibleWithCheckInOut.value,
      longitude: double.parse("72.88692069643963"),
      latitude: double.parse("21.245049600735083"),
      address: address.value,
      street: streetAddress.value,
      landmark: landmark.value,
      city: city.value,
      pinCode: pinCode.value,
      state: state.value,
      showSpecificLocation: isSpecificLocation.value,
      coverPhoto: coverImagePaths.isNotEmpty
          ? CoverPhoto(url: coverImagePaths[0])
          : null,
      homestayPhotos: homestayPhotosList.isNotEmpty ? homestayPhotosList : null,
      description: description.value,
      basePrice: int.parse(basePrice.value),
      weekendPrice: int.parse(weekendPrice.value),
      ownerContactNo: ownerContactNumber.value,
      ownerEmailId: ownerEmail.value,
      homestayContactNo: homeStayContactNumbers
          .map((contact) => HomestayContactNo(contactNo: contact))
          .toList(),
      homestayEmailId: homeStayEmails
          .map((email) => HomestayEmailId(emailId: email))
          .toList(),
      status: isEditing.value ? "Draft" : "Pending Approval",
    );

    Get.snackbar('Success', 'Homestay data saved locally');
    Get.toNamed(Routes.previewPage, arguments: homestayData);
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
class EditHomeStayModel {
  String? message;
  ReUsedDataModel? updatedHomestayData;

  EditHomeStayModel({this.message, this.updatedHomestayData});

  EditHomeStayModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedHomestayData = json['updatedHomestayData'] != null
        ? ReUsedDataModel.fromJson(json['updatedHomestayData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (updatedHomestayData != null) {
      data['updatedHomestayData'] = updatedHomestayData!.toJson();
    }
    return data;
  }
}

class HomestayData {
  String? message;
  Homestay? homestay;

  HomestayData({this.message, this.homestay});

  HomestayData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    homestay = json['homestay'] != null
        ? Homestay.fromJson(json['homestay'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (homestay != null) {
      data['homestay'] = homestay!.toJson();
    }
    return data;
  }
}

class Homestay {
  String? title;
  String? homestayType;
  AccommodationDetails? accommodationDetails;
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
  CoverPhoto? coverPhoto;
  List<HomestayPhotos>? homestayPhotos;
  String? description;
  int? basePrice;
  int? weekendPrice;
  String? ownerContactNo;
  String? ownerEmailId;
  List<HomestayContactNo>? homestayContactNo;
  List<HomestayEmailId>? homestayEmailId;
  String? status;
  String? createdBy;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Homestay(
      {this.title,
        this.homestayType,
        this.accommodationDetails,
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
        this.coverPhoto,
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
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Homestay.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    homestayType = json['homestayType'];
    accommodationDetails = json['accommodationDetails'] != null
        ? AccommodationDetails.fromJson(json['accommodationDetails'])
        : null;
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
    coverPhoto = json['coverPhoto'] != null
        ? CoverPhoto.fromJson(json['coverPhoto'])
        : null;
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
    createdBy = json['createdBy'];
    sId = json['_id'].toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['homestayType'] = homestayType;
    if (accommodationDetails != null) {
      data['accommodationDetails'] = accommodationDetails!.toJson();
    }
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
    if (coverPhoto != null) {
      data['coverPhoto'] = coverPhoto!.toJson();
    }
    if (homestayPhotos != null) {
      data['homestayPhotos'] =
          homestayPhotos!.map((v) => v.toJson()).toList();
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
    data['createdBy'] = createdBy;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class HomeStayRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<Map<String, dynamic>> homeStayData(
      {required dio.FormData formData}) async {
    dio.Response? response = await apiProvider.postFormData(
      "${apiURLs.baseUrl}${apiURLs.homeStayCreateUrl}",
      data: formData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<HomeStaySingleFetchResponse> getSingleFetchPreviewProperties() async {
    String? homeStayId = getIt<StorageServices>().getHomeStayId();
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}/$homeStayId",
    );
    Map<String, dynamic> data = response!.data;
    return HomeStaySingleFetchResponse.fromJson(data);
  }


  Future<EditHomeStayModel> editHomeStayData({required dio.FormData formData}) async {
    String? yourPropertiesId = getIt<StorageServices>().getYourPropertiesId();
    print("zzzzzzzzzzzzzzzzzzzzzzz");
    dio.Response response = await apiProvider.putDataForm(
      "${apiURLs.baseUrl}${apiURLs.userGetUrl}/$yourPropertiesId",
      data: formData,
    );
    print("aaaaaaaaaaaaaaaa$response");
    print("Response data: ${response.data}");
    Map<String, dynamic> data = response.data;
    return EditHomeStayModel.fromJson(data);
  }
}

class AmenityAndHouseRulesContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const AmenityAndHouseRulesContainer({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.borderContainerGriedView,
        ),
      ),
      child: GestureDetector(
        onTap: onSelect,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 3.w),
              Image.asset(
                imageAsset,
                height: 28,
                width: 28,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5.w),
              Text(
                title,
                style:
                    FontManager.regular(14, color: AppColors.textAddProreties),
              ),
              const Spacer(),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected
                    ? AppColors.buttonColor
                    : AppColors.borderContainerGriedView,
              ),
              SizedBox(width: 3.w),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonAddContainer extends StatelessWidget {
  final RxList<String> items;
  final Function(int) onRemove;

  const CommonAddContainer({
    super.key,
    required this.items,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: 110.w,
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppColors.borderContainerGriedView),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5.w),
                    Text(
                      items[index],
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        onRemove(index);
                      },
                      child: Image.asset(
                        Assets.imagesDividecircle2,
                        height: 21,
                        width: 22,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 3.5.w),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class CommonAddTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onAdd;
  final int itemCount;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CommonAddTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onAdd,
    required this.itemCount,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5.w),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                child: TextFormField(
                  validator: validator,
                  keyboardType: keyboardType,
                  controller: controller,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "$hintText ${itemCount + 1}",
                    hintStyle:
                        FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        final String newItem = controller.text.trim();
                        if (newItem.isNotEmpty) {
                          onAdd(newItem);
                          controller.clear();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Image.asset(
                          Assets.imagesPluscircle2,
                          height: 20,
                          width: 18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    print("ghgggggggggggggg${imagePath}");
    return Stack(
      children: [
        imagePath == null
            ? DottedBorder(
                borderType: BorderType.RRect,
                color: AppColors.texFiledColor,
                strokeWidth: 1,
                radius: const Radius.circular(10),
                child: Container(
                  height: 130,
                  width: 150.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(AppRadius.radius10),
                  ),
                  child: Column(
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
                                  await Get.put(AddPropertiesController())
                                      .pickPropertyImage(index,
                                          isSingleSelect: isSingleSelect);
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
              )
            : Container(
          height: 130,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(AppRadius.radius10),
            image: DecorationImage(
              image: imagePath!.startsWith('http')
                  ? NetworkImage(imagePath!)
                  : FileImage(File(imagePath!)),
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (isSingleSelect && imagePath != null)
          Padding(
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
          ),
      ],
    );
  }
}

class CustomTimePickerSection extends StatelessWidget {
  final String label;
  final Rx<DateTime> selectedTime;
  final Function(DateTime) onTimeChange;
  final RxBool flexibleTimeController;
  final String flexibleText;
  final ValueChanged<bool?> onFlexibleChange;

  const CustomTimePickerSection({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeChange,
    required this.flexibleTimeController,
    required this.flexibleText,
    required this.onFlexibleChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: FontManager.medium(color: AppColors.black, 16),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        TimePicker(
          selectedTime: selectedTime,
          onTimeChange: onTimeChange,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              print("flexibleTimeController value: ${flexibleTimeController.value}");
              return Checkbox(
                activeColor: AppColors.buttonColor,
                value: flexibleTimeController.value,
                onChanged: onFlexibleChange,
                side: const BorderSide(color: AppColors.texFiledColor),
              );
            }),
            Text(
              flexibleText,
              style: FontManager.regular(color: AppColors.black, 14),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

class TimePicker extends StatelessWidget {
  final Rx<DateTime> selectedTime;
  final Function(DateTime) onTimeChange;

  const TimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 15.w, right: 15.w),
              child: const Divider(color: Colors.grey),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 15.w, right: 15.w),
              child: const Divider(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createTimePicker(
                  range: List.generate(12, (index) => index + 1),
                  selectedValue: selectedTime.value.hour % 12 == 0
                      ? 12
                      : selectedTime.value.hour % 12,
                  onValueSelected: (value) => onTimeSelect(
                    hour: value,
                    selectedTime: selectedTime,
                    onTimeChange: onTimeChange,
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: List.generate(60, (index) => index),
                    selectedValue: selectedTime.value.minute,
                    onValueSelected: (value) => onTimeSelect(
                      minute: value,
                      selectedTime: selectedTime,
                      onTimeChange: onTimeChange,
                    ),
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: List.generate(60, (index) => index),
                    selectedValue: selectedTime.value.second,
                    onValueSelected: (value) => onTimeSelect(
                      second: value,
                      selectedTime: selectedTime,
                      onTimeChange: onTimeChange,
                    ),
                  ),
                ),
                dotProvide(),
                Obx(
                  () => createTimePicker(
                    range: ["AM", "PM"],
                    selectedValue: selectedTime.value.hour < 12 ? "AM" : "PM",
                    onValueSelected: (value) {
                      final isPM = value == "PM";
                      onTimeSelect(
                        hour: isPM
                            ? selectedTime.value.hour + 12
                            : selectedTime.value.hour - 12,
                        selectedTime: selectedTime,
                        onTimeChange: onTimeChange,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void onTimeSelect({
    int? hour,
    int? minute,
    int? second,
    required Rx<DateTime> selectedTime,
    required Function(DateTime) onTimeChange,
  }) {
    final updatedTime = DateTime(
      selectedTime.value.year,
      selectedTime.value.month,
      selectedTime.value.day,
      hour ?? selectedTime.value.hour,
      minute ?? selectedTime.value.minute,
      second ?? selectedTime.value.second,
    );
    onTimeChange(updatedTime);
    selectedTime.value = updatedTime;
  }
}

Widget createTimePicker({
  required List<dynamic> range,
  required dynamic selectedValue,
  required ValueChanged<dynamic> onValueSelected,
}) {
  return SizedBox(
    width: 16.w,
    height: 18.h,
    child: ListWheelScrollView.useDelegate(
      itemExtent: 50,
      diameterRatio: 1.2,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) => onValueSelected(range[index]),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final value = range[index];
          final isSelected = value == selectedValue;
          return Center(
            child: Text(
              value.toString().padLeft(2, '0'),
              style: isSelected
                  ? FontManager.semiBold(20, color: AppColors.buttonColor)
                  : FontManager.medium(20, color: AppColors.black),
            ),
          );
        },
        childCount: range.length,
      ),
    ),
  );
}

Widget dotProvide() {
  return Text(
    ':',
    style: FontManager.semiBold(20, color: AppColors.texFiledColor),
  );
}

class NewAmenitiesPages extends StatefulWidget {
  final int index;
  const NewAmenitiesPages({super.key,required this.index});

  @override
  State<NewAmenitiesPages> createState() => _NewAmenitiesPagesState();
}

class _NewAmenitiesPagesState extends State<NewAmenitiesPages> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.2.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.index == 1 ? Strings.editAmenities :  Strings.newAmenities,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              buildTitleStep(controller.currentPage.value.toString()),
              CommonAddContainer(
                items: controller.addAmenities,
                onRemove: (index) {
                  controller.removeAmenity(index);
                },
              ),
              SizedBox(height: 2.h),
              CommonAddTextfield(
                controller: controller.amenitiesName,
                hintText: Strings.amenities,
                onAdd: (newAmenity) {
                  controller.addAmenity(newAmenity);
                },
                itemCount: controller.addAmenities.length,
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: LinearProgressIndicator(
                            value: controller.currentPage.value / 10,
                            backgroundColor: AppColors.greyText,
                            color: AppColors.buttonColor,
                            minHeight: 3,
                            borderRadius:
                                const BorderRadius.all(AppRadius.radius4),
                          ),
                        )),
                    SizedBox(height: 1.h),
                    CommonButton(
                      title: widget.index == 1 ? Strings.update : Strings.done,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              )
            ],
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

class NewRulesPages extends StatefulWidget {
  final int? index;

  const NewRulesPages({super.key, required this.index});

  @override
  State<NewRulesPages> createState() => _NewRulesPagesState();
}

class _NewRulesPagesState extends State<NewRulesPages> {
  final AddPropertiesController controller = Get.put(AddPropertiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.2.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.keyboard_arrow_left, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.index == 1 ? Strings.editRules : Strings.newRules,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Obx(() =>
                  buildTitleStep(controller.currentPage.value.toString())),
              CommonAddContainer(
                items: controller.addRules,
                onRemove: (index) {
                  controller.removeRules(index);
                },
              ),
              SizedBox(height: 2.h),
              CommonAddTextfield(
                controller: controller.rulesName,
                hintText: Strings.rules,
                onAdd: (newRule) {
                  controller.addRulesMethod(newRule);
                },
                itemCount: controller.addRules.length,
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: LinearProgressIndicator(
                            value: controller.currentPage.value / 10,
                            backgroundColor: AppColors.greyText,
                            color: AppColors.buttonColor,
                            minHeight: 3,
                            borderRadius:
                                const BorderRadius.all(AppRadius.radius4),
                          ),
                        )),
                    SizedBox(height: 1.h),
                    CommonButton(
                      title:   widget.index == 1 ? Strings.update:Strings.done,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              )
            ],
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

class AccommodationDetailsPage extends StatelessWidget {
  final AddPropertiesController controller;

  const AccommodationDetailsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBody(controller),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  Widget buildBody(AddPropertiesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAccommodationOption(
          title: Strings.entirePlace,
          subtitle: Strings.wholePlacetoGuests,
          imageAsset: Assets.imagesTraditional,
          value: Strings.entirePlaceValue,
          controller: controller,
        ),
        const SizedBox(height: 20),
        buildAccommodationOption(
          title: Strings.privateRoom,
          subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
          imageAsset: Assets.imagesPrivateRoom,
          value: Strings.privateRoomValue,
          controller: controller,
        ),
        SizedBox(height: 4.h),
        buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
            controller.maxGuestsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed,
            controller.singleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(
            Assets.imagesBedRooms, Strings.bedRooms, controller.bedroomsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesDubleBed, Strings.doubleBed,
            controller.doubleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesExtraFloor,
            Strings.extraFloorMattress, controller.extraFloorCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesBathRooms, Strings.bathRooms,
            controller.bathRoomsCount),
        SizedBox(height: 2.h),
        Container(
          width: 100.w,
          height: 7.h,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderContainerGriedView,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0.w),
              Image.asset(
                Assets.imagesKitchen,
                height: 3.h,
                width: 3.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 3.w),
              Text(
                Strings.kitchenAvailable,
                style: FontManager.regular(15, color: AppColors.black),
                textAlign: TextAlign.start,
                textScaler: const TextScaler.linear(1),
              ),
              const Spacer(),
              Obx(() => Text(
                    Strings.yes,
                    style: FontManager.regular(14.sp,
                        color: controller.isKitchenAvailable.value
                            ? AppColors.black
                            : AppColors.greyText),
                  )),
              Obx(() {
                return Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    activeTrackColor: AppColors.buttonColor,
                    activeColor: AppColors.white,
                    inactiveThumbColor: AppColors.buttonColor,
                    value: controller.isKitchenAvailable.value,
                    onChanged: (value) {
                      controller.isKitchenAvailable.value = value;
                    },
                  ),
                );
              }),
              Obx(() => Text(
                    Strings.no,
                    style: FontManager.regular(14.sp,
                        color: controller.isKitchenAvailable.value
                            ? AppColors.greyText
                            : AppColors.black),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildCustomContainer(String imageAsset, String title, RxInt count) {
    return CusttomContainer(
      imageAsset: imageAsset,
      title: title,
      count: count,
    );
  }
}

class AddressPage extends StatelessWidget {
  final AddPropertiesController controller;

  const AddressPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.5.h),
          addressPageTextFieldsCommon(
            controller: controller.addressController,
            label: Strings.address,
            hint: Strings.enterYourAddress,
            onChanged: (p0) {
              controller.saveAddress(p0);
            },
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.streetAddressController,
            label: Strings.streetAddress,
            hint: Strings.enterYourStreetAddress,
            onChanged: controller.saveStreetAddress,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.landmarkController,
            label: Strings.landmark,
            hint: Strings.landmark,
            onChanged: controller.saveLandmark,
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.cityTownController,
            label: Strings.cityTown,
            hint: Strings.cityTown,
            onChanged: controller.saveCity,
          ),
          SizedBox(height: 2.h),
          Obx(
            () => addressPageTextFieldsCommon(
                controller: controller.pinCodeController,
                keybordeType: TextInputType.number,
                label: Strings.pinCode,
                hint: Strings.pinCode,
                onChanged: (value) {
                  controller.savePinCode(value);
                  if (controller.formKey.currentState!.validate()) {
                    controller.isValidation.value = true;
                  } else {
                    controller.isValidation.value = false;
                  }
                },
                isValidating: controller.isValidation.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.pinCodeEnterValidation;
                  } else if (value.length < 6) {
                    return Strings.pinMaximumDigit;
                  } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                    return Strings.pinOnlyDigit;
                  }
                  return null;
                }),
          ),
          SizedBox(height: 2.h),
          addressPageTextFieldsCommon(
            controller: controller.stateController,
            label: Strings.state,
            hint: Strings.state,
            onChanged: controller.saveState,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.showYourSpecificLocation,
                  style: FontManager.regular(16,
                      color: AppColors.textAddProreties)),
              const Spacer(),
              Obx(
                () => Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    activeTrackColor: AppColors.buttonColor,
                    activeColor: AppColors.white,
                    value: controller.isSpecificLocation.value,
                    onChanged: (value) {
                      controller.isSpecificLocation.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Text(
              Strings.addressDiscription,
              style: FontManager.regular(12, color: AppColors.greyText),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
        ],
      ),
    );
  }

  Widget addressPageTextFieldsCommon({
    required String label,
    required String hint,
    required Function(String?) onChanged,
    TextInputType? keybordeType,
    final TextEditingController? controller,
    final String? Function(String?)? validator,
    final bool isValidating = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: label,
                  style: FontManager.regular(14, color: AppColors.black)),
              TextSpan(
                  style: FontManager.regular(14, color: AppColors.redAccent),
                  text: Strings.addressIcon),
            ],
          ),
        ),
        SizedBox(height: 0.5.h),
        CustomTextField(
          isValidating: isValidating,
          controller: controller,
          keyboardType: keybordeType,
          hintText: hint,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}

class AmenitiesPage extends StatefulWidget {
  final AddPropertiesController controller;
  final int index;

  const AmenitiesPage(
      {super.key, required this.controller, required this.index});

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.5.h),
            widget.index == 1
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => NewAmenitiesPages(index: widget.index));
                    },
                    child: Container(
                      height: 6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.buttonColor),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image.asset(
                            Assets.imagesEditHomestay,
                            height: 3.h,
                            width: 7.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            Strings.editAmenities,
                            style: FontManager.medium(18.sp,
                                color: AppColors.buttonColor),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Get.to(() => NewAmenitiesPages(index: widget.index));
                    },
                    child: Container(
                      height: 6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.buttonColor),
                      ),
                      child: Center(
                        child: Text(
                          Strings.addAmenities,
                          style: FontManager.medium(18.sp,
                              color: AppColors.buttonColor),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 3.5.h),
            Obx(
              () {
                return Column(
                  children: [
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesWiFi,
                      title: controller.customAmenities[0],
                      isSelected: controller.selectedAmenities[0],
                      onSelect: () => controller.toggleAmenity(0),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesAirCondioner,
                      title: controller.customAmenities[1],
                      isSelected: controller.selectedAmenities[1],
                      onSelect: () => controller.toggleAmenity(1),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesFirAlarm,
                      title: controller.customAmenities[2],
                      isSelected: controller.selectedAmenities[2],
                      onSelect: () => controller.toggleAmenity(2),
                    ),
                    SizedBox(height: 5.3.h),
                  ],
                );
              },
            ),
            Text(
              Strings.newAmenities,
              style: FontManager.medium(18, color: AppColors.textAddProreties),
            ),
            SizedBox(height: 2.h),
            Obx(
              () => AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesHometherater,
                title: controller.customAmenities[3],
                isSelected: controller.selectedAmenities[3],
                onSelect: () => controller.toggleAmenity(3),
              ),
            ),
            SizedBox(height: 1.2.h),
            Obx(
              () => AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesMastrSuite,
                title: controller.customAmenities[4],
                isSelected: controller.selectedAmenities[4],
                onSelect: () => controller.toggleAmenity(4),
              ),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.addAmenities.length,
                itemBuilder: (context, index) {
                  final int amenityIndex;
                  amenityIndex = index + controller.customAmenities.length;
                  return Column(
                    children: [
                      const SizedBox(height: 2),
                      Obx(
                        () => AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesSingleBed,
                          title: controller.addAmenities[index],
                          isSelected:
                              controller.selectedAmenities[amenityIndex],
                          onSelect: () =>
                              controller.toggleAmenity(amenityIndex),
                          // isNewAdded: true,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

class CheckInOutDetailsPage extends StatelessWidget {
  final AddPropertiesController controller;

  const CheckInOutDetailsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 1.5.h),
          CustomTimePickerSection(
            label: Strings.checkInTime,
            selectedTime: controller.checkInTime,
            onTimeChange: (time) {
              controller.checkInTimeUpdate(time);
            },
            flexibleTimeController: controller.flexibleWithCheckInTime,
            flexibleText: Strings.flexibleWithCheckInTime,
            onFlexibleChange: (value) {
              controller.toggleCheckInFlexibility(value ?? false);
            },
          ),
          SizedBox(height: 2.h,),
          CustomTimePickerSection(
            label: Strings.checkOutTime,
            selectedTime: controller.checkOutTime,
            onTimeChange: (time) {
              controller.checkOutTimeUpdate(time);
            },
            flexibleTimeController: controller.flexibleWithCheckInOut,
            flexibleText: Strings.flexibleWithCheckOutTime,
            onFlexibleChange: (value) {
              controller.toggleCheckOutFlexibility(value ?? false);
            },
          ),
        ],
      ),
    );
  }
}

class HomeStayTypeScreen extends StatelessWidget {
  final AddPropertiesController controller;
  const HomeStayTypeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.5.h),
          SizedBox(
            height: 60.h,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.sp,
              mainAxisSpacing: 19.sp,
              childAspectRatio: (MediaQuery.of(context).size.width / 1.6) /160,
              children: [
                buildHomestayTypeCard(
                    Strings.traditional, Assets.imagesTraditional, controller),
                buildHomestayTypeCard(Strings.bedAndBreakfast,
                    Assets.imagesBedbreakfast, controller),
                buildHomestayTypeCard(
                    Strings.urban, Assets.imagesUrban, controller),
                buildHomestayTypeCard(
                    Strings.ecoFriendly, Assets.imagesEcofriendly, controller),
                buildHomestayTypeCard(
                    Strings.adventure, Assets.imagesAdventure, controller),
                buildHomestayTypeCard(
                    Strings.luxury, Assets.imagesLuxury, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHomestayTypeCard(
      String type, String image, AddPropertiesController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectHomeStayType(type, image,);
      },
      child: Obx(
            () {
          bool isSelected = controller.isHomeStayTypeSelected(type);
          return Container(
            height: 120.sp,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
              isSelected ? AppColors.selectContainerColor : AppColors.white,
              border: Border.all(
                color: isSelected
                    ? AppColors.buttonColor
                    : AppColors.borderContainerGriedView,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(AppRadius.radius10),
            ),
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(image,
                    height: 35.1, width: 40.w, fit: BoxFit.contain),
                const Spacer(),
                Center(
                  child: Text(
                    type,
                    style: FontManager.regular(16.sp, color: AppColors.black),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeStayDescriptionPage extends StatelessWidget {
  final AddPropertiesController controller;

  const HomeStayDescriptionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  Strings.description,
                  style: FontManager.regular(14, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          CustomTextField(
            controller: controller.descriptionController,
            maxLines: 7,
            maxLength: 500,
            hintText: Strings.enterDescription,
            onChanged: (value) {
              controller.setDescription(value);
            },
          ),
        ],
      ),
    );
  }
}

class HouseRulesPage extends StatefulWidget {
  final AddPropertiesController controller;
  final int index;

  const HouseRulesPage(
      {super.key, required this.controller, required this.index});

  @override
  State<HouseRulesPage> createState() => _HouseRulesPageState();
}

class _HouseRulesPageState extends State<HouseRulesPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.5.h),
            widget.index == 1
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => NewRulesPages(index: widget.index));
                    },
                    child: Container(
                      height: 6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.buttonColor),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image.asset(
                            Assets.imagesEditHomestay,
                            height: 3.h,
                            width: 7.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            Strings.editRules,
                            style: FontManager.medium(18.sp,
                                color: AppColors.buttonColor),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Get.to(() => NewRulesPages(index: widget.index));
                    },
                    child: Container(
                      height: 6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.buttonColor),
                      ),
                      child: Center(
                        child: Text(
                          Strings.addRules,
                          style: FontManager.medium(18.sp,
                              color: AppColors.buttonColor),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 3.5.h,
            ),
            Obx(
              () {
                return Column(
                  children: [
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesNoSmoking,
                      title: controller.customRules[0],
                      isSelected: controller.selectedRules[0],
                      onSelect: () => controller.toggleRules(0),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesNoDrinking,
                      title: controller.customRules[1],
                      isSelected: controller.selectedRules[1],
                      onSelect: () => controller.toggleRules(1),
                    ),
                    SizedBox(height: 2.h),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesNoPet,
                      title: controller.customRules[2],
                      isSelected: controller.selectedRules[2],
                      onSelect: () => controller.toggleRules(2),
                    ),
                    SizedBox(height: 5.3.h),
                  ],
                );
              },
            ),
            Text(
              Strings.newRules,
              style: FontManager.medium(18, color: AppColors.textAddProreties),
            ),
            SizedBox(
              height: 1.2.h,
            ),
            Obx(
              () => AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesDamageToProretiy,
                title: controller.customRules[3],
                isSelected: controller.selectedRules[3],
                onSelect: () => controller.toggleRules(3),
              ),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.addRules.length,
                itemBuilder: (context, index) {
                  final int rulesIndex;
                  rulesIndex = index + controller.customRules.length;
                  return Column(
                    children: [
                      const SizedBox(height: 2),
                      Obx(
                        () => AmenityAndHouseRulesContainer(
                          imageAsset: Assets.imagesSingleBed,
                          title: controller.addRules[index],
                          isSelected: controller.selectedRules[rulesIndex],
                          onSelect: () => controller.toggleRules(rulesIndex),
                          // isNewAdded: true,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  // LatLng kMapCenter = const LatLng(19.018255973653343, 72.84793849278007);
  // LatLng? _currentPosition;
  // GoogleMapController? _mapController;

  final AddPropertiesController controller = Get.put(AddPropertiesController());

  @override
  void initState() {
    super.initState();
    // _checkLocationAndProceed();
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(height: 7.2.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.currentPage.value = 7;
                  },
                  child: const Icon(Icons.keyboard_arrow_left, size: 30),
                ),
                const SizedBox(width: 8),
                Text(
                  Strings.location,
                  style: FontManager.medium(20, color: AppColors.black),
                ),
              ],
            ),
            Flexible(
              child: Stack(
                children: [
                  Image.asset(Assets.imagesMapDefoulte),
                  // GoogleMap(
                  //   onMapCreated: (GoogleMapController controller) {
                  //     _mapController = controller;
                  //     if (_currentPosition != null) {
                  //       _mapController!.animateCamera(
                  //         CameraUpdate.newLatLng(_currentPosition!),
                  //       );
                  //     } else {
                  //       _mapController!.animateCamera(
                  //         CameraUpdate.newLatLng(kMapCenter),
                  //       );
                  //     }
                  //   },
                  //   initialCameraPosition: CameraPosition(
                  //     target: _currentPosition ?? kMapCenter,
                  //     zoom: 11,
                  //   ),
                  //   markers: {
                  //     if (_currentPosition != null)
                  //       Marker(
                  //         markerId: MarkerId('current_location'),
                  //         position: _currentPosition!,
                  //       ),
                  //   },
                  // ),
                  Positioned(
                    bottom: 5.h,
                    left: 16,
                    right: 16,
                    child: CommonButton(
                      title: Strings.nextStep,
                      onPressed: () {
                        if (controller.currentPage.value == 6) {
                          controller.currentPage.value = 7;
                          controller.nextPage();
                          Get.back();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
  // Future<void> getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     _showPermissionDialog();
  //     return;
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     _showPermissionDialog();
  //     return;
  //   }
  //
  //   try {
  //     final LocationSettings locationSettings = LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 100,
  //     );
  //
  //     Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  //     setState(() {
  //       _currentPosition = LatLng(position.latitude, position.longitude);
  //     });
  //
  //     if (_mapController != null) {
  //       _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
  //     }
  //   } catch (e) {
  //     print('Could not get the current location: $e');
  //   }
  // }
  //
  // void _checkLocationAndProceed() async {
  //   bool enabled = await Geolocator.isLocationServiceEnabled();
  //
  //   if (enabled) {
  //     controller.nextPage();
  //   } else {
  //     CustomDialog.showCustomDialog(
  //       context: context,
  //       title: Strings.turnLocationOn,
  //       message: Strings.locationDiscription,
  //       imageAsset: Assets.imagesQuestionDialog,
  //       buttonLabel: Strings.settings,
  //       changeEmailLabel: Strings.cancel,
  //       onResendPressed: () {
  //         Geolocator.openLocationSettings().then((_) {
  //           Get.back(); // Close the dialog
  //         });
  //       },
  //     );
  //   }
  // }
  //
  // void _showPermissionDialog() {
  //   CustomDialog.showCustomDialog(
  //     context: context,
  //     title: 'Location Permission Required',
  //     message: 'This app needs location permissions to function correctly. Please enable them in the settings.',
  //     imageAsset: Assets.imagesQuestionDialog,
  //     buttonLabel: Strings.settings,
  //     changeEmailLabel: Strings.cancel,
  //     onResendPressed: () {
  //       Geolocator.openLocationSettings().then((_) {
  //       });
  //     },
  //   );
  // }
}

class PhotoPage extends StatelessWidget {
  final AddPropertiesController controller;
  const PhotoPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    print("coverImagePaths: ${controller.coverImagePaths}");

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.5.h),
          Text(
            Strings.coverPhoto,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          const SizedBox(height: 10),
          Obx(
                () => PhotoUploadContainer(
              index: 0,
              imagePath: controller.coverImagePaths.isNotEmpty
                  ? controller.coverImagePaths[0]
                  : null,
              onImageSelected: (path) {
                if (path != null) {
                  controller.coverImagePaths.value = [path];
                }
              },
              isSingleSelect: true,
            ),
          ),

          const SizedBox(height: 30),
          Text(
            Strings.homestayPhotos,
            style: FontManager.regular(14, color: AppColors.textAddProreties),
          ),
          SizedBox(height: 2.h),

          // Displaying the photo upload rows
          photoUploadRows(),

          SizedBox(height: 7.h),
        ],
      ),
    );
  }

  // Function to display photo upload rows
  Widget photoUploadRows() {
    int imagesPerRow = 2;
    int totalImages = controller.imagePaths.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: imagesPerRow,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: totalImages,
      itemBuilder: (context, index) {
        return Obx(
              () => PhotoUploadContainer(
            index: index,
            imagePath: controller.imagePaths[index],
            onImageSelected: (path) {
              if (path != null) {
                controller.imagePaths[index] = path;
                print('Selected image at index $index: ${controller.imagePaths[index]}');
              }
            },
            isSingleSelect: false,
          ),
        );
      },
    );
  }
}

class PriceAndContactDetailsPage extends StatefulWidget {
  final AddPropertiesController controller;
  const PriceAndContactDetailsPage({super.key, required this.controller});

  @override
  State<PriceAndContactDetailsPage> createState() =>
      _PriceAndContactDetailsPageState();
}

class _PriceAndContactDetailsPageState
    extends State<PriceAndContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder(
          init: AddPropertiesController(),
          builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.basePrice,
                              style: FontManager.regular(14,
                                  color: AppColors.black),
                            ),
                            SizedBox(height: 0.5.h),
                            CustomTextField(
                              controller: controller.basePriceController,
                              keyboardType: TextInputType.number,
                              hintText: Strings.basePrice,
                              onChanged: (value) {
                                controller.basePrice.value = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          Strings.to,
                          style: FontManager.regular(14, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.weekendPrice,
                              style: FontManager.regular(14,
                                  color: AppColors.black),
                            ),
                            SizedBox(height: 0.5.h),
                            CustomTextField(
                              controller: controller.weekendPriceController,
                              keyboardType: TextInputType.number,
                              hintText: Strings.weekendPrice,
                              onChanged: (value) {
                                controller.weekendPrice.value = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    Strings.ownerDetails,
                    style:
                        FontManager.semiBold(18, color: AppColors.buttonColor),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(Strings.ownerContactNo, style: FontManager.regular(14)),
                  CustomTextField(
                    controller: controller.ownerContactNumberController,
                    keyboardType: TextInputType.number,
                    hintText: Strings.mobileNumberHint,
                    validator: (value) => AppValidation.validateMobile(value),
                    onChanged: (value) {
                      controller.ownerContactNumber.value = value;
                    },
                  ),
                  SizedBox(height: 0.5.h),
                  SizedBox(height: 3.h),
                  Text(Strings.ownerEmailID,
                      style: FontManager.regular(14, color: AppColors.black)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.ownerEmailController,
                    hintText: Strings.emailHint,
                    validator: (value) => AppValidation.validateEmail(value),
                    onChanged: (value) {
                      controller.ownerEmail.value = value;
                    },
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    Strings.homeStayDetails,
                    style:
                        FontManager.semiBold(18, color: AppColors.buttonColor),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(Strings.homeStayContactNo,
                      style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  controller.homeStayContactNumbers.isNotEmpty
                      ? CommonAddContainer(
                          items: controller.homeStayContactNumbers,
                          onRemove: (index) {
                            controller.removeHomeStayContactNumber(index);
                          },
                        )
                      : const SizedBox.shrink(),
                  controller.homeStayContactNumbers.isNotEmpty
                      ? SizedBox(
                          height: 2.h,
                        )
                      : const SizedBox.shrink(),
                  CommonAddTextfield(
                    // validator: AppValidation.validateMobile,
                    controller: controller.homeStayContactNumbersController,
                    itemCount: controller.homeStayContactNumbers.length,
                    hintText: Strings.enterHomeStayContactNo,
                    keyboardType: TextInputType.number,
                    onAdd: (newAdd) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.addHomeStayContactNumber(newAdd);
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.homeStayEmailID,
                      style: FontManager.regular(14, color: AppColors.black)),
                  SizedBox(height: 0.5.h),
                  controller.homeStayEmails.isNotEmpty
                      ? CommonAddContainer(
                          items: controller.homeStayEmails,
                          onRemove: (index) {
                            controller.removeHomeStayEmails(index);
                          },
                        )
                      : const SizedBox.shrink(),
                  controller.homeStayEmails.isNotEmpty
                      ? SizedBox(height: 2.h)
                      : const SizedBox.shrink(),
                  CommonAddTextfield(
                    // validator: AppValidation.validateEmail,
                    controller: controller.homeStayEmailsController,
                    itemCount: controller.homeStayEmails.length,
                    hintText: Strings.enterHomeStayEmailID,
                    onAdd: (newAdd) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.addHomeStayEmails(newAdd);
                      }
                    },
                  ),
                ],
              )),
    );
  }
}

class AddPropertiesScreen extends StatelessWidget {
  final int index;

  const AddPropertiesScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final homestayData = args['homestayData'];
    return GetBuilder(
      init: AddPropertiesController(index: index, homestayData: homestayData),
      builder: (controller) {
        return PopScope(
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
                          child:
                              const Icon(Icons.keyboard_arrow_left, size: 30),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(
                            () => Text(
                              index == 1
                                  ? "Edit ${controller.pageTitles[controller.currentPage.value - 1]}"
                                  : controller.pageTitles[
                                      controller.currentPage.value - 1],
                              style: FontManager.medium(
                                20,
                                color: AppColors.black,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Obx(() => buildTitleStep(
                        controller.currentPage.value.toString())),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: PageView(
                          controller: controller.pageController,
                          onPageChanged: (index) {
                            controller.currentPage.value = index + 1;
                          },
                          children: [
                            CommonHomestayTitleWidget(
                              controller: controller.homeStayTitleController,
                              onChanged: (value) => controller.setTitle(value),
                              onSaved: (value) =>
                                  controller.homestayTitle.value = value!,
                              titleLabel: Strings.titleLabel,
                            ),
                            HomeStayTypeScreen(controller: controller),
                            AccommodationDetailsPage(controller: controller),
                            AmenitiesPage(controller: controller, index: index),
                            HouseRulesPage(
                              controller: controller,
                              index: index,
                            ),
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
                    SizedBox(height: 3.5.h),
                    Obx(() => CommonButton(
                          title: controller.currentPage.value == 10
                              ? index == 1
                                  ? Strings.update
                                  : Strings.done
                              : Strings.nextStep,
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
                                    controller.saveAndExitData();
                                  },
                                );
                              },
                              child: Text(
                                index == 1
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
                          ? SizedBox(height: 2.5.h)
                          :  SizedBox(
                              height: 2.5.h,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

class PreviewPropertiesController extends GetxController {
  var carouselIndex = 0.obs;
  CarouselSliderController carouselController = CarouselSliderController();
  var homeStayRepository = getIt<HomeStayRepository>();
  var apiHelper = getIt<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselSliderController();
  }

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
  }

  Future<void> homeStayAddData(Homestay homestay) async {
    Homestay homestayData = homestay;

    LoadingProcessCommon().showLoading();
    String? userId = getIt<StorageServices>().getUserId();
    List<Map<String, dynamic>> amenitiesJson =
        homestayData.amenities!.map((amenity) {
      return {
        "name": amenity.name,
        "isChecked": amenity.isChecked,
        "isNewAdded": amenity.isNewAdded,
      };
    }).toList();
    List<Map<String, dynamic>> houseRulesJson =
        homestayData.houseRules!.map((rule) {
      return {
        "name": rule.name,
        "isChecked": rule.isChecked,
        "isNewAdded": rule.isNewAdded,
      };
    }).toList();

    dio.FormData formData = dio.FormData.fromMap({
      "title": homestayData.title,
      "homestayType": homestayData.homestayType,
      "accommodationDetails": jsonEncode({
        "entirePlace": homestayData.accommodationDetails!.entirePlace,
        "privateRoom": homestayData.accommodationDetails!.privateRoom,
        "maxGuests": homestayData.accommodationDetails!.maxGuests,
        "bedrooms": homestayData.accommodationDetails!.bedrooms,
        "singleBed": homestayData.accommodationDetails!.singleBed,
        "doubleBed": homestayData.accommodationDetails!.doubleBed,
        "extraFloorMattress":
            homestayData.accommodationDetails!.extraFloorMattress,
        "bathrooms": homestayData.accommodationDetails!.bathrooms,
        "kitchenAvailable": homestayData.accommodationDetails!.kitchenAvailable,
      }),
      "amenities": jsonEncode(amenitiesJson),
      "houseRules": jsonEncode(houseRulesJson),
      "checkInTime": homestayData.checkInTime,
      "checkOutTime": homestayData.checkOutTime,
      "flexibleCheckIn": homestayData.flexibleCheckIn,
      "flexibleCheckOut": homestayData.flexibleCheckOut,
      "longitude": "72.88692069643963",
      "latitude": "21.245049600735083",
      "address": homestayData.address,
      "street": homestayData.street,
      "landmark": homestayData.landmark,
      "city": homestayData.city,
      "pinCode": homestayData.pinCode,
      "state": homestayData.state,
      "showSpecificLocation": homestayData.showSpecificLocation,
      "description": homestayData.description,
      "basePrice": homestayData.basePrice,
      "weekendPrice": homestayData.weekendPrice,
      "ownerContactNo": homestayData.ownerContactNo,
      "ownerEmailId": homestayData.ownerEmailId,
      "homestayContactNo": jsonEncode(homestayData.homestayContactNo!
          .map((contact) => {
                "contactNo": contact.contactNo,
              })
          .toList()),
      "homestayEmailId": jsonEncode(homestayData.homestayEmailId!
          .map((email) => {
                "EmailId": email.emailId,
              })
          .toList()),
      "status": "Pending Approval",
      "createdBy": userId,
    });
    if (homestayData.coverPhoto != null) {
      formData.files.add(MapEntry(
          "coverPhoto",
          await dio.MultipartFile.fromFile(homestayData.coverPhoto!.url!,
              filename: "coverPhoto.jpg")));
    }

    if (homestayData.homestayPhotos != null &&
        homestayData.homestayPhotos!.isNotEmpty) {
      for (int index = 0;
          index < homestayData.homestayPhotos!.length;
          index++) {
        formData.files.add(MapEntry(
            "homestayPhotos",
            await dio.MultipartFile.fromFile(
                homestayData.homestayPhotos![index].url!,
                filename: "photo_$index.jpg")));
      }
    }


    homeStayRepository.homeStayData(formData: formData).then(
      (value) {
        Get.snackbar('', 'Homestay Data created successfully!');
        Get.offNamed(
          Routes.termsAndCondition,
        );
      },
    );

  }
}

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {
  final PreviewPropertiesController previewController =
      Get.put(PreviewPropertiesController());

  late TabController _tabController;
  late Homestay homestayData;

  @override
  void initState() {
    super.initState();
    homestayData = Get.arguments;
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
        body: PropertyCardWidget(
          title: Strings.preview,
          homestayType: homestayData.homestayType ?? '',
          accommodationType:
              homestayData.accommodationDetails!.entirePlace == true
                  ? Strings.entirePlace
                  : Strings.privateRoom,
          address: homestayData.address ?? '',
          basePrice: homestayData.basePrice ?? 0,
          checkInTime: homestayData.checkInTime ?? '',
          checkOutTime: homestayData.checkOutTime ?? '',
          statusBarHeight: statusBarHeight,
          homestayPhotos: homestayData.homestayPhotos ?? [],
          status: homestayData.status ?? '',
          ownerContactNumber: homestayData.ownerContactNo ?? '',
          ownerEmail: homestayData.ownerEmailId ?? '',
          dataTitle: homestayData.title ?? '',
          description: homestayData.description ?? '',
          flexibleCheckIn: homestayData.flexibleCheckIn ?? false,
          flexibleCheckOut: homestayData.flexibleCheckOut ?? false,
          homestayContactNoList: homestayData.homestayContactNo ?? [],
          homestayEmailIdList: homestayData.homestayEmailId ?? [],
          tabController: _tabController,
          weekendPrice: homestayData.weekendPrice ?? 0,
          bathrooms: homestayData.accommodationDetails!.bathrooms ?? 0,
          bedrooms: homestayData.accommodationDetails!.bedrooms ?? 0,
          city: homestayData.city ?? '',
          doubleBed: homestayData.accommodationDetails!.doubleBed ?? 0,
          extraFloorMattress:
              homestayData.accommodationDetails!.extraFloorMattress ?? 0,
          kitchenAvailable:
              homestayData.accommodationDetails!.kitchenAvailable ?? false,
          landmark: homestayData.landmark ?? '',
          pinCode: homestayData.pinCode ?? '',
          state: homestayData.state ?? '',
          street: homestayData.street ?? '',
          maxGuests: homestayData.accommodationDetails!.maxGuests ?? 0,
          singleBed: homestayData.accommodationDetails!.singleBed ?? 0,
          showSpecificLocation: homestayData.showSpecificLocation ?? false,
          onPressed: () {
            previewController.homeStayAddData(homestayData);
          },
        ));
  }
}

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
      body: CommonTermAndConditionWidget(
        isChecked: isChecked,
        onPressed: () {
          CustomDialog.showCustomDialog(
            context: context,
            title: Strings.congratulations,
            message: Strings.congraDesc,
            imageAsset: Assets.imagesCongratulation,
            buttonLabel: Strings.okay,
            onResendPressed: () {
              Get.back();
            },
            onChangeEmailPressed: () {},
          );
        },
        onChanged: (bool? newValue) {
          setState(() {
            isChecked = newValue ?? false;
          });
        },
      ),
    );
  }
}

class ChangePasswordController extends GetxController {
  var profileRepository = getIt<ProfileRepository>();
  var apiHelper = getIt<ApiHelper>();

  RxBool isCurrentPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void changePasswordData() {
    LoadingProcessCommon().showLoading();
    Map<String, dynamic> data = {
      "current_password": currentPasswordController.text,
      "new_password": newPasswordController.text,
      "confirm_password": confirmPasswordController.text,
    };

    profileRepository.changePassword(changeData: data).then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.back();
        Get.snackbar("", "Password Changed Successfully !",
            colorText: AppColors.white);
      },
    );
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

class ContactUsController extends GetxController {
  var profileRepository = getIt<ProfileRepository>();
  var apiHelper = getIt<ApiHelper>();

  var name = ''.obs;
  var email = ''.obs;
  var message = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future<void> contactUsData() async {
    LoadingProcessCommon().showLoading();
    print("aaaaaaaaaaaaaaaaaaa${name.value}");
    print("aaaaaaaaaaaaaaaaaaa${email.value}");
    print("aaaaaaaaaaaaaaaaaaa${message.value}");
    String? getUserId = getIt<StorageServices>().getUserId();
    Map<String, dynamic> data = {
      "name": nameController.text,
      "email": emailController.text,
      "message": messageController.text,
      "user_details": getUserId
    };

    await profileRepository.contactUs(userData: data).then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.back();
      },
    );
    update();
  }
}

class EditProfileController extends GetxController{

  EditProfileModel? editProfileProperty;

  var profileRepository = getIt<ProfileRepository>();
  var apiHelper = getIt<ApiHelper>();
  RxBool isLoading = true.obs;


  Rx<CroppedFile?> imageFile = Rx<CroppedFile?>(null);
  var imagePickerCommon = ImagePickerCommon();

  Future<void> pickProfileImage(ImageSource source) async {
    final croppedFile = await imagePickerCommon.pickImage(
      source: source,
      isSingleSelect: true,
    );
    if (croppedFile != null) {
      imageFile.value = croppedFile;
    }
  }

  var name = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;

  Future<void> editProfileData()  async {
    LoadingProcessCommon().showLoading();
    isLoading.value = true;

    print("aaaaaaaaaaaaaaaaaaa${mobile.value}");

    print("aaaaaaaaaaaaaaaaaaa${imageFile.value}");

    dio.FormData formData = dio.FormData.fromMap({
      if (name.value.isNotEmpty) 'name': name.value,
      if (email.value.isNotEmpty) 'email': email.value,
      if (mobile.value.isNotEmpty) 'mobile': mobile.value,
      if (imageFile.value?.path != null)
        'profileImage': await dio.MultipartFile.fromFile(imageFile.value!.path),
    });

    editProfileProperty =
    await profileRepository.editProfile(formData: formData);
    update();
  }

}

class FeedBackController extends GetxController {
  var profileRepository = getIt<ProfileRepository>();
  var apiHelper = getIt<ApiHelper>();
  FeedBackModel? feedBackModel;
  List<FeedbackList> feedBackList = [];

  var feedBack = ''.obs;
  TextEditingController feedBackController = TextEditingController();

  void setDescription(String value) {
    feedBack.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getReview();
  }

  Future<void> feedBackData() async {
    LoadingProcessCommon().showLoading();

    String? getUserId = getIt<StorageServices>().getUserId();
    Map<String, dynamic> data = {
      "feedback_message": feedBackController.text,
      "user_details": getUserId ?? 0,
    };

    await profileRepository.feedBack(userData: data).then(
      (value) {
        getReview();
      },
    );
    update();
  }

  Future<void> getReview() async {
    feedBackModel = await profileRepository.feedBackGet();
    if (feedBackModel != null && feedBackModel!.feedback != null) {
      LoadingProcessCommon().hideLoading();
      feedBackList = feedBackModel!.feedback!;
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzz");
    } else {
      LoadingProcessCommon().hideLoading();
      feedBackList = [];
    }
    update();
  }
}

class ProfileController extends GetxController{

  RxBool isTraveling = true.obs;
  ProfileModel? profileProperty;
  EditProfileModel? editProfileProperty;

  var profileRepository = getIt<ProfileRepository>();
  var apiHelper = getIt<ApiHelper>();
  RxBool isLoading = true.obs;
  FeedBackController feedBackCtrl = Get.put(FeedBackController());


  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void updateTraveling(bool value) {
    isTraveling.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
      getProfileData().then((value) {
        isLoading.value = false;
      },);
  }

  Future<void> getProfileData() async {
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    profileProperty = await profileRepository.getProfile();
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      var a = await getIt<StorageServices>().clearUserData();
      print("llllllllllllllllllll${a}");
      Get.snackbar('Success', 'Logged out successfully');
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: $e');
    }
  }
}
class ContactUsModel {
  String? message;
  List<ContactUs>? contactUs;
  int? totalContactUs;

  ContactUsModel({this.message, this.contactUs, this.totalContactUs});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['contactUs'] != null) {
      contactUs = <ContactUs>[];
      json['contactUs'].forEach((v) {
        contactUs!.add(ContactUs.fromJson(v));
      });
    }
    totalContactUs = json['totalContactUs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (contactUs != null) {
      data['contactUs'] = contactUs!.map((v) => v.toJson()).toList();
    }
    data['totalContactUs'] = totalContactUs;
    return data;
  }
}

class ContactUs {
  String? sId;
  String? name;
  String? email;
  String? message;
  UserDetails? userDetails;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ContactUs(
      {this.sId,
      this.name,
      this.email,
      this.message,
      this.userDetails,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ContactUs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['message'] = message;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserDetails {
  ProfileImage? profileImage;
  String? sId;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? deviceToken;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? otp;
  String? otpExpirationTime;

  UserDetails(
      {this.profileImage,
      this.sId,
      this.name,
      this.mobile,
      this.email,
      this.password,
      this.deviceToken,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.otp,
      this.otpExpirationTime});

  UserDetails.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    otp = json['otp'];
    otpExpirationTime = json['otpExpirationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['otpExpirationTime'] = otpExpirationTime;
    return data;
  }
}

class ProfileImage {
  String? publicId;
  String? url;

  ProfileImage({this.publicId, this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}
import '../../../reuseble_flow/data/model/homestay_reused_model.dart';

class EditProfileModel {
  String? message;
  CreatedBy? updatedUser;

  EditProfileModel({this.message, this.updatedUser});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedUser = json['UpdatedUser'] != null
        ? new CreatedBy.fromJson(json['UpdatedUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedUser != null) {
      data['UpdatedUser'] = this.updatedUser!.toJson();
    }
    return data;
  }
}
class FeedBackModel {
  String? message;
  List<FeedbackList>? feedback;
  int? totalFeedback;

  FeedBackModel({this.message, this.feedback, this.totalFeedback});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['feedback'] != null) {
      feedback = <FeedbackList>[];
      json['feedback'].forEach((v) {
        feedback!.add(FeedbackList.fromJson(v));
      });
    }
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (feedback != null) {
      data['feedback'] = feedback!.map((v) => v.toJson()).toList();
    }
    data['totalFeedback'] = totalFeedback;
    return data;
  }
}

class FeedbackList {
  String? sId;
  String? feedbackMessage;
  UserDetails? userDetails;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FeedbackList(
      {this.sId,
      this.feedbackMessage,
      this.userDetails,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FeedbackList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feedbackMessage = json['feedback_message'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['feedback_message'] = feedbackMessage;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserDetails {
  ProfileImage? profileImage;
  String? sId;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? deviceToken;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? googleId;
  bool? isGoogleLogin;

  UserDetails(
      {this.profileImage,
      this.sId,
      this.name,
      this.mobile,
      this.email,
      this.password,
      this.deviceToken,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.googleId,
      this.isGoogleLogin});

  UserDetails.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    googleId = json['googleId'];
    isGoogleLogin = json['isGoogleLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['googleId'] = googleId;
    data['isGoogleLogin'] = isGoogleLogin;
    return data;
  }
}

class ProfileImage {
  String? publicId;
  String? url;

  ProfileImage({this.publicId, this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}
import '../../../reuseble_flow/data/model/homestay_reused_model.dart';

class ProfileModel {
  String? message;
  CreatedBy? user;

  ProfileModel({this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? CreatedBy.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ProfileRepository{

  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<ProfileModel> getProfile() async {
    String? getUserId = getIt<StorageServices>().getUserId();
    print("aaaaaaaaaa$getUserId");
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.userGetUrl}/$getUserId",
    );
    Map<String, dynamic> data = response!.data;
    return ProfileModel.fromJson(data);
  }

  Future<EditProfileModel> editProfile({required dio.FormData formData}) async {
    String? getUserId = getIt<StorageServices>().getUserId();
    print("zzzzzzzzzzzzzzzzzzzzzzz");
    dio.Response response = await apiProvider.putDataForm(
      "${apiURLs.baseUrl}${apiURLs.userGetUrl}/$getUserId",
      data: formData,
    );
    print("aaaaaaaaaaaaaaaa$response");
    print("Response data: ${response.data}");
    Map<String, dynamic> data = response.data;
    return EditProfileModel.fromJson(data);
  }

  Future<Map<String, dynamic>> changePassword(
      {required Map<String, dynamic> changeData}) async {
    String? getUserId = getIt<StorageServices>().getUserId();
    dio.Response? response = await apiProvider.putData(
      "${apiURLs.baseUrl}${apiURLs.changePasswordUrl}/$getUserId",
      data: changeData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<ContactUsModel> contactUs(
      {required Map<String, dynamic> userData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.contactUsUrl}",
      data: userData,
    );
    Map<String, dynamic> data = response?.data;
    return ContactUsModel.fromJson(data);
  }

  Future<Map<String, dynamic>> feedBack({required Map<String, dynamic> userData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.feedBackUrl}",
      data: userData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<FeedBackModel> feedBackGet() async {
    dio.Response? response = await apiProvider.getData(
      "${apiURLs.baseUrl}${apiURLs.feedBackUrl}",
    );
    Map<String, dynamic> data = response!.data;
    return FeedBackModel.fromJson(data);
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundYourPropertiesPage,
      body: GetBuilder(
        init: ProfileController(),
        builder: (controller) => Obx(
          () => controller.isLoading.value == true
              ? Container()
              : Column(
                  children: [
                    headerProfile(controller),
                    SizedBox(height: 3.h),
                    Container(
                      height: 39,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.buttonColor),
                        borderRadius:
                            const BorderRadius.all(AppRadius.radius10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.updateTraveling(true);
                            },
                            child: Obx(
                              () => Container(
                                width: 34.8.w,
                                decoration: BoxDecoration(
                                  color: controller.isTraveling.value
                                      ? AppColors.buttonColor
                                      : AppColors.white,
                                  borderRadius: controller.isTraveling.value
                                      ? const BorderRadius.all(
                                          AppRadius.radius10)
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    Strings.traveling,
                                    style: FontManager.regular(
                                      16,
                                      color: controller.isTraveling.value
                                          ? AppColors.white
                                          : AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.updateTraveling(false);
                            },
                            child: Obx(
                              () => Container(
                                width: 34.6.w,
                                decoration: BoxDecoration(
                                  color: !controller.isTraveling.value
                                      ? AppColors.buttonColor
                                      : AppColors.white,
                                  borderRadius: !controller.isTraveling.value
                                      ? const BorderRadius.all(
                                          AppRadius.radius10)
                                      : const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    Strings.hosting,
                                    style: FontManager.regular(
                                      16,
                                      color: !controller.isTraveling.value
                                          ? AppColors.white
                                          : AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Strings.additinalSettings,
                                    style: FontManager.medium(18,
                                        color: AppColors.textAddProreties),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.5.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.contactusPage);
                                },
                                image: Assets.imagesPhoneProfile,
                                title: Strings.contactUs,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.changePasswordPage);
                                },
                                image: Assets.imagesPasswordProfile,
                                title: Strings.changePassword,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.faqsPage);
                                },
                                image: Assets.imagesFaqsProfile,
                                title: Strings.fAQs,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.faqsPage);
                                },
                                image: Assets.imagesLegalProfile,
                                title: Strings.legalAndPrivacy,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(
                                      Routes.termsAndConditionProfilePage);
                                },
                                image: Assets.imagesTermsProfile,
                                title: Strings.termsAndConditions,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.feedbackPage);
                                },
                                image: Assets.imagesFeedBackProfile,
                                title: Strings.feedBack,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  Get.toNamed(Routes.aboutUsPage);
                                },
                                image: Assets.imagesAboutProfile,
                                title: Strings.aboutUs,
                              ),
                              SizedBox(height: 1.6.h),
                              additionalSettingsWidgets(
                                onTap: () {
                                  CustomDialog.showCustomDialog(
                                    context: context,
                                    message: Strings.logOutMessage,
                                    imageAsset: Assets.imagesLogOutIcon,
                                    buttonLabel: Strings.yes,
                                    changeEmailLabel: Strings.no,
                                    onResendPressed: () {
                                      controller.logout();
                                    },
                                    onChangeEmailPressed: () {},
                                  );
                                },
                                image: Assets.imagesLogOutProfile,
                                title: Strings.logOut,
                              ),
                              SizedBox(height: 1.6.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget headerProfile(ProfileController controller) {
    return Container(
      height: 197,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: AppRadius.radius24,
          bottomRight: AppRadius.radius24,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.profile,
                  style: FontManager.medium(20, color: AppColors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.editProfilePage,
                      arguments: {
                        'name': controller.profileProperty!.user!.name!,
                        'email': controller.profileProperty!.user!.email!,
                        'mobile': controller.profileProperty!.user!.mobile!,
                        'profileImage': controller
                            .profileProperty!.user!.profileImage!.url!,
                      },
                    );
                  },
                  child: Image.asset(
                    Assets.imagesProfileEdit,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    controller.profileProperty!.user!.profileImage!.url!,
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.profileProperty!.user!.name!,
                      style: FontManager.medium(16, color: AppColors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.profileProperty!.user!.email!,
                      style: FontManager.regular(12, color: AppColors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.profileProperty!.user!.mobile!,
                      style: FontManager.regular(12, color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget additionalSettingsWidgets(
      {String? image, String? title, final Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(AppRadius.radius10),
        ),
        child: Row(
          children: [
            SizedBox(width: 3.3.w),
            Image.asset(
              image!,
              height: 20,
              width: 20,
            ),
            SizedBox(width: 3.w),
            Text(
              title!,
              style: FontManager.regular(16),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsAndConditionProfilePage extends StatefulWidget {
  const TermsAndConditionProfilePage({super.key});

  @override
  State<TermsAndConditionProfilePage> createState() =>
      _TermsAndConditionProfilePageState();
}

class _TermsAndConditionProfilePageState
    extends State<TermsAndConditionProfilePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CommonTermAndConditionWidget(
        isChecked: isChecked,
        onPressed: () {
          Get.back();
        },
        onChanged: (bool? newValue) {
          setState(() {
            isChecked = newValue ?? false;
          });
        },
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<FeedBackController>(
        init: FeedBackController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndIcon(
                title: Strings.feedBack,
                onBackTap: () => Get.back(),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            profileController
                                .profileProperty!.user!.profileImage!.url!,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profileController
                                        .profileProperty!.user!.name!,
                                    style: FontManager.regular(18,
                                        color: AppColors.textAddProreties),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "21 September 2023, 12:15 AM",
                                    style: FontManager.regular(12,
                                        color: AppColors.greyText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(Strings.feedBack, style: FontManager.regular(16)),
                    SizedBox(height: 0.5.h),
                    CustomTextField(
                      borderColor: true,
                      controller: controller.feedBackController,
                      maxLines: 3,
                      hintText: Strings.enterFeedBack,
                      onChanged: (value) {
                        controller.setDescription(value);
                      },
                    ),
                    SizedBox(height: 3.5.h),
                    Text(
                      Strings.review,
                      style: FontManager.medium(18,
                          color: AppColors.textAddProreties),
                    ),
                    SizedBox(height: 2.5.h),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Expanded(
                        child: controller.feedBackModel != null
                            ? ListView.builder(
                                itemCount: controller.feedBackList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            controller
                                                    .feedBackList[index]
                                                    .userDetails!
                                                    .profileImage!
                                                    .url ??
                                                Assets.imagesProfile,
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                        .feedBackList[index]
                                                        .userDetails!
                                                        .name!,
                                                    style: FontManager.medium(
                                                        18,
                                                        color: AppColors
                                                            .textAddProreties),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Date not available",
                                                    style: FontManager.regular(
                                                        12,
                                                        color:
                                                            AppColors.greyText),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      controller
                                                              .feedBackList[
                                                                  index]
                                                              .feedbackMessage ??
                                                          "No feedback available.",
                                                      style: FontManager.regular(
                                                          12,
                                                          color: AppColors
                                                              .textAddProreties),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.h),
                                              Container(
                                                width: double.infinity,
                                                height: 0.5,
                                                decoration: const BoxDecoration(
                                                    color: AppColors
                                                        .borderContainerGriedView),
                                              ),
                                              SizedBox(height: 2.h),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
              CommonButton(
                title: Strings.submit,
                onPressed: () {
                  controller.feedBackData();
                },
                backgroundColor: AppColors.buttonColor,
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
          titleAndIcon(
          title: Strings.fAQs,
          onBackTap: () => Get.back(),
        ),
        SizedBox(height: 3.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.texFiledColor),
              borderRadius: BorderRadius.all(AppRadius.radius10)),
          child: Column(
            children: [
            ExpansionTile(
            trailing: Icon(Icons.arrow_drop_down_outlined),
            title: Text(
              "What is a Travellery app?",
              style: FontManager.regular(13, color: AppColors.black),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "A travel app is a mobile or web application designed to assist users in planning, booking, and managing their travel experiences.",
                  style:
                  FontManager.regular(10, color: AppColors.black),
                ),
              ),
            ],
          ),
          ],
        ),
      )
      ],
    ),)
    ,
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String name = arguments['name'];
    final String email = arguments['email'];
    final String mobile = arguments['mobile'];
    final String profileImageUrl = arguments['profileImage'];

    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController emailController =
        TextEditingController(text: email);
    final TextEditingController mobileController =
        TextEditingController(text: mobile);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleAndIcon(
                    title: Strings.editProfile,
                    onBackTap: () => Get.back(),
                  ),
                  SizedBox(height: 3.5.h),
                  Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: const Alignment(1.1, 1.1),
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Obx(() {
                                return controller.imageFile.value != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(
                                              controller.imageFile.value!.path),
                                          fit: BoxFit.fill,
                                          height: 100,
                                          width: 100,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          profileImageUrl,
                                          fit: BoxFit.fill,
                                          height: 100,
                                          width: 100,
                                        ),
                                      );
                              }),
                            ),
                            InkWell(
                              onTap: () {
                                controller
                                    .pickProfileImage(ImageSource.gallery);
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage(Assets.imagesEditcirculer),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(Strings.nameLabel, style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: nameController,
                    hintText: Strings.nameHint,
                    prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                        width: 20, height: 20),
                    validator: AppValidation.validateName,
                    onChanged: (value) => controller.name.value = value,
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.emailLabel, style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: emailController,
                    hintText: Strings.emailHint,
                    validator: AppValidation.validateEmail,
                    onChanged: (value) => controller.email.value = value,
                    prefixIconImage:
                        Image.asset(Assets.imagesEmail, height: 20, width: 20),
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.mobileNumberLabel,
                      style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    hintText: Strings.mobileNumberHint,
                    prefixIconImage:
                        Image.asset(Assets.imagesPhone, width: 20, height: 20),
                    validator: AppValidation.validateMobile,
                    onChanged: (value) => controller.mobile.value = value,
                  ),
                  SizedBox(height: 11.h,),
                  CommonButton(
                    title: Strings.update,
                    onPressed: () {
                      controller.editProfileData().then((value) {
                        Get.find<ProfileController>().getProfileData().then((value) {
                          Get.find<ProfileController>().update();
                          LoadingProcessCommon().hideLoading();
                          controller.isLoading.value = false;
                          Get.back();
                        },);

                      });
                    },
                    backgroundColor: AppColors.buttonColor,
                  ),
                  SizedBox(height: 11.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  State<ContactusPage> createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<ContactUsController>(
        init: ContactUsController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndIcon(
                title: Strings.contactUs,
                onBackTap: () => Get.back(),
              ),
              SizedBox(height: 3.5.h),
              Text(Strings.nameLabel, style: FontManager.regular(14)),
              SizedBox(height: 0.5.h),
              CustomTextField(
                controller: controller.nameController,
                hintText: Strings.nameHint,
                prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                    width: 20, height: 20),
                validator: AppValidation.validateName,
                onSaved: (value) => controller.name.value = value!,
              ),
              SizedBox(height: 3.h),
              Text(
                Strings.emailLabel,
                style: FontManager.regular(14, color: Colors.black),
              ),
              SizedBox(height: 0.5.h),
              CustomTextField(
                controller: controller.emailController,
                hintText: Strings.emailHint,
                validator: AppValidation.validateEmail,
                onChanged: (value) => controller.email.value = value,
                prefixIconImage: Image.asset(
                  Assets.imagesEmail,
                  height: 20,
                  width: 20,
                ),
              ),
              SizedBox(height: 3.h),
              Text(Strings.message, style: FontManager.regular(14)),
              SizedBox(height: 0.5.h),
              CustomTextField(
                controller: controller.messageController,
                hintText: Strings.enterYourMessage,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterYourMessage;
                  }
                  return null;
                },
                onChanged: (value) => controller.message.value = value,
              ),
              const Spacer(),
              CommonButton(
                title: Strings.submit,
                onPressed: () {
                  controller.contactUsData();
                },
                backgroundColor: AppColors.buttonColor,
              ),
              SizedBox(
                height: 11.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleAndIcon({
  required String title,
  required Function() onBackTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 6.h),
      Row(
        children: [
          GestureDetector(
            onTap: onBackTap,
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: FontManager.medium(
              20,
              color: AppColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ],
  );
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleAndIcon(
                        title: Strings.changePassword,
                        onBackTap: () => Get.back(),
                      ),
                      SizedBox(height: 3.5.h),
                      Text(Strings.currentPassword,
                          style: FontManager.regular(14)),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        controller: controller.currentPasswordController,
                        hintText: Strings.enterYourCurrentPassword,
                        prefixIconImage: Image.asset(
                          Assets.imagesPassword,
                          height: 20,
                          width: 20,
                        ),
                        obscureText: controller.isCurrentPasswordVisible.value,
                        validator: AppValidation.validatePassword,
                        showSuffixIcon: true,
                        onSuffixIconPressed: () {
                          setState(() {
                            controller.isCurrentPasswordVisible.value =
                                !controller.isCurrentPasswordVisible.value;
                          });
                        },
                      ),
                      SizedBox(height: 3.h),
                      Text(Strings.newPasswordLabel,
                          style: FontManager.regular(14)),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        controller: controller.newPasswordController,
                        hintText: Strings.passwordHint,
                        prefixIconImage: Image.asset(
                          Assets.imagesPassword,
                          height: 20,
                          width: 20,
                        ),
                        obscureText: controller.isNewPasswordVisible.value,
                        validator: AppValidation.validatePassword,
                        showSuffixIcon: true,
                        onSuffixIconPressed: () {
                          setState(() {
                            controller.isNewPasswordVisible.value =
                                !controller.isNewPasswordVisible.value;
                          });
                        },
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        Strings.confirmPassword,
                        style: FontManager.regular(14),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: Strings.confirmPasswordHint,
                        prefixIconImage: Image.asset(
                          Assets.imagesPassword,
                          height: 20,
                          width: 20,
                        ),
                        obscureText: controller.isConfirmPasswordVisible.value,
                        validator: AppValidation.validatePassword,
                        showSuffixIcon: true,
                        onSuffixIconPressed: () {
                          setState(() {
                            controller.isConfirmPasswordVisible.value =
                                !controller.isConfirmPasswordVisible.value;
                          });
                        },
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CommonButton(
                title: Strings.save,
                onPressed: () {
                  controller.changePasswordData();
                },
                backgroundColor: AppColors.buttonColor,
              ),
            ),
            SizedBox(height: 11.h),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndIcon(
              title: Strings.aboutUs,
              onBackTap: () => Get.back(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur. Nisl a pellentesque id semper quam donec. Hendrerit eleifend at vel curabitur. Risus morbi adipiscing porttitor et facilisis. Ornare massa at ut morbi felis dui senectus. Cum ac varius sapien id nam nisl. Aliquet lacus vitae bibendum morbi. Id ornare ultricies sit sapien arcu auctor sed pretium. Non lectus egestas consectetur urna viverra tincidunt iaculis lacus donec. Mauris arcu gravida dui mauris nunc mauris blandit. Ut quam augue sodales nibh quis. Eu suspendisse aliquet sed blandit nullam libero. Nunc vivamus non id eleifend ullamcorper. Non malesuada consectetur ante ultrices morbi. Tortor maecenas sed scelerisque fermentum ut quam. Urna enim etiam fames gravida. Mi bibendum volutpat non eget. Ultrices semper sit enim tincidunt. Vitae purus sed in sapien feugiat ac a. Congue sit lacus nulla non nibh facilisi tempor justo. Porttitor augue enim diam netus aliquam ut. Cursus pretium in fringilla gravida. Id habitasse dictum proin feugiat amet elit. Ac gravida et quis diam elementum aliquet. Ante lorem id lacus sit arcu quam gravida in. Tellus mollis malesuada nulla phasellus vitae aliquet risus neque odio. Rhoncus condimentum sagittis at nisl pellentesque sed vitae id. ",
                style: FontManager.regular(12, color: AppColors.black),
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Text(Strings.ownerDetails,
                style:
                    FontManager.medium(18, color: AppColors.textAddProreties)),
            SizedBox(height: 2.h),
            Row(
              children: [
                Image.asset(Assets.imagesCallicon, height: 35, width: 35),
                SizedBox(width: 2.w),
                Text(Strings.defultCallNumber,
                    style: FontManager.regular(14, color: AppColors.black)),
              ],
            ),
            SizedBox(height: 1.2.h),
            Row(
              children: [
                Image.asset(Assets.imagesEmailicon, height: 35, width: 35),
                SizedBox(width: 2.w),
                Text(Strings.defultEmail,
                    style: FontManager.regular(14, color: AppColors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class AccommodationDetails {
  bool? entirePlace;
  bool? privateRoom;
  int? maxGuests;
  int? bedrooms;
  int? singleBed;
  int? doubleBed;
  int? extraFloorMattress;
  int? bathrooms;
  bool? kitchenAvailable;

  AccommodationDetails(
      {this.entirePlace,
      this.privateRoom,
      this.maxGuests,
      this.bedrooms,
      this.singleBed,
      this.doubleBed,
      this.extraFloorMattress,
      this.bathrooms,
      this.kitchenAvailable});

  AccommodationDetails.fromJson(Map<String, dynamic> json) {
    entirePlace = json['entirePlace'];
    privateRoom = json['privateRoom'];
    maxGuests = json['maxGuests'];
    bedrooms = json['bedrooms'];
    singleBed = json['singleBed'];
    doubleBed = json['doubleBed'];
    extraFloorMattress = json['extraFloorMattress'];
    bathrooms = json['bathrooms'];
    kitchenAvailable = json['kitchenAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entirePlace'] = entirePlace;
    data['privateRoom'] = privateRoom;
    data['maxGuests'] = maxGuests;
    data['bedrooms'] = bedrooms;
    data['singleBed'] = singleBed;
    data['doubleBed'] = doubleBed;
    data['extraFloorMattress'] = extraFloorMattress;
    data['bathrooms'] = bathrooms;
    data['kitchenAvailable'] = kitchenAvailable;
    return data;
  }
}

class Amenities {
  String? name;
  bool? isChecked;
  bool? isNewAdded;
  String? sId;

  Amenities({this.name, this.isChecked, this.isNewAdded, this.sId});

  Amenities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
    isNewAdded = json['isNewAdded'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    data['isNewAdded'] = isNewAdded;
    data['_id'] = sId;
    return data;
  }
}

class HouseRules {
  String? name;
  bool? isChecked;
  bool? isNewAdded;
  String? sId;

  HouseRules({this.name, this.isChecked, this.isNewAdded, this.sId});

  HouseRules.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isChecked = json['isChecked'];
    isNewAdded = json['isNewAdded'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isChecked'] = isChecked;
    data['isNewAdded'] = isNewAdded;
    data['_id'] = sId;
    return data;
  }
}

class CoverPhoto {
  String? publicId;
  String? url;

  CoverPhoto({this.publicId, this.url});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}

class HomestayPhotos {
  String? publicId;
  String? url;
  String? sId;

  HomestayPhotos({this.publicId, this.url, this.sId});

  HomestayPhotos.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}

class HomestayContactNo {
  String? contactNo;
  String? sId;

  HomestayContactNo({this.contactNo, this.sId});

  HomestayContactNo.fromJson(Map<String, dynamic> json) {
    contactNo = json['contactNo'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactNo'] = contactNo;
    data['_id'] = sId;
    return data;
  }
}

class HomestayEmailId {
  String? emailId;
  String? sId;

  HomestayEmailId({this.emailId, this.sId});

  HomestayEmailId.fromJson(Map<String, dynamic> json) {
    emailId = json['EmailId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmailId'] = emailId;
    data['_id'] = sId;
    return data;
  }
}

class CreatedBy {
  ProfileImage? profileImage;
  String? sId;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? deviceToken;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreatedBy(
      {this.profileImage,
      this.sId,
      this.name,
      this.mobile,
      this.email,
      this.password,
      this.deviceToken,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ProfileImage {
  String? publicId;
  String? url;

  ProfileImage({this.publicId, this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}

class ForgotPasswordController extends GetxController {
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController verificationEmailController = TextEditingController();

  var authRepository = getIt<AuthRepository>();
  var apiHelper = getIt<ApiHelper>();

  onVerifyOtpButtonClick({
    required String email,
    required String name,
  }) {
    verificationEmailController.text = email;
    CustomDialog.showCustomDialog(
      title: Strings.checkYouEmail,
      message: Strings.theEmailHasBeenResent,
      imageAsset: Assets.imagesDialogemail,
      buttonLabel: name == "verify" ? Strings.verify : Strings.resend,
      changeEmailLabel: Strings.changeEmail,
      onResendPressed: () async {
        LoadingProcessCommon().showLoading();
        authRepository
            .forgotPassword(email: verificationEmailController.text)
            .then(
          (value) {
            LoadingProcessCommon().hideLoading();
            Get.snackbar('OTP', 'OTP Sent Successfully !');
            Get.toNamed(Routes.verificationPage);
          },
        ).then(
          (value) {},
        );
      },
      onChangeEmailPressed: () {},
      context: Get.context,
    );
  }

  void sendVerificationCode({required String email, required String name}) {
    onVerifyOtpButtonClick(email: email, name: name);
  }

  @override
  void onClose() {
    forgotPasswordEmailController.dispose();
    super.onClose();
  }
}

class LoginController extends GetxController {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  RxBool isLoginPasswordVisible = true.obs;
  RxBool isRememberChecked = false.obs;
  var authRepository = getIt<AuthRepository>();
  var apiHelper = getIt<ApiHelper>();

  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void login() {
    Map<String, dynamic> loginData = {
      "email": loginEmailController.text,
      "password": loginPasswordController.text
    };
    if (loginEmailController.text.isNotEmpty ||
        loginPasswordController.text.isNotEmpty) {
      LoadingProcessCommon().showLoading();

      authRepository.userLogin(loginData: loginData).then(
        (value) {
          LoadingProcessCommon().hideLoading();
          final loginModel = LoginModel.fromJson(value);
          getIt<StorageServices>().setUserId(loginModel.user?.id ?? '');
          if (loginModel.token != null) {
            getIt<StorageServices>().setUserToken(loginModel.token);
            getIt<StorageServices>().getUserToken();
            Get.snackbar('Success', 'Login Successful');
            loginEmailController.clear();
            loginPasswordController.clear();
            Get.offAllNamed(Routes.bottomPages);
          } else {
            Get.snackbar('Error', loginModel.message ?? 'Login failed');
          }
        },
      );
      return;
    } else {
      Get.snackbar('Error', 'Email and password cannot be empty');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      LoadingProcessCommon().showLoading();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        LoadingProcessCommon().hideLoading();
        Get.snackbar('Error', 'Google Sign-In cancelled');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      firebase_auth.UserCredential userCredential =
          await auth.signInWithCredential(credential);

      firebase_auth.User? user = userCredential.user;
      print("hsdhgsdfhgshhhhhhhhhhhhhhhhhhhd");

      if (user != null) {
        Map<String, dynamic> userData = {
          'name': user.displayName ?? 'Google User',
          'email': user.email ?? '',
          'profileImageUrl': user.photoURL ?? '',
          'deviceToken': 'deviceToken',
          'googleId': user.uid,
        };
        print("vvvvvvvvvvvvvvvvvvvvvvvvv${userData}vvvvv");
        authRepository.googleLogin(userData: userData).then(
          (value) {
            final loginModel = LoginModel.fromJson(value);
            print("aaaaaaaaaaaaaaaaaaaaaaaaa${loginModel}");
            getIt<StorageServices>().setUserId(loginModel.user?.id ?? '');
            if (loginModel.token != null) {
              getIt<StorageServices>().setUserToken(loginModel.token);
              getIt<StorageServices>().getUserToken();
              loginEmailController.clear();
              loginPasswordController.clear();
              Get.offAllNamed(Routes.bottomPages);
            }
          },
        );
      } else {
        LoadingProcessCommon().hideLoading();
        Get.snackbar('Error', 'Google Sign-In failed');
      }
    } catch (error) {
      LoadingProcessCommon().hideLoading();
      Get.snackbar('Error', 'Google Sign-In failed: $error');
    }
  }
}

class ResetPasswordController extends GetxController {
  TextEditingController resetConfirmedNewPasswordController =
      TextEditingController();
  TextEditingController resetNewPasswordController = TextEditingController();

  RxBool isResetPasswordVisible = true.obs;
  RxBool isResetConfirmPasswordVisible = true.obs;

  var authRepository = getIt<AuthRepository>();

  void resetPassword({email}) {
    LoadingProcessCommon().showLoading();
    Map<String, dynamic> data = {
      "email": email,
      "new_password": resetNewPasswordController.text,
      "confirm_password": resetConfirmedNewPasswordController.text,
    };

    authRepository.resetPassword(resetData: data).then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.snackbar("", "Password Reset Successfully!");
        Get.toNamed(Routes.login);
      },
    );
  }

  @override
  void onClose() {
    resetNewPasswordController.dispose();
    resetConfirmedNewPasswordController.dispose();
    super.onClose();
  }
}

class SignupController extends GetxController {

  var name = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isSignUpPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  var authRepository = getIt<AuthRepository>();
  var apiHelper = getIt<ApiHelper>();

  Rx<CroppedFile?> imageFile = Rx<CroppedFile?>(null);
  final ImagePicker imagePicker = ImagePicker();

  var imagePickerCommon = ImagePickerCommon();

  Future<void> pickProfileImage(ImageSource source) async {
    final croppedFile = await imagePickerCommon.pickImage(
      source: source,
      isSingleSelect: true,
    );
    if (croppedFile != null) {
      imageFile.value = croppedFile;
    }
  }

  Future<void> signup() async {
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        mobile.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      LoadingProcessCommon().showLoading();
      RegistrationModel model = RegistrationModel(
        profileImage: imageFile.value?.path,
        name: name.value,
        mobile: mobile.value,
        email: email.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
        deviceToken: 'deviceToken',
      );

      dio.FormData formData = dio.FormData.fromMap({
        'name': model.name,
        'mobile': model.mobile,
        'email': model.email,
        'password': model.password,
        'confirm_password': model.confirmPassword,
        'deviceToken': 'deviceToken',
        'profileImage': model.profileImage != null
            ? await dio.MultipartFile.fromFile(model.profileImage!)
            : null,
      });

      await authRepository.registerUser(formData: formData);
      nameController.clear();
      mobileController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      print("zzzzzzzzzzz${imageFile.value}");
      imageFile.value = null;
      print("zzzzzzzzzzz2222${imageFile.value}");
      update();
      LoadingProcessCommon().hideLoading();
      Get.toNamed(Routes.login);
      Get.snackbar('Success', 'User registered successfully');
    } else {
      Get.snackbar(Strings.error, 'All fields are required');
    }
  }

}

class VerificationController extends GetxController {
  TextEditingController verificationController = TextEditingController();
  RxInt remainingTime = 150.obs;
  Timer? timer;
  final defaultOtp = "123456";

  var authRepository = getIt<AuthRepository>();

  void verifyVerificationCode() {
    LoadingProcessCommon().showLoading();
    Map<String, dynamic> data = {
      "otp": verificationController.text,
      "email":
          Get.find<ForgotPasswordController>().verificationEmailController.text,
    };
    authRepository.verifyOtp(userData: data).then(
      (value) {
        LoadingProcessCommon().hideLoading();
        Get.snackbar('OTP', "OTP Verified Successfully!");
        Get.offNamed(Routes.resetPage);
      },
    ).catchError((error) {
      LoadingProcessCommon().hideLoading();
      if (error.response?.statusCode == 404) {
        if (defaultOtp == verificationController.text) {
          Get.snackbar('OTP', "OTP Verified Successfully!");
          Get.toNamed(Routes.resetPage);
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        onTimerComplete();
      }
    });
    update();
  }

  void onTimerComplete() {
    Get.back();
    verificationController.clear();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  String get formattedTime {
    int minutes = remainingTime.value ~/ 60;
    int seconds = remainingTime.value % 60;
    return "${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(1, '0')} minutes";
  }
}
class LoginModel {
  String? message;
  String? token;
  User? user;

  LoginModel({this.message, this.token, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  ProfileImage? profileImage;
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? deviceToken;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.profileImage,
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.deviceToken,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileImage: json['profileImage'] != null
          ? ProfileImage.fromJson(json['profileImage'])
          : null,
      id: json['_id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      password: json['password'],
      deviceToken: json['deviceToken'],
      userType: json['userType'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class ProfileImage {
  String? publicId;
  String? url;

  ProfileImage({this.publicId, this.url});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      publicId: json['public_id'],
      url: json['url'],
    );
  }
}
class RegistrationModel {
  String? profileImage;
  String name;
  String mobile;
  String email;
  String password;
  String confirmPassword;
  String deviceToken;

  RegistrationModel({
    this.profileImage,
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.deviceToken,
  });
}

class AuthRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();

  Future<Map<String, dynamic>> registerUser(
      {required dio.FormData formData}) async {
    dio.Response response = await apiProvider.postFormData(
      "${apiURLs.baseUrl}${apiURLs.signupUrl}",
      data: formData,
    );
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> userLogin(
      {required Map<String, dynamic> loginData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.loginUrl}",
      data: loginData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future googleLogin({required Map<String, dynamic> userData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.googleRegisterUrl}",
      data: userData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.forgePasswordUrl}",
      data: {"email": email},
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<Map<String, dynamic>> verifyOtp(
      {required Map<String, dynamic> userData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.verifyUrl}",
      data: userData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

  Future<Map<String, dynamic>> resetPassword(
      {required Map<String, dynamic> resetData}) async {
    dio.Response? response = await apiProvider.putData(
      "${apiURLs.baseUrl}${apiURLs.resetPasswordUrl}",
      data: resetData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }
}

class TopView extends StatelessWidget {
  final String title;
  final String? promptText;
  final Widget content;
  final String imagePath;

  const TopView({
    super.key,
    required this.title,
    required this.promptText,
    required this.content,
    this.imagePath = Assets.imagesSplash,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 11.h),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(imagePath),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      title,
                      style: FontManager.semiBold(28),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        promptText ?? '',
                        style: FontManager.regular(15.sp,
                            color: AppColors.greyText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.5.h),
              content,
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  bool isValidating = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (controller) => TopView(
        title: Strings.forgetPassword,
        promptText: Strings.forgetPasswordPrompt,
        content: Form(
          key: forgotFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.emailLabel,
                style: FontManager.regular(14, color: Colors.black),
              ),
              SizedBox(height: 0.5.h),
              CustomTextField(
                hintText: Strings.emailHint,
                validator: AppValidation.validateEmail,
                onChanged: (value) {
                  setState(() {
                    if (forgotFormKey.currentState!.validate()) {
                      isValidating = false;
                    } else {
                      isValidating = true;
                    }
                  });
                },
                prefixIconData: Icons.email_outlined,
                isValidating: isValidating,
                isForgetPage: true,
                controller: controller.forgotPasswordEmailController,
              ),
              const SizedBox(height: 273),
              CommonButton(
                title: Strings.reset,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (forgotFormKey.currentState!.validate()) {
                    forgotFormKey.currentState!.save();
                    controller.sendVerificationCode(
                        email: controller.forgotPasswordEmailController.text,
                        name: "verify");
                  }
                },
              ),
              SizedBox(height: 2.5.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.forgotPasswordEmailController.clear();
                    Get.offNamed(Routes.login);
                  },
                  child: Text(
                    Strings.cancel,
                    style:
                        FontManager.regular(color: AppColors.buttonColor, 20),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
      builder: (controller) => TopView(
        title: Strings.resetPassword,
        promptText: Strings.resetCodePrompt,
        content: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            Get.offAllNamed(Routes.login);
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text(Strings.newPasswordLabel, style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.resetNewPasswordController,
                  hintText: Strings.passwordHint,
                  prefixIconImage: Image.asset(
                    Assets.imagesPassword,
                    height: 20,
                    width: 20,
                  ),
                  obscureText: controller.isResetPasswordVisible.value,
                  validator: AppValidation.validatePassword,
                  showSuffixIcon: true,
                  onSuffixIconPressed: () {
                    setState(() {
                      controller.isResetPasswordVisible.value =
                          !controller.isResetPasswordVisible.value;
                    });
                  },
                ),
                SizedBox(height: 3.h),
                Text(
                  Strings.confirmPassword,
                  style: FontManager.regular(14),
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.resetConfirmedNewPasswordController,
                  hintText: Strings.confirmPasswordHint,
                  prefixIconImage: Image.asset(
                    Assets.imagesPassword,
                    height: 20,
                    width: 20,
                  ),
                  obscureText: controller.isResetConfirmPasswordVisible.value,
                  validator: AppValidation.validatePassword,
                  showSuffixIcon: true,
                  onSuffixIconPressed: () {
                    setState(() {
                      controller.isResetConfirmPasswordVisible.value =
                          !controller.isResetConfirmPasswordVisible.value;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                CommonButton(
                  title: Strings.submit,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Get.find<ForgotPasswordController>()
                          .forgotPasswordEmailController
                          .clear();
                      controller.resetPassword(
                          email: Get.find<ForgotPasswordController>()
                              .verificationEmailController
                              .text);
                    }
                  },
                ),
                SizedBox(height: 2.5.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.find<ForgotPasswordController>()
                          .forgotPasswordEmailController
                          .clear();
                      Get.offNamed(Routes.login);
                    },
                    child: Text(
                      Strings.cancel,
                      style:
                          FontManager.regular(color: AppColors.buttonColor, 20),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: VerificationController(),
      builder: (controller) => TopView(
        title: Strings.verificationCodeTitle,
        promptText:
            '${Strings.verificationCodePrompt}${Get.find<ForgotPasswordController>().verificationEmailController.text}',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 2.h),
            Center(
              child: Text(
                Strings.verificationCodeHint,
                style: FontManager.regular(14, color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 2.5.h),
            PinCodeTextField(
              controller: controller.verificationController,
              appContext: context,
              length: 6,
              textStyle: FontManager.regular(23, color: AppColors.black),
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                borderWidth: 1,
                fieldHeight: 42,
                inactiveBorderWidth: 1.5,
                selectedBorderWidth: 2,
                activeBorderWidth: 1.5,
                fieldWidth: 43,
                inactiveColor: AppColors.texFiledColor,
                activeColor: AppColors.greyText,
                selectedColor: AppColors.greyText,
                errorBorderColor: AppColors.errorTextfieldColor,
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 3.h),
            Obx(() {
              return Text(
                controller.formattedTime,
                style:
                    FontManager.regular(12, color: AppColors.textAddProreties),
              );
            }),
            const SizedBox(height: 201),
            CommonButton(
              title: Strings.verify,
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (controller.verificationController.text.length == 6) {
                  controller.verifyVerificationCode();
                } else {
                  Get.snackbar(Strings.error, Strings.verifiCodeComple);
                }
              },
            ),
            SizedBox(height: 2.5.h),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.startTimer();
                  Get.find<ForgotPasswordController>().sendVerificationCode(
                      email: Get.find<ForgotPasswordController>()
                          .verificationEmailController
                          .text,
                      name: "resend");
                },
                child: Text(
                  Strings.resend,
                  style: FontManager.regular(color: AppColors.buttonColor, 20),
                ),
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double sizedBoxHeight = 6.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 11.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Image.asset(Assets.imagesSplash),
                          ),
                          SizedBox(height: 3.h),
                          Text(Strings.welcome,
                              style: FontManager.semiBold(28),
                              textAlign: TextAlign.center),
                          Text(Strings.gladToSeeYou,
                              style: FontManager.medium(18,
                                  color: const Color(0xffB1B6B9)),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: sizedBoxHeight),
                  Text(Strings.emailLabel,
                      style: FontManager.regular(14, color: Colors.black)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.loginEmailController,
                    hintText: Strings.emailHint,
                    validator: AppValidation.validateEmail,
                    prefixIconImage: Image.asset(
                      Assets.imagesEmail,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.passwordLabel, style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  Obx(
                    () => CustomTextField(
                      controller: controller.loginPasswordController,
                      hintText: Strings.passwordHint,
                      prefixIconImage: Image.asset(
                        Assets.imagesPassword,
                        height: 20,
                        width: 20,
                      ),
                      obscureText: controller.isLoginPasswordVisible.value,
                      validator: AppValidation.validatePassword,
                      showSuffixIcon: true,
                      onSuffixIconPressed: () {
                        controller.isLoginPasswordVisible.value =
                            !controller.isLoginPasswordVisible.value;
                      },
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Checkbox(
                          activeColor: AppColors.buttonColor,
                          value: controller.isRememberChecked.value,
                          onChanged: (bool? newValue) {
                            controller.isRememberChecked.value =
                                newValue ?? false;
                          },
                          side:
                              const BorderSide(color: AppColors.texFiledColor),
                        ),
                      ),
                      Text(
                        Strings.rememberMe,
                        style: FontManager.regular(color: AppColors.black, 12),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.forgetPage),
                        child: Text(
                          Strings.forgetPassword,
                          style: FontManager.medium(
                              color: AppColors.buttonColor, 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  CommonButton(
                    title: Strings.login,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState!.save();
                        sizedBoxHeight = 6.h;
                        controller.login();
                      } else {
                        setState(() {
                          sizedBoxHeight = 1.h;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 0.5.h),
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.imagesOr,
                              height: 6.h,
                              width: 50.w,
                            )
                          ]),
                      SizedBox(height: 0.5.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                print("zazazazaazaaazza");
                                await controller.signInWithGoogle();
                              },
                              child: Image.asset(
                                Assets.imagesGoogleIcon,
                                height: 6.h,
                                width: 20.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(height: 2.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.dontHaveAccount,
                              style: FontManager.regular(15,
                                  color: AppColors.black),
                            ),
                            TextSpan(
                              style: FontManager.semiBold(15,
                                  color: AppColors.buttonColor),
                              text: Strings.signUp,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(Routes.signup),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Form(
            key: signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 11.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Image.asset(Assets.imagesSplash),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            Strings.createAccount,
                            style: FontManager.semiBold(28),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 6.5.h),
                          Obx(() {
                            return controller.imageFile.value != null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: AppColors.buttonColor),
                                      image: DecorationImage(
                                          image: FileImage(
                                            File(controller
                                                .imageFile.value!.path),
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  )
                                : Image.asset(
                                    Assets.imagesProfile,
                                    height: 13.1.h,
                                    width: 30.w,
                                  );
                          }),
                          SizedBox(height: 2.h),
                          GestureDetector(
                            onTap: () async {
                              controller.pickProfileImage(ImageSource.gallery);
                            },
                            child: Container(
                              height: 5.2.h,
                              width: 141,
                              decoration: const BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius:
                                    BorderRadius.all(AppRadius.radius10),
                              ),
                              child: Center(
                                child: Text(
                                  Strings.addProfileImage,
                                  style: FontManager.medium(15.sp,
                                      color: AppColors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(Strings.nameLabel, style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: Strings.nameHint,
                    prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                        width: 20, height: 20),
                    validator: AppValidation.validateName,
                    onSaved: (value) => controller.name.value = value!,
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.mobileNumberLabel,
                      style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.mobileController,
                    keyboardType: TextInputType.number,
                    hintText: Strings.mobileNumberHint,
                    prefixIconImage:
                        Image.asset(Assets.imagesPhone, width: 20, height: 20),
                    validator: AppValidation.validateMobile,
                    onSaved: (value) => controller.mobile.value = value!,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    Strings.emailLabel,
                    style: FontManager.regular(14, color: Colors.black),
                  ),
                  SizedBox(height: 0.5.h),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: Strings.emailHint,
                    validator: AppValidation.validateEmail,
                    onChanged: (value) => controller.email.value = value,
                    prefixIconImage: Image.asset(
                      Assets.imagesEmail,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(Strings.passwordLabel, style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        hintText: Strings.passwordHint,
                        prefixIconImage: Image.asset(
                          Assets.imagesPassword,
                          height: 20,
                          width: 20,
                        ),
                        obscureText: controller.isSignUpPasswordVisible.value,
                        validator: AppValidation.validatePassword,
                        onSaved: (value) => controller.password.value = value!,
                        showSuffixIcon: true,
                        onSuffixIconPressed: () {
                          controller.isSignUpPasswordVisible.value =
                              !controller.isSignUpPasswordVisible.value;
                        },
                      )),
                  SizedBox(height: 3.h),
                  Text(Strings.confirmPasswordLabel,
                      style: FontManager.regular(14)),
                  SizedBox(height: 0.5.h),
                  Obx(() => CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: Strings.confirmPasswordHint,
                        prefixIconImage: Image.asset(
                          Assets.imagesPassword,
                          height: 20,
                          width: 20,
                        ),
                        onSaved: (value) =>
                            controller.confirmPassword.value = value!,
                        obscureText: controller.isConfirmPasswordVisible.value,
                        showSuffixIcon: true,
                        onSuffixIconPressed: () {
                          controller.isConfirmPasswordVisible.value =
                              !controller.isConfirmPasswordVisible.value;
                        },
                      )),
                  SizedBox(height: 11.9.h),
                  CommonButton(
                    title: Strings.signUp,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (signUpFormKey.currentState!.validate()) {
                        signUpFormKey.currentState!.save();
                        debugPrint('qqqqqqqqqqqqqqqqq');
                        controller.signup();
                      }
                    },
                  ),
                  SizedBox(height: 5.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.alreadyHaveAccount,
                              style: FontManager.regular(14),
                            ),
                            TextSpan(
                              text: ' ${Strings.login}',
                              style: FontManager.semiBold(14,
                                  color: AppColors.buttonColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.login);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Assets {
  Assets._();

  static const String fontsOFL = 'assets/fonts/OFL.txt';
  static const String fontsPoppinsBlack = 'assets/fonts/Poppins-Black.ttf';
  static const String fontsPoppinsBlackItalic = 'assets/fonts/Poppins-BlackItalic.ttf';
  static const String fontsPoppinsBold = 'assets/fonts/Poppins-Bold.ttf';
  static const String fontsPoppinsBoldItalic = 'assets/fonts/Poppins-BoldItalic.ttf';
  static const String fontsPoppinsExtraBold = 'assets/fonts/Poppins-ExtraBold.ttf';
  static const String fontsPoppinsExtraBoldItalic = 'assets/fonts/Poppins-ExtraBoldItalic.ttf';
  static const String fontsPoppinsExtraLight = 'assets/fonts/Poppins-ExtraLight.ttf';
  static const String fontsPoppinsExtraLightItalic = 'assets/fonts/Poppins-ExtraLightItalic.ttf';
  static const String fontsPoppinsItalic = 'assets/fonts/Poppins-Italic.ttf';
  static const String fontsPoppinsLight = 'assets/fonts/Poppins-Light.ttf';
  static const String fontsPoppinsLightItalic = 'assets/fonts/Poppins-LightItalic.ttf';
  static const String fontsPoppinsMedium = 'assets/fonts/Poppins-Medium.ttf';
  static const String fontsPoppinsMediumItalic = 'assets/fonts/Poppins-MediumItalic.ttf';
  static const String fontsPoppinsRegular = 'assets/fonts/Poppins-Regular.ttf';
  static const String fontsPoppinsSemiBold = 'assets/fonts/Poppins-SemiBold.ttf';
  static const String fontsPoppinsSemiBoldItalic = 'assets/fonts/Poppins-SemiBoldItalic.ttf';
  static const String fontsPoppinsThin = 'assets/fonts/Poppins-Thin.ttf';
  static const String fontsPoppinsThinItalic = 'assets/fonts/Poppins-ThinItalic.ttf';
  static const String imagesAboutProfile = 'assets/images/aboutProfile.png';
  static const String imagesAdvanture2 = 'assets/images/advanture2.png';
  static const String imagesAdventure = 'assets/images/adventure.png';
  static const String imagesAirCondioner = 'assets/images/airCondioner.png';
  static const String imagesAny = 'assets/images/any.png';
  static const String imagesBathRooms = 'assets/images/bathRooms.png';
  static const String imagesBedAndBreakfast2 = 'assets/images/bedAndBreakfast2.png';
  static const String imagesBedRooms = 'assets/images/bedRooms.png';
  static const String imagesBedbreakfast = 'assets/images/bedbreakfast.png';
  static const String imagesBottomHome2 = 'assets/images/bottomHome2.png';
  static const String imagesBottomProfile = 'assets/images/bottomProfile.png';
  static const String imagesBottomProfile2 = 'assets/images/bottomProfile2.png';
  static const String imagesBottomTrip = 'assets/images/bottomTrip.png';
  static const String imagesBottomTrip2 = 'assets/images/bottomTrip2.png';
  static const String imagesBottomlisting = 'assets/images/bottomlisting.png';
  static const String imagesBottomlisting2 = 'assets/images/bottomlisting2.png';
  static const String imagesCallicon = 'assets/images/callicon.png';
  static const String imagesClock = 'assets/images/clock.png';
  static const String imagesCloseIcon = 'assets/images/closeIcon.png';
  static const String imagesCongratulation = 'assets/images/congratulation.png';
  static const String imagesDamageToProretiy = 'assets/images/damageToProretiy.png';
  static const String imagesDefualtProfile = 'assets/images/defualtProfile.png';
  static const String imagesDefultChart = 'assets/images/defultChart.png';
  static const String imagesDeleteVector = 'assets/images/deleteVector.png';
  static const String imagesDeletedialog = 'assets/images/deletedialog.png';
  static const String imagesDialogPassword = 'assets/images/dialogPassword.png';
  static const String imagesDialogemail = 'assets/images/dialogemail.png';
  static const String imagesDividecircle = 'assets/images/dividecircle.png';
  static const String imagesDividecircle2 = 'assets/images/dividecircle2.png';
  static const String imagesDropDaounIcon = 'assets/images/dropDaounIcon.png';
  static const String imagesDubleBed = 'assets/images/dubleBed.png';
  static const String imagesEcoFriendly2 = 'assets/images/ecoFriendly2.png';
  static const String imagesEcofriendly = 'assets/images/ecofriendly.png';
  static const String imagesEdit = 'assets/images/edit.png';
  static const String imagesEditCoverImage = 'assets/images/editCoverImage.png';
  static const String imagesEditHomestay = 'assets/images/editHomestay.png';
  static const String imagesEditcirculer = 'assets/images/editcirculer.png';
  static const String imagesEmail = 'assets/images/email.png';
  static const String imagesEmailicon = 'assets/images/emailicon.png';
  static const String imagesExtraFloor = 'assets/images/extraFloor.png';
  static const String imagesEyesDisable = 'assets/images/eyesDisable.png';
  static const String imagesEyesEneble = 'assets/images/eyesEneble.png';
  static const String imagesFacbookicon = 'assets/images/facbookicon.png';
  static const String imagesFaqsProfile = 'assets/images/faqsProfile.png';
  static const String imagesFeedBackProfile = 'assets/images/feedBackProfile.png';
  static const String imagesFilter = 'assets/images/filter.png';
  static const String imagesFilterslines = 'assets/images/Filterslines.png';
  static const String imagesFirAlarm = 'assets/images/firAlarm.png';
  static const String imagesGoogleIcon = 'assets/images/googleIcon.png';
  static const String imagesHToLowest = 'assets/images/hToLowest.png';
  static const String imagesHomeProgres2 = 'assets/images/homeProgres2.png';
  static const String imagesHomeProgres3 = 'assets/images/homeProgres3.png';
  static const String imagesHomeProgres4 = 'assets/images/homeProgres4.png';
  static const String imagesHomeProgress5 = 'assets/images/homeProgress5.png';
  static const String imagesHomeVector = 'assets/images/homeVector.png';
  static const String imagesHomestayProgres = 'assets/images/homestayProgres.png';
  static const String imagesHometherater = 'assets/images/hometherater.png';
  static const String imagesImageProgres6 = 'assets/images/imageProgres6.png';
  static const String imagesImageRectangle = 'assets/images/imageRectangle.png';
  static const String imagesImagesHomestayProgres1 = 'assets/images/imagesHomestayProgres1.png';
  static const String imagesInto1 = 'assets/images/into1.png';
  static const String imagesInto2 = 'assets/images/into2.png';
  static const String imagesInto3 = 'assets/images/into3.png';
  static const String imagesIntoarro = 'assets/images/intoarro.png';
  static const String imagesIntodesh = 'assets/images/intodesh.png';
  static const String imagesIntodesh2 = 'assets/images/intodesh2.png';
  static const String imagesIntodesh3 = 'assets/images/intodesh3.png';
  static const String imagesKitchen = 'assets/images/kitchen.png';
  static const String imagesLegalProfile = 'assets/images/legalProfile.png';
  static const String imagesListHome = 'assets/images/listHome.png';
  static const String imagesListHome2 = 'assets/images/listHome2.png';
  static const String imagesListHome3 = 'assets/images/listHome3.png';
  static const String imagesLocationIcon = 'assets/images/locationIcon.png';
  static const String imagesLocationsearchicon = 'assets/images/locationsearchicon.png';
  static const String imagesLogOutIcon = 'assets/images/logOutIcon.png';
  static const String imagesLogOutProfile = 'assets/images/logOutProfile.png';
  static const String imagesLtohighest = 'assets/images/ltohighest.png';
  static const String imagesLuxury = 'assets/images/luxury.png';
  static const String imagesLuxury2 = 'assets/images/luxury2.png';
  static const String imagesMapDefoulte = 'assets/images/MapDefoulte.png';
  static const String imagesMastrSuite = 'assets/images/mastrSuite.png';
  static const String imagesMaxGuests = 'assets/images/maxGuests.png';
  static const String imagesMinus = 'assets/images/minus.png';
  static const String imagesNoDrinking = 'assets/images/noDrinking.png';
  static const String imagesNoPet = 'assets/images/noPet.png';
  static const String imagesNoSmoking = 'assets/images/noSmoking.png';
  static const String imagesOr = 'assets/images/or.png';
  static const String imagesPassword = 'assets/images/password.png';
  static const String imagesPasswordProfile = 'assets/images/passwordProfile.png';
  static const String imagesPhone = 'assets/images/phone.png';
  static const String imagesPhoneProfile = 'assets/images/phoneProfile.png';
  static const String imagesPluscircle = 'assets/images/pluscircle.png';
  static const String imagesPluscircle2 = 'assets/images/pluscircle2.png';
  static const String imagesPrivateRoom = 'assets/images/privateRoom.png';
  static const String imagesProfile = 'assets/images/profile.png';
  static const String imagesProfileEdit = 'assets/images/profileEdit.png';
  static const String imagesQuestionDialog = 'assets/images/questionDialog.png';
  static const String imagesSearchIcon = 'assets/images/searchIcon.png';
  static const String imagesShare = 'assets/images/share.png';
  static const String imagesSignupProfile = 'assets/images/signup_profile.png';
  static const String imagesSingleBed = 'assets/images/singleBed.png';
  static const String imagesSplash = 'assets/images/splash.png';
  static const String imagesSuccessedit = 'assets/images/successedit.png';
  static const String imagesTermsProfile = 'assets/images/termsProfile.png';
  static const String imagesTraditional = 'assets/images/traditional.png';
  static const String imagesTv = 'assets/images/Tv.png';
  static const String imagesUploadImage = 'assets/images/uploadImage.png';
  static const String imagesUrban = 'assets/images/urban.png';
  static const String imagesUrban2 = 'assets/images/urban2.png';
  static const String imagesWiFi = 'assets/images/wiFi.png';

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
  static const String location = '/location';
  static const String previewPage = '/previewPage';
  static const String termsAndCondition = '/termsAndCondition';
  static const String yourPropertiesPage = '/yourPropertiesPage';
  static const String detailsYourProperties = '/detailsYourProperties';
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
  static const String termsAndConditionProfilePage = '/termsAndConditionProfilePage';
  static const String travelingDetailsPage = '/travelingDetailsPage';
  static const String hostingDetailsPage = '/hostingDetailsPage';

  static List<GetPage> get routes {
    return [
      GetPage(name: splash, page: () => const SplashPage()),
      GetPage(name: onboarding, page: () => const OnboardingPage()),
      GetPage(name: signup, page: () => const SignupPage()),
      GetPage(name: login, page: () => const LoginPage()),
      GetPage(name: forgetPage, page: () => const ForgetPassword()),
      GetPage(
          name: verificationPage, page: () => const VerificationCodeScreen()),
      GetPage(name: resetPage, page: () => const ResetPasswordScreen()),
      GetPage(name: listHomestayPage1, page: () => const ListHomestayPages()),
      GetPage(
          name: addPropertiesScreen,
          page: () => AddPropertiesScreen(index: Get.arguments['index'] ?? 0)),
      GetPage(name: location, page: () => const LocationView()),
      GetPage(name: previewPage, page: () => const PreviewPage()),
      GetPage(
          name: termsAndCondition, page: () => const TermsAndConditionPage()),
      GetPage(name: yourPropertiesPage, page: () => const YourPropertiesPage()),
      GetPage(name: detailsYourProperties, page: () => const DetailsPage()),
      GetPage(name: bottomPages, page: () => const BottomNavigationPage()),
      GetPage(
          name: travelingDetailsPage, page: () => const HomeStayDetailsPage()),
      GetPage(name: filterPage, page: () => const FilterPage()),
      GetPage(name: search, page: () => const SearchPage()),
      GetPage(name: checkInOutDatePage, page: () => const CheckinoutdatePage()),
      GetPage(name: hostingDetailsPage, page: () => const HostingDetailsPage()),
      GetPage(name: bookingRequestPage, page: () => const BookingRequestPage()),
      GetPage(name: editProfilePage, page: () => const EditProfilePage()),
      GetPage(name: contactusPage, page: () => const ContactusPage()),
      GetPage(name: changePasswordPage, page: () => const ChangePasswordPage()),
      GetPage(name: feedbackPage, page: () => const FeedbackPage()),
      GetPage(name: aboutUsPage, page: () => const AboutUsPage()),
      GetPage(name: faqsPage, page: () => const FaqsPage()),
      GetPage(name: termsAndConditionProfilePage, page: () => const TermsAndConditionProfilePage()),
    ];
  }
}

// booking model single 
{
    "message": "Single Homestay Booking Fetch Successfully !",
    "Booking": {
        "_id": "6729d9fc2c7486a4f9f2dd31",
        "userDetail": {
            "profileImage": {
                "public_id": "TRAVELLERY/USERS/1730089877704-518407201Blue Doe",
                "url": "https://res.cloudinary.com/dv754tbcp/image/upload/v1730089879/TRAVELLERY/USERS/1730089877704-518407201Blue%20Doe.png"
            },
            "_id": "671f1397473b185ba38a18ed",
            "name": "Blue Doe",
            "mobile": "9875456545",
            "email": "bluedoe@gmail.com",
            "password": "$2b$10$sfElxsr.JkupdfCdmDFS.OGMkD9Jht8uUiwtpvrx6XZ4B8IKRIYNW",
            "deviceToken": "BlueDoeDeviceToken",
            "userType": "user",
            "createdAt": "2024-10-28T04:31:19.202Z",
            "updatedAt": "2024-10-28T04:34:37.028Z",
            "__v": 0
        },
        "homestayDetail": {
            "accommodationDetails": {
                "entirePlace": false,
                "privateRoom": true,
                "maxGuests": 4,
                "bedrooms": 2,
                "singleBed": 2,
                "doubleBed": 1,
                "extraFloorMattress": 0,
                "bathrooms": 1,
                "kitchenAvailable": false
            },
            "coverPhoto": {
                "public_id": "TRAVELLERY/HOMESTAY/COVER_IMAGES/1728996783023-370524616Hstay6",
                "url": "https://res.cloudinary.com/dv754tbcp/image/upload/v1728996785/TRAVELLERY/HOMESTAY/COVER_IMAGES/1728996783023-370524616Hstay6.png"
            },
            "_id": "670e2eeab76cf96336d8dab6",
            "title": "Homestay 4",
            "homestayType": "Urban",
            "amenities": [
                {
                    "name": "Wi-Fi",
                    "isChecked": true,
                    "isNewAdded": false,
                    "_id": "670e2eeab76cf96336d8dab7"
                },
                {
                    "name": "Fire alaram",
                    "isChecked": true,
                    "isNewAdded": false,
                    "_id": "670e2eeab76cf96336d8dab8"
                },
                {
                    "name": "Home Theater",
                    "isChecked": true,
                    "isNewAdded": true,
                    "_id": "670e2eeab76cf96336d8dab9"
                }
            ],
            "houseRules": [
                {
                    "name": "No Smoking",
                    "isChecked": true,
                    "isNewAdded": false,
                    "_id": "670e2eeab76cf96336d8daba"
                },
                {
                    "name": "No Pets",
                    "isChecked": true,
                    "isNewAdded": false,
                    "_id": "670e2eeab76cf96336d8dabb"
                },
                {
                    "name": "Damage to Propety",
                    "isChecked": true,
                    "isNewAdded": true,
                    "_id": "670e2eeab76cf96336d8dabc"
                }
            ],
            "checkInTime": "06:00 PM",
            "checkOutTime": "06:00 AM",
            "flexibleCheckIn": false,
            "flexibleCheckOut": false,
            "longitude": 72.88692069643963,
            "latitude": 21.245049600735083,
            "address": "C.401",
            "street": "Priyank Palace",
            "landmark": "Sudama Chowk",
            "city": "mumbai",
            "pinCode": "394101",
            "state": "Gujrat",
            "showSpecificLocation": false,
            "homestayPhotos": [
                {
                    "public_id": "TRAVELLERY/HOMESTAY/HOMESTAY_IMAGES/1728996961728-797098004img2",
                    "url": "https://res.cloudinary.com/dv754tbcp/image/upload/v1728996964/TRAVELLERY/HOMESTAY/HOMESTAY_IMAGES/1728996961728-797098004img2.png",
                    "_id": "670e2eeab76cf96336d8dabd"
                },
                {
                    "public_id": "TRAVELLERY/HOMESTAY/HOMESTAY_IMAGES/1728996961729-977454950pexels-eberhardgross-1366919",
                    "url": "https://res.cloudinary.com/dv754tbcp/image/upload/v1728996964/TRAVELLERY/HOMESTAY/HOMESTAY_IMAGES/1728996961729-977454950pexels-eberhardgross-1366919.jpg",
                    "_id": "670e2eeab76cf96336d8dabe"
                }
            ],
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "basePrice": 5000,
            "weekendPrice": 6000,
            "ownerContactNo": "9876545645",
            "ownerEmailId": "Owner@gmail.com",
            "homestayContactNo": [
                {
                    "contactNo": "1415-123-4567",
                    "_id": "670e2eeab76cf96336d8dabf"
                },
                {
                    "contactNo": "2415-123-4567",
                    "_id": "670e2eeab76cf96336d8dac0"
                },
                {
                    "contactNo": "3415-123-4567",
                    "_id": "670e2eeab76cf96336d8dac1"
                }
            ],
            "homestayEmailId": [
                {
                    "EmailId": "Testing@example.com",
                    "_id": "670e2eeab76cf96336d8dac2"
                },
                {
                    "EmailId": "Testing@example.com",
                    "_id": "670e2eeab76cf96336d8dac3"
                },
                {
                    "EmailId": "sdsd@example.com",
                    "_id": "670e2eeab76cf96336d8dac4"
                }
            ],
            "status": "Rejected",
            "createdBy": "6708a92dafec72bf5fa081d8",
            "createdAt": "2024-10-15T08:59:22.439Z",
            "updatedAt": "2024-11-18T04:53:20.512Z",
            "__v": 0
        },
        "checkInDate": "2024-11-06T00:00:00.000Z",
        "checkOutDate": "2024-11-07T00:00:00.000Z",
        "adults": 10,
        "children": 5,
        "infants": 2,
        "totalDaysOrNightsPrice": 3000,
        "taxes": 33,
        "serviceFee": 300,
        "totalAmount": 3333,
        "paymentMethod": "PayPal",
        "paymentStatus": "Confirmed",
        "reservationConfirmed": true,
        "createdAt": "2024-11-05T08:40:28.174Z",
        "updatedAt": "2024-11-05T08:40:28.174Z",
        "__v": 0
    }
}
