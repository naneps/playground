import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<String>> getFcmTokens() async {
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<String> tokens = [];
    for (var doc in querySnapshot.docs) {
      if (doc['fcmToken'] != null) {
        tokens.add(doc['fcmToken']);
      }
    }
    return tokens;
  }

  void handleNotificationPayload(Map<String, dynamic> data) {
    // Handle notification payload, e.g., navigate to a specific screen
    print('Notification payload: $data');
    // Add your payload handling logic here
  }

  Future<void> init() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Configure foreground notification presentation options
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message while in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      handleNotificationPayload(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  //   send all users notification
  Future<void> sendAllUsersNotification(String title, String body) async {
    List<String> tokens = await getFcmTokens();
    for (String token in tokens) {
      await sendNotification(token, title, body);
    }
  }

  Future<void> sendNotification(String token, String title, String body) async {
    try {
      // ignore: deprecated_member_use
      await _firebaseMessaging.sendMessage(
        to: token,
        collapseKey: '1',
        data: <String, String>{
          'title': title,
          'body': body,
        },
        ttl: const Duration(minutes: 60).inSeconds,
        messageType: 'notification',
      );
      print('Notification sent successfully');
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> sendNotificationToUser(
      String userId, String title, String body) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc['fcmToken'] != null) {
        String token = userDoc['fcmToken'];
        await sendNotification(token, title, body);
      } else {
        print('User does not have a valid FCM token');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }
}
