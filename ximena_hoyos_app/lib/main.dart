import 'package:data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:data/models/checkout_item.dart';
import 'package:data/models/woocommerce_order_model.dart';

int numOfCardItems = 1;
List<CheckoutItem> checkoutItems = [];
List<LineItems> shopOrderItems = [];
Billing userBilling = Billing();
int selectedChallengeId = 0;
double totalPrice = 0;
bool isChallengeOwned = false;
int? challengeSelectedId = 0;
bool areRecipesUnlocked = false;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.light));
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}
