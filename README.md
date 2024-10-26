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
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../api_helper/api_helper.dart';
import '../../../api_helper/getit_service.dart';
import '../../../common_widgets/common_dialog.dart';
import '../../../routes_app/all_routes_app.dart';
import '../../../services/storage_services.dart';
import '../../../utils/app_string.dart';
import '../data/models/model.dart';
import 'package:dio/dio.dart' as dio;
import '../data/repository/auth_repository.dart';
import '../login_page/model/login_model.dart';

class AuthController extends GetxController {
  var authRepository = getIt<AuthRepository>();
  var apiHelper = getIt<ApiHelper>();

  var name = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoginPasswordVisible = true.obs;
  RxBool isSignUpPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool isResetPasswordVisible = true.obs;
  RxBool isResetConfirmPasswordVisible = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController verificationController = TextEditingController();
  TextEditingController forgotConfirmedNewPasswordController = TextEditingController();
  TextEditingController forgotNewPasswordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    verificationController.dispose();
    super.onClose();
  }

  Rx<CroppedFile?> imageFile = Rx<CroppedFile?>(null);
  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.buttonColor,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(),
            ],
          ),
          WebUiSettings(
            context: Get.context!,
            size: CropperSize(width: 500, height: 500),
            dragMode: WebDragMode.crop,
            modal: true,
            guides: true,
            center: true,
            highlight: true,
            background: true,
            movable: true,
            rotatable: true,
            scalable: true,
            zoomable: true,
            zoomOnTouch: true,
            zoomOnWheel: true,
            wheelZoomRatio: 0.1,
            cropBoxMovable: true,
            cropBoxResizable: true,
            toggleDragModeOnDblclick: true,
            presentStyle: WebPresentStyle.dialog,
          ),
        ],
      );

      if (croppedFile != null) {
        imageFile.value = croppedFile;
      }
    }
  }

  Widget loadingDialog() {
    return Center(
      child: CircularProgressIndicator(color: AppColors.greyText,),
    );
  }

  void showLoading() {
    isLoading.value = true;
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: loadingDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    isLoading.value = false;
    Get.back();
  }
  Future<void> signup() async {
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        mobile.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        imageFile.value!.path.isNotEmpty) {
      showLoading();
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
      nameController.text = '';
      mobileController.text = '';
      emailController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';
      hideLoading();
      Get.toNamed(Routes.login);
      Get.snackbar('Success', 'User registered successfully');
    } else {
      Get.snackbar(Strings.error, 'All fields are required');
    }
  }

  void login() {
    print('1111111111${loginEmailController.text}');
    print('1111111111${loginPasswordController.text}');

    Map<String, dynamic> loginData = {
      "email": loginEmailController.text,
      "password": loginPasswordController.text
    };
    if (loginEmailController.text.isNotEmpty ||
        loginPasswordController.text.isNotEmpty) {
      showLoading();

      authRepository.userLogin(loginData: loginData).then(
        (value) {
          hideLoading();
          print('vvvvvvvvvvvvv_________${value}');
          final loginModel = LoginModel.fromJson(value);
          if (loginModel.token != null) {

            getIt<StorageServices>().setUserToken(loginModel.token);
            getIt<StorageServices>().getUserToken();

            Get.snackbar('Success', 'Login Successful');
            Get.toNamed(Routes.listHomestayPage1);
            loginEmailController.text = '';
            loginPasswordController.text = '';
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

  onResendOtpButtonClick({
    required String email,
  }) {
    CustomDialog.showCustomDialog(
      title: Strings.checkYouEmail,
      message: Strings.theEmailHasBeenResent,
      imageAsset: Assets.imagesDialogemail,
      buttonLabel: Strings.verify,
      changeEmailLabel: Strings.changeEmail,
      onResendPressed: () {
        Get.toNamed(Routes.verificationPage);
      },
      onChangeEmailPressed: () {
        Get.back();
      },
      context: Get.context,
    );
  }

  onResetPasswordButtonClick() {
    CustomDialog.showCustomDialog(
      context: Get.context,
      title: Strings.passwordUpdate,
      message: Strings.thepasswordChange,
      imageAsset: Assets.imagesDialogPassword,
      buttonLabel: Strings.login,
      onResendPressed: () {
        Get.toNamed(Routes.login);
      },
    );
  }

  void sendVerificationCode({required String email}) {
    showLoading();
    authRepository.forgotPassword(email: email).then(
      (value) {
        hideLoading();
        Get.snackbar('OTP', 'OTP Sent Successfully !');
        onResendOtpButtonClick(email: email);
      },
    );
  }

  void verifyVerificationCode() {
    showLoading();
    Map<String, dynamic> data = {
      "otp": verificationController.text,
      "email": forgotPasswordEmailController.text,
    };
      authRepository.verifyOtp(userData: data).then((value) {
        hideLoading();
        Get.snackbar('OTP', "OTP Verified Sucessfully !");
        Get.offNamed(Routes.resetPage);
      },
    );
  }

  void resetPassword(){
    showLoading();
    Map<String, dynamic> data = {
      "email": forgotPasswordEmailController.text,
      "new_password": forgotNewPasswordController.text,
      "confirm_password": forgotConfirmedNewPasswordController.text,
    };

    authRepository.resetPassword(resetData: data).then((value) {
      hideLoading();
      Get.snackbar("","Password Reset Sucessfully !");
      onResetPasswordButtonClick();
    },);
  }
}


class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
 import 'package:travellery_mobile/travellery_mobile/api_helper/api_helper.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../api_helper/api_uri.dart';
import '../../../../api_helper/getit_service.dart';

class AuthRepository{
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();


  Future<Map<String, dynamic>> registerUser(
      {required dio.FormData formData}) async {
    dio.Response? response = await apiProvider.postFormData(
      "${apiURLs.baseUrl}${apiURLs.signupUrl}",
      data: formData,

    );
    Map<String, dynamic> data = response?.data;
    return data;
  }


  Future<Map<String, dynamic>> userLogin({required Map<String, dynamic> loginData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.loginUrl}",
      data: loginData,
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

  Future<Map<String, dynamic>> verifyOtp({required Map<String, dynamic> userData}) async {
    dio.Response? response = await apiProvider.postData(
      "${apiURLs.baseUrl}${apiURLs.verifyUrl}",
      data: userData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
  }


  Future<Map<String, dynamic>> resetPassword({required Map<String, dynamic> resetData}) async {
    dio.Response? response = await apiProvider.putData(
      "${apiURLs.baseUrl}${apiURLs.resetPasswordUrl}",
      data: resetData,
    );
    Map<String, dynamic> data = response?.data;
    return data;
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
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../utils/textFormField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();
  double sizedBoxHeight = 6.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.emailEmpty;
                    } else if (!GetUtils.isEmail(value)) {
                      return Strings.invalidEmail;
                    }
                    return null;
                  },
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
                Obx(
                  () => CustomTextField(
                    controller: controller.loginPasswordController,
                    hintText: Strings.passwordHint,
                    prefixIconImage: Image.asset(
                      Assets.imagesPassword,
                      height: 20,
                      width: 20,
                    ),
                    obscureText: !controller.isLoginPasswordVisible.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.passwordError;
                      } else if (value.length < 6) {
                        return Strings.passwordLengthError;
                      }
                      return null;
                    },
                    onSaved: (value) => controller.password.value = value!,
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
                        value: controller.isChecked.value,
                        onChanged: (bool? newValue) {
                          controller.isChecked.value = newValue ?? false;
                        },
                        side: const BorderSide(color: AppColors.texFiledColor),
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
                CommonButton(title: Strings.login, onPressed: onLogin),
                SizedBox(height: 0.5.h),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        Assets.imagesOr,
                        height: 6.h,
                        width: 50.w,
                      )
                    ]),
                    SizedBox(height: 0.5.h),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        Assets.imagesGoogleIcon,
                        height: 6.h,
                        width: 20.w,
                        fit: BoxFit.cover,
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
                            style:
                                FontManager.regular(15, color: AppColors.black),
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
                SizedBox(height: 33),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin() {
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
  }
}

import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/generated/assets.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../utils/textFormField.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Form(
          key: _formKey,
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                              border: Border.all(
                                  color: AppColors.buttonColor),
                              image: DecorationImage(
                                  image: FileImage(
                                    File(
                                        controller.imageFile.value!.path),
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    Strings.chooseImageSource,
                                    style: FontManager.regular(20),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.camera,
                                          ),
                                          title: Text(Strings.camera),
                                          onTap: () {
                                            controller
                                                .pickImage(ImageSource.camera);
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo),
                                          title: Text(Strings.gallery),
                                          onTap: () {
                                            controller
                                                .pickImage(ImageSource.gallery);
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(Strings.cancel),
                                    ),
                                  ],
                                );
                              },
                            );
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
                  validator: (value) {
                    if (value!.isEmpty) {

                      return Strings.nameError;
                    }
                    return null;
                  },
                  onSaved: (value) => controller.name.value = value!,
                ),
                SizedBox(height: 3.h),
                Text(Strings.mobileNumberLabel, style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.mobileController,
                  keyboardType: TextInputType.number,
                  hintText: Strings.mobileNumberHint,
                  prefixIconImage:
                  Image.asset(Assets.imagesPhone, width: 20, height: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.mobileNumberError;
                    } else if (value.length < 10) {
                      return Strings.mobileNumberLengthError;
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.emailEmpty;
                    } else if (!GetUtils.isEmail(value)) {
                      return Strings.invalidEmail;
                    }
                    return null;
                  },
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
                  obscureText: !controller.isSignUpPasswordVisible.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.passwordError;

                    } else if (value.length < 6) {
                      return Strings.passwordLengthError;
                    }
                    return null;
                  },
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
                  onSaved:(value) => controller.confirmPassword.value = value!,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.confirmPasswordError;
                    } else if ( controller.confirmPasswordController.text != controller.passwordController.text) {
                      return Strings.passwordMatchError;
                    }
                    return null;
                  },
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
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
    );
  }
}

