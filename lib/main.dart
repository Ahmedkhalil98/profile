import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:profile/Screen/messages_board.dart';
import 'package:profile/Screen/profile_page.dart';
import 'package:profile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessagesBoard(),
    );
  }
}
