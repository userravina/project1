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
import 'package:gym_app/utils/color.dart';

class CommonAuthBtn extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;

  const CommonAuthBtn({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
            colors: [ColorUtils.blue, ColorUtils.lightPurple],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/utils/color.dart';

class CommonDeleteDialouge extends StatelessWidget {
  final String title;
  final String btnNameGoBack;
  final String permissionString;
  final Widget child;
  final VoidCallback onPressedGoBack;
  final VoidCallback onPressedDelete;

  const CommonDeleteDialouge(
      {super.key,
      required this.title,
      required this.btnNameGoBack,
      required this.permissionString,
      required this.onPressedGoBack,
      required this.child,
      required this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 1),
            Text(
              title,
              style: commonTextStyle(
                  color: ColorUtils.background, fontWeight: FontWeight.w700),
            ),
            Text(
              permissionString,
              style: commonTextStyle(color: ColorUtils.background),
            ),
            const SizedBox(height: 2),
            Divider(
              color: ColorUtils.background.withOpacity(0.2),
              thickness: 0.2,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: const WidgetStatePropertyAll(Size(100, 45)),
                      backgroundColor:
                          const WidgetStatePropertyAll(ColorUtils.background),
                      foregroundColor:
                          const WidgetStatePropertyAll(ColorUtils.white),
                      shape: WidgetStatePropertyAll(
                        ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                    onPressed: onPressedGoBack,
                    child: Text(
                      btnNameGoBack,
                      style: commonTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: const WidgetStatePropertyAll(Size(100, 45)),
                      backgroundColor:
                          const WidgetStatePropertyAll(ColorUtils.error),
                      foregroundColor:
                          const WidgetStatePropertyAll(ColorUtils.white),
                      shape: WidgetStatePropertyAll(
                        ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                    onPressed: onPressedDelete,
                    child: child,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Text(
// btnNameDelete,
// style: commonTextStyle(),
// ),
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> commonEasyLoading({required String errorMsg}) {
  return EasyLoading.showError(
    errorMsg,
    duration: const Duration(seconds: 2),
  );
}
import 'package:flutter/material.dart';

class CommonEmptyView extends StatelessWidget {
  final String emptyText;

  const CommonEmptyView({super.key, required this.emptyText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emptyText, textAlign: TextAlign.center),
    );
  }
}
import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../utils/color.dart';

class CommonNetworkImg extends StatelessWidget {
  final String img;
  final double? borderRadius;

  const CommonNetworkImg({super.key, required this.img, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 100),
      child: Image.network(
        img,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(
            child: CircularProgressIndicator(
              color: ColorUtils.background,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Image.asset(
                Assets.pngFitnessLogo,
                fit: BoxFit.contain,
                color: ColorUtils.background,
                height: 40,
                width: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/utils/color.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final VoidCallback? suffixIconOnPressed;
  final Widget? suffixIcon;
  final int? maxLength;
  final Color? inputTextColor;
  final Color? borderSideColor;

  const CommonTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText,
    this.suffixIconOnPressed,
    this.suffixIcon,
    this.maxLength,
    this.inputTextColor,
    this.borderSideColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        controller: controller,
        style: commonTextStyle(color: inputTextColor),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          counterText: "",
          counterStyle: commonTextStyle(fontSize: 10),
          suffixIcon: IconButton(
              onPressed: suffixIconOnPressed,
              icon: suffixIcon ?? const SizedBox()),
          fillColor: ColorUtils.white.withOpacity(0.1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: borderSideColor ?? ColorUtils.whiteTextFieldBorder,
                width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: borderSideColor ?? ColorUtils.whiteTextFieldBorder,
                width: 1),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gym_app/utils/color.dart';

String fontFamily = "Poppins";

TextStyle commonTextStyle(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration}) {
  return TextStyle(
    color: color ?? ColorUtils.white,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.w500,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    fontFamily: fontFamily,
    // height: 1.2,
  );
}

TextStyle commonTitleTextStyle(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration}) {
  return TextStyle(
    color: color ?? ColorUtils.white,
    fontSize: fontSize ?? 20,
    fontWeight: fontWeight ?? FontWeight.w700,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    fontFamily: fontFamily,
  );
}
import 'package:flutter/material.dart';
import 'package:gym_app/common_components/common_text_style.dart';

class CommonToolTip extends StatelessWidget {
  final String message;
  final Widget child;

  const CommonToolTip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textStyle: commonTextStyle(fontSize: 12),
      child: child,
    );
  }
}

///This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class Assets {
  Assets._();

  static const String fontsPoppinsBlack = 'assets/fonts/poppins_black.ttf';
  static const String fontsPoppinsBold = 'assets/fonts/poppins_bold.ttf';
  static const String fontsPoppinsExtraBold =
      'assets/fonts/poppins_extra_bold.ttf';
  static const String fontsPoppinsExtraLight =
      'assets/fonts/poppins_extra_light.ttf';
  static const String fontsPoppinsLight = 'assets/fonts/poppins_light.ttf';
  static const String fontsPoppinsMedium = 'assets/fonts/poppins_medium.ttf';
  static const String fontsPoppinsRegular = 'assets/fonts/poppins_regular.ttf';
  static const String fontsPoppinsSemiBold =
      'assets/fonts/poppins_semi_bold.ttf';
  static const String fontsPoppinsThin = 'assets/fonts/poppins_thin.ttf';
  static const String pngBgImg = 'assets/icons/png/bg_img.png';
  static const String pngExerciseIcon = 'assets/icons/png/exercise_icon.png';
  static const String pngFitnessLogo = 'assets/icons/png/fitness_logo.png';
  static const String pngGymBackgroundImg =
      'assets/icons/png/gym_background_img.png';
  static const String pngLoginImg = 'assets/icons/png/login_img.png';
  static const String pngLogoutIcon = 'assets/icons/png/logout_icon.png';
  static const String pngMusclesIcon = 'assets/icons/png/muscles_icon.png';
  static const String pngRegisterImg = 'assets/icons/png/register_img.png';
  static const String pngSplashImg = 'assets/icons/png/splash_img.png';
  static const String pngUserListIcon = 'assets/icons/png/user_list_icon.png';
  static const String pngWorkoutIcon = 'assets/icons/png/workout_icon.png';
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseRepository {
  static final firestore = FirebaseFirestore.instance;

  static adminRegister(
      {required String adminId, required Map<String, dynamic> request}) async {
    try {
      await firestore
          .collection('Admin')
          .doc(adminId)
          .set(request)
          .then((value) {
        if (kDebugMode) {
          print("Admin has been  registered");
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("Error while adding admin in fire store");
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Admin Register :: $e");
      }
    }
  }

  static fetchData({required String key}) async {
    return await firestore.collection(key).get();
  }

  static updateData(
      {required String key,
      required String uId,
      required Map<String, dynamic> data}) async {
    try {
      return await firestore.collection(key).doc(uId).update(data);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static addData(
      {required String key, required Map<String, dynamic> data}) async {
    try {
      return await firestore.collection(key).add(data);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static deleteData({required String key, required String id}) async {
    try {
      await firestore.collection(key).doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<String> uploadFile(XFile img) async {
    final storageRef = FirebaseStorage.instance.ref("images");
    final mountainsRef = storageRef.child(img.name);
    await mountainsRef.putBlob(await img.readAsBytes());
    return await mountainsRef.getDownloadURL();
  }
}
import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static final getStorage = GetStorage();

  static String adminId = "adminId";

  static writeMethod({required String key, required String value}) async {
    return await getStorage.write(key, value);
  }

  static readMethod({required String key}) {
    return getStorage.read(key);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class SideMenuModel {
  bool? isVerified;
  String? userId;
  String? gymId;
  String? email;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<String>? exerciseSet;
  List<String>? muscleSet;
  List<dynamic>? levelSet;
  String? setID;
  String? workoutID;
  String? description;
  String? exerciseId;
  String? image;
  String? gif;
  String? name;
  String? set;
  String? repetation;
  String? weight;

  SideMenuModel({
    this.exerciseId,
    this.gymId,
    this.updatedAt,
    this.createdAt,
    this.name,
    this.description,
    this.levelSet,
    this.image,
    this.gif,
    this.repetation,
    this.weight,
    this.exerciseSet,
    this.muscleSet,
    this.setID,
    this.workoutID,
    this.set,
    this.isVerified,
    this.userId,
    this.email,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["exercise_Id"] = exerciseId;
    data["gym_Id"] = gymId;
    data["userId"] = userId;
    data["set_ID"] = setID;
    data["workout_ID"] = workoutID;
    data["set"] = set;
    data["IsVerified"] = isVerified;
    data["created_At"] = createdAt;
    data["updated_At"] = updatedAt;
    data["name"] = name;
    data['level_set'] = levelSet;
    data["email"] = email;
    data["description"] = description;
    data["image"] = image;
    data["gif"] = gif;
    data["repetation"] = repetation;
    data["exercise_set"] = exerciseSet;
    data["muscle_set"] = muscleSet;
    data["weight"] = weight;
    return data;
  }

  SideMenuModel.fromJson(Map<String, dynamic> doc) {
    if (doc['exercise_set'] != null) {
      exerciseSet = doc['exercise_set'].cast<String>();
    }
    if (doc['muscle_set'] != null) {
      muscleSet = doc['muscle_set'].cast<String>();
    }
    gymId = doc["gym_Id"];
    userId = doc["userId"];
    setID = doc["set_ID"];
    workoutID = doc["workout_ID"];
    set = doc["set"];
    isVerified = doc["IsVerified"];
    createdAt = doc["created_At"];
    updatedAt = doc["updated_At"];
    name = doc["name"];
    levelSet = doc['level_set'];
    email = doc["email"];
    description = doc["description"];
    image = doc["image"];
    gif = doc["gif"];
    repetation = doc["repetation"];
    exerciseId = doc["exercise_Id"];
    weight = doc["weight"];
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:gym_app/routes/app_route_config.gr.dart';

import 'app_route_path.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(
          path: AutoRoutePath.splashRoute,
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: AutoRoutePath.loginRoute,
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: AutoRoutePath.registrationRoute,
          page: RegistrationRoute.page,
        ),
        AutoRoute(
          path: AutoRoutePath.dashboardRoute,
          page: DashboardRoute.page,
          children: [
            AutoRoute(
              path: '',
              page: UserListRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: AutoRoutePath.exerciseNavigation,
              page: ExerciseNavigation.page,
              children: [
                AutoRoute(
                  path: AutoRoutePath.exerciseListRoute,
                  page: ExerciseListRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.addExerciseRoute,
                  page: AddExerciseRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.readExerciseRoute,
                  page: ReadExerciseRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: AutoRoutePath.muscleNavigation,
              page: MuscleNavigation.page,
              children: [
                AutoRoute(
                  path: AutoRoutePath.muscleSetRoute,
                  page: MuscleSetRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.addMuscleRoute,
                  page: AddMuscleSetRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.readMuscleRoute,
                  page: ReadMuscleRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: AutoRoutePath.workoutNavigation,
              page: WorkoutNavigation.page,
              children: [
                AutoRoute(
                  path: AutoRoutePath.workOutRoute,
                  page: WorkOutRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.addWorkOutRoute,
                  page: AddWorkOutRoute.page,
                ),
                AutoRoute(
                  path: AutoRoutePath.readWorkOutRoute,
                  page: ReadWorkoutRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:gym_app/model/side_menu_model.dart' as _i21;
import 'package:gym_app/screens/auth_screen/login_screen.dart' as _i8;
import 'package:gym_app/screens/auth_screen/registration_screen.dart' as _i14;
import 'package:gym_app/screens/dashboard_screen/dashboard_screen.dart' as _i4;
import 'package:gym_app/screens/error_screen/error_screen.dart' as _i5;
import 'package:gym_app/screens/side_menu_screen/exercise_list_screen/exercise_list_screen.dart'
    as _i6;
import 'package:gym_app/screens/side_menu_screen/exercise_list_screen/exercise_navigation.dart'
    as _i7;
import 'package:gym_app/screens/side_menu_screen/exercise_list_screen/widget/add_exercise.dart'
    as _i1;
import 'package:gym_app/screens/side_menu_screen/exercise_list_screen/widget/read_exercise_screen.dart'
    as _i11;
import 'package:gym_app/screens/side_menu_screen/muscle_set_screen/muscle_navigation.dart'
    as _i9;
import 'package:gym_app/screens/side_menu_screen/muscle_set_screen/muscle_set_list_screen.dart'
    as _i10;
import 'package:gym_app/screens/side_menu_screen/muscle_set_screen/widget/add_muscle_set.dart'
    as _i2;
import 'package:gym_app/screens/side_menu_screen/muscle_set_screen/widget/read_muscle_screen.dart'
    as _i12;
import 'package:gym_app/screens/side_menu_screen/user_list_screen/user_list_screen.dart'
    as _i16;
import 'package:gym_app/screens/side_menu_screen/work_out_screen/widget/add_work_out.dart'
    as _i3;
import 'package:gym_app/screens/side_menu_screen/work_out_screen/widget/read_workout_screen.dart'
    as _i13;
import 'package:gym_app/screens/side_menu_screen/work_out_screen/work_out_list_screen.dart'
    as _i17;
import 'package:gym_app/screens/side_menu_screen/work_out_screen/workout_navigation.dart'
    as _i18;
import 'package:gym_app/screens/splash_screen/splash_screen.dart' as _i15;

/// generated route for
/// [_i1.AddExerciseScreen]
class AddExerciseRoute extends _i19.PageRouteInfo<AddExerciseRouteArgs> {
  AddExerciseRoute({
    _i20.Key? key,
    bool? fillData,
    _i21.SideMenuModel? exercise,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          AddExerciseRoute.name,
          args: AddExerciseRouteArgs(
            key: key,
            fillData: fillData,
            exercise: exercise,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExerciseRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExerciseRouteArgs>(
          orElse: () => const AddExerciseRouteArgs());
      return _i1.AddExerciseScreen(
        key: args.key,
        fillData: args.fillData,
        exercise: args.exercise,
      );
    },
  );
}

class AddExerciseRouteArgs {
  const AddExerciseRouteArgs({
    this.key,
    this.fillData,
    this.exercise,
  });

  final _i20.Key? key;

  final bool? fillData;

  final _i21.SideMenuModel? exercise;

  @override
  String toString() {
    return 'AddExerciseRouteArgs{key: $key, fillData: $fillData, exercise: $exercise}';
  }
}

/// generated route for
/// [_i2.AddMuscleSetScreen]
class AddMuscleSetRoute extends _i19.PageRouteInfo<AddMuscleSetRouteArgs> {
  AddMuscleSetRoute({
    _i20.Key? key,
    bool? fillData,
    _i21.SideMenuModel? muscleSet,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          AddMuscleSetRoute.name,
          args: AddMuscleSetRouteArgs(
            key: key,
            fillData: fillData,
            muscleSet: muscleSet,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMuscleSetRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMuscleSetRouteArgs>(
          orElse: () => const AddMuscleSetRouteArgs());
      return _i2.AddMuscleSetScreen(
        key: args.key,
        fillData: args.fillData,
        muscleSet: args.muscleSet,
      );
    },
  );
}

class AddMuscleSetRouteArgs {
  const AddMuscleSetRouteArgs({
    this.key,
    this.fillData,
    this.muscleSet,
  });

  final _i20.Key? key;

  final bool? fillData;

  final _i21.SideMenuModel? muscleSet;

  @override
  String toString() {
    return 'AddMuscleSetRouteArgs{key: $key, fillData: $fillData, muscleSet: $muscleSet}';
  }
}

/// generated route for
/// [_i3.AddWorkOutScreen]
class AddWorkOutRoute extends _i19.PageRouteInfo<AddWorkOutRouteArgs> {
  AddWorkOutRoute({
    _i20.Key? key,
    bool? fillData,
    _i21.SideMenuModel? workout,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          AddWorkOutRoute.name,
          args: AddWorkOutRouteArgs(
            key: key,
            fillData: fillData,
            workout: workout,
          ),
          initialChildren: children,
        );

  static const String name = 'AddWorkOutRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddWorkOutRouteArgs>(
          orElse: () => const AddWorkOutRouteArgs());
      return _i3.AddWorkOutScreen(
        key: args.key,
        fillData: args.fillData,
        workout: args.workout,
      );
    },
  );
}

class AddWorkOutRouteArgs {
  const AddWorkOutRouteArgs({
    this.key,
    this.fillData,
    this.workout,
  });

  final _i20.Key? key;

  final bool? fillData;

  final _i21.SideMenuModel? workout;

  @override
  String toString() {
    return 'AddWorkOutRouteArgs{key: $key, fillData: $fillData, workout: $workout}';
  }
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i19.PageRouteInfo<void> {
  const DashboardRoute({List<_i19.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i5.ErrorScreen]
class ErrorRoute extends _i19.PageRouteInfo<void> {
  const ErrorRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.ErrorScreen();
    },
  );
}

/// generated route for
/// [_i6.ExerciseListScreen]
class ExerciseListRoute extends _i19.PageRouteInfo<void> {
  const ExerciseListRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ExerciseListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.ExerciseListScreen();
    },
  );
}

/// generated route for
/// [_i7.ExerciseNavigation]
class ExerciseNavigation extends _i19.PageRouteInfo<void> {
  const ExerciseNavigation({List<_i19.PageRouteInfo>? children})
      : super(
          ExerciseNavigation.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseNavigation';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.ExerciseNavigation();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute({List<_i19.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginScreen();
    },
  );
}

/// generated route for
/// [_i9.MuscleNavigation]
class MuscleNavigation extends _i19.PageRouteInfo<void> {
  const MuscleNavigation({List<_i19.PageRouteInfo>? children})
      : super(
          MuscleNavigation.name,
          initialChildren: children,
        );

  static const String name = 'MuscleNavigation';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i9.MuscleNavigation();
    },
  );
}

/// generated route for
/// [_i10.MuscleSetScreen]
class MuscleSetRoute extends _i19.PageRouteInfo<void> {
  const MuscleSetRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MuscleSetRoute.name,
          initialChildren: children,
        );

  static const String name = 'MuscleSetRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.MuscleSetScreen();
    },
  );
}

/// generated route for
/// [_i11.ReadExerciseScreen]
class ReadExerciseRoute extends _i19.PageRouteInfo<ReadExerciseRouteArgs> {
  ReadExerciseRoute({
    _i20.Key? key,
    required _i21.SideMenuModel exercise,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ReadExerciseRoute.name,
          args: ReadExerciseRouteArgs(
            key: key,
            exercise: exercise,
          ),
          initialChildren: children,
        );

  static const String name = 'ReadExerciseRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReadExerciseRouteArgs>();
      return _i11.ReadExerciseScreen(
        key: args.key,
        exercise: args.exercise,
      );
    },
  );
}

class ReadExerciseRouteArgs {
  const ReadExerciseRouteArgs({
    this.key,
    required this.exercise,
  });

  final _i20.Key? key;

  final _i21.SideMenuModel exercise;

  @override
  String toString() {
    return 'ReadExerciseRouteArgs{key: $key, exercise: $exercise}';
  }
}

/// generated route for
/// [_i12.ReadMuscleScreen]
class ReadMuscleRoute extends _i19.PageRouteInfo<ReadMuscleRouteArgs> {
  ReadMuscleRoute({
    _i20.Key? key,
    required _i21.SideMenuModel muscle,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ReadMuscleRoute.name,
          args: ReadMuscleRouteArgs(
            key: key,
            muscle: muscle,
          ),
          initialChildren: children,
        );

  static const String name = 'ReadMuscleRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReadMuscleRouteArgs>();
      return _i12.ReadMuscleScreen(
        key: args.key,
        muscle: args.muscle,
      );
    },
  );
}

class ReadMuscleRouteArgs {
  const ReadMuscleRouteArgs({
    this.key,
    required this.muscle,
  });

  final _i20.Key? key;

  final _i21.SideMenuModel muscle;

  @override
  String toString() {
    return 'ReadMuscleRouteArgs{key: $key, muscle: $muscle}';
  }
}

/// generated route for
/// [_i13.ReadWorkoutScreen]
class ReadWorkoutRoute extends _i19.PageRouteInfo<ReadWorkoutRouteArgs> {
  ReadWorkoutRoute({
    _i20.Key? key,
    required _i21.SideMenuModel workout,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ReadWorkoutRoute.name,
          args: ReadWorkoutRouteArgs(
            key: key,
            workout: workout,
          ),
          initialChildren: children,
        );

  static const String name = 'ReadWorkoutRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReadWorkoutRouteArgs>();
      return _i13.ReadWorkoutScreen(
        key: args.key,
        workout: args.workout,
      );
    },
  );
}

class ReadWorkoutRouteArgs {
  const ReadWorkoutRouteArgs({
    this.key,
    required this.workout,
  });

  final _i20.Key? key;

  final _i21.SideMenuModel workout;

  @override
  String toString() {
    return 'ReadWorkoutRouteArgs{key: $key, workout: $workout}';
  }
}

/// generated route for
/// [_i14.RegistrationScreen]
class RegistrationRoute extends _i19.PageRouteInfo<void> {
  const RegistrationRoute({List<_i19.PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i14.RegistrationScreen();
    },
  );
}

/// generated route for
/// [_i15.SplashScreen]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.SplashScreen();
    },
  );
}

/// generated route for
/// [_i16.UserListScreen]
class UserListRoute extends _i19.PageRouteInfo<void> {
  const UserListRoute({List<_i19.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i16.UserListScreen();
    },
  );
}

/// generated route for
/// [_i17.WorkOutScreen]
class WorkOutRoute extends _i19.PageRouteInfo<void> {
  const WorkOutRoute({List<_i19.PageRouteInfo>? children})
      : super(
          WorkOutRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkOutRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i17.WorkOutScreen();
    },
  );
}

/// generated route for
/// [_i18.WorkoutNavigation]
class WorkoutNavigation extends _i19.PageRouteInfo<void> {
  const WorkoutNavigation({List<_i19.PageRouteInfo>? children})
      : super(
          WorkoutNavigation.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutNavigation';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.WorkoutNavigation();
    },
  );
}
class AutoRoutePath {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registrationRoute = '/registration';
  static const String dashboardRoute = '/dashboard';
  static const String exerciseNavigation = 'exercisesNavigation';
  static const String muscleNavigation = 'musclesNavigation';
  static const String workoutNavigation = 'workoutsNavigation';

  // Exercise routes
  static const String exerciseListRoute = 'exercises';
  static const String addExerciseRoute = 'addExercises';
  static const String readExerciseRoute = ':id';

  // Muscle routes
  static const String muscleSetRoute = 'muscles';
  static const String addMuscleRoute = 'addMuscles';
  static const String readMuscleRoute = ':id';

  // Workout routes
  static const String workOutRoute = 'workouts';
  static const String addWorkOutRoute = 'addWorkouts';
  static const String readWorkOutRoute = ':id';
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_easy_loading.dart';
import 'package:gym_app/helper/get_storage/get_storage.dart';
import 'package:gym_app/routes/app_route_config.gr.dart';

import '../../../injection_container.dart';
import '../../../routes/app_route_config.dart';

class AuthController extends GetxController {
  AppRouter appRouter = getIt<AppRouter>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userEmail = '';
  RxBool obscureTextPass = true.obs;
  RxBool obscureRegiTextPass = true.obs;
  RxBool obscureTextConfirmPass = true.obs;

  GlobalKey<FormState> registerFormKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController gymNameController = TextEditingController();
  bool success = false;
  RxBool isLoading = false.obs;

  RegExp emailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  register(BuildContext context) async {
    if (registerFormKey.currentState?.validate() ?? false) {
      bool result = await adminRegistration();
      if (result) {
        appRouter.replaceAll([const LoginRoute()]);
      }
    }
  }

  login(BuildContext context) async {
    if (loginFormKey.currentState?.validate() ?? false) {
      bool result = await adminLogin(
          emailController.text.trim(), passController.text.trim());
      if (result) {
        String adminUid = FirebaseAuth.instance.currentUser?.uid ?? "";
        await GetStorageServices.writeMethod(
            key: GetStorageServices.adminId, value: adminUid);

        appRouter.replaceAll([const DashboardRoute()]);
      }
    }
  }

  Future<bool> adminRegistration() async {
    isLoading.value = true;
    try {
      final UserCredential admin = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      success = true;
      userEmail = admin.user?.email ?? '';
      if (admin.user?.uid != null) {
        Map<String, dynamic> request = {
          'adminId': admin.user?.uid,
          'mobile_number': mobileNoController.text.trim(),
          'email': emailController.text.trim(),
          'gym_Name': gymNameController.text.trim(),
          'gymId': admin.user?.uid,
          'created_At': DateTime.now(),
          'updated_At': DateTime.now(),
        };

        await FirebaseFirestore.instance
            .collection('Gym')
            .doc(admin.user?.uid ?? '')
            .set({
          'gym_name': gymNameController.text.trim(),
          'gym_id': admin.user?.uid ?? ''
        });

        await FirebaseFirestore.instance
            .collection('Admin')
            .doc(admin.user?.uid ?? '')
            .set(request);

        await GetStorageServices.writeMethod(
            key: GetStorageServices.adminId, value: admin.user?.uid ?? "");
        if (kDebugMode) {
          print(
              "=====> read(adminId) : ${GetStorageServices.readMethod(key: GetStorageServices.adminId)}");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        commonEasyLoading(errorMsg: "Password is weak");
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        commonEasyLoading(
            errorMsg: "The account already exists for that email");
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        success = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
    return success;
  }

  Future<bool> adminLogin(String email, String password) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      success = true;
      if (kDebugMode) {
        print('=====> Login Success.');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (e.code == 'user-not-found') {
        commonEasyLoading(errorMsg: "No user found");
        if (kDebugMode) {
          print('=====> No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        commonEasyLoading(errorMsg: "Password is wrong");
        if (kDebugMode) {
          print('=====> Wrong password provided for that user.');
        }
        success = false;
      } else {
        commonEasyLoading(
            errorMsg: (e as FirebaseException).message.toString());
        if (kDebugMode) {
          print(
              '=====> e as FirebaseException : ${(e as FirebaseException).message}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('=====> Login $e');
      }
    } finally {
      isLoading.value = false;
    }
    return success;
  }

  clearCtrl() {
    emailController.clear();
    mobileNoController.clear();
    gymNameController.clear();
    passController.clear();
    confirmPassController.clear();
  }

  @override
  void onClose() {
    clearCtrl();
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/common_components/common_text_form_field.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/utils/color.dart';
import 'package:get/get.dart';

class CommonTextFieldAndNameWidget extends StatelessWidget {
  final String fieldName;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Color? fieldNameColor;
  final Widget? suffixIcon;
  final VoidCallback? suffixIconOnPressed;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Color? inputTextColor;
  final Color? borderSideColor;

  const CommonTextFieldAndNameWidget({
    super.key,
    required this.fieldName,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.fieldNameColor,
    this.obscureText,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.inputFormatters,
    this.maxLength,
    this.inputTextColor,
    this.borderSideColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            fieldName,
            style: commonTextStyle(
              fontSize: 14,
              color: fieldNameColor ?? ColorUtils.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 5),
          CommonTextFormField(
            borderSideColor: borderSideColor,
            inputTextColor: inputTextColor,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            suffixIcon: suffixIcon,
            suffixIconOnPressed: suffixIconOnPressed,
            keyboardType: keyboardType,
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 8);
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/utils/color.dart';

class CommonShowEyeIconWidget extends StatelessWidget {
  const CommonShowEyeIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.remove_red_eye,
      color: ColorUtils.whiteTextFieldBorder,
    );
  }
}

class CommonHideEyeIconWidget extends StatelessWidget {
  const CommonHideEyeIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.eye_slash_fill,
      color: ColorUtils.whiteTextFieldBorder,
    );
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_auth_btn.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/common_components/common_tool_tip.dart';
import 'package:gym_app/generated/assets.dart';
import 'package:gym_app/routes/app_route_config.gr.dart';
import 'package:gym_app/screens/auth_screen/controller/auth_controller.dart';
import 'package:gym_app/screens/auth_screen/widget/common_text_field_and_name_column.dart';
import 'package:gym_app/screens/auth_screen/widget/show_hide_eye_icon.dart';
import 'package:gym_app/utils/color.dart';
import 'package:gym_app/utils/string.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AuthController(),
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.pngLoginImg),
              ),
            ),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonToolTip(
                        message: StringUtils.signup,
                        child: TextButton(
                          onPressed: () {
                            controller.clearCtrl();
                            context.router.replaceAll([const RegistrationRoute()]);
                          },
                          child: Row(
                            children: [
                              Text(
                                StringUtils.signup,
                                style: commonTextStyle(
                                  fontSize: 16,
                                  color: ColorUtils.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorUtils.white.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingSlideInFromRight(
                            duration: const Duration(seconds: 2),
                            blur: const Offset(3, 5),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: ColorUtils.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.32,
                              width: 400,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringUtils.loginHere,
                                          style: commonTextStyle(),
                                        ),
                                        Text(
                                          StringUtils.letsJoinUs,
                                          style: commonTextStyle(
                                              fontSize: 12,
                                              color: ColorUtils.white
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                    CommonTextFieldAndNameWidget(
                                      fieldName: "Email",
                                      controller: controller.emailController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please Enter Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    Obx(
                                      () => CommonTextFieldAndNameWidget(
                                        fieldName: "Password",
                                        controller: controller.passController,
                                        obscureText:
                                            controller.obscureTextPass.value,
                                        suffixIcon: controller
                                                .obscureTextPass.value
                                            ? const CommonShowEyeIconWidget()
                                            : const CommonHideEyeIconWidget(),
                                        suffixIconOnPressed: () {
                                          setState(() {
                                            controller.obscureTextPass.value =
                                                !controller
                                                    .obscureTextPass.value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return 'Please Enter Password';
                                          } else if (value!.length < 6) {
                                            return 'Please Enter atleast 6 character.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => controller.isLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                            )
                                          : CommonToolTip(
                                              message: StringUtils.login,
                                              child: CommonAuthBtn(
                                                onTap: () async {
                                                  controller.login(context);
                                                },
                                                child: Text(
                                                  StringUtils.login,
                                                  style: commonTextStyle(
                                                      color: ColorUtils.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        StringUtils.forgotPassword,
                                        style: commonTextStyle(
                                            fontSize: 12,
                                            color: ColorUtils.white
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_tool_tip.dart';
import 'package:gym_app/generated/assets.dart';
import 'package:gym_app/routes/app_route_config.gr.dart';
import 'package:gym_app/screens/auth_screen/widget/common_text_field_and_name_column.dart';
import 'package:gym_app/screens/auth_screen/widget/show_hide_eye_icon.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../common_components/common_auth_btn.dart';
import '../../common_components/common_text_style.dart';
import '../../injection_container.dart';
import '../../routes/app_route_config.dart';
import '../../utils/color.dart';
import '../../utils/string.dart';
import 'controller/auth_controller.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AppRouter appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AuthController(),
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.pngRegisterImg),
                // opacity: 0.5,
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: controller.registerFormKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonToolTip(
                        message: StringUtils.login,
                        child: TextButton(
                          onPressed: () {
                            controller.clearCtrl();
                            context.router.replaceAll([const LoginRoute()]);
                          },
                          child: Row(
                            children: [
                              Text(
                                StringUtils.login,
                                style: commonTextStyle(
                                  fontSize: 16,
                                  color: ColorUtils.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorUtils.white.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingSlideInFromBottom(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.elasticInOut),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: ColorUtils.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.62,
                              width: 400,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringUtils.signupHere,
                                          style: commonTextStyle(),
                                        ),
                                        Text(
                                          StringUtils.letsJoinUs,
                                          style: commonTextStyle(
                                              fontSize: 12,
                                              color: ColorUtils.white
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                    CommonTextFieldAndNameWidget(
                                      fieldName: "Email",
                                      controller: controller.emailController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please Enter Email';
                                        } else if (value.isNotEmpty &&
                                            !controller.emailPattern
                                                .hasMatch(value)) {
                                          return 'Email Formats is Not Valid';
                                        }
                                        return null;
                                      },
                                    ),
                                    CommonTextFieldAndNameWidget(
                                      fieldName: "Mobile No",
                                      maxLength: 10,
                                      controller: controller.mobileNoController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please Enter Mobile No';
                                        } else if (int.parse(value) < 1 &&
                                            int.parse(value) > 10) {
                                          return 'Please Enter 10 Digit';
                                        }
                                        return null;
                                      },
                                    ),
                                    Obx(
                                      () => CommonTextFieldAndNameWidget(
                                        fieldName: "Password",
                                        controller: controller.passController,
                                        obscureText: controller
                                            .obscureRegiTextPass.value,
                                        suffixIcon: controller
                                                .obscureRegiTextPass.value
                                            ? const CommonShowEyeIconWidget()
                                            : const CommonHideEyeIconWidget(),
                                        suffixIconOnPressed: () {
                                          setState(() {
                                            controller
                                                    .obscureRegiTextPass.value =
                                                !controller
                                                    .obscureRegiTextPass.value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return 'Please Enter Password';
                                          } else if (value!.length < 6) {
                                            return 'Please Enter atleast 6 character.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Obx(
                                      () => CommonTextFieldAndNameWidget(
                                        fieldName: "Confirm Password",
                                        controller:
                                            controller.confirmPassController,
                                        obscureText: controller
                                            .obscureTextConfirmPass.value,
                                        suffixIcon: controller
                                                .obscureTextConfirmPass.value
                                            ? const CommonShowEyeIconWidget()
                                            : const CommonHideEyeIconWidget(),
                                        suffixIconOnPressed: () {
                                          setState(() {
                                            controller.obscureTextConfirmPass
                                                    .value =
                                                !controller
                                                    .obscureTextConfirmPass
                                                    .value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return 'Please Enter Password';
                                          } else if (value!.length < 6) {
                                            return 'Please Enter atleast 6 character.';
                                          } else if (value !=
                                              controller.passController.text) {
                                            return 'Please Enter correct password';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    CommonTextFieldAndNameWidget(
                                      fieldName: "Gym Name",
                                      controller: controller.gymNameController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please Enter Gym Name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => controller.isLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                            )
                                          : CommonToolTip(
                                              message: StringUtils.register,
                                              child: CommonAuthBtn(
                                                onTap: () async {
                                                  controller.register(context);
                                                },
                                                child: Text(
                                                  StringUtils.register,
                                                  style: commonTextStyle(
                                                      color: ColorUtils.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        StringUtils.forgotPassword,
                                        style: commonTextStyle(
                                            fontSize: 12,
                                            color: ColorUtils.white
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:get/get.dart';
import 'package:gym_app/generated/assets.dart';
import 'package:gym_app/injection_container.dart';

import '../../../routes/app_route_config.dart';

class DashboardController extends GetxController {
  final appRouter = getIt<AppRouter>();

  static const userList = "User";
  static const exerciseList = "Exercise";
  static const muscleSet = "Muscle";
  static const workOutSet = "Work Out";

  final Map<String, String> mapIcons = {
    userList: Assets.pngUserListIcon,
    exerciseList: Assets.pngExerciseIcon,
    muscleSet: Assets.pngMusclesIcon,
    workOutSet: Assets.pngWorkoutIcon
  };
}
import 'package:flutter/material.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/utils/color.dart';

class NavigationDrawerItemTileWidget extends StatelessWidget {
  final bool? isCenter;
  final bool isSelected;
  final String title;
  final String img;
  final VoidCallback onTap;

  const NavigationDrawerItemTileWidget({
    this.isCenter,
    required this.isSelected,
    required this.title,
    required this.img,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? ColorUtils.background : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: isCenter ?? false
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Image.asset(
                img,
                height: 24,
                width: 24,
                color: isSelected ? ColorUtils.white : ColorUtils.background,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: commonTextStyle(
                  color: isSelected ? ColorUtils.white : ColorUtils.background,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/generated/assets.dart';
import 'package:gym_app/routes/app_route_config.gr.dart';
import 'package:gym_app/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:gym_app/screens/dashboard_screen/widget/navigation_drawer_item_tile_widget.dart';
import 'package:gym_app/utils/color.dart';
import 'package:gym_app/utils/string.dart';

import '../../common_components/common_delete_dialouge.dart';
import '../../injection_container.dart';
import '../../routes/app_route_config.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = getIt<AppRouter>();
    return AutoTabsRouter.tabBar(
      routes: const [
        UserListRoute(),
        ExerciseListRoute(),
        MuscleSetRoute(),
        WorkOutRoute(),
      ],
      builder: (context, child, tabController) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
            backgroundColor: ColorUtils.whiteTextFieldBorder,
            body: GetBuilder(
              init: DashboardController(),
              builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration:
                              const BoxDecoration(color: ColorUtils.background),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                StringUtils.gymApp,
                                style: commonTitleTextStyle(),
                              ),
                              const Spacer(),
                              Image.asset(Assets.pngFitnessLogo,
                                  height: 50, width: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            width: 220,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.mapIcons.length,
                                    itemBuilder: (context, index) {
                                      return NavigationDrawerItemTileWidget(
                                        isSelected: index == tabsRouter.activeIndex,
                                        title: controller.mapIcons.keys
                                            .elementAt(index),
                                        img: controller.mapIcons.values
                                            .elementAt(index),
                                        onTap: () {
                                          tabsRouter.setActiveIndex(index);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                  color: ColorUtils.background.withOpacity(0.3),
                                  height: 0.5,
                                ),
                                NavigationDrawerItemTileWidget(
                                  isCenter: true,
                                  isSelected: false,
                                  title: StringUtils.logout,
                                  img: Assets.pngLogoutIcon,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CommonDeleteDialouge(
                                          title: StringUtils.logout,
                                          permissionString:
                                              StringUtils.logoutPermission,
                                          btnNameGoBack: StringUtils.cancel,
                                          onPressedGoBack: () {
                                            appRouter.maybePop();
                                          },
                                          child: Text(
                                            StringUtils.logout,
                                            style: commonTextStyle(),
                                          ),
                                          onPressedDelete: () async {
                                            appRouter.replaceAll([const LoginRoute()]);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ),
                        // Dynamic Content Area
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 12, right: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtils.bg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.blue.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/utils/color.dart';

@RoutePage()
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.background,
      body: Center(
        child: Text(
          "Page Not Found",
          style: commonTextStyle(),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_tool_tip.dart';
import 'package:gym_app/helper/firebase_repository/firebase_repo.dart';
import 'package:gym_app/model/side_menu_model.dart';
import 'package:gym_app/utils/string.dart';

import '../../../../injection_container.dart';
import '../../../../routes/app_route_config.dart';

class UserListController extends GetxController
    with GetTickerProviderStateMixin {
  final appRouter = getIt<AppRouter>();
  String adminId = "";
  List<SideMenuModel> userList = [];
  List<SideMenuModel> userListAccepted = [];

  RxBool acceptLoading = false.obs;
  RxBool declineLoading = false.obs;

  final SideMenuModel user = SideMenuModel();

  TabController? tabController;
  List<Widget> tabBarList = [
    const CommonToolTip(
      message: ("${StringUtils.all} ${StringUtils.userList}"),
      child: Tab(text: StringUtils.all),
    ),
    const CommonToolTip(
      message: ("${StringUtils.accepted} ${StringUtils.userList}"),
      child: Tab(text: StringUtils.accepted),
    ),
    const CommonToolTip(
      message: ("${StringUtils.pending} ${StringUtils.userList}"),
      child: Tab(text: StringUtils.pending),
    ),
  ];

  tabBar() {
    tabController = TabController(length: tabBarList.length, vsync: this);
    tabController?.addListener(() {});
  }

  RxBool isUserLoading = false.obs;

  fetchUserData() async {
    isUserLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .where("gym_id", isEqualTo: adminId)
          .get()
          .then((value) async {
        userList = List.from(value.docs.map((doc) {
          final data = doc.data();
          return SideMenuModel.fromJson(data);
        }));
        await fetchAcceptedUserList();
        await fetchPendingUserList();
      });
      update();
    } catch (e) {
      print("===> fetchUserData $e");
    } finally {
      isUserLoading.value = false;
    }
  }

  var acceptedUserList = [].obs;
  RxBool isUserAcceptLoading = false.obs;

  fetchAcceptedUserList() {
    isUserAcceptLoading.value = true;
    try {
      acceptedUserList.value =
          userList.where((e) => e.isVerified == true).toList();
    } catch (e) {
      print("===> fetchAcceptedUserList $e");
    } finally {
      isUserAcceptLoading.value = false;
    }
  }

  var pendingUserList = [].obs;
  RxBool isUserPendingLoading = false.obs;

  fetchPendingUserList() {
    isUserPendingLoading.value = true;
    try {
      pendingUserList.value =
          userList.where((e) => e.isVerified == false).toList();
    } on Exception catch (e) {
      print("===> fetchPendingUserList $e");
    } finally {
      isUserPendingLoading.value = false;
    }
  }

  acceptRequest(
      {required bool isVerified,
      required int index,
      required String uid}) async {
    acceptLoading.value = true;
    try {
      print(uid);
      if (uid != "") {
        await FirebaseRepository.updateData(key: "Users", uId: uid, data: {
          'IsVerified': isVerified,
        });
      } else {
        if (kDebugMode) {
          print("🚀🚀🚀🚀🚀🚀🚀🚀🚀    UID Null    🚀🚀🚀🚀🚀🚀🚀🚀🚀");
        }
      }
      await fetchUserData();
      update();
    } on Exception catch (e) {
      print(e);
    } finally {
      acceptLoading.value = false;
    }
  }

  declineRequest({
    required bool isVerified,
    required BuildContext context,
    required String uid,
  }) async {
    declineLoading.value = true;
    if (uid != "") {
      await FirebaseRepository.updateData(key: "Users", uId: uid, data: {
        'IsVerified': isVerified,
      });
    } else {
      if (kDebugMode) {
        print("🚀🚀🚀🚀🚀🚀🚀🚀🚀    UID Null    🚀🚀🚀🚀🚀🚀🚀🚀🚀");
      }
    }
    declineLoading.value = false;
    await fetchUserData();
    appRouter.maybePop();
    update();
  }

  @override
  void onInit() {
    tabBar();
    adminId = FirebaseAuth.instance.currentUser?.uid ?? "";
    // adminUid.value = adminId;
    print(adminId);
    fetchUserData();
    super.onInit();
  }

  @override
  void onClose() {
    tabController;
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_delete_dialouge.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/common_components/common_tool_tip.dart';
import 'package:gym_app/model/side_menu_model.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/controller/user_list_controller.dart';
import 'package:gym_app/utils/color.dart';
import 'package:gym_app/utils/string.dart';
import 'package:intl/intl.dart';

import '../../../../../injection_container.dart';
import '../../../../../routes/app_route_config.dart';
import '../user_details_view.dart';

class UserListAccepted extends StatelessWidget {
  final SideMenuModel acceptedList;
  final int? index;

  const UserListAccepted({super.key, required this.acceptedList, this.index});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    final dateTime = acceptedList.updatedAt?.toDate();
    final dateFormat =
        DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime.now());

    return GetBuilder<UserListController>(
      builder: (userListController) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorUtils.bg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserDetailsView(
                        fieldName: "Name : ",
                        fieldValue: acceptedList.name ?? ""),
                    UserDetailsView(
                        fieldName: "Email : ",
                        fieldValue: acceptedList.email ?? ""),
                    UserDetailsView(
                        fieldName: "Date : ", fieldValue: dateFormat),
                  ],
                ),
              ),
              GetBuilder<UserListController>(
                builder: (controller) => _buildBtn(
                  commonToolTipMsg:
                      ("${StringUtils.remove} ${StringUtils.userList}"),
                  child: const Icon(
                    Icons.close,
                    size: 25,
                    color: ColorUtils.white,
                  ),
                  color: ColorUtils.error,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(
                          () => CommonDeleteDialouge(
                            permissionString: StringUtils.removePermission,
                            title: acceptedList.name ?? "",
                            btnNameGoBack: StringUtils.cancel,
                            onPressedGoBack: () {
                              appRouter.maybePop();
                            },
                            child: userListController.declineLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorUtils.white,
                                    ),
                                  )
                                : Text(
                                    StringUtils.remove,
                                    style: commonTextStyle(),
                                  ),
                            onPressedDelete: () async {
                              await userListController.declineRequest(
                                context: context,
                                isVerified: false,
                                uid: acceptedList.userId ?? "",
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBtn(
      {required GestureTapCallback onTap,
      required Widget child,
      required String commonToolTipMsg,
      required Color color}) {
    return CommonToolTip(
      message: commonToolTipMsg,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/common_components/common_delete_dialouge.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/common_components/common_tool_tip.dart';
import 'package:gym_app/model/side_menu_model.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/controller/user_list_controller.dart';
import 'package:gym_app/utils/color.dart';
import 'package:gym_app/utils/string.dart';
import 'package:intl/intl.dart';

import '../../../../../injection_container.dart';
import '../../../../../routes/app_route_config.dart';
import '../user_details_view.dart';

class UserListView extends StatelessWidget {
  final SideMenuModel userList;
  final int? index;

  const UserListView({super.key, required this.userList, this.index});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    final dateTime = userList.updatedAt?.toDate();
    final dateFormat =
        DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime.now());

    return GetBuilder<UserListController>(
      builder: (userListController) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorUtils.bg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserDetailsView(
                        fieldName: "Name : ", fieldValue: userList.name ?? ""),
                    UserDetailsView(
                        fieldName: "Email : ",
                        fieldValue: userList.email ?? ""),
                    UserDetailsView(
                        fieldName: "Date : ", fieldValue: dateFormat),
                  ],
                ),
              ),
              GetBuilder<UserListController>(
                builder: (controller) => userList.isVerified == false
                    ? userListController.acceptLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorUtils.background,
                            ),
                          )
                        : _buildBtn(
                            commonToolTipMsg:
                                ("${StringUtils.accept} ${StringUtils.userList}"),
                            child: const Icon(
                              Icons.check,
                              size: 25,
                              color: ColorUtils.white,
                            ),
                            color: ColorUtils.success,
                            onTap: () => userListController.acceptRequest(
                                uid: userList.userId ?? "",
                                isVerified: true,
                                index: index ?? 0),
                          )
                    : const SizedBox(),
              ),
              const SizedBox(width: 12),
              GetBuilder<UserListController>(
                builder: (controller) => userList.isVerified == false
                    ? userListController.declineLoading.value
                        ? const Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: ColorUtils.white,
                              ),
                            ),
                          )
                        : _buildBtn(
                            commonToolTipMsg:
                                ("${StringUtils.remove} ${StringUtils.userList}"),
                            child: const Icon(
                              Icons.close,
                              size: 25,
                              color: ColorUtils.white,
                            ),
                            color: ColorUtils.error,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Obx(
                                    () => userListController
                                            .declineLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: ColorUtils.background,
                                            ),
                                          )
                                        : CommonDeleteDialouge(
                                            permissionString:
                                                StringUtils.removePermission,
                                            title: userList.name ?? "",
                                            btnNameGoBack: StringUtils.cancel,
                                            onPressedGoBack: () {
                                              appRouter.maybePop();
                                            },
                                            child: Text(
                                              StringUtils.remove,
                                              style: commonTextStyle(),
                                            ),
                                            onPressedDelete: () async {
                                              await userListController
                                                  .declineRequest(
                                                context: context,
                                                isVerified: false,
                                                uid: userList.userId ?? "",
                                              );
                                            },
                                          ),
                                  );
                                },
                              );
                            })
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBtn(
      {required GestureTapCallback onTap,
      required Widget? child,
      required String commonToolTipMsg,
      required Color color}) {
    return CommonToolTip(
      message: commonToolTipMsg,
      child: InkWell(
        onTap: onTap,
        child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child),
      ),
    );
  }
}

class UserListTabBar extends StatelessWidget {
  const UserListTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userListController = Get.find<UserListController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TabBar(
        isScrollable: true,
        onTap: userListController.tabBar(),
        controller: userListController.tabController,
        tabs: userListController.tabBarList,
        unselectedLabelStyle:
            commonTextStyle(color: ColorUtils.black.withOpacity(0.68)),
        labelStyle: commonTextStyle(color: ColorUtils.background),
        indicatorColor: ColorUtils.background,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../common_components/common_text_style.dart';
import '../../../../utils/color.dart';

class UserDetailsView extends StatelessWidget {
  final String? fieldName;
  final String? fieldValue;

  const UserDetailsView({super.key, this.fieldName, this.fieldValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            fieldName ?? "",
            style: commonTextStyle(
              fontSize: 15,
              color: ColorUtils.background,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            fieldValue ?? "",
            style: commonTextStyle(color: ColorUtils.background, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/controller/user_list_controller.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/widget/tab_bar_widget.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/widget/tab_screen_view/user_list_accepted.dart';
import 'package:gym_app/screens/side_menu_screen/user_list_screen/widget/tab_screen_view/user_list_view.dart';
import 'package:gym_app/utils/color.dart';

import '../../../common_components/common_empty_view.dart';
import '../../../utils/string.dart';

@RoutePage()
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserListController>(
      init: UserListController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserListTabBar(),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorUtils.white,
                  ),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Obx(
                        () => controller.isUserLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorUtils.background,
                                ),
                              )
                            : controller.userList.isEmpty
                                ? _buildEmptyView(
                                    emptyText:
                                        StringUtils.allUserEmptyValidation,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.userList.length,
                                    itemBuilder: (context, index) {
                                      final userData =
                                          controller.userList[index];
                                      return Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          UserListView(
                                            userList: userData,
                                            index: index,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                      Obx(
                        () => controller.isUserAcceptLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorUtils.background,
                                ),
                              )
                            : controller.acceptedUserList.isEmpty
                                ? _buildEmptyView(
                                    emptyText:
                                        StringUtils.acceptedUserEmptyValidation,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.acceptedUserList.length,
                                    itemBuilder: (context, index) {
                                      final userListAccepted =
                                          controller.acceptedUserList[index];
                                      return Column(
                                        children: [
                                          const SizedBox(height: 11),
                                          UserListAccepted(
                                            acceptedList: userListAccepted,
                                            index: index,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                      Obx(
                        () => controller.isUserPendingLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorUtils.background,
                                ),
                              )
                            : controller.pendingUserList.isEmpty
                                ? _buildEmptyView(
                                    emptyText:
                                        StringUtils.pendingUserEmptyValidation,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.pendingUserList.length,
                                    itemBuilder: (context, index) {
                                      final userData =
                                          controller.pendingUserList[index];
                                      return Column(
                                        children: [
                                          const SizedBox(height: 11),
                                          UserListView(
                                            userList: userData,
                                            index: index,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildEmptyView({required String emptyText}) {
    return CommonEmptyView(emptyText: emptyText);
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/common_components/common_text_style.dart';
import 'package:gym_app/generated/assets.dart';
import 'package:gym_app/helper/get_storage/get_storage.dart';
import 'package:gym_app/utils/color.dart';
import 'package:gym_app/utils/string.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../../injection_container.dart';
import '../../routes/app_route_config.dart';
import '../../routes/app_route_config.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppRouter appRouter = getIt<AppRouter>();

  @override
  void initState() {
    stayLogin();
    super.initState();
  }

  stayLogin() async {
    if (GetStorageServices.readMethod(key: GetStorageServices.adminId) !=
            null &&
        GetStorageServices.readMethod(key: GetStorageServices.adminId) != "") {
      Future.delayed(
        const Duration(seconds: 9),
        () {

          // if (html.window.location.href.contains("/")) {
          //   html.window.history.replaceState(null, 'Dashboard', '/dashboard');
          // }
          context.router.replaceAll([const DashboardRoute()]);
          // context.router.replaceAll([const DashboardRoute()]);
          // appRouter.replace( const DashboardRoute());
          // appRouter.replaceAll(const DashboardRoute() as List<PageRouteInfo>);
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 9),
        () {

          print("llllllllllllllllll");
          context.router.replace(const LoginRoute());

          // context.router.replace(const DashboardRoute());
          // context.router.replaceAll([const LoginRoute()]);
          // appRouter.replace(const LoginRoute());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
            duration: const Duration(seconds: 1)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.pngSplashImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultTextStyle(
                style: commonTextStyle(
                  fontSize: 25,
                  color: ColorUtils.white.withOpacity(0.8),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText("Breath"),
                    WavyAnimatedText("Train"),
                    WavyAnimatedText("Achieve"),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                StringUtils.gymApp,
                style: commonTextStyle(fontSize: 50),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ColorUtils {
  static const Color white = Colors.white;
  static const Color whiteTextFieldBorder = Colors.white54;
  static const Color black = Colors.black;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color transparent = Colors.transparent;
  static const Color background = Color(0xff0A194A);
  static const Color boxShadow = Color(0xff7a92de);
  static const Color blue = Color(0xff2E23A7);
  static const Color purple = Color(0xff332377);
  static const Color lightPurple = Color(0xff7236FB);
  static const Color fillColor = Color(0xff1B2956);
  static const Color bg = Color(0xffD7DAEE);
}
class StringUtils {
  static const String gymApp = "Gym App";
  static const String login = "LOGIN";
  static const String register = "REGISTER";
  static const String signup = "Signup";
  static const String logout = "Logout";
  static const String loginHere = "You can Login Here";
  static const String signupHere = "You can Register Here";
  static const String email = "Email";
  static const String userName = "Username";
  static const String confirmPassword = "Confirm Password";
  static const String password = "Password";
  static const String forgotPassword = "Forgot your password?";
  static const String letsJoinUs = "Let's join us :)";
  static const String selectedAGym = "Select a Gym";
  static const String userList = "User";
  static const String exerciseList = "Exercise";
  static const String muscleSet = "Muscle";
  static const String workOutSet = "Gym App";
  static const String back = "Back";
  static const String create = "Create";
  static const String delete = "Delete";
  static const String cancel = "Cancel";
  static const String edit = "Edit";
  static const String all = "All";
  static const String accepted = "Accepted";
  static const String pending = "Pending";
  static const String remove = "Remove";
  static const String accept = "Accept";
  static const String exercise = "Exercise";
  static const String muscle = "Muscle";
  static const String workout = "Workout";
  static const String update = "Update";
  static const String save = "Save";
  static const String selectImage = "Select Image";
  static const String selectGif = "Select GIF";
  static const String selectFrom = "Select Form";
  static const String dropHere = "Drop Here";
  static const String deletePermission = "Are you sure you want to delete?";
  static const String removePermission = "Are you sure you want to remove?";
  static const String logoutPermission = "Are you sure you want to logout?";
  static const String allUserEmptyValidation =
      "Add new users or manage existing users here.";
  static const String acceptedUserEmptyValidation =
      "No user requests have been accepted yet.";
  static const String pendingUserEmptyValidation =
      "No user requests are currently pending.";
  static const String exerciseEmptyValidation =
      "No exercises added yet. Manage your exercises here.";
  static const String muscleEmptyValidation =
      "No muscle sets found. Manage your muscle sets here.";
  static const String workoutEmptyValidation =
      "No workout plans available. Start building plans here.";
}
import 'package:get_it/get_it.dart';
import 'package:gym_app/routes/app_route_config.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  GetIt.instance.registerSingleton<AppRouter>(AppRouter());
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/routes/app_route_config.dart';

import 'injection_container.dart';

Future<void> main() async {
  await initGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB83Xefgp7Kera-jEjFSOuZGom8p8QRyfI",
        appId: "1:418098993920:web:1ea9b84f6bf1ce5fd5f1e5",
        messagingSenderId: "418098993920",
        projectId: "gym-app-def5e",
        storageBucket: "gym-app-def5e.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = getIt<AppRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: ThemeData(
        fontFamily: "Poppins",
        useMaterial3: false,
      ),
    );
  }
}
name: gym_app
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: '>=3.3.1 <4.0.0'

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.6
#  go_router: ^14.0.2
  auto_route: ^9.2.0
  get: ^4.6.6
  intl: ^0.19.0
  image_picker: ^1.0.7
  drag_and_drop_lists: ^0.3.3
  path: ^1.9.0
  firebase_core: ^2.31.0
  firebase_storage: ^11.7.5
  cloud_firestore: ^4.15.10
  get_storage: ^2.1.1
  firebase_auth: ^4.19.5
  universal_html: ^2.2.4
  flutter_easyloading: ^3.0.5
  animated_text_kit: ^4.2.2
  widget_and_text_animator: ^1.1.5
  get_it: ^8.0.3
  go_router: ^14.6.3

dev_dependencies:
  auto_route_generator: ^9.0.0
  build_runner:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^3.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/poppins_thin.ttf
          weight: 100
        - asset: assets/fonts/poppins_extra_light.ttf
          weight: 200
        - asset: assets/fonts/poppins_light.ttf
          weight: 300
        - asset: assets/fonts/poppins_regular.ttf
          weight: 400
        - asset: assets/fonts/poppins_medium.ttf
          weight: 500
        - asset: assets/fonts/poppins_semi_bold.ttf
          weight: 600
        - asset: assets/fonts/poppins_bold.ttf
          weight: 700
        - asset: assets/fonts/poppins_extra_bold.ttf
          weight: 800
        - asset: assets/fonts/poppins_black.ttf
          weight: 900

  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages
  assets:
    - assets/icons/png/
    - assets/icons/svg/