import 'package:dio/dio.dart';

import '../services/storage_services.dart';
import 'getit_service.dart';

class CustomTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = getIt<StorageServices>().getUserToken();
    if (token != "") {
      print("*********************************");
      options.headers["Authorization"] = "Bearer $token";

    } else {}

    handler.next(options);
  }
}
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:travellery_mobile/travellery_mobile/api_helper/api_helper.dart';
import '../screen/add_properties_screen/steps/data/repository/homestay_repository.dart';
import '../services/storage_services.dart';
import 'api_uri.dart';
import 'dio_interceptors.dart';
import '../screen/auth_flow/data/repository/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<APIUrls>(() => APIUrls());
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getDioInstance()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<HomeStayRepository>(() => HomeStayRepository());
  getIt.registerLazySingleton<StorageServices>(() => StorageServices());



}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile/travellery_mobile/api_helper/getit_service.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';

import '../screen/auth_flow/login_page/model/login_model.dart';


class CustomErrorHandlerInterceptor extends Interceptor {
  CustomErrorHandlerInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioExceptions.fromDioError(err);
    print('33333333333333333${err}');
    return super.onError(err, handler);
  }

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  //   // Retrieve the stored login model
  //   LoginModel? storedLoginModel = await getIt<StoreService>().getLoginModel(key: StoreKeys.logInData);
  //
  //   // Print the token for debugging
  //   print("token value :: ${storedLoginModel?.result?.token}");
  //
  //   // Check if the token is not null or empty
  //   if (storedLoginModel?.result?.token != null &&
  //       storedLoginModel!.result!.token.isNotEmpty) {
  //     options.headers['Authorization'] = 'Bearer ${storedLoginModel.result.token}';
  //     options.headers['Content-Type'] = 'application/json';
  //   }
  //
  //   // Proceed with the request
  //   return handler.next(options);
  // }
}

