import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/user.model.dart';

class UserService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> createUserInFirestore(User firebaseUser) async {
    try {
      final userDoc = _firestore.collection('users').doc(firebaseUser.uid);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        final newUser = UserModel(
          uid: firebaseUser.uid,
          avatar: firebaseUser.photoURL ?? '',
          email: firebaseUser.email,
          name: firebaseUser.displayName,
          username: 'user_${firebaseUser.uid.substring(0, 5)}',
          online: true,
          typingStatus: {}, // Initialize typingStatus as an empty map
        );
        await userDoc.set(newUser.toJson());
        user.value = newUser;
        print('User created in Firestore');
      } else {
        print('User already exists in Firestore, skipping creation');
      }
    } catch (e) {
      print('Error during user creation in Firestore: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void setUserIsTyping(bool isTyping, String chatRoomId) {
    if (user.value != null) {
      final typingStatus = user.value!.typingStatus ?? {};
      typingStatus[chatRoomId] = isTyping;
      user.value!.typingStatus = typingStatus;
      updateUserFieldInFirestore('typingStatus', typingStatus);
    }
  }

  Future<void> setUserOnlineStatus(bool isOnline) async {
    if (user.value != null && user.value!.online != isOnline) {
      user.value!.online = isOnline;
      updateUserFieldInFirestore('online', isOnline);
    }
  }

  Future<void> updateUserFieldInFirestore(String field, dynamic value) async {
    try {
      final userDoc = _firestore.collection('users').doc(user.value!.uid);
      await userDoc.update({field: value});
      print('User $field updated in Firestore');
    } catch (e) {
      print('Error updating user $field in Firestore: $e');
    }
  }

  Future<void> updateUserInFirestore(UserModel updatedUser) async {
    try {
      final userDoc = _firestore.collection('users').doc(updatedUser.uid);
      await userDoc.update(updatedUser.toJson());
      user.value = updatedUser;
      print('User updated in Firestore');
    } catch (e) {
      print('Error updating user in Firestore: $e');
    }
  }

  void updateUserProfile({
    String? name,
    String? role,
    String? about,
    DateTime? birthday,
  }) {
    if (user.value != null) {
      final updatedUser = user.value!;
      if (name != null) updatedUser.name = name;
      if (role != null) updatedUser.role = role;
      if (about != null) updatedUser.about = about;
      if (birthday != null) updatedUser.birthday = birthday;
      updateUserInFirestore(updatedUser);
    }
  }

  Future<UserModel?> _getUserFromFirestore(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data()!);
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
    }
    return null;
  }

  void _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      user.value = null;
    } else {
      user.value = await _getUserFromFirestore(firebaseUser.uid);
      if (user.value != null) {
        setUserOnlineStatus(true);
      }
    }
  }
}
