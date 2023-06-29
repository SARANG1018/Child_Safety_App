import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void getPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void subscribeToTopic(String topic){
    messaging.subscribeToTopic(topic);
  }
  void unSubscribeToTopic(String topic){
    messaging.unsubscribeFromTopic(topic);
  }

  void TokenSubs(){
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
      // TODO: If necessary send token to application server.
      print("FCM Token :$fcmToken");

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
        .onError((err) {
      print("FCM Error :$err");
      // Error getting token.
    });
  }

  void getMessage(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
  @override
  void onInit() {

    print("Initializing FCM");
    getPermission();
    TokenSubs();
    getMessage();
    FirebaseMessaging.instance.getToken().then((value) => print(value));

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
