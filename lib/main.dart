import 'package:chat_app/constant/app_routes.dart';
import 'package:chat_app/view/pages/chat_page.dart';
import 'package:chat_app/view/pages/login_page.dart';
import 'package:chat_app/view/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Scolar_Chat());
}

class Scolar_Chat extends StatelessWidget {
  const Scolar_Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRoute.chatPage: (context)=>ChatPage(),
        AppRoute.loginPage: (context) => const LoginPage(),
        AppRoute.registerPage: (context) => RegisterPage()
      },
      initialRoute: AppRoute.loginPage,
    );
  }
}
