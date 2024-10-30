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
// lib/utils/strings.dart

class Strings {
  // Onboarding Titles
  static const String onboardingTitle1 = "Book with ease, travel with joy";
  static const String onboardingTitle2 =
      "Discover and find your perfect healing place";
  static const String onboardingTitle3 = "Giving the best deal just for you";

  // Onboarding Descriptions
  static const String onboardingDescription1 =
      '"Discover a seamless booking experience with our user-friendly interface and exclusive deals."';
  static const String onboardingDescription2 =
      '"Escape to a world of tranquility and rejuvenation. Discover our curated selection of wellness retreats and healing spaces."';
  static const String onboardingDescription3 =
      '"Get exclusive offers and discounts on hotels, flights, and packages, curated just for your travel style."';

  // Button Texts
  static const String nextButton = "Next";

  // General Strings
  static const String welcome = "Welcome";
  static const String gladToSeeYou = "Glad to see you!";

  // Form Labels
  static const String rememberMe = "Remember me";
  static const String forgetPassword = "Forget password?";
  static const String loginButton = "Login";
  static const String dontHaveAccount = "Don’t have an account?";

  // Validation Messages
  static const String emailEmpty = 'The email field is required.';
  static const String invalidEmail = 'Invalid email. Please enter your registered email';
  static const String passwordEmpty = 'Please enter your password';
  static const String shortPassword = 'Password must be at least 6 characters';

  // Hint texts
  static const String nameHint = 'Enter your name';
  static const String mobileNumberHint = 'Enter your Mobile Number';
  static const String emailHint = 'Enter Your Email';
  static const String passwordHint = 'Enter your Password';
  static const String confirmPasswordHint = 'Confirm Password';
  static const String addProfileImage = 'Add Profile Image';

  // Labels
  static const String createAccount = 'Create Account';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String nameLabel = 'Name';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String emailLabel = 'Email';
  static const String signUp = ' Sign Up';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String login = 'Login';

  // Error messages
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

  // verification
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
  static const String wholePlacetoGuests = "Whole place to Guests";
  static const String privateRoom = "Private Room";
  static const String guestsSleepInPrivateRoomButSomeAreasAreShared =
      "Guests sleep in private room but some areas are shared";
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
  static const String defultbedrooms = '6 Bedrooms';
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
  static const String updateAndExit = 'Update and Exit ';
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String trips = 'Trips';
  static const String helloJhon = 'Hello Jhon!';
  static const String welcomeToTravelbud = 'Welcome to Travelbud.';
  static const String search = 'Search';
  static const String delhi = 'Delhi';
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
import 'package:travellery_mobile/travellery_mobile/utils/app_validation.dart';
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
                              const BorderRadius.all(Radius.circular(100)),
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
                                            controller.pickImage(ImageSource.gallery);
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
                  validator: AppValidation.validateName,
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
                  obscureText: !controller.isSignUpPasswordVisible.value,
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
                  onSaved:(value) => controller.confirmPassword.value = value!,
                  obscureText: !controller.isConfirmPasswordVisible.value,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_validation.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../routes_app/all_routes_app.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';
import '../../common_view/common_topview_forget_pages.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();
  bool isValidating = false;

  @override
  Widget build(BuildContext context) {
    return TopView(
      title: Strings.forgetPassword,
      promptText: Strings.forgetPasswordPrompt,
      content: Form(
        key: _formKey,
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
                controller.email.value = value;
                setState(() {
                  if(_formKey.currentState!.validate()){
                    isValidating = false;
                  }else{
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    controller.sendVerificationCode(email: controller.forgotPasswordEmailController.text);
                  }
                },
            ),
            SizedBox(height: 2.5.h),
            Center(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.offNamed(Routes.login);
                },
                child: Text(
                  Strings.cancel,
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
import 'dart:async';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

class VerificationController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  RxInt remainingTime = 150.obs;
  Timer? timer;


  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        onTimerComplete();
      }
    });
  }