class DioExceptions implements Exception {
  late String message;
  late int statusCode;

  DioExceptions.fromDioError(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final responseMessage = dioError.response?.statusMessage;
    final errorMessage = dioError.response?.data["message"];
    final token = dioError.response?.data["token"];
    print("token------------");
    Get.find<AuthController>().hideLoading();
    print('ooo===${dioError.type}');
    switch (dioError.type) {
      case DioExceptionType.badResponse:
        print('2222222222222${dioError.type}');
        message =  dioError.response?.data['message'] ?? "An error occurred.";
        Get.snackbar("Error", errorMessage);
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        message = dioError.message ?? "An unknown error occurred.";
        if (dioError.response != null) {
          print('Response data: ${dioError.response?.data}');
        }

        break;
      default:
        print("----------------############");
        message = _handleError(
          statusCode,
          dioError.response?.data,
        );
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 422:
        return '422 Unprocessable Content';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:travellery_mobile/travellery_mobile/api_helper/token.dart';
import 'error_handler_intercaptor.dart';
import 'getit_service.dart';

Dio getDioInstance() {
  Dio dio = getIt<Dio>();
  dio.interceptors.add(CustomErrorHandlerInterceptor());
  dio.interceptors.add(CustomTokenInterceptor());
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: true,
      filter: (options, args) {
        if (options.path.contains('/posts')) {
          return false;
        }
        return !args.isResponse || !args.hasUint8ListData;
      }
    )
  );

  dio.interceptors.add(PrettyDioLogger());
  return dio;
}
import 'package:dio/dio.dart';
import 'package:travellery_mobile/travellery_mobile/api_helper/api_uri.dart';
import 'getit_service.dart';

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
    } catch (error) {}
  }


  Future postData(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } catch (error) {}
  }

  Future putData(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(url, data: data);
      return response;
    } catch (error) {}
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/data/repository/homestay_repository.dart';
import '../../../../api_helper/api_helper.dart';
import '../../../../api_helper/getit_service.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_string.dart';

