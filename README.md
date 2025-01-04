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
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/supabase_service.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SupabaseService supabaseService;

  UserBloc(this.supabaseService) : super(UserInitial()) {
    on<LoadUsers>(onLoadUsers);
    on<SendInvitation>(onSendInvitation);
    on<CancelInvitation>(onCancelInvitation);
  }

  Future<void> onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final users = await supabaseService.getAllUsers();
      final invitationStatuses = await supabaseService.getInvitationStatuses();
      emit(UsersLoaded(users, invitationStatuses));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> onSendInvitation(
      SendInvitation event, Emitter<UserState> emit) async {
    try {
      await supabaseService.sendInvitation(
        inviteeId: event.inviteeId,
        message: event.message,
      );
      add(LoadUsers());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> onCancelInvitation(
      CancelInvitation event, Emitter<UserState> emit) async {
    try {
      await supabaseService.cancelInvitation(event.inviteeId);
      add(LoadUsers());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class SendInvitation extends UserEvent {
  final String inviteeId;
  final String message;

  const SendInvitation({
    required this.inviteeId,
    this.message = "Hey, let's chat!",
  });

  @override
  List<Object?> get props => [inviteeId, message];
}

class CancelInvitation extends UserEvent {
  final String inviteeId;

  const CancelInvitation({required this.inviteeId});

  @override
  List<Object?> get props => [inviteeId];
}

class UpdateUsers extends UserEvent {}
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;
  final Map<String, Map<String, dynamic>> invitationStatuses;

  const UsersLoaded(this.users, this.invitationStatuses);

  @override
  List<Object> get props => [users, invitationStatuses];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/supabase_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SupabaseService authService = SupabaseService();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginButtonPressed);
  }

  Future<void> onLoginButtonPressed(
    LoginButtonPressed event, 
    Emitter<LoginState> emit
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginFailed("All fields are required."));
      return;
    }

    emit(LoginInProgress());

    try {
      final UserModel user = await authService.signIn(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(user));
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains("invalid_credentials") || 
          errorMessage.contains("user-not-found")) {
        emit(LoginFailed("User not found. Please sign up."));
      } else {
        emit(LoginFailed(errorMessage));
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
  List<Object> get props => [email,password];
}
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/supabase_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SupabaseService authService = SupabaseService();

  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event, 
    Emitter<SignupState> emit
  ) async {
    if (event.username.isEmpty ||
        event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(SignupFailed("All fields are required."));
      return;
    }

    if (!_isValidEmail(event.email)) {
      emit(SignupFailed("Please enter a valid email address"));
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
      final UserModel user = await authService.signUp(
        email: event.email,
        password: event.password,
        username: event.username,
        profileImage: event.urlImage,
      );
      emit(SignupSuccess(user));
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains("email_address_invalid")) {
        emit(SignupFailed("Please enter a valid email address"));
      } else {
        emit(SignupFailed(errorMessage));
      }
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
  List<Object?> get props =>  [urlImage,username, email, password, confirmPassword];
}
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

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
  final UserModel user;
  SignupSuccess(this.user);

  @override
  List<Object?> get props => [];
}

class SignupFailed extends SignupState {
  final String errorMessage;

  SignupFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/message_model.dart';
import '../../data/services/supabase_service.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class InitializeChat extends ChatEvent {
  final String otherUserId;
  const InitializeChat(this.otherUserId);

  @override
  List<Object?> get props => [otherUserId];
}

class SendMessage extends ChatEvent {
  final String content;
  const SendMessage(this.content);

  @override
  List<Object?> get props => [content];
}

class MarkAsRead extends ChatEvent {}

