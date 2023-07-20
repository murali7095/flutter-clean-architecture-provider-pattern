import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/common%20widgets/bottom_nav_bar_widget.dart';
import 'package:m_mart_shopping/home%20page/home_page.dart';
import 'package:m_mart_shopping/products/product_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(create:  (_)=>ProductProvider()),
  ],
  child: const MyApp()));
}

Future<void> getData() async{
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
      home: const MyHomePage(),
    );
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,x
  }) : super(key: key);

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
        actions: [
          IconButton(onPressed:  (){}, icon:  const Icon(Icons.person))
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
