import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:data/models/checkout_item.dart';

int numOfCardItems = 0;
List<CheckoutItem> checkoutItems = [];
double totalPrice = 0;
bool isChallengeOwned = false;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.light));
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}