// States
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatReady extends ChatState {
  final String chatId;
  final List<MessageModel> messages;
  final bool isLoading;

  const ChatReady({
    required this.chatId,
    required this.messages,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [chatId, messages, isLoading];

  ChatReady copyWith({
    String? chatId,
    List<MessageModel>? messages,
    bool? isLoading,
  }) {
    return ChatReady(
      chatId: chatId ?? this.chatId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SupabaseService _supabaseService;
  Stream<List<Map<String, dynamic>>>? _messagesStream;

  ChatBloc(this._supabaseService) : super(ChatInitial()) {
    on<InitializeChat>(_onInitializeChat);
    on<SendMessage>(_onSendMessage);
    on<MarkAsRead>(_onMarkAsRead);
  }

  Future<void> _onInitializeChat(
    InitializeChat event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      
      // Get or create chat
      String chatId = await _supabaseService.createChat(event.otherUserId);
      
      // Start listening to messages
      _messagesStream = _supabaseService.getMessages(chatId);
      
      emit(ChatReady(chatId: chatId, messages: []));

      // Listen to message updates
      await emit.forEach(
        _messagesStream!,
        onData: (List<Map<String, dynamic>> data) {
          final messages = data.map((m) => MessageModel.fromMap(m)).toList();
          return (state as ChatReady).copyWith(messages: messages);
        },
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatReady) {
      final currentState = state as ChatReady;
      try {
        emit(currentState.copyWith(isLoading: true));
        await _supabaseService.sendMessage(currentState.chatId, event.content);
        emit(currentState.copyWith(isLoading: false));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    }
  }

  Future<void> _onMarkAsRead(
    MarkAsRead event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatReady) {
      final currentState = state as ChatReady;
      try {
        await _supabaseService.markMessagesAsRead(currentState.chatId);
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    // Clean up any subscriptions
    return super.close();
  }
}
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/supabase_service.dart';
part 'chat_home_event.dart';
part 'chat_home_state.dart';

class ChatHomeBloc extends Bloc<ChatHomeEvent, ChatHomeState> {
  final SupabaseService authService;

  ChatHomeBloc({required SupabaseService service}): authService = service, super(ChatHomeState(user: service.currentUser,  profileUrl: service.getProfileImageUrl(), )) {
    on<UpdateProfileImage>(onUpdateProfileImage);
    on<OnSignOutButton>(onSignOutButton);
    on<LoadChats>(onLoadChats);
  }

  Future<void> onUpdateProfileImage(
    UpdateProfileImage event,
    Emitter<ChatHomeState> emit,
    
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      
      await authService.updateProfileImage(event.imageFile);
      
      emit(state.copyWith(
        isLoading: false,
        user: authService.currentUser,
        profileUrl: authService.getProfileImageUrl(),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> onSignOutButton(
    OnSignOutButton event,
    Emitter<ChatHomeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await  authService.signOut();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> onLoadChats(
    LoadChats event,
    Emitter<ChatHomeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      
      final chats = await authService.getChats();
      final chatUsers = <String, UserModel?>{};
      
      for (final chat in chats) {
        final otherUserId = chat.user1Id == authService.currentUser!.id 
            ? chat.user2Id 
            : chat.user1Id;
        chatUsers[chat.id] = await authService.getUserById(otherUserId);
      }

      emit(state.copyWith(
        isLoading: false,
        chats: chats,
        chatUsers: chatUsers,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
} 
part of 'chat_home_bloc.dart';

abstract class ChatHomeEvent extends Equatable {
  const ChatHomeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileImage extends ChatHomeEvent {
  final File imageFile;

  const UpdateProfileImage(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class OnSignOutButton extends ChatHomeEvent {}

class LoadChats extends ChatHomeEvent {} 
part of 'chat_home_bloc.dart';

class ChatHomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final User? user;
  final String? profileUrl;
  final List<ChatModel> chats;
  final Map<String, UserModel?> chatUsers;

  const ChatHomeState({
    this.isLoading = false,
    this.error,
    this.user,
    this.profileUrl,
    this.chats = const [],
    this.chatUsers = const {},
  });

  ChatHomeState copyWith({
    bool? isLoading,
    String? error,
    User? user,
    String? profileUrl,
    List<ChatModel>? chats,
    Map<String, UserModel?>? chatUsers,
  }) {
    return ChatHomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      profileUrl: profileUrl ?? this.profileUrl,
      chats: chats ?? this.chats,
      chatUsers: chatUsers ?? this.chatUsers,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, user, profileUrl, chats, chatUsers];
} import 'package:chat_app_supabase/blocs/invitation/invitation_event.dart';
import 'package:chat_app_supabase/blocs/invitation/invitation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/supabase_service.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final SupabaseService supabaseService;

  InvitationBloc(this.supabaseService) : super(InvitationInitial()) {
    on<LoadInvitations>(onLoadInvitations);
    on<RespondToInvitation>(onRespondToInvitation);
    on<CancelInvitation>(onCancelInvitation); 
  }

  Future<void> onLoadInvitations(
    LoadInvitations event,
    Emitter<InvitationState> emit,
  ) async {
    try {
      emit(InvitationLoading());
      final invitations = await supabaseService.getAllInvitations();
      emit(InvitationsLoaded(invitations));
    } catch (e) {
      emit(InvitationError(e.toString()));
    }
  }

  Future<void> onRespondToInvitation(
    RespondToInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    try {
      await supabaseService.respondToInvitation(
        invitationId: event.invitationId,
        status: event.status,
      );
      add(LoadInvitations()); 
    } catch (e) {
      emit(InvitationError(e.toString()));
    }
  }

  Future<void> onCancelInvitation(
    CancelInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    try {
      await supabaseService.cancelInvitation(event.invitationId);
      add(LoadInvitations());
    } catch (e) {
      emit(InvitationError(e.toString()));
    }
  }
}

import 'package:equatable/equatable.dart';

abstract class InvitationEvent extends Equatable {}

class LoadInvitations extends InvitationEvent {
  @override
  List<Object> get props => []; 
}

class RespondToInvitation extends InvitationEvent {
  final String invitationId;
  final String status;

  RespondToInvitation({required this.invitationId, required this.status});

  @override
  List<Object> get props => [invitationId, status];
}

class CancelInvitation extends InvitationEvent {
  final String invitationId;

  CancelInvitation({required this.invitationId});

  @override
  List<Object> get props => [invitationId]; 
}
import '../../data/models/invitation_model.dart';
import 'package:equatable/equatable.dart';

abstract class InvitationState extends Equatable {}

class InvitationInitial extends InvitationState {
  @override
  List<Object> get props => [];
}

class InvitationLoading extends InvitationState {
  @override
  List<Object> get props => [];
}

class InvitationsLoaded extends InvitationState {
  final List<InvitationModel> invitations;

  InvitationsLoaded(this.invitations);

  @override
  List<Object> get props => [invitations]; 
}

class InvitationError extends InvitationState {
  final String message;

  InvitationError(this.message);

  @override
  List<Object> get props => [message];
}
import 'package:chat_app_supabase/data/services/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SupabaseService authService = SupabaseService();

  SplashBloc() : super(SplashInitialState()) {
    on<SplashStartEvent>((event, emit) async {
      try {
          await Future.delayed(const Duration(seconds: 2));
        final user = authService.currentUser;

        if (user != null) {
          if (authService.isAuthenticated) {
            emit(SplashLoadedState(isLoggedIn: true));
          } else {
            emit(SplashErrorState("Session expired. Please login again."));
            await authService.signOut();
          }
        } else {
          emit(SplashLoadedState(isLoggedIn: false));
        }

      } catch (e) {
        emit(SplashErrorState(e.toString()));
        await authService.signOut();
      }
    });
  }
}
import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {}

class SplashStartEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class SplashInitialState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashLoadedState extends SplashState {
  final bool isLoggedIn;

  SplashLoadedState({required this.isLoggedIn});

  @override
  List<Object?> get props => [];
}

class SplashErrorState extends SplashState {
  final String message;

  SplashErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
class ChatModel {
  final String id;
  final String user1Id;
  final String user2Id;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int user1UnreadCount;
  final int user2UnreadCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    this.lastMessage,
    this.lastMessageTime,
    this.user1UnreadCount = 0,
    this.user2UnreadCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      user1Id: map['user1_id'],
      user2Id: map['user2_id'],
      lastMessage: map['last_message'],
      lastMessageTime: map['last_message_time'] != null 
          ? DateTime.parse(map['last_message_time'])
          : null,
      user1UnreadCount: map['user1_unread_count'] ?? 0,
      user2UnreadCount: map['user2_unread_count'] ?? 0,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
} 
class InvitationModel {
  final String id;
  final String inviterId;
  final String inviterName;
  final String inviteeId;
  final String inviteeName;
  final String message;
  final String status;
  final DateTime inviteTime;
  final String? inviterProfileUrl;
  final String? inviteeProfileUrl;
  bool isSentByMe;

  InvitationModel({
    required this.id,
    required this.inviterId,
    required this.inviterName,
    required this.inviteeId,
    required this.inviteeName,
    required this.message,
    required this.status,
    required this.inviteTime,
    this.inviterProfileUrl,
    this.inviteeProfileUrl,
    this.isSentByMe = false,
  });

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      id: map['id'],
      inviterId: map['inviter_id'],
      inviterName: map['inviter']['username'],
      inviteeId: map['invitee_id'],
      inviteeName: map['invitee']['username'],
      message: map['message'],
      status: map['status'] ?? 'pending',
      inviteTime: DateTime.parse(map['invite_time'] ?? DateTime.now().toIso8601String()),
      inviterProfileUrl: map['inviter']['profile_url'],
      inviteeProfileUrl: map['invitee']['profile_url'],
    );
  }
} 
import '../services/supabase_service.dart';

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final String status;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    this.isRead = false,
    this.status = 'sent',
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      chatId: map['chat_id'],
      senderId: map['sender_id'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      isRead: map['is_read'] ?? false,
      status: map['status'] ?? 'sent',
    );
  }

  bool get isMine => senderId == SupabaseService().currentUser?.id;
} 
class UserModel {
  final String id;
  final String email;
  final String? name;
  final DateTime createdAt;
  final bool isOnline;
  final DateTime lastSeen;
  final String? pushToken;
  final int unreadCount;
  final String? profileUrl;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    DateTime? createdAt,
    this.isOnline = false,
    DateTime? lastSeen,
    this.pushToken,
    this.unreadCount = 0,
    this.profileUrl,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastSeen = lastSeen ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['username'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      pushToken: json['pushToken'] as String?,
      unreadCount: json['unreadCount'] as int? ?? 0,
      profileUrl: json['profile_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': name,
      'createdAt': createdAt.toIso8601String(),
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
      'pushToken': pushToken,
      'unreadCount': unreadCount,
      'profile_url': profileUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['username'],
      profileUrl: map['profile_url'],
    );
  }
} 
// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:path/path.dart' as path;

import '../models/user_model.dart';
import '../models/invitation_model.dart';
import '../models/chat_model.dart';

class SupabaseService {
  static final SupabaseService authService = SupabaseService._internal();

  final SupabaseClient supabase = Supabase.instance.client;

  factory SupabaseService() {
    return authService;
  }

  SupabaseService._internal();

  bool get isAuthenticated => supabase.auth.currentUser != null;

  User? get currentUser => supabase.auth.currentUser;

  UserModel? convertToUserModel(User? user) {
    if (user == null) return null;

    return UserModel(
      id: user.id,
      email: user.email ?? '',                                                                                                                                                                                                                                                                                                                                                                         
      name: user.userMetadata?['username'] as String?,
    );
  }

  UserModel? get currentUserModel => convertToUserModel(currentUser);

  Future<UserModel> signUp({
    required String email,
    required String password,
    String? username,
    File? profileImage,
  }) async {
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );

    if (response.user == null) {
      throw Exception('Signup failed');
    }

    String? profileUrl;
    
    if (profileImage != null) {
      final String fileExtension = path.extension(profileImage.path);
      final String fileName = '${response.user!.id}$fileExtension';

      try {
        profileUrl = await uploadProfileImage(
          userId: response.user!.id,
          file: profileImage,
          fileName: fileName,
        );
        await supabase.auth.updateUser(
          UserAttributes(
            data: {
              'profile_url': profileUrl,
              'username': username,
            },
          ),
        );
      } catch (e) {
        debugPrint('Failed to upload profile image: $e');
      }
    }

    await supabase.from('users').insert({
      'id': response.user!.id,
      'email': email,
      'username': username,
      'createdAt': DateTime.now().toIso8601String(),
      'isOnline': true,
      'lastSeen': DateTime.now().toIso8601String(),
      'pushToken': '',
      'unreadCount': 0,
      'profile_url': profileUrl, 
    });

    return convertToUserModel(response.user)!;
  }

  Future<String> uploadProfileImage({
    required String userId,
    required File file,
    required String fileName,
  }) async {
    const String bucketName = 'profiles';

    final String storagePath = '$userId/$fileName';

    try {
      final List<FileObject> oldFiles =
          await supabase.storage.from(bucketName).list(path: userId);

      if (oldFiles.isNotEmpty) {
        await supabase.storage
            .from(bucketName)
            .remove(['$userId/${oldFiles.first.name}']);
      }

      await supabase.storage.from(bucketName).upload(
            storagePath,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final String imageUrl =
          supabase.storage.from(bucketName).getPublicUrl(storagePath);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  Future<void> updateProfileImage(File profileImage) async {
    if (currentUser == null) {
      throw Exception('No authenticated user');
    }

    final String fileExtension = path.extension(profileImage.path);

    final String fileName = '${currentUser!.id}$fileExtension';

    final String storagePath = await uploadProfileImage(
      userId: currentUser!.id,
      file: profileImage,
      fileName: fileName,
    );

    await supabase.auth.updateUser(
      UserAttributes(
        data: {
          'profile_url': storagePath,
        },
      ),
    );
  }

  String? getProfileImageUrl() {
    return currentUser?.userMetadata?['profile_url'] as String?;
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Login failed');
    }

    return convertToUserModel(response.user)!;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;

  Future<void> updateOnlineStatus(bool isOnline) async {
    if (currentUser == null) return;

    await supabase.from('users').update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().toIso8601String(),
    }).eq('id', currentUser!.id);
  }

  Future<void> updatePushToken(String token) async {
    if (currentUser == null) return;

    await supabase.from('users').update({
      'pushToken': token,
    }).eq('id', currentUser!.id);
  }

  Future<List<UserModel>> getAllUsers() async {
    final List<Map<String, dynamic>> response = await supabase
        .from('users')
        .select()
        .neq('id', currentUser!.id)
        .order('username');

    return response.map((userData) => UserModel.fromMap(userData)).toList();
  }

  Future<void> sendInvitation({
    required String inviteeId,
    String message = "Hey, let's chat!",
  }) async {
    await supabase.from('invitations').insert({
      'inviter_id': currentUser!.id,
      'invitee_id': inviteeId,
      'message': message,
      'status': 'pending',
      'invite_time': DateTime.now().toIso8601String(),
    });
  }

  Future<void> cancelInvitation(String invitationId) async {
    await supabase
        .from('invitations')
        .delete()
        .eq('invitee_id', invitationId)
        .eq('inviter_id', currentUser!.id);
  }

  Future<Map<String, Map<String, dynamic>>> getInvitationStatuses() async {
    final List<Map<String, dynamic>> invitations = await supabase
        .from('invitations')
        .select()
        .or('inviter_id.eq.${currentUser!.id},invitee_id.eq.${currentUser!.id}');

    final Map<String, Map<String, dynamic>> statuses = {};

    for (final invitation in invitations) {
      final String inviterId = invitation['inviter_id'];
      final String inviteeId = invitation['invitee_id'];
      final String status = invitation['status'];

      if (inviterId == currentUser!.id) {
        statuses[inviteeId] = {
          'sent': true,
          'received': false,
          'status': status,
        };
      } else {
        statuses[inviterId] = {
          'sent': false,
          'received': true,
          'status': status,
        };
      }
    }

    return statuses;
  }

  Future<List<InvitationModel>> getReceivedInvitations() async {
    final List<Map<String, dynamic>> response = await supabase
        .from('invitations')
        .select('''
          *,
          inviter:users!fk_inviter (
            username
          )
        ''')
        .eq('invitee_id', currentUser!.id);

    return response.map((data) => InvitationModel.fromMap(data)).toList();
  }

  Future<void> respondToInvitation({
    required String invitationId,
    required String status,
  }) async {
    // First update invitation status
    await supabase
        .from('invitations')
        .update({'status': status})
        .eq('id', invitationId)
        .eq('invitee_id', currentUser!.id);

    // If accepted, create chat
    if (status == 'accepted') {
      print("aaaaaaaaaaaaaaaaaaaaaaaa${invitationId}");
      final invitation = await supabase
          .from('invitations')
          .select()
          .eq('id', invitationId)
          .single();

      // Get inviter_id from the invitation
      final String inviterId = invitation['inviter_id'];

      // Ensure user1_id is always less than user2_id for consistency
      final String user1Id = currentUser!.id.compareTo(inviterId) < 0 
          ? currentUser!.id 
          : inviterId;
      final String user2Id = currentUser!.id.compareTo(inviterId) < 0 
          ? inviterId 
          : currentUser!.id;

      // Create chat if it doesn't exist
      try {
        await supabase
            .from('chats')
            .insert({
              'user1_id': user1Id,
              'user2_id': user2Id,
            })
            .select()
            .single();
      } catch (e) {
        // Chat might already exist, ignore the error
        debugPrint('Chat creation error (might already exist): $e');
      }
    }
  }

  Future<List<InvitationModel>> getAllInvitations() async {
    final List<Map<String, dynamic>> sentResponse = await supabase
        .from('invitations')
        .select('''
          *,
          inviter:users!invitations_inviter_id_fkey (
            id,
            username,
            profile_url
          ),
          invitee:users!invitations_invitee_id_fkey (
            id,
            username,
            profile_url
          )
        ''')
        .eq('inviter_id', currentUser!.id);

    final List<Map<String, dynamic>> receivedResponse = await supabase
        .from('invitations')
        .select('''
          *,
          inviter:users!invitations_inviter_id_fkey (
            id,
            username,
            profile_url
          ),
          invitee:users!invitations_invitee_id_fkey (
            id,
            username,
            profile_url
          )
        ''')
        .eq('invitee_id', currentUser!.id);

    final sent = sentResponse.map((data) => 
      InvitationModel.fromMap(data)..isSentByMe = true).toList();
    final received = receivedResponse.map((data) => 
      InvitationModel.fromMap(data)..isSentByMe = false).toList();

    return [...sent, ...received];
  }

  Future<String> createChat(String otherUserId) async {
    // Ensure user1_id is always less than user2_id
    final String user1Id = currentUser!.id.compareTo(otherUserId) < 0 
        ? currentUser!.id 
        : otherUserId;
    final String user2Id = currentUser!.id.compareTo(otherUserId) < 0 
        ? otherUserId 
        : currentUser!.id;

    final response = await supabase
        .from('chats')
        .insert({
          'user1_id': user1Id,
          'user2_id': user2Id,
        })
        .select()
        .single();

    return response['id'];
  }

  Future<List<ChatModel>> getChats() async {
    final response = await supabase
        .from('chats')
        .select()
        .or('user1_id.eq.${currentUser!.id},user2_id.eq.${currentUser!.id}')
        .order('updated_at', ascending: false);

    return response.map((chat) => ChatModel.fromMap(chat)).toList();
  }

  Future<void> sendMessage(String chatId, String content) async {
    await supabase
        .from('messages')
        .insert({
          'chat_id': chatId,
          'sender_id': currentUser!.id,
          'content': content,
        });
  }

  Stream<List<Map<String, dynamic>>> getMessages(String chatId) {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at');
  }

  Future<void> markMessagesAsRead(String chatId) async {
    final chat = await supabase
        .from('chats')
        .select()
        .eq('id', chatId)
        .single();

    if (chat['user1_id'] == currentUser!.id) {
      await supabase
          .from('chats')
          .update({'user1_unread_count': 0})
          .eq('id', chatId);
    } else {
      await supabase
          .from('chats')
          .update({'user2_unread_count': 0})
          .eq('id', chatId);
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    
    return UserModel.fromMap(response);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/all_user/user_bloc.dart';
import '../../../blocs/all_user/user_event.dart';
import '../../../blocs/all_user/user_state.dart';
import '../../../data/models/user_model.dart';

class AllUserPage extends StatelessWidget {
  const AllUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Users',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
          bottom: const TabBar(
            labelColor: Colors.black54,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black54,
            tabs: [
              Tab(
                text: 'All Users',
              ),
              Tab(
                text: 'Pending',
              ),
            ],
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserError) {
              return Center(child: Text(state.message));
            }

            if (state is UsersLoaded) {
              final allUsers = state.users;
              final pendingUsers = state.users
                  .where((user) =>
                      state.invitationStatuses[user.id]?['sent'] == true)
                  .toList();

              return TabBarView(
                children: [
                  _UsersList(
                    users: allUsers,
                    invitationStatuses: state.invitationStatuses,
                  ),
                  _UsersList(
                    users: pendingUsers,
                    invitationStatuses: state.invitationStatuses,
                    showOnlyPending: true,
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  final List<UserModel> users;
  final Map<String, Map<String, dynamic>> invitationStatuses;
  final bool showOnlyPending;

  const _UsersList({
    required this.users,
    required this.invitationStatuses,
    this.showOnlyPending = false,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              showOnlyPending ? Icons.pending_outlined : Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              showOnlyPending ? 'No pending invitations' : 'No users found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final invitationStatus = invitationStatuses[user.id] ?? {};
        final bool invitationSent = invitationStatus['sent'] ?? false;
        final bool invitationReceived = invitationStatus['received'] ?? false;

        return Card(
          color: Colors.grey.shade300,
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: user.profileUrl != null
                      ? NetworkImage(user.profileUrl!)
                      : null,
                  child: user.profileUrl == null
                      ? Text(
                          user.name?[0].toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name ?? 'No name',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (invitationReceived) ...[
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(Icons.mail, size: 16, color: Colors.black),
                            SizedBox(width: 4),
                            Text(
                              'Invitation received',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                invitationReceived == true
        ? InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'invitations');
            },
            child: const Padding( 
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.email_outlined),
            ))
        : buildActionButton(context, user, invitationSent,invitationReceived),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildActionButton(
      BuildContext context, UserModel user, bool invitationSent, bool invitationReceived) {
    if (invitationStatuses[user.id]?['status'] == 'accepted') {
      return ElevatedButton.icon(
        icon: const Icon(Icons.chat, size: 20, color: Colors.white),
        label: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade600,
          elevation: 4,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            'chat',
            arguments: {
              'userId': user.id,
              'userName': user.name ?? 'User',
              'userProfileUrl': user.profileUrl,
            },
          );
        },
      );
    }

    if (showOnlyPending) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Pending',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      );
    }
        
    if (invitationSent) {
      return OutlinedButton.icon(
        icon: const Icon(Icons.person_remove, size: 20),
        label: const Text('Cancel'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          context.read<UserBloc>().add(CancelInvitation(inviteeId: user.id));
        },
      );
    }

    return ElevatedButton.icon(
            icon: const Icon(
              Icons.person_add,
              size: 20,
              color: Colors.white,
            ),
            label: const Text(
              'Invite',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade600,
              elevation: 4,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => showInviteDialog(context, user),
          );
  }

  void showInviteDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Chat Invite'),
          content: const Text('Do you want to invite this user to chat?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(
                      SendInvitation(
                        inviteeId: user.id,
                      ),
                    );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invite sent!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Send Invite',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/auth/login/login_bloc.dart';
import '../../../blocs/auth/login/login_event.dart';
import '../../../blocs/auth/login/login_state.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
                            // await FirebaseHelper.firebaseHelper
                            //     .signInAnonymously()
                            //     .then(
                            //   (value) {
                            //     Navigator.pushReplacementNamed(context, 'home');
                            //   },
                            // );
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
                            // await FirebaseHelper.firebaseHelper
                            //     .googleSignIn()
                            //     .then((userCredential) {
                            //   debugPrint(
                            //       "User signed in: ${userCredential.user!.displayName}");
                            //   Navigator.pushReplacementNamed(context, 'home');
                            // }).catchError((e) {
                            //   debugPrint("Error signing in with Google: $e");
                            // });
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
                          if (state.errorMessage == "User not found. Please sign up.") {
                            Navigator.pushReplacementNamed(context, 'signUp');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please create an account first')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
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
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../blocs/auth/signup/signup_bloc.dart';
import '../../../blocs/auth/signup/signup_event.dart';
import '../../../blocs/auth/signup/signup_state.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';


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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/chat/chat_bloc.dart';
import '../../../data/models/message_model.dart';
import '../../../data/services/supabase_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc(SupabaseService());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _chatBloc.add(InitializeChat(args['userId'] as String));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    return BlocProvider.value(
      value: _chatBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                backgroundImage: args['userProfileUrl'] != null
                    ? NetworkImage(args['userProfileUrl'] as String)
                    : null,
                child: args['userProfileUrl'] == null
                    ? Text(
                        (args['userName'] as String)[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                args['userName'] as String,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChatReady) {
              return Column(
                children: [
                  Expanded(
                    child: state.messages.isEmpty
                        ? Center(
                            child: Text(
                              'No messages yet',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final message = state.messages[index];
                              return _MessageBubble(message: message);
                            },
                          ),
                  ),
                  _buildMessageInput(state),
                ],
              );
            }

            if (state is ChatError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMessageInput(ChatReady state) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: state.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send, color: Colors.white),
                onPressed: state.isLoading
                    ? null
                    : () {
                        if (_messageController.text.trim().isNotEmpty) {
                          _chatBloc.add(SendMessage(_messageController.text));
                          _messageController.clear();
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageModel message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMine ? Colors.grey.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: message.isMine ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/all_user/user_bloc.dart';
import '../../../blocs/all_user/user_event.dart';
import '../../../blocs/invitation/invitation_event.dart';
import '../../../data/services/supabase_service.dart';
import '../../../blocs/chat_home/chat_home_bloc.dart';
import '../../../blocs/invitation/invitation_bloc.dart';

// all chat user show list
class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (!mounted) return;
      context.read<ChatHomeBloc>().add(UpdateProfileImage(File(image.path)));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ChatHomeBloc>().add(LoadChats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatHomeBloc, ChatHomeState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Messages',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.black54),
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              ),
            ],
          ),
          endDrawer: Drawer(
            backgroundColor: Colors.grey.shade100,
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: updateProfileImage,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: state.profileUrl != null
                                    ? NetworkImage(state.profileUrl!)
                                    : null,
                                child: state.profileUrl == null
                                    ? const Icon(Icons.person,
                                        size: 45, color: Colors.grey)
                                    : null,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            if (state.isLoading)
                              const Positioned.fill(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        state.user?.userMetadata?['username'] ?? 'User',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.user?.email ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: Icon(Icons.home_outlined, color: Colors.grey[700]),
                        title: const Text('Home'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: Icon(Icons.mail_lock_outlined, color: Colors.grey[700]),
                        title: const Text("Invitations"),
                        onTap: () {
                          context.read<InvitationBloc>().add(LoadInvitations());
                          Navigator.pushNamed(context, 'invitations');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.grey[700]),
                        title: const Text('Logout'),
                        onTap: () {
                          context.read<ChatHomeBloc>().add(OnSignOutButton());
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.chats.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat_bubble_outline,
                                    size: 64, color: Colors.grey[400]),
                                const SizedBox(height: 16),
                                Text(
                                  'No chats yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.chats.length,
                            itemBuilder: (context, index) {
                              final chat = state.chats[index];
                              final otherUser = state.chatUsers[chat.id];

                              if (otherUser == null) {
                                return const SizedBox.shrink();
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    'chat',
                                    arguments: {
                                      'userId': otherUser.id,
                                      'userName': otherUser.name ?? 'User',
                                      'userProfileUrl': otherUser.profileUrl,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        radius: 24,
                                        backgroundImage: otherUser.profileUrl != null
                                            ? NetworkImage(otherUser.profileUrl!)
                                            : null,
                                        child: otherUser.profileUrl == null
                                            ? Text(
                                                (otherUser.name ?? 'U')[0]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              otherUser.name ?? 'User',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              otherUser.email,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<UserBloc>().add(LoadUsers());
              Navigator.pushNamed(context, 'user');
            },
            backgroundColor: Colors.black54,
            elevation: 4,
            child: const Icon(Icons.chat_rounded, color: Colors.white),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invitation/invitation_bloc.dart';
import '../../../blocs/invitation/invitation_event.dart';
import '../../../blocs/invitation/invitation_state.dart';
import '../../../data/models/invitation_model.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Invitations',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
          bottom: const TabBar(
            labelColor: Colors.black54,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black54,
            tabs: [
              Tab(text: 'Received'),
              Tab(text: 'Sent'),
            ],
          ),
        ),
        body: BlocBuilder<InvitationBloc, InvitationState>(
          builder: (context, state) {
            if (state is InvitationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is InvitationsLoaded) {
              final receivedInvitations =
                  state.invitations.where((inv) => !inv.isSentByMe).toList();
              final sentInvitations =
                  state.invitations.where((inv) => inv.isSentByMe).toList();

              return TabBarView(
                children: [
                  InvitationsList(
                      invitations: receivedInvitations, isSent: false),
                  InvitationsList(invitations: sentInvitations, isSent: true),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class InvitationsList extends StatelessWidget {
  final List<InvitationModel> invitations;
  final bool isSent;

  const InvitationsList(
      {super.key, required this.invitations, required this.isSent});

  @override
  Widget build(BuildContext context) {
    if (invitations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSent ? Icons.outbox : Icons.inbox,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isSent ? 'No sent invitations' : 'No received invitations',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: invitations.length,
      itemBuilder: (context, index) {
        final invitation = invitations[index];
        return Card(
          color: Colors.grey.shade300,
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                invitation.status == 'accepted'
                    ? Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                getProfileImage(invitation, isSent),
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint(
                                  'Error loading profile image: $exception');
                            },
                            child: getProfileImage(invitation, isSent) == null
                                ? Text(
                                    (isSent
                                            ? invitation.inviteeName
                                            : invitation.inviterName)[0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null, 
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSent
                                      ? invitation.inviteeName
                                      : invitation.inviterName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _formatDate(invitation.inviteTime),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.chat,
                                size: 20, color: Colors.white),
                            label: const Text(
                              'Chat',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade600,
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                'chat',
                                arguments: {
                                  'userId': isSent ? invitation.inviteeId : invitation.inviterId,
                                  'userName': isSent ? invitation.inviteeName : invitation.inviterName,
                                  'userProfileUrl': isSent ? invitation.inviteeProfileUrl : invitation.inviterProfileUrl,
                                },
                              );
                            },
                          )
                        ],
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                getProfileImage(invitation, isSent),
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint(
                                  'Error loading profile image: $exception');
                            },
                            child: getProfileImage(invitation, isSent) == null
                                ? Text(
                                    (isSent
                                            ? invitation.inviteeName
                                            : invitation.inviterName)[0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSent
                                      ? invitation.inviteeName
                                      : invitation.inviterName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _formatDate(invitation.inviteTime),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildStatusChip(invitation.status),
                        ],
                      ),
                invitation.status == 'accepted'
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 12),
                invitation.status == 'accepted'
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          invitation.message,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                if (invitation.status == 'pending') ...[
                  const SizedBox(height: 16),
                  _buildActionButtons(context, invitation, isSent),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    final statusData = {
      'pending': (Colors.grey.shade600, 'pending'),
      'accepted': (Colors.grey.shade600, 'accepted'),
      'declined': (Colors.grey.shade600, 'declined'),
    }[status]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        statusData.$2,
        style: TextStyle(
          fontSize: 12,
          color: statusData.$1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, InvitationModel invitation, bool isSent) {
    if (!isSent) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              label:
                  const Text('Accept', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade600,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.read<InvitationBloc>().add(
                      RespondToInvitation(
                        invitationId: invitation.id,
                        status: 'accepted',
                      ),
                    );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              label: const Text('Decline'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.read<InvitationBloc>().add(
                      RespondToInvitation(
                        invitationId: invitation.id,
                        status: 'declined',
                      ),
                    );
              },
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton.icon(
            label: const Text('Cancel'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black54,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context.read<InvitationBloc>().add(
                    CancelInvitation(invitationId: invitation.id),
                  );
            },
          ),
        ],
      );
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }

  ImageProvider? getProfileImage(InvitationModel invitation, bool isSent) {
    final String? profileUrl =
        isSent ? invitation.inviteeProfileUrl : invitation.inviterProfileUrl;

    if (profileUrl != null && profileUrl.isNotEmpty) {
      return NetworkImage(profileUrl);
    }
    return null;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/splash/splash_bloc.dart';
import '../../../blocs/splash/splash_event.dart';
import '../../../blocs/splash/splash_state.dart';
import '../../../generated/assets.dart';

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
              } else if (state is SplashErrorState) {
                Navigator.pushReplacementNamed(context, 'signUp');
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
import 'package:chat_app_supabase/blocs/chat_home/chat_home_bloc.dart';
import 'package:chat_app_supabase/presentation/screens/all_user/all_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'bloc_observer.dart';
import 'blocs/all_user/user_bloc.dart';
import 'blocs/auth/login/login_bloc.dart';
import 'blocs/auth/signup/signup_bloc.dart';
import 'data/services/supabase_service.dart';
import 'presentation/screens/auth/login_page.dart';
import 'presentation/screens/auth/signup_page.dart';
import 'presentation/screens/chat/chat_page.dart';
import 'presentation/screens/chat_home/chat_home_page.dart';
import 'presentation/screens/splash/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'blocs/invitation/invitation_bloc.dart';
import 'presentation/screens/invitation/invitation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fvizazfquzexxcetrrfl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2aXphemZxdXpleHhjZXRycmZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU3OTIxNDQsImV4cCI6MjA1MTM2ODE0NH0.G9REr4C7uIhXUeUz2ybsK3F6dE7kG64m09kVqzO8DaE',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
          BlocProvider<ChatHomeBloc>(
            create: (context) => ChatHomeBloc(service: SupabaseService()),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(SupabaseService()),
          ),
          BlocProvider<InvitationBloc>(
            create: (context) => InvitationBloc(SupabaseService()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreen(),
            'signUp': (context) => const SignupPage(),
            'login': (context) => const LogInPage(),
            'home': (context) => const ChatHomePage(),
            'user': (context) => const AllUserPage(),
            'invitations': (context) => const InvitationPage(),
            'chat': (context) => const ChatPage(),
          },
        ),
      );
    },
  ));
}
