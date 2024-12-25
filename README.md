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


import 'package:chat_app/bloc_observer.dart';
import 'package:chat_app/screen/all_chats_flow/view/chatlist_page.dart';
import 'package:chat_app/screen/auth_flow/login_flow/bloc/login_bloc.dart';
import 'package:chat_app/screen/auth_flow/login_flow/view/login_page.dart';
import 'package:chat_app/screen/auth_flow/signup_flow/bloc/signup_bloc.dart';
import 'package:chat_app/screen/auth_flow/signup_flow/view/signup_page.dart';
import 'package:chat_app/screen/invitation_flow/view/invitation_page.dart';
import 'package:chat_app/screen/list_user_flow/view/loginuser_page.dart';
import 'package:chat_app/screen/splash_flow/view/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  });

  Bloc.observer = ChatObserver();
  runApp(Sizer(
    builder: (p0, p1, p2) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreen(),
            'signUp': (context) => const SignupPage(),
            'login': (context) => const LogInPage(),
            'home': (context) => const ChatListPage(),
            'user': (context) => const LoginUserPage(),
            'notification': (context) => const InvitationPage(),
          },
        ),
      );
    },
  ));
}

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event****: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition: $transition');
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static final FirebaseHelper firebaseHelper = FirebaseHelper._();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseHelper._();

  Future<String> signInAnonymously() async {
    try {
      await auth.signInAnonymously();
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createAccount(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<UserCredential> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleUser == null || googleAuth == null) {
        throw 'Google sign-in failed';
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      await saveGoogleUserData(userCredential.user!);

      return userCredential;
    } catch (e) {
      throw 'Error during Google sign-in: $e';
    }
  }
  Future<String> createChat(String otherUserId) async {
    String currentUserId = auth.currentUser!.uid;
    String chatId = _generateChatId(currentUserId, otherUserId);

    if (chatId.isEmpty) {
      throw 'Chat ID cannot be empty';
    }

    await firebaseFirestore.collection('chats').doc(chatId).set({
      'users': [currentUserId, otherUserId],
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount': 0,
    });

    await firebaseFirestore.collection('chats').doc(chatId).collection('messages').add({
      'senderId': currentUserId,
      'message': 'Chat started!',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return chatId;
  }

  String _generateChatId(String user1, String user2) {
    List<String> users = [user1, user2]..sort();
    return users.join('_');
  }

  bool checkUser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<void> userLogout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  // Future<String> uploadProfileImage(File profileImage) async {
  //   try {
  //     String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     UploadTask uploadTask = storage.ref(fileName).putFile(profileImage);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadUrl = await snapshot.ref.getDownloadURL();
  //     return downloadUrl;
  //   } catch (e) {
  //     return '';
  //   }
  // }

  Future<void> saveGoogleUserData(User user) async {
    try {
      String username = user.displayName ?? 'Anonymous';
      String email = user.email ?? '';
      String profileImageUrl = user.photoURL ?? '';

      var userDoc =
          await firebaseFirestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await firebaseFirestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'profileImage': profileImageUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw 'Error saving user data to Firestore: $e';
    }
  }

  Future<void> saveUserData(
      String userId, String username, String email) async {
    try {
      await firebaseFirestore.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        // 'profileImage': profileImageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkUserExists(String uid) async {
    try {
      DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(uid).get();
      return userDoc.exists;
    } catch (e) {
      print('Error checking user in Firestore: $e');
      return false;
    }
  }

  Future<List<DocumentSnapshot>> getUsers() async {
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection('users').get();
      return snapshot.docs;
    } catch (e) {
      throw 'Error fetching users: $e';
    }
  }
  Future<DocumentSnapshot> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        return await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      } catch (e) {
        throw 'Error fetching user data: $e';
      }
    } else {
      throw 'User not logged in';
    }
  }
  Future<void> deleteUserAccount(String uid) async {
    try {
      User? user = auth.currentUser;
      if (user != null && user.uid == uid) {
        await user.delete();
      }
    } catch (_) {
      throw "Error deleting user account.";
    }
  }

  Future<void> sendChatInvite(
      String inviterId, String inviteeId, String message) async {
    try {
      QuerySnapshot userInvite = await firebaseFirestore
          .collection('invitations')
          .where('inviterId', isEqualTo: inviterId)
          .where('inviteeId', isEqualTo: inviteeId)
          .limit(1)
          .get();

      if (userInvite.docs.isNotEmpty) {
        throw Exception('An invitation has already been sent to this user.');
      }

      await firebaseFirestore.collection('invitations').add({
        'inviterId': inviterId,
        'inviteeId': inviteeId,
        'message': message,
        'status': 'pending',
        'inviteTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Error sending chat invite: $e");
    }
  }

  Stream<Map<String, dynamic>> checkInviteStatus(String userId) {
    try {
      return firebaseFirestore
          .collection('invitations')
          .where('inviterId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('inviteeId', isEqualTo: userId)
          .where('status', whereIn: ['pending', 'declined', 'accepted'])
          .limit(1)
          .snapshots()
          .map((snapshot) {
            if (snapshot.docs.isNotEmpty) {
              var status = snapshot.docs.first['status'];
              return {
                'pending': status == 'pending',
                'declined': status == 'declined',
                'accepted': status == 'accepted'
              };
            } else {
              return {'pending': false, 'declined': false, 'accepted': false};
            }
          });
    } catch (e) {
      throw Exception("Error checking invite status: $e");
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../generated/assets.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStartEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoadedState) {
                if (state.isLoggedIn) {
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  Navigator.pushReplacementNamed(context, 'login');
                }
              }
            },
            child: Image.asset(
              Assets.imagesSplash,
              height: 20.h,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/firebase_services.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashStartEvent>((event, emit) async {
      bool login = false;
      login =  FirebaseHelper.firebaseHelper.checkUser();
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashLoadedState(isLoggedIn: login));
    });
  }
}
abstract class SplashEvent {}

class SplashStartEvent extends SplashEvent {}
abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadedState extends SplashState {
  final bool isLoggedIn;

  SplashLoadedState({required this.isLoggedIn});
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/firebase_services.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseHelper firebaseHelper;

  UserBloc({required this.firebaseHelper}) : super(UserLoadingState()) {
    on<FetchUsersEvent>(onFetchUsersEvent);
    on<SendChatInviteEvent>(onSendChatInviteEvent);
  }

  Future<void> onFetchUsersEvent(
      FetchUsersEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      var users = await firebaseHelper.getUsers();
      emit(UserLoadedState(users));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> onSendChatInviteEvent(
      SendChatInviteEvent event, Emitter<UserState> emit) async {
    try {
      await firebaseHelper.sendChatInvite(
        event.currentUserId,
        event.selectedUserId,
        event.inviteMessage,
      );
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsersEvent extends UserEvent {}

class SendChatInviteEvent extends UserEvent {
  final String currentUserId;
  final String selectedUserId;
  final String inviteMessage;

  SendChatInviteEvent(
      {required this.currentUserId,
      required this.selectedUserId,
      required this.inviteMessage});

  @override
  List<Object?> get props => [currentUserId, selectedUserId, inviteMessage];
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<DocumentSnapshot> users;

  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class InviteStatusState extends UserState {
  final bool isPending;
  final bool isDeclined;
  final bool isAccepted;

  InviteStatusState(
      {required this.isPending,
      required this.isDeclined,
      required this.isAccepted});

  @override
  List<Object?> get props => [isPending, isDeclined, isAccepted];
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/assets.dart';
import '../../../services/firebase_services.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
            child: const Text('Please log in'),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) =>
          UserBloc(firebaseHelper: FirebaseHelper.firebaseHelper)
            ..add(FetchUsersEvent()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: const Text('Invite Chat Users'),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserErrorState) {
                return Center(child: Text(state.error));
              } else if (state is UserLoadedState) {
                var users = state.users;
                users = users.where((userDoc) {
                  String userId = userDoc.id;
                  return userId != FirebaseAuth.instance.currentUser?.uid;
                }).toList();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var userData =
                          users[index].data() as Map<String, dynamic>;
                      String username = userData['username'] ?? 'No name';
                      String email = userData['email'] ?? 'No email';
                      String profileImage = userData['profileImage'] ?? '';
                      String userId = users[index].id;

                      return BlocProvider(
                        create: (context) => UserBloc(
                            firebaseHelper: FirebaseHelper.firebaseHelper),
                        child: UserInviteCard(
                          userId: userId,
                          username: username,
                          email: email,
                          profileImage: profileImage,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No users found.'));
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserInviteCard extends StatelessWidget {
  final String userId;
  final String username;
  final String email;
  final String profileImage;

  const UserInviteCard({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
          UserBloc(firebaseHelper: FirebaseHelper.firebaseHelper),
      child: StreamBuilder<Map<String, dynamic>>(
        stream: FirebaseHelper.firebaseHelper.checkInviteStatus(userId),
        builder: (context, statusSnapshot) {
          if (statusSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (statusSnapshot.hasError) {
            return Center(child: Text(statusSnapshot.error.toString()));
          } else if (statusSnapshot.hasData) {
            var status = statusSnapshot.data!;
            bool isPending = status['pending'];
            bool isDeclined = status['declined'];
            bool isAccepted = status['accepted'];

            return Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : const AssetImage(Assets.imagesProfile) as ImageProvider,
                  radius: 25,
                ),
                title: Text(username),
                subtitle: Text(email),
                trailing: isPending
                    ? const Text(
                        "Pending",
                        style: TextStyle(color: Colors.orange),
                      )
                    : isDeclined
                        ? const Text(
                            "Declined",
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : isAccepted
                            ? const Text(
                                "Accepted",
                                style: TextStyle(color: Colors.green),
                              )
                            : IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Chat Invite'),
                                        content: const Text(
                                            'Do you want to invite this user to chat?'),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.grey.shade200),
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<UserBloc>(context)
                                                  .add(
                                                SendChatInviteEvent(
                                                  currentUserId: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  selectedUserId: userId,
                                                  inviteMessage:
                                                      "Hey, let's chat!",
                                                ),
                                              );
                                              Navigator.of(dialogContext).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text('Invite sent!'),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black),
                                            child: const Text(
                                              'Send Invite',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../services/firebase_services.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  @override
  Widget build(BuildContext context) {
    String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Invitations Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('invitations')
            .where('inviteeId',
                isEqualTo: FirebaseHelper.firebaseHelper.auth.currentUser!.uid)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (cv, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final invitations = snapshot.data?.docs ?? [];

          if (invitations.isEmpty) {
            return const Center(child: Text('No invitations.'));
          }

          return ListView.builder(
            itemCount: invitations.length,
            itemBuilder: (jh, index) {
              var inviteData =
                  invitations[index].data() as Map<String, dynamic>;
              String inviterId = inviteData['inviterId'];
              String inviteeId = inviteData['inviteeId'];
              String inviteMessage = inviteData['message'];
              Timestamp? inviteTime = inviteData['inviteTime'];

              String formattedTime = 'Unknown Time';
              if (inviteTime != null) {
                formattedTime =
                    DateFormat('hh:mm a').format(inviteTime.toDate());
              }

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(inviterId)
                    .get(),
                builder: (bn, inviterSnapshot) {
                  if (inviterSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (inviterSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${inviterSnapshot.error}'));
                  }

                  var inviterData =
                      inviterSnapshot.data?.data() as Map<String, dynamic>;
                  String inviterName = inviterData['username'] ?? 'Unknown';
                  String inviterProfileImage =
                      inviterData['profileImage'] ?? '';
                  String inviterEmail = inviterData['email'] ?? '';
                  print("aaaaaaaaaaaaaaaaaaaaa${inviterEmail}");
                  print("aaaaaaaaaaaaaaaaaaaaa${currentUserEmail}");

                  if (inviterEmail == currentUserEmail) {
                    return const Center(
                        child: Card(
                      color: Colors.green,
                    ));
                  } else {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: inviterProfileImage.isNotEmpty
                                  ? NetworkImage(inviterProfileImage)
                                  : const AssetImage(
                                          'assets/images/profile.png')
                                      as ImageProvider,
                              radius: 25,
                            ),
                            SizedBox(width: 2.h),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        inviterName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        formattedTime,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    inviteMessage,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 1.5.h),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('invitations')
                                                .doc(invitations[index].id)
                                                .update({
                                              'status': 'declined',
                                            });
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Invitation declined')),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'Decline',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            print(
                                                "aaaaaaaaaaaaaaaaaaaaa111111111111${inviterId}");
                                            print(
                                                "aaaaaaaaaaaaaaaaaaaaa222222222222${inviteeId}");
                                            print(
                                                "aaaaaaaaaaaaaaaaaaaaa333333333333333333${FirebaseAuth.instance.currentUser!.uid}");

                                            String invitationId =
                                                invitations[index].id;
                                            print(
                                                "aaaaaaaaaaaaaaaaaaaaa333333333333333333${invitationId}");
                                            if (invitationId.isNotEmpty) {
                                              await FirebaseFirestore.instance
                                                  .collection('invitations')
                                                  .doc(invitationId)
                                                  .update(
                                                      {'status': 'accepted'});
                                            } else {
                                              print(
                                                  'Invalid document ID: $invitationId');
                                            }
                                            print(
                                                "sender================${inviterId}");
                                            String chatId = await FirebaseHelper
                                                .firebaseHelper
                                                .createChat(inviterId);

                                            Navigator.pop(context);

                                            // if (chatId.isNotEmpty) {
                                            //   Navigator.pushNamed(
                                            //       context, 'chat',
                                            //       arguments: chatId);
                                            // }
                                          },
                                          child: const Text(
                                            'Accept',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:chat_app/screen/chat_flow/data/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String chatId;

  ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  String? otherUserName;

  Future<void> getOtherUserName() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get();
    List<String> users = List<String>.from(chatDoc.data()?['users'] ?? []);
    String otherUserId =
        users.firstWhere((userId) => userId != currentUser.uid);

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(otherUserId).get();
    setState(() {
      otherUserName = userDoc.data()?['username'] ?? 'Unknown User';
    });
  }

  @override
  void initState() {
    super.initState();
    getOtherUserName();
  }

  Future<void> sendMessage(String chatId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final messageText = _controller.text.trim();
    if (messageText.isEmpty) return;
    final messageData = {
      'senderId': currentUser.uid,
      'message': messageText,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);

    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastMessage': messageText,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    final chatDoc =
        await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
    final users = List<String>.from(chatDoc.data()!['users']);
    final otherUser = users.firstWhere((user) => user != currentUser.uid);

    await FirebaseFirestore.instance.collection('users').doc(otherUser).update({
      'unreadCount': FieldValue.increment(1),
    });
  }

  Stream<List<Message>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(otherUserName ?? 'Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: getMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final currentUser = FirebaseAuth.instance.currentUser;

                    bool isSentByUser = message.senderId == currentUser?.uid;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ChatBubble(
                        clipper: ChatBubbleClipper1(
                            type: isSentByUser
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble),
                        alignment: isSentByUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10.0),
                        backGroundColor: isSentByUser
                            ? Colors.grey.shade600
                            : Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: isSentByUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message,
                              style: TextStyle(
                                color:
                                    isSentByUser ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(message.timestamp.toDate()),
                              style: TextStyle(
                                fontSize: 12,
                                color: isSentByUser
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        prefixIcon: const Icon(Icons.camera_alt_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(widget.chatId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final List<String> users;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final int unreadCount;

  Chat({
    required this.users,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'unreadCount': unreadCount,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      users: List<String>.from(map['users']),
      lastMessage: map['lastMessage'],
      lastMessageTime: map['lastMessageTime'],
      unreadCount: map['unreadCount'],
    );
  }
}


class Message {
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../components/button_common.dart';
import '../../../../components/text_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import 'dart:io';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? profileImage;

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: const Text("Select Image Source"),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await pickFromGallery();
              },
              child: const Text('Pick from Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await pickFromCamera();
              },
              child: const Text('Take a Photo'),
            ),
          ],
        );
      },
    );
  }

  Future<void> pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[100],
                    backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                    child: profileImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.grey,
                    )
                        : null,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 4.5.h,
                      width: 141,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Profile Image",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: userNameController,
                          hintText: "User Name",
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User Name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }

                            String pattern = r'\w+@\w+\.\w+';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        BlocConsumer<SignupBloc, SignupState>(
                          listener: (context, state) {
                            if (state is SignupFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                              );
                            }
                            if (state is SignupSuccess) {
                              Navigator.pushNamed(context, 'login');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Signup Successful!')),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is SignupInProgress) {
                              return const CircularProgressIndicator(
                                color: Colors.black,
                              );
                            }
                            return MyButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<SignupBloc>().add(
                                    SignupButtonPressed(
                                      username: userNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword: confirmPasswordController.text,
                                      urlImage: profileImage,
                                    ),
                                  );
                                }
                              },
                              text: "Sign Up",
                            );
                          },
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'login');
                              },
                              child: const Text(
                                "LogIn",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../services/firebase_services.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseHelper firebaseHelper = FirebaseHelper.firebaseHelper;

  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(onSignupButtonPressed);
  }

  Future<void> onSignupButtonPressed(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    if (event.username.isEmpty ||
        event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(SignupFailed("All fields are required."));
      return;
    }

    if (event.password != event.confirmPassword) {
      emit(SignupFailed('Passwords do not match'));
      return;
    }

    if (event.urlImage == null) {
      emit(SignupFailed("Profile image is required."));
      return;
    }

    emit(SignupInProgress());

    try {
      String result =
          await firebaseHelper.createAccount(event.email, event.password);

      if (result == "Success") {
        // String profileImageUrl = '';
        // if (event.urlImage != null) {
        //   profileImageUrl =
        //     await firebaseHelper.uploadProfileImage(event.urlImage!);
        // }

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await firebaseHelper.saveUserData(
            user.uid,
            event.username,
            event.email,
            // profileImageUrl,
          );
        }

        emit(SignupSuccess());
      } else {
        emit(SignupFailed(result));
      }
    } catch (e) {
      emit(SignupFailed(e.toString()));
    }
  }
}
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {}

class SignupButtonPressed extends SignupEvent {
  final File? urlImage;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignupButtonPressed({
    required this.urlImage,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>  [urlImage,username, email, password, confirmPassword];
}
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {}

class SignupInitial extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupInProgress extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccess extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupFailed extends SignupState {
  final String errorMessage;

  SignupFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LogInPage extends StatelessWidget {
  const LogInPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    const Icon(
                      Icons.message_rounded,
                      size: 100,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    const Text(
                      "Welcome back you've been missed!!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    MyTextField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            await FirebaseHelper.firebaseHelper
                                .signInAnonymously()
                                .then(
                              (value) {
                                Navigator.pushReplacementNamed(context, 'home');
                              },
                            );
                          },
                          child: Container(
                            height: 7.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.person,
                                color: Color(0xff2D2B2B)),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await FirebaseHelper.firebaseHelper
                                .googleSignIn()
                                .then((userCredential) {
                              debugPrint(
                                  "User signed in: ${userCredential.user!.displayName}");
                              Navigator.pushReplacementNamed(context, 'home');
                            }).catchError((e) {
                              debugPrint("Error signing in with Google: $e");
                            });
                          },
                          child: Container(
                            height: 7.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.g_mobiledata_outlined,
                              color: Color(0xff2D2B2B),
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginFailed) {
                          if (state.errorMessage ==
                              "User Token Expired. Please complete your registration.") {
                            Navigator.pushReplacementNamed(context, 'signUp');
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                        if (state is LoginSuccess) {
                          Navigator.pushReplacementNamed(context, 'home');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Successful!')),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginInProgress) {
                          return const CircularProgressIndicator(
                            color: Colors.black,
                          );
                        }
                        return MyButton(
                          onTap: () {
                            String email = emailController.text;
                            String password = passwordController.text;

                            if (email.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('All fields are required!')),
                              );
                            } else if (!isValidEmail(email)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid email format!')),
                              );
                            } else if (password.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Password must be at least 6 characters!')),
                              );
                            } else {
                              context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                            }
                          },
                          text: "LogIn",
                        );
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'signUp');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/firebase_services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseHelper firebaseHelper = FirebaseHelper.firebaseHelper;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginButtonPressed);
  }

  Future<void> onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginFailed("All fields are required."));
      return;
    }

    emit(LoginInProgress());

    try {
      String result = await firebaseHelper.signInWithEmailPassword(
          event.email, event.password);

      if (result == "Success") {
        User? user = firebaseHelper.auth.currentUser;

        if (user != null) {
          bool userExists = await firebaseHelper.checkUserExists(user.uid);

          if (userExists) {
            emit(LoginSuccess());
          } else {
            emit(LoginFailed(
                "User Token Expired. Please complete your registration."));
            await firebaseHelper.deleteUserAccount(user.uid);

          }
        } else {
          emit(LoginFailed("User authentication failed."));
        }
      } else {
        emit(LoginFailed(result));
      }
    } catch (e) {
      if (e.toString().contains("token expired")) {
        emit(LoginFailed("Your session has expired. Please log in again."));
        await firebaseHelper.userLogout();
      } else {
        emit(LoginFailed(e.toString()));
      }
    }
  }
}
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../services/firebase_services.dart';
import '../../chat_flow/view/chat_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseHelper.firebaseHelper.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No user data available.'));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String username = userData['username'] ?? 'Unknown User';
            String profileImage = userData['profileImage'] ?? '';
            String email = userData['email'] ?? '';

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: profileImage.isNotEmpty
                            ? NetworkImage(profileImage)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Invitations Messages'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, 'notification');
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () async {
                    await FirebaseHelper.firebaseHelper.userLogout();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('users', arrayContains: FirebaseHelper.firebaseHelper.auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                var chatRooms = snapshot.data?.docs ?? [];
                if (chatRooms.isEmpty) {
                  return const Center(child: Text('No chats available.'));
                }

                return ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    var chatData = chatRooms[index].data() as Map<String, dynamic>;
                    List<String> users = List<String>.from(chatData['users']);
                    String lastMessage = chatData['lastMessage'] ?? '';
                    Timestamp? lastMessageTime = chatData['lastMessageTime'];
                    int unreadCount = chatData['unreadCount'] ?? 0;

                    String formattedTime = 'Unknown Time';
                    if (lastMessageTime != null) {
                      formattedTime = DateFormat('hh:mm a').format(lastMessageTime.toDate());
                    }

                    String otherUserId = users.firstWhere((userId) =>
                    userId != FirebaseHelper.firebaseHelper.auth.currentUser!.uid);

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (userSnapshot.hasError) {
                          return Center(child: Text('Error: ${userSnapshot.error}'));
                        }

                        var userData = userSnapshot.data?.data() as Map<String, dynamic>;
                        String userName = userData['username'] ?? 'Unknown';
                        String userProfileImage = userData['profileImage'] ?? '';

                        return InkWell(
                          onTap: () {
                            String chatId = chatRooms[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(chatId: chatId),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: userProfileImage.isNotEmpty
                                      ? NetworkImage(userProfileImage)
                                      : const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                                  radius: 25,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            userName,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          Text(
                                            formattedTime,
                                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            lastMessage,
                                            style: const TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (unreadCount > 0)
                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                unreadCount.toString(),
                                                style: const TextStyle(color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                        ],
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
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'user');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      validator: validator,
    );
  }
}