class AddPropertiesController extends GetxController {
  var currentPage = 1.obs;
  RxString homestayTitle = ''.obs;
  var selectedType = ''.obs;
  var selectedTypeImage = ''.obs;
  var selectedAccommodation = ''.obs;
  var selectedAccommodationImage = ''.obs;
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

  bool canGoToNextPage() {
    return isCurrentPageValid();
  }

  void nextPage() {
    if (currentPage.value < 8) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  void backPage() {
    if (currentPage.value > 1) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.toNamed(Routes.listHomestayPage1);
    }
  }

  // homestayTitle Page Logic

  TextEditingController homeStayTitleController = TextEditingController();

  void setTitle(String title) {
    homestayTitle.value = title;
    update();
  }

  // homestayType Page Logic
  void selectHomeStayType(String index,String image) {
    selectedType.value = index;
    selectedTypeImage.value = image;
    update();
  }

  bool isHomeStayTypeSelected(String index) {
    return selectedType.value == index;
  }

  // Accommodation Page Logic
  void selectAccommodation(String value,String image) {
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

  RxList<bool> selectedAmenities = List.generate(7, (index) => false).obs;
  TextEditingController amenitiesName = TextEditingController();
  List<TextEditingController> textControllers = [];
  var amenities = <String>[].obs;

  void addAmenity(String amenityName) {
    amenities.add(amenityName);
    selectedAmenities.add(true);
    textControllers.add(TextEditingController());
  }

  void removeAmenity(int index) {
    if (index < amenities.length) {
      if (index < textControllers.length) {
        textControllers[index].dispose();
        textControllers.removeAt(index);
      }
      amenities.removeAt(index);
      selectedAmenities.removeAt(index);
    }
  }

  void toggleAmenity(int index) {
    if (index >= 0 && index < selectedAmenities.length) {
      selectedAmenities[index] = !selectedAmenities[index];
      update();
    }
  }

  // House Rules and New Rules Logic
  RxList<bool> selectedRules = List.generate(10, (index) => false).obs;
  TextEditingController rulesName = TextEditingController();
  List<TextEditingController> rulesTextControllers = [];
  var rules = <String>[].obs;

  void addRules(String amenityName) {
    rules.add(amenityName);
    selectedRules.add(true);
    rulesTextControllers.add(TextEditingController());
  }

  void removeRules(int index) {

    if (index < rules.length) {
      if (index < textControllers.length) {
        rules.removeAt(index);
        rulesTextControllers.removeAt(index);
      }
      rules.removeAt(index);
      selectedRules.removeAt(index);
    }
  }

  void toggleRules(int index) {
    if (index >= 0 && index < selectedRules.length) {
      selectedRules[index] = !selectedRules[index];
      update();
    }
  }

  // Check - in/ut details page logic

  var flexibleWithCheckInTime = false.obs;
  var flexibleWithCheckInOut = false.obs;
  Rx<DateTime> checkInTime = DateTime.now().obs;
  Rx<DateTime> checkOutTime = DateTime.now().obs;

  void checkInTimeUpdate(var value){
    flexibleWithCheckInTime.value = value;
    update();
  }

  void checkOutTimeUpdate(var value){
    flexibleWithCheckInOut.value = value;
    update();
  }

  // location page add logic


  // Address page add logic
  var address = ''.obs;
  var streetAddress = ''.obs;
  var landmark = ''.obs;
  var city = ''.obs;
  var pinCode = ''.obs;
  var state = ''.obs;
  var isSpecificLocation = false.obs;

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

  var imagePaths = List<String?>.filled(7, null).obs;

  // description Page add logic
  var description = ''.obs;

  void setDescription(String value) {
    description.value = value;
    update();
  }

  // Price and Contact details page logic

  var startPrice = ''.obs;
  var endPrice = ''.obs;
  var ownerContactNumber = ''.obs;
  var ownerEmail = ''.obs;
  var homeStayContactNumbers = [].obs;
  var homeStayEmails = <Strings>[].obs;

  // api add data
   Future<void> homeStayAddData() async {

     dio.FormData formData = dio.FormData.fromMap({
       "title": homestayTitle.value,
       "homestayType": selectedType.value,
       "accommodationDetails": jsonEncode({
         "entirePlace": selectedAccommodation.value == 'entirePlace',
         "privateRoom": selectedAccommodation.value == 'privateRoom',
         "maxGuests": maxGuestsCount.value,
         "bedrooms": bedroomsCount.value,
         "singleBed": singleBedCount.value,
         "doubleBed": doubleBedCount.value,
         "extraFloorMattress": extraFloorCount.value,
         "bathrooms": bathRoomsCount.value,
         "kitchenAvailable": isKitchenAvailable.value,
       }),
       "amenities":jsonEncode(amenities.map((amenity) => {
         "name": amenity,
         "isChecked": selectedAmenities[amenities.indexOf(amenity)],
         "isNewAdded": true,
       },).toList()),
       "houseRules":jsonEncode(rules.map((rule) => {
         "name": rules,
         "isChecked": true,
         "isNewAdded": true,
       }).toList()),
       "checkInTime": checkInTime.value,
       "checkOutTime": checkOutTime.value,
       "flexibleCheckIn": flexibleWithCheckInTime.value,
       "flexibleCheckOut": flexibleWithCheckInOut.value,
       "longitude": "72.88692069643963",
       "latitude": "21.245049600735083",
       "address": "uuihrhg",
       "street": "qewred",
       "landmark": "jdbhdhfgb",
       "city": city.value,
       "pinCode": 234567,
       "state": state.value,
       "showSpecificLocation": false,
       "description": description.value,
       "basePrice": 20000,
       "weekendPrice": 100000,
       "ownerContactNo": 3000000,
       "ownerEmailId": 6000000,
       "homestayContactNo": homeStayContactNumbers.map((contact) => {
         "contactNo": contact,
       }).toList(),
       "homestayEmailId": homeStayEmails.map((email) => {
         "EmailId": email,
       }).toList(),
       "status": "Draft",
       "createdBy": "671777327fb924f8aaa26f72",
     });

     homeStayRepository.homeStayData(formData: formData).then((value) {
       Get.snackbar('', 'Homestay Data created successfully!');
      },);
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
        return  selectedRules.contains(true);
      case 6:
        return flexibleWithCheckInTime.value && flexibleWithCheckInOut.value == true;
      case 7:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 8:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 9:
        return description.value.isNotEmpty;
      case 10:
        return startPrice.value.isNotEmpty;
      default:
        return false;
    }
  }
}