  void onTimerComplete() {
    Get.back();
    authController.verificationController.clear();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  String get formattedTime {
    int minutes = remainingTime.value ~/ 60;
    int seconds = remainingTime.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} minutes";
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';
import '../../../../../common_widgets/common_button.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../common_view/common_topview_forget_pages.dart';
import '../controller/verification_controller.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationController controller = Get.find();
   final AuthController authController = Get.find<AuthController>();
    return TopView(
      title: Strings.verificationCodeTitle,
      promptText: Strings.verificationCodePrompt+authController.email.value,
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
            controller: authController.verificationController,
            appContext: context,
            length: 6,textStyle: FontManager.regular(23,color: AppColors.black),
            obscureText: false,
            animationType: AnimationType.fade,keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              borderWidth: 1,
              fieldHeight: 42,inactiveBorderWidth: 1.5,selectedBorderWidth: 2,activeBorderWidth: 1.5,
              fieldWidth: 43,
              inactiveColor: AppColors.texFiledColor,
              activeColor:  AppColors.greyText,
              selectedColor:  AppColors.greyText,
              errorBorderColor: AppColors.errorTextfieldColor,
            ),
            onChanged: (value) {},
          ),
          SizedBox(height: 3.h),
          Obx(() {
            return Text(
              controller.formattedTime,
              style: FontManager.regular(12, color: AppColors.textAddProreties),
            );
          }),
          SizedBox(height: 201),
          CommonButton(
            title: Strings.verify,

            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (authController.verificationController.text.length == 6) {
              authController.verifyVerificationCode();
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
                authController.sendVerificationCode(email: authController.verificationController.text);
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
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../controller/add_properties_controller.dart';

class CheckInOutDetailsPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CheckInOutDetailsPage({super.key, required this.onNext, required this.onBack});

  @override
  State<CheckInOutDetailsPage> createState() => _CheckInOutDetailsPageState();
}

class _CheckInOutDetailsPageState extends State<CheckInOutDetailsPage> {
  final AddPropertiesController  controller = Get.find<AddPropertiesController>();

  @override
  Widget build(BuildContext context) {
    return CustomAddPropertiesPage(
      body: Column(
        children: [
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Strings.checkInTime,
                  style: FontManager.medium(color: AppColors.black, 16)),
            ],
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: TimePickerSpinner(
              locale: const Locale('en', ''),
              time: controller.checkInTime.value,
              is24HourMode: false,
              isShowSeconds: true,itemWidth: 40,
              itemHeight: 80,alignment: Alignment.bottomLeft,
              normalTextStyle: FontManager.regular(20.sp),
              highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
              isForce2Digits: true,
              onTimeChange: (time) {
                controller.checkInTime.value = time;
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Checkbox(activeColor: AppColors.buttonColor,
                value: controller.flexibleWithCheckInTime.value,
                onChanged: (bool? newValue) {
                  controller.flexibleWithCheckInTime.value = newValue ?? false;
                  controller.checkInTimeUpdate(controller.flexibleWithCheckInTime.value);
                },
                side: const BorderSide(color: AppColors.texFiledColor),
              )),
              Text(Strings.flexibleWithCheckInTime,
                  style: FontManager.regular(color: AppColors.black, 14)),
              const Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Strings.checkOutTime,
                  style: FontManager.medium(color: AppColors.black, 16)),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TimePickerSpinner(
              locale: const Locale('en', ''),
              time: controller.checkOutTime.value,
              is24HourMode: false,
              isShowSeconds: true,itemWidth: 40,
              itemHeight: 80,alignment: Alignment.bottomLeft,
              normalTextStyle: FontManager.regular(20.sp),
              highlightedTextStyle: FontManager.semiBold(20, color: AppColors.buttonColor),
              isForce2Digits: true,
              onTimeChange: (time) {
                controller.checkOutTime.value = time;
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Checkbox(activeColor: AppColors.buttonColor,
                value: controller.flexibleWithCheckInOut.value,
                onChanged: (bool? newValue) {
                  controller.flexibleWithCheckInOut.value = newValue ?? false;
                  controller.checkOutTimeUpdate(controller.flexibleWithCheckInOut.value);
                },
                side: const BorderSide(color: AppColors.texFiledColor),
              )),
              Text(
                Strings.flexibleWithCheckInTime,
                style: FontManager.regular(color: AppColors.black, 14),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../common_widgets/accommodation_type_of_place.dart';
import '../../../../../utils/app_radius.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../common_widgets/accommondation_details.dart';
import '../../controller/add_properties_controller.dart';
import '../../custom_add_properties_pages/custom_add_properties_pages.dart';

class AccommodationDetailsPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AccommodationDetailsPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final AddPropertiesController controller = Get.find<AddPropertiesController>();

    return CustomAddPropertiesPage(
      body: buildBody(controller),
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
          value: 'entirePlace',
          controller: controller,
        ),
        const SizedBox(height: 20),
        buildAccommodationOption(
          title: Strings.privateRoom,
          subtitle: Strings.guestsSleepInPrivateRoomButSomeAreasAreShared,
          imageAsset: Assets.imagesPrivateRoom,
          value: 'privateRoom',
          controller: controller,
        ),
        SizedBox(height: 4.h),
        buildCustomContainer(Assets.imagesMaxGuests, Strings.maxGuests,
            controller.maxGuestsCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesSingleBed, Strings.singleBed,
            controller.singleBedCount),
        SizedBox(height: 2.h),
        buildCustomContainer(Assets.imagesBedRooms, Strings.bedRooms,
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
              Spacer(),
              Obx(() => Text(Strings.yes,style: FontManager.regular(14,color:  controller.isKitchenAvailable.value ? AppColors.black : AppColors.greyText),)),
              Obx(() {
                 return   Switch(
                   value: controller.isKitchenAvailable.value,
                   onChanged: (value) {
                     controller.isKitchenAvailable.value = value;
                   },
                   activeColor: AppColors.buttonColor,
                 );
              }),
              Obx(() => Text(Strings.no,style: FontManager.regular(14,color:  controller.isKitchenAvailable.value ? AppColors.greyText : AppColors.black),)),

            ],
          ),
        ),
        SizedBox(height: 16),
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
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import '../../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/font_manager.dart';


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
            imageAsset,
            height: 26,
            width: 26,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: FontManager.regular(14, color: AppColors.black),
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.find<AddPropertiesController>().decrement(count);
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
                  Get.find<AddPropertiesController>().increment(count);
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
}import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

import '../screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/font_manager.dart';

Widget buildAccommodationOption({
  required String title,
  required String subtitle,
  required String imageAsset,
  required String value,
  required AddPropertiesController controller,
  // final Function(String) onChanged;
  // final bool isSelected;
}) {
  return GestureDetector(
    onTap: () {},
    child: Obx(() {
      bool isSelected = controller.selectedAccommodation.value == value;
      return Container(
        width: double.infinity,
        height: 9.3.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectContainerColor : Colors.white,
          borderRadius: BorderRadius.all(AppRadius.radius10),
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
                  SizedBox(height: 2),
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
          const SizedBox(height: 10),
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

  // Widget photoUploadRows() {
  //   int imagesPerRow = 2;
  //   int totalImages = controller.imagePaths.length;
  //
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: imagesPerRow,
  //       childAspectRatio: 1.4,
  //       crossAxisSpacing: 10.0,
  //       mainAxisSpacing: 10.0,
  //     ),
  //     itemCount: totalImages,
  //     itemBuilder: (context, index) {
  //       int uploadedImages =  controller.imagePaths.where((paths) => paths.isNotEmpty).length;
  //
  //       return GestureDetector(
  //         onTap: () async {
  //           var result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true,
  //           );
  //
  //           if (result != null && result.paths.isNotEmpty) {
  //             List<String> selectedPaths =
  //                 result.paths.map((path) => path!).toList();
  //             if (selectedPaths.length > 5) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                     content: Text('You can only select up to 5 images.')),
  //               );
  //               return;
  //             }
  //
  //             setState(() {
  //               controller.imagePaths[index] = selectedPaths;
  //             });
  //           }
  //         },
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             PhotoUploadContainer(
  //               index: index,
  //               imagePath: controller.imagePaths[index].isNotEmpty
  //                   ? controller.imagePaths[index].first
  //                   : null,
  //               onImageSelected: (paths) {
  //                 setState(() {
  //                   controller.imagePaths[index] = paths!.split(",");
  //                 });
  //               },
  //               isSingleSelect: false,
  //             ),
  //             if (controller.imagePaths[index].isNotEmpty)
  //               CircularPercentIndicator(
  //                 radius: 23,
  //                 lineWidth: 2.0,
  //                 animation: true,
  //                 circularStrokeCap: CircularStrokeCap.round,
  //                 percent: controller.imagePaths[index].length / 5,
  //                 center: Text(
  //                   "${(controller.imagePaths[index].length / 5 * 100).toStringAsFixed(0)}%",
  //                   style: FontManager.regular(13, color: AppColors.white),
  //                 ),
  //                 progressColor: AppColors.white,
  //                 footer: Text(
  //                   Strings.uploadingImage,
  //                   style: FontManager.regular(12, color: AppColors.white),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
        return PhotoUploadContainer(
          index: index,
          imagePath: controller.imagePaths[index],
          onImageSelected: (path) {
            setState(() {
              controller.imagePaths[index] = path;
            });
          },
          isSingleSelect: true,
        );
      },
    );
  }
}
 import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
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
        imagePath == null
            ? DottedBorder(
          borderType: BorderType.RRect,color: AppColors.texFiledColor,strokeWidth: 1,
          radius: Radius.circular(10),
          child: Container(
            height: 130,
            width: 150.w,
            decoration: BoxDecoration(
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
                        style: FontManager.regular(10, color: AppColors.greyText),
                      ),
                      TextSpan(
                        mouseCursor: SystemMouseCursors.click,
                        style: FontManager.regular(10, color: AppColors.buttonColor),
                        text: Strings.chooseFile,
                        recognizer: TapGestureRecognizer()..onTap = () async {

                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: isSingleSelect,
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
                        style: FontManager.regular(10, color: AppColors.greyText),
                        text: Strings.to,
                      ),
                      TextSpan(
                        style: FontManager.regular(10, color: AppColors.greyText),
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
            borderRadius: BorderRadius.all(AppRadius.radius10),
            image: DecorationImage(
              image: FileImage(File(imagePath!)),
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
} import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/controller/add_properties_controller.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/custom_add_properties_pages/custom_add_properties_pages.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/font_manager.dart';
import '../../../../../utils/textFormField.dart';
import '../../common_widget/common_add_container.dart';
import '../../common_widget/common_add_textfield.dart';

class PriceAndContactDetailsPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PriceAndContactDetailsPage(
      {super.key, required this.onNext, required this.onBack});

  @override
  State<PriceAndContactDetailsPage> createState() =>
      _PriceAndContactDetailsPageState();
}

class _PriceAndContactDetailsPageState
    extends State<PriceAndContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddPropertiesController(),
      builder: (controller) => CustomAddPropertiesPage(
        body: Column(
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
                        style: FontManager.regular(14, color: AppColors.black),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
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
                        style: FontManager.regular(14, color: AppColors.black),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
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
              style: FontManager.semiBold(18, color: AppColors.buttonColor),
            ),
            SizedBox(height: 1.5.h),
            Text(Strings.ownerContactNo, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              keyboardType: TextInputType.number,
              hintText: Strings.mobileNumberHint,
              validator: (value) {
                if (value!.isEmpty) {
                  return Strings.mobileNumberError;
                } else if (value.length < 10) {
                  return Strings.mobileNumberLengthError;
                }
                return null;
              },
              onSaved: (value) {
                controller.ownerContactNumber.value = value!;
              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.ownerEmailID,
                style: FontManager.regular(14, color: AppColors.black)),
            SizedBox(height: 0.5.h),
            CustomTextField(
              hintText: Strings.emailHint,
              validator: (value) {
                if (value!.isEmpty) {
                  return Strings.emailEmpty;
                } else if (!GetUtils.isEmail(value)) {
                  return Strings.invalidEmail;
                }
                return null;
              },
              onChanged: (value) {
                controller.ownerEmail.value = value;
              },
            ),
            SizedBox(height: 3.h),
            Text(
              Strings.homeStayDetails,
              style: FontManager.semiBold(18, color: AppColors.buttonColor),
            ),
            SizedBox(height: 1.5.h),
            Text(Strings.homeStayContactNo, style: FontManager.regular(14)),
            SizedBox(height: 0.5.h),
            controller.homeStayContactNumbers.isNotEmpty
                ? CommonAddContainer(
                    items: controller.homeStayContactNumbers,
                    onRemove: (index) {
                      controller.removeHomeStayContactNumber(index);
                    },
                  )
                : SizedBox.shrink(),
            controller.homeStayContactNumbers.isNotEmpty
                ? SizedBox(
                    height: 2.h,
                  )
                : SizedBox.shrink(),
            CommonAddTextfield(
              controller: controller.homeStayContactNumbersController,
              itemCount: controller.homeStayContactNumbers.length,
              hintText: Strings.homeStayContactNo,
              keyboardType: TextInputType.number,
              onAdd: (newAdd) {
                controller.addHomeStayContactNumber(newAdd);
              },
            ),
            SizedBox(height: 3.h),
            Text(Strings.homeStayEmailID,
                style: FontManager.regular(14, color: AppColors.black)),
            SizedBox(height: 0.5.h),
            controller.homeStayContactNumbers.isNotEmpty
                ? CommonAddContainer(
                    items: controller.homeStayEmails,
                    onRemove: (index) {
                      controller.removeHomeStayEmails(index);
                    },
                  )
                : SizedBox.shrink(),
            controller.homeStayContactNumbers.isNotEmpty
                ? SizedBox(height: 2.h)
                : SizedBox.shrink(),
            CommonAddTextfield(
              controller: controller.homeStayEmailsController,
              itemCount: controller.homeStayEmails.length,
              hintText: Strings.enterHomeStayEmailID,
              onAdd: (newAdd) {
                controller.addHomeStayEmails(newAdd);
              },
            ),
          ],
        ),
      ),
    );
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
    if (currentPage.value < 10) {
      if(currentPage.value == 6){
        Get.toNamed(Routes.location);
        return;
      }
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),

        curve: Curves.easeIn,
      );
    } else {
      homeStayAddData();


      Get.toNamed(Routes.previewPage, arguments: {
        'index': 0,
      },);
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
    super.onInit();
    selectedAmenities.addAll(List.generate(customAmenities.length, (_) => false));
    selectedRules.addAll(List.generate(customRules.length, (_) => false));
    createAllAmenities();
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
  var imagePaths = List<String?>.filled(6, null).obs;
  // var imagePaths = List<List<String?>>.filled(6, []).obs;

  // description Page add logic
  var description = ''.obs;

  void setDescription(String value) {
    description.value = value;
    update();
  }

  // Price and Contact details page logic

  var basePrice = ''.obs;
  var weekendPrice = ''.obs;
  var ownerContactNumber = ''.obs;
  var ownerEmail = ''.obs;
  var homeStayContactNumbers = <String>[].obs;
  TextEditingController homeStayContactNumbersController = TextEditingController();

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
     "amenities":jsonEncode(allAmenities.map((amenity) {
       int index = allAmenities.indexOf(amenity);
       return {
         "name": amenity,
         "isChecked": selectedAmenities[index],
         "isNewAdded": selectedAmenities.length > customAmenities.length && index >= customAmenities.length,
       };
     }).toList()),
       "houseRules":jsonEncode(allRules.map((rules) {
         int index = allRules.indexOf(rules);
         return {
           "name": rules,
           "isChecked": selectedRules[index],
           "isNewAdded": selectedRules.length > customRules.length && index >= customRules.length,
         };
       }).toList()),
       "checkInTime": checkInTime.value,
       "checkOutTime": checkOutTime.value,
       "flexibleCheckIn": flexibleWithCheckInTime.value,
       "flexibleCheckOut": flexibleWithCheckInOut.value,
       "longitude": "72.88692069643963",
       "latitude": "21.245049600735083",
       "address":  address.value,
       "street": streetAddress.value,
       "landmark": landmark.value,
       "city": city.value,
       "pinCode": pinCode.value,
       "state": state.value,
       "showSpecificLocation": isSpecificLocation,
       "coverPhoto": await dio.MultipartFile.fromFile(coverImagePaths[0]!, filename: "coverPhoto.jpg"),
       // "homestayPhotos": ,
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
     // for (int index = 0; index < imagePaths.length; index++) {
     //   if (imagePaths[index] != null) {
     //     formData.files.add(MapEntry(
     //       "homestayPhotos:",
     //       await dio.MultipartFile.fromFile(imagePaths[index]!, filename: "photo_$index.jpg"),
     //     ));
     //   }
     // }
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
        return flexibleWithCheckInTime.value || flexibleWithCheckInOut.value == true;
      case 7:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 8:
        return address.value.isNotEmpty && streetAddress.value.isNotEmpty && landmark.value.isNotEmpty && city.value.isNotEmpty && pinCode.value.isNotEmpty && state.value.isNotEmpty;
      case 9:
        return description.value.isNotEmpty;
      case 10:
        return basePrice.value.isNotEmpty;
      default:
        return false;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../utils/font_manager.dart';

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
        itemBuilder: (context,index) {
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
                      style: FontManager.regular(16, color: AppColors.textAddProreties),
                    ),
                    Spacer(),
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
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../utils/font_manager.dart';

class CommonAddTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onAdd;
  final int itemCount;
  final TextInputType? keyboardType;

  const CommonAddTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onAdd,
    required this.itemCount,
    this.keyboardType,
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
                  keyboardType: keyboardType,
                  controller: controller,
                  style: FontManager.regular(16),
                  decoration: InputDecoration(
                    hintText: "$hintText ${itemCount + 1}",
                    hintStyle: FontManager.regular(16, color: AppColors.greyText),
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/common_widget/common_add_textfield.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../common_widget/common_add_container.dart';
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
import 'package:travellery_mobile/travellery_mobile/screen/add_properties_screen/steps/common_widget/common_add_textfield.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_colors.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../common_widgets/common_button.dart';
import '../../../../../../utils/app_radius.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/font_manager.dart';
import '../../../common_widget/common_add_container.dart';
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

