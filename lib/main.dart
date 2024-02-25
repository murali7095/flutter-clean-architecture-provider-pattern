import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/bottom_nav_bar_widget.dart';
import 'package:m_mart_shopping/core/common%20widgets/splash%20screens/welcome_screen.dart';

import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/screens/sign_in_user_main.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/usecases/sign_up_usecase.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/repositories/sign_up_repo_impl.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/screens/sign_up_user_main.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:m_mart_shopping/features/products/product_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // //final res =await SignUpUser(SignUpRepositoryImplementation()).registerTheUser(signUpModel: SignUpModel(email: "reddy162@gmail.com", password: "murali12354", returnSecureToken: true));
  // debugPrint("the isLeft() : ${res.isLeft().toString()}");
  // debugPrint("the isRight() : ${res.isRight()}");

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, x}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screens = [
      const HomePage(),
      const HomePage(),
    ];

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("MMart"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

void getSTream() {
  StreamController<double> controller = StreamController<double>();
}