import 'package:dio/dio.dart' as dio;
import '../../../../../api_helper/api_helper.dart';
import '../../../../../api_helper/api_uri.dart';
import '../../../../../api_helper/getit_service.dart';

class HomeStayRepository {
  var apiProvider = getIt<ApiHelper>();
  var apiURLs = getIt<APIUrls>();


  Future<Map<String, dynamic>> homeStayData(
      {required dio.FormData formData}) async {
    dio.Response? response = await apiProvider.postFormData(
      "${apiURLs.baseUrl}${apiURLs.homeStayUrl}",
      data: formData,

    );
    Map<String, dynamic> data = response?.data;
    return data;
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';

class NewAmenitiesPages extends StatefulWidget {
  const NewAmenitiesPages({super.key});

  @override
  State<NewAmenitiesPages> createState() => _NewAmenitiesPagesState();
}

class _NewAmenitiesPagesState extends State<NewAmenitiesPages> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

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
                    Strings.newAmenities,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              buildTitleStep(controller.currentPage.value.toString()),
              amenitiesList(),
              SizedBox(height: 2.h),
              addTextField(),
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
                      title: Strings.done,
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

  Widget addTextField() {
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
            Obx(() =>  Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                  child: TextFormField(
                    controller: controller.amenitiesName,
                    style: FontManager.regular(16),
                    decoration: InputDecoration(
                      hintText: "Amenity ${controller.amenities.length + 1}",
                      hintStyle:
                          FontManager.regular(16, color: AppColors.greyText),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          final String newAmenity =
                              controller.amenitiesName.text.trim();
                          if (newAmenity.isNotEmpty) {
                            controller.addAmenity(newAmenity);
                            controller.amenitiesName.clear();
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
            ),
          ],
        ),
      ),
    );
  }

