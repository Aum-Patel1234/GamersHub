import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
    this.bio,
    this.createdAt,
    this.updatedAt,
    this.favoriteGames,
    this.preferredGenres,
    this.friends,
    this.followers,
    this.following,
    this.achievements,
    this.recentlyPlayed,
    this.notificationsEnabled,
    this.isGuest = false,
  });

  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profilePicture; 
  final String? bio; 
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String>? favoriteGames; 
  final List<String>? preferredGenres;
  final List<String>? friends; 
  final List<String>? followers; 
  final List<String>? following; 
  final List<String>? achievements; 
  final List<String>? recentlyPlayed; 
  final bool? notificationsEnabled; 
  final bool isGuest;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] != null ? map['email'] as String : "", // handle null
      phoneNumber: map['phoneNumber'] as String?,
      username: map['username'] != null ? map['username'] as String : map['email'].toString().split('@')[0],
      profilePicture: map['profilePicture'] as String?,
      bio: map['bio'] as String?,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      favoriteGames: List<String>.from(map['favoriteGames'] ?? []),
      preferredGenres: List<String>.from(map['preferredGenres'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      achievements: List<String>.from(map['achievements'] ?? []),
      recentlyPlayed: List<String>.from(map['recentlyPlayed'] ?? []),
      notificationsEnabled: map['notificationsEnabled'] as bool?,
      isGuest: map['isGuest'] as bool,
    );
  }

  UserModel copyWith({
    String? username,
    String? profilePicture,
    String? bio,
    DateTime? updatedAt,
    List<String>? favoriteGames,
    List<String>? preferredGenres,
    List<String>? friends,
    List<String>? followers,
    List<String>? following,
    List<String>? achievements,
    List<String>? recentlyPlayed,
    bool? notificationsEnabled,
    Map<String, dynamic>? privacySettings,
  }) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      email: email,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteGames: favoriteGames ?? this.favoriteGames,
      preferredGenres: preferredGenres ?? this.preferredGenres,
      friends: friends ?? this.friends,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      achievements: achievements ?? this.achievements,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isGuest: isGuest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'bio': bio,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'favoriteGames': favoriteGames,
      'preferredGenres': preferredGenres,
      'friends': friends,
      'followers': followers,
      'following': following,
      'achievements': achievements,
      'recentlyPlayed': recentlyPlayed,
      'notificationsEnabled': notificationsEnabled,
      'isGuest': isGuest,
    };
  }
  
  factory UserModel.fromFirebaseUser(User user, {bool isGuest = false}) {
    return UserModel(
      id: user.uid,
      username: user.displayName ?? user.email!.split("@")[0],
      email: user.email ?? '',
      phoneNumber: user.phoneNumber,
      profilePicture: user.photoURL,
      bio: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      favoriteGames: [],
      preferredGenres: [],
      friends: [],
      followers: [],
      following: [],
      achievements: [],
      recentlyPlayed: [],
      notificationsEnabled: true,
      isGuest: isGuest,
    );
  }
}
