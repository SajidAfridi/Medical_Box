import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler); // Register the background message handler
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      // Show an alert notification when a message is received in the foreground
      badge: true,
      // Update the badge number of the app's launcher icon when a message is received in the foreground
      sound: true, // Play a sound when a message is received in the foreground
    );
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      handleForegroundMessage(initialMessage);
    }
    // Listen for incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleForegroundMessage(message);
    });
    // Listen for notification tap events when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleForegroundMessage(message);
    });
  }

  // Handle background messages
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  // Handle foreground messages
  void handleForegroundMessage(RemoteMessage message) {}
}