  Widget amenitiesList() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.amenities.length,
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
                      controller.amenities[index],
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.removeAmenity(index);
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../controller/add_properties_controller.dart';

class NewRulesPages extends StatefulWidget {
  const NewRulesPages({super.key});

  @override
  State<NewRulesPages> createState() => _NewRulesPagesState();
}

class _NewRulesPagesState extends State<NewRulesPages> {
  final AddPropertiesController controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:  Padding(
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
                    Strings.newRules,
                    style: FontManager.medium(20, color: AppColors.black),
                  ),
                ],
              ),
              Obx(() =>
                  buildTitleStep(controller.currentPage.value.toString())),
              amenitiesList(),
              SizedBox(height: 2.h),
              addTextField(),
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
                        borderRadius: const BorderRadius.all(AppRadius.radius4),
                      ),
                    )),
                    SizedBox(height: 1.h),
                    CommonButton(
                      title: Strings.done,
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

  Widget amenitiesList() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.rules.length,
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
                      controller.rules[index],
                      style: FontManager.regular(16,
                          color: AppColors.textAddProreties),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.removeRules(index);
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

  Widget customAmenities(String rulesName) {
    return Container(
      width: 110.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.borderContainerGriedView),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5.w),
            Text(
              rulesName,
              style: FontManager.regular(16, color: AppColors.textAddProreties),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
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
    );
  }


  Widget addTextField() {
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
            Obx(() =>  Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, bottom: 0),
                child: TextFormField(
                  controller: controller.rulesName,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "rules ${controller.amenities.length + 1}",
                    hintStyle:
                    FontManager.regular(16, color: AppColors.greyText),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        final String newRules =
                        controller.rulesName.text.trim();
                        if (newRules.isNotEmpty) {
                          controller.addRules(newRules);
                          controller.rulesName.clear();
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
            ),
          ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/routes_app/all_routes_app.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/amenities_and_houserules_custom.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

class AmenitiesPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AmenitiesPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  final AddPropertiesController controller =
      Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.newamenities);
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
                  style: FontManager.medium(18.sp, color: AppColors.buttonColor),
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
                  SizedBox(height: 5.3.h),
                ],
              );
            },
          ),
          Text(
            Strings.newAmenities,
            style: FontManager.medium(18, color: AppColors.black),
          ),
          SizedBox(height: 2.h),
          Obx(() =>  AmenityAndHouseRulesContainer(
              imageAsset: Assets.imagesHometherater,
              title: Strings.homeTheater,
              isSelected: controller.selectedAmenities[3],
              onSelect: () => controller.toggleAmenity(3),
            ),
          ),
          SizedBox(height: 1.2.h),
          Obx(() =>  AmenityAndHouseRulesContainer(
              imageAsset: Assets.imagesMastrSuite,
              title: Strings.masterSuiteBalcony,
              isSelected: controller.selectedAmenities[4],
              onSelect: () => controller.toggleAmenity(4),
            ),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.amenities.length,
              itemBuilder: (context, index) {
                if (index >= controller.selectedAmenities.length) {
                  controller.selectedAmenities.add(false);
                }
                return Column(
                  children: [
                    const SizedBox(height: 2),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesMastrSuite,
                      title: controller.amenities[index],
                      isSelected: true,
                      onSelect: () => controller.toggleAmenity(index),
                    ),
                  ],
                );
              },
            );
          }),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_widget/amenities_and_houserules_custom.dart';
