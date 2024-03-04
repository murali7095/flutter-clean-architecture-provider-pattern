import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/bottom_nav_bar_widget.dart';
import 'package:m_mart_shopping/core/common%20widgets/splash%20screens/welcome_screen.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:m_mart_shopping/features/products/product_provider.dart';
import 'package:provider/provider.dart';

import 'features/auth/signIn/presentation/screens/sign_in_user_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
    ChangeNotifierProvider<SignInController>(create: (_) => SignInController()),
    ChangeNotifierProvider<SignUpController>(create: (_) => SignUpController()),
  ], child: const MyApp()));
}

Future<void> getData() async {
  ProductProvider().getProducts();
  // await source.getTheAllProducts;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '𝙈𝙈𝙖𝙧𝙩',
      theme: ThemeData(
          useMaterial3: true,
          //primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Colors.blue.shade500,
            titleTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black87,
          )),
      home: const SafeArea(child: WelcomeScreen()),
    );
  }
}



