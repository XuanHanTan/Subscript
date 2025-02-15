import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:subscript/services/listenerEnums.dart';
import 'package:subscript/services/notificationservice.dart';
import 'package:subscript/pages/homepage.dart';
import 'package:subscript/services/subscription.dart';
import 'package:subscript/pages/signinpage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:async';

import 'package:uuid/uuid.dart';

final lightTheme = ThemeData.light(useMaterial3: true);
final filledButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: lightTheme.colorScheme.primary,
        foregroundColor: lightTheme.colorScheme.onPrimary)
    .copyWith(elevation: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.hovered)) {
    return 1;
  }
  return 0;
}));

final darkTheme = ThemeData.dark(useMaterial3: true);
final darkFilledButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: darkTheme.colorScheme.primary,
        foregroundColor: darkTheme.colorScheme.onPrimary)
    .copyWith(elevation: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.hovered)) {
    return 1;
  }
  return 0;
}));

late final String uid;
final List<Subscription> Subscripts = [
  Subscription(
      id: const Uuid().v4(),
      title: "Netflix",
      description: "Netflix personal plan monthly payment!!!",
      dueDate: DateTime(2023, 3, 15, 00, 06),
      price: 5.129971234,
      currency: "SGD",
      frequency: "per month"),
  Subscription(
      id: const Uuid().v4(),
      title: "Youtube Premium",
      description: "please pay i need ad-free among us vids",
      dueDate: DateTime(2023, 3, 15, 00, 06),
      price: 90.99123475,
      currency: "SGD",
      frequency: "per year"),
  Subscription(
      id: const Uuid().v4(),
      title: "NordVPN Premium",
      description: "need the hub privately so pls pay",
      dueDate: DateTime(2023, 3, 15, 00, 06),
      price: 23.234234,
      currency: "SGD",
      frequency: "per week")
];
final subStreamController = StreamController<SubscriptStream>.broadcast();

/// Feedback:
/// 1. Use notificationService globally and initialize in main function

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  NotificationService().initNotification();
  tz.initializeTimeZones();

  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    runApp(MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SignInPage(),
    ));
  } else {
    uid = currentUser.uid;
    runApp(MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    ));
  }
}
