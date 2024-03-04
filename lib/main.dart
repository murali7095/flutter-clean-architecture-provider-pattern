import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/bottom_nav_bar_widget.dart';
import 'package:m_mart_shopping/core/common%20widgets/splash%20screens/welcome_screen.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/screens/sign_up_user_main.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:m_mart_shopping/features/products/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'features/auth/signIn/presentation/screens/sign_in_user_main.dart';
import 'features/home page/presentation/home_page_main.dart';
import 'features/products/data/products_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await ProductDataSourceImpl().getTheProducts();
  // await updateProducts();
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
      home: const SafeArea(child: SignInUserMain()),
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
//
// Future<void> updateProducts() async{
//   final info = await http.get(Uri.parse("https://dummyjson.com/products"));
//   debugPrint(info.body);
//   final result = json.decode(info.body);
//   debugPrint("result : $result");
//   final data = await http.post(Uri.parse("https://shop-app-36d2c-default-rtdb.firebaseio.com/products.json"),body: json.encode(result));
//
// }