import '../../controller/add_properties_controller.dart';

class HouseRulesPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const HouseRulesPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  State<HouseRulesPage> createState() => _HouseRulesPageState();
}

class _HouseRulesPageState extends State<HouseRulesPage> {

  final AddPropertiesController controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.newRules);
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
                  style:
                  FontManager.medium(18.sp, color: AppColors.buttonColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Obx(() {
            return Column(children: [
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoSmoking,
                title: Strings.noSmoking,
                isSelected: controller.selectedRules[1],
                onSelect: () => controller.toggleRules(1),
              ),
              SizedBox(height: 2.h),
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoDrinking,
                title: Strings.noDrinking,
                isSelected: controller.selectedRules[2],
                onSelect: () => controller.toggleRules(2),
              ),
              SizedBox(height: 2.h),
              AmenityAndHouseRulesContainer(
                imageAsset: Assets.imagesNoPet,
                title: Strings.noPet,
                isSelected: controller.selectedRules[3],
                onSelect: () => controller.toggleRules(3),
              ),
              SizedBox(height: 5.3.h),
            ],);
          },),
          Text(
            Strings.newRules,
            style: FontManager.medium( 18, color: AppColors.textAddProreties),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          AmenityAndHouseRulesContainer(
            imageAsset: Assets.imagesDamageToProretiy,
            title: Strings.damageToProperty,
            isSelected: controller.selectedRules[4],
            onSelect: () => controller.toggleRules(4),
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.rules.length,
              itemBuilder: (context, index) {
                if (index >= controller.selectedRules.length) {
                  controller.selectedRules.add(false);
                }
                return Column(
                  children: [
                    SizedBox(height: 15),
                    AmenityAndHouseRulesContainer(
                      imageAsset: Assets.imagesMastrSuite,
                      title: controller.rules[index],
                      isSelected: controller.selectedRules[index],
                      onSelect: () => controller.toggleRules(index),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/common_widgets/common_button.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../common_widgets/common_dialog.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/app_string.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LatLng kMapCenter = const LatLng(19.018255973653343, 72.84793849278007);
  LatLng? _currentPosition;
  late GoogleMapController _mapController;

  CameraPosition? initialPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      if (_currentPosition != null) {
                        _mapController.animateCamera(
                          CameraUpdate.newLatLng(_currentPosition!),
                        );
                      } else {

                        _mapController.animateCamera(
                          CameraUpdate.newLatLng(kMapCenter),
                        );
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition ?? kMapCenter,
                      zoom: 11,
                    ),
                    markers: {
                      if (_currentPosition != null)
                        Marker(
                          markerId: MarkerId('current_location'),
                          position: _currentPosition!,
                        ),
                    },
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 16,
                    right: 16,
                    child: CommonButton(
                      title: Strings.nextStep,
                      onPressed: () {
                        CustomDialog.showCustomDialog(
                          context: context,
                          title: Strings.turnLocationOn,
                          message: Strings.locationDiscription,
                          imageAsset: Assets.imagesQuestionDialog,
                          buttonLabel: Strings.settings,
                          changeEmailLabel: Strings.cancel,
                          onResendPressed: () {
                            Get.back();
                          },
                        );
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

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }
}
