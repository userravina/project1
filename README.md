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

// name store
  static String userName = "userName";

 getIt<StorageServices>().setUserName(loginModel.user?.name ?? '');
  @override
  void onInit() {
    super.onInit();
    getUserName();
    if (propertiesList.isEmpty || cityPropertiesList.isEmpty) {
      getTravelingData();
      getCityData();
    }
  }
  RxString? getUserId = ''.obs;
  void getUserName(){
    getUserId?.value = getIt<StorageServices>().getUserName()!;

  }

controller.getUserId?.value ?? ''
  @override
  void onInit() {
    super.onInit();
    getUserName();
    if (propertiesList.isEmpty) {
      getHostingData();
    }
  }
  RxString? getUserId = ''.obs;
  void getUserName(){
    getUserId?.value = getIt<StorageServices>().getUserName()!;

  }

  // bottom change tab 
    @override
  void onInit() {
    super.onInit();
    ever(profileCtrl.isTraveling, (bool isTraveling) {
      if (!isTraveling || isTraveling) {
        selectedIndex.value = 0;
      }
    });
  }
  //

  
