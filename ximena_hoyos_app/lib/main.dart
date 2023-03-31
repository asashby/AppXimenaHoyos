import 'package:data/models/products_payload_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:data/models/checkout_item.dart';
import 'package:data/models/woocommerce_order_model.dart';
import 'package:data/models/shop_product.dart';
import 'package:data/models/shop_order.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

int numOfCardItems = 1;
List<CheckoutItem> checkoutItems = [];
List<ShopItem> shopOrderItems = [];
List<ShopProduct> shopProducts = [];
List<int> shopPromoItems = [];
Billing userBilling = Billing();
int selectedChallengeId = 0;
double totalPrice = 0;
bool isChallengeOwned = false;
int? challengeSelectedId = 0;
bool areRecipesUnlocked = false;
bool orderHasPromo = false;
List<Product> productsRawData = [];
List<Product> productsFilteredData = [];
List<Categories> categoriesRawData = [];
dynamic consultationBody = {};

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.light));
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*await setFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebasemessagingBackgroundHandler);*/

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(App());
}

Future setFirebaseMessaging() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((event) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${event.data}}');

    if(event.notification!=null){
      print('Message also contained a notification: ${event.notification}');
    }
  });
}

Future<void> _firebasemessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  
  print("Handling a background message: ${message.messageId}");
}