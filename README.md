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
import 'package:chat_app/screen/group/select_users_page.dart';
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
import 'package:chat_app/screen/chat_flow/bloc/chat_bloc.dart';

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
           BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(),
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
            'groupSelect': (context) => const SelectUsersPage(),
          },
        ),
      );
    },
  ));
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
    String chatId = generateChatId(currentUserId, otherUserId);

    if (chatId.isEmpty) {
      throw 'Chat ID cannot be empty';
    }

    await firebaseFirestore.collection('chats').doc(chatId).set({
      'users': [currentUserId, otherUserId],
      'isGroup': false,
      'lastMessage': 'Chat started!',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount': {
        currentUserId: 0,
        otherUserId: 0,
      },
    });
  

    await firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': currentUserId,
      'message': 'Chat started!',
      'timestamp': FieldValue.serverTimestamp(),
      'type': 'system',
    });

    return chatId;
  }

  String generateChatId(String user1, String user2) {
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

  Future<void> saveUserData(String userId, String username, String email) async {
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
        return await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
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
          .where('inviteeId', isEqualTo: inviterId)
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
                'accepted': status == 'accepted',
              };
            } else {
              return {'pending': false, 'declined': false, 'accepted': false};
            }
          });
    } catch (e) {
      throw Exception("Error checking invite status: $e");
    }
  }

  Future<bool> isUserInChat(String currentUserId, String selectedUserId) async {
    try {
      var chatUser = FirebaseFirestore.instance.collection('chats');
      var querySnapshot = await chatUser.where('users',
          arrayContainsAny: [currentUserId, selectedUserId]).get();

      return querySnapshot.docs.any((doc) {
        var users = List<String>.from(doc['users']);
        return users.contains(currentUserId) && users.contains(selectedUserId);
      });
    } catch (e) {
      print("Error checking chat status: $e");
      return false;
    }
  }

  Future<String> createGroupChat(
      String groupName, List<String> selectedUsers) async {
    try {
      String currentUserId = auth.currentUser!.uid;

      if (selectedUsers.isEmpty ||
          (selectedUsers.length == 1 && selectedUsers.first == currentUserId)) {
        throw 'Please select at least one other user for the group';
      }

      if (!selectedUsers.contains(currentUserId)) {
        selectedUsers.add(currentUserId);
      }

      QuerySnapshot existingGroups = await firebaseFirestore
          .collection('chats')
          .where('isGroup', isEqualTo: true)
          .get();

      for (var doc in existingGroups.docs) {
        List<String> users = List<String>.from(doc['users'] ?? []);
        if (users.length == selectedUsers.length &&
            users.every((user) => selectedUsers.contains(user))) {
          throw 'A group with these exact members already exists';
        }
      }

      DocumentReference chatRef =
          await firebaseFirestore.collection('chats').add({
        'users': selectedUsers,
        'isGroup': true,
        'groupName': groupName,
        'createdBy': currentUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessage': 'Group created',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadCount': { for (var user in selectedUsers) user : 0 },
      });

      await chatRef.collection('messages').add({
        'senderId': currentUserId,
        'message': 'Group created',
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'system',
      });

      for (String userId in selectedUsers) {
        if (userId != currentUserId) {
          await firebaseFirestore.collection('users').doc(userId).update({
            'unreadCount': FieldValue.increment(1),
          });
        }
      }

      return chatRef.id;
    } catch (e) {
      throw 'Error creating group chat: $e';
    }
  }

  Stream<QuerySnapshot> getGroupChats() {
    String currentUserId = auth.currentUser!.uid;
    return firebaseFirestore
        .collection('group_chats')
        .where('members', arrayContains: currentUserId)
        .snapshots();
  }

  Future<void> updateUnreadCount(String chatId, String senderId) async {
    try {
      DocumentSnapshot chatDoc = await firebaseFirestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
      List<String> users = List<String>.from(chatData['users']);
      Map<String, dynamic> unreadCount = Map<String, dynamic>.from(chatData['unreadCount']);

      for (String userId in users) {
        if (userId != senderId) {
          unreadCount[userId] = (unreadCount[userId] ?? 0) + 1;
        }
      }

      await firebaseFirestore.collection('chats').doc(chatId).update({
        'unreadCount': unreadCount,
      });
    } catch (e) {
      print('Error updating unread count: $e');
    }
  }

  Future<void> sendMessage(String chatId, String message) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) return;

      // Add the message
      await firebaseFirestore.collection('chats').doc(chatId).collection('messages').add({
        'senderId': currentUser.uid,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'text',
      });

      // Update last message
      await firebaseFirestore.collection('chats').doc(chatId).update({
        'lastMessage': message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });

      // Update unread counts
      await updateUnreadCount(chatId, currentUser.uid);
    } catch (e) {
      throw 'Error sending message: $e';
    }
  }

  Future<void> resetUnreadCount(String chatId) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) return;

      DocumentSnapshot chatDoc = await firebaseFirestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> unreadCount = Map<String, dynamic>.from(chatDoc.get('unreadCount'));

      unreadCount[currentUser.uid] = 0;

      await firebaseFirestore.collection('chats').doc(chatId).update({
        'unreadCount': unreadCount,
      });
    } catch (e) {
      print('Error resetting unread count: $e');
    }
  }
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
                      var userData =  users[index].data() as Map<String, dynamic>;
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
            // String message = status['inviteeId'];
            //
            print("cccccccccccc222222222${isPending}");

            print("user id ${FirebaseAuth.instance.currentUser!.uid}");
            print("inviteeId111111111111111 ${userId}");

            return FutureBuilder<bool>(
              future: FirebaseHelper.firebaseHelper
                  .isUserInChat(FirebaseAuth.instance.currentUser!.uid, userId),
              builder: (context, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                bool isInChat = chatSnapshot.data ?? false;

                return Card(
                  color: Colors.grey[100],
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profileImage.isNotEmpty
                          ? NetworkImage(profileImage)
                          : const AssetImage(Assets.imagesProfile)
                              as ImageProvider,
                      radius: 25,
                    ),
                    title: Text(username),
                    subtitle: Text(email),
                    trailing: isInChat
                        ? const Text(
                            "Already in chat",
                            style: TextStyle(color: Colors.blue),
                          )
                        : isPending
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
                                                title:
                                                    const Text('Chat Invite'),
                                                content: const Text(
                                                    'Do you want to invite this user to chat?'),
                                                actions: [
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .grey.shade200),
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
                                                    onPressed: isInChat
                                                        ? null
                                                        : () {
                                                            BlocProvider.of<UserBloc>(context).add(
                                                              SendChatInviteEvent(
                                                                currentUserId:
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                selectedUserId:
                                                                    userId,
                                                                inviteMessage:
                                                                    "Hey, let's chat!",
                                                              ),
                                                            );
                                                            Navigator.of(
                                                                    dialogContext)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Invite sent!'),
                                                              ),
                                                            );
                                                          },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.black),
                                                    child: Text(
                                                      isInChat
                                                          ? 'Already in chat'
                                                          : 'Send Invite',
                                                      style: const TextStyle(
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
              },
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
                   print("aaaaaaaaaaaaaaaaaaaaa${inviterName}");

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
                                            await FirebaseHelper.firebaseHelper
                                                .createChat(inviterId);

                                            Navigator.pop(context);
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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/firebase_services.dart';

class SelectUsersPage extends StatefulWidget {
  const SelectUsersPage({super.key});

  @override
  State<SelectUsersPage> createState() => _SelectUsersPageState();
}

class _SelectUsersPageState extends State<SelectUsersPage> {
  final List<String> selectedUsers = [];
  final TextEditingController groupNameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  Future<void> createGroup() async {
    if (selectedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one user')),
      );
      return;
    }

    if (groupNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseHelper.firebaseHelper.createGroupChat(
        groupNameController.text.trim(),
        selectedUsers,
      );
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating group: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Create Group',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (selectedUsers.isNotEmpty)
            TextButton(
              onPressed: isLoading ? null : () => createGroup(),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create'),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText: 'Group Name',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Selected Users: ${selectedUsers.length}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userData = users[index].data() as Map<String, dynamic>;
                    final userId = users[index].id;
                    final username = userData['username'] ?? 'Unknown User';
                    final profileImage = userData['profileImage'] ?? '';

                    if (userId == FirebaseAuth.instance.currentUser?.uid) {
                      return const SizedBox.shrink();
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: profileImage.isNotEmpty
                              ? NetworkImage(profileImage)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                        ),
                        title: Text(
                          username,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Checkbox(
                          value: selectedUsers.contains(userId),
                          activeColor: Colors.black54,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedUsers.add(userId);
                              } else {
                                selectedUsers.remove(userId);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 
import 'package:chat_app/screen/chat_flow/bloc/chat_bloc.dart';
import 'package:chat_app/screen/chat_flow/bloc/chat_event.dart';
import 'package:chat_app/screen/chat_flow/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/firebase_services.dart';

class ChatPage extends StatefulWidget {
  final String chatId;

  const ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String? chatName;
  bool isGroup = false;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    FirebaseHelper.firebaseHelper.resetUnreadCount(widget.chatId);
    context.read<ChatBloc>().add(LoadMessagesEvent(widget.chatId));
    getChatInfo();
  }

  Future<void> getChatInfo() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get();
    
    final chatData = chatDoc.data();
    if (chatData == null) return;

    isGroup = chatData['isGroup'] ?? false;

    if (isGroup) {
      setState(() {
        chatName = chatData['groupName'] ?? 'Unnamed Group';
      });
    } else {
      List<String> users = List<String>.from(chatData['users'] ?? []);
      String otherUserId = users.firstWhere(
        (userId) => userId != currentUser.uid,
        orElse: () => '',
      );

      if (otherUserId.isNotEmpty) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(otherUserId)
            .get();
        setState(() {
          chatName = userDoc.data()?['username'] ?? 'Unknown User';
        });
      }
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,  
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.grey.shade100,
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, color: Colors.grey.shade800),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatName ?? 'Chat',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (!isGroup)
              Text(
                'online',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
          ],
        ),
        actions: [
          if (isGroup)
            IconButton(
              icon: Icon(Icons.group, color: Colors.grey.shade700),
              onPressed: () {
              },
            ),
          BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is MessagesDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('All messages deleted successfully')),
                );
              } else if (state is MessageErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey.shade700),
              color: Colors.white,
              onSelected: (value) async {
                if (value == 'delete') {
                  bool? confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: const Text(
                        'Delete Messages',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: Text(
                        'Are you sure you want to delete all messages in this chat?',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red.shade600),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (confirmDelete == true) {
                    context
                        .read<ChatBloc>()
                        .add(DeleteAllMessagesEvent(widget.chatId));
                  }
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete Messages'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is MessagesLoadedState) {
                  scrollToBottom();
                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final currentUser = FirebaseAuth.instance.currentUser;
                      bool isSentByUser = message.senderId == currentUser?.uid;

                      return Align(
                        alignment: isSentByUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSentByUser
                                ? Colors.grey.shade200
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                message.message,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat('HH:mm')
                                        .format(message.timestamp.toDate()),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  if (isSentByUser) ...[
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.done_all,
                                      size: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is MessageSendingState) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: Colors.grey.shade600));
                } else if (state is MessageErrorState) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return Center(
                  child: Text(
                    'No messages yet.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.grey.shade600,
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        isTyping = value.trim().isNotEmpty;
                      });
                    },
                    onSubmitted: (_) {
                      final message = controller.text.trim();
                      if (message.isNotEmpty) {
                        context
                            .read<ChatBloc>()
                            .add(SendMessageEvent(widget.chatId, message));
                        controller.clear();
                        setState(() {
                          isTyping = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Message',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.grey.shade600,
                  onPressed: () {
                    if (isTyping) {
                      final message = controller.text.trim();
                      if (message.isNotEmpty) {
                        context
                            .read<ChatBloc>()
                            .add(SendMessageEvent(widget.chatId, message));
                        controller.clear();
                        setState(() {
                          isTyping = false;
                        });
                      }
                    }
                  },
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

class Message {
  final String id;
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.id,
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
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
import 'package:chat_app/screen/chat_flow/data/model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {}

class MessagesLoadedState extends ChatState {
  final List<Message> messages;

  const MessagesLoadedState(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessageSendingState extends ChatState {}

class MessageSentState extends ChatState {}

class MessageErrorState extends ChatState {
  final String error;
  const MessageErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class MessagesDeletedState extends ChatState {}import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadMessagesEvent extends ChatEvent {
  final String chatId;

  const LoadMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String message;

  const SendMessageEvent(this.chatId, this.message);

  @override
  List<Object> get props => [chatId, message];
}

class DeleteAllMessagesEvent extends ChatEvent {
  final String chatId;

  const DeleteAllMessagesEvent(this.chatId);
}
import 'package:chat_app/screen/chat_flow/bloc/chat_event.dart';
import 'package:chat_app/screen/chat_flow/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screen/chat_flow/data/model.dart';
import 'package:chat_app/services/firebase_services.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<LoadMessagesEvent>(onLoadMessages);
    on<SendMessageEvent>(onSendMessage);
  }

  Future<void> onLoadMessages(
      LoadMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      final messagesSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(event.chatId)
          .collection('messages')
          .orderBy('timestamp')
          .get();

      final messages = messagesSnapshot.docs
          .map((doc) => Message.fromMap(doc.data()))
          .toList();

      emit(MessagesLoadedState(messages));
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  Future<void> onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(MessageSendingState());
      
      await FirebaseHelper.firebaseHelper.sendMessage(
        event.chatId,
        event.message,
      );
      
      add(LoadMessagesEvent(event.chatId));
      
      emit(MessageSentState());
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }
}
import 'package:chat_app/generated/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54),
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
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black87, Colors.black54],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: profileImage.isNotEmpty
                              ? NetworkImage(profileImage)
                              : const AssetImage(Assets.imagesProfile)
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black87),
                  title: const Text('Home', style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                 ListTile(
                  leading: const Icon(Icons.group, color: Colors.black87),
                  title: const Text('Create Group', style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Navigator.pushNamed(context, 'groupSelect');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mail, color: Colors.black87),
                  title: const Text('Invitations', style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Navigator.pushNamed(context, 'notification');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.black87),
                  title: const Text('Logout', style: TextStyle(fontSize: 16)),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('users',arrayContains:
                          FirebaseHelper.firebaseHelper.auth.currentUser!.uid)
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Chat yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {

                    var chatData = chatRooms[index].data() as Map<String, dynamic>;
                    List<String> users = List<String>.from(chatData['users']);
                    String lastMessage = chatData['lastMessage'] ?? '';
                    Timestamp? lastMessageTime = chatData['lastMessageTime'];
                    bool isGroup = chatData['isGroup'] ?? false;
                    
                    int unreadCount = 0;
                    if (chatData['unreadCount'] != null) {
                      if (chatData['unreadCount'] is Map) {
                        Map<String, dynamic> unreadCounts = Map<String, dynamic>.from(chatData['unreadCount']);
                        unreadCount = unreadCounts[FirebaseHelper.firebaseHelper.auth.currentUser!.uid] ?? 0;
                        print("ssssssssssssaaaaaaaaaaaaaa${unreadCount}");
                      } else {
                       int unreadCount = chatData['unreadCount'] as int;
                        print("ssssssssssssaaaaaaaaaaaaaa1111111111${unreadCount}");
                      }
                    }

                    String formattedTime = 'Unknown Time';
                    if (lastMessageTime != null) {
                      formattedTime = DateFormat('hh:mm a').format(lastMessageTime.toDate());
                    }

                    return ListTile(
                      onTap: () {
                        String chatId = chatRooms[index].id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(chatId: chatId),
                          ),
                        );
                      },
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 25,
                            child: isGroup 
                              ? Icon(Icons.group, color: Colors.grey[600], size: 30)
                              : FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(users.firstWhere(
                                        (userId) => userId != FirebaseHelper.firebaseHelper.auth.currentUser!.uid
                                      ))
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData && snapshot.data?.data() != null) {
                                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                                      final profileImage = userData['profileImage'] ?? '';
                                      return CircleAvatar(
                                        radius: 25,
                                        backgroundImage: profileImage.isNotEmpty
                                            ? NetworkImage(profileImage)
                                            : const AssetImage('assets/images/profile.png')
                                                as ImageProvider,
                                      );
                                    }
                                    return Icon(Icons.person, color: Colors.grey[600], size: 30);
                                  },
                                ),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                                child: Text(
                                  unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: isGroup 
                        ? Text(
                            chatData['groupName'] ?? 'Unnamed Group',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        : FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(users.firstWhere(
                                  (userId) => userId != FirebaseHelper.firebaseHelper.auth.currentUser!.uid
                                ))
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data?.data() != null) {
                                final userData = snapshot.data!.data() as Map<String, dynamic>;
                                return Text(
                                  userData['username'] ?? 'Unknown User',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                );
                              }
                              return const Text('Loading...');
                            },
                          ),
                      subtitle: Text(
                        lastMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: unreadCount > 0 ? Colors.black87 : Colors.grey.shade600,
                          fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
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
        backgroundColor: Colors.black54,
        elevation: 4,
        child: const Icon(Icons.chat_rounded, color: Colors.white),
      ),
    );
  }
}    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
