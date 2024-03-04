import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/features/home%20page/presentation/Phones.dart';
import 'package:m_mart_shopping/features/home%20page/presentation/laptops.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final offersList = [
    "assets/images/offer.jpg",
    "assets/images/offer2.png",
    "assets/images/offer3.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuBar(
        children: [],
      ),
      appBar: AppBar(
        title: const Text("𝙈𝙈𝙖𝙧𝙩"),
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 18,
          ),
          Badge(
            label: Text("3"),
            child: Icon(Icons.notifications),
          ),
          SizedBox(
            width: 18,
          ),
          Icon(Icons.shopping_cart),
          SizedBox(
            width: 4,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 180.0),
              items: offersList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      elevation: 4,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.asset(
                            i,
                            fit: BoxFit.fill,
                          )),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                categoryItemsWidget(
                    "assets/images/phone.png", "Mobile", const PhonesWidget()),
                categoryItemsWidget("assets/images/laptop.png", "Laptops",
                    const LaptopsWidget()),
                categoryItemsWidget("assets/images/home.png", "home Decoration",
                    const PhonesWidget()),
                categoryItemsWidget("assets/images/grocery.png", "Grocery",
                    const LaptopsWidget()),
                // categoryItemsWidget("assets/images/phone.png","Laptops",const LaptopsWidget()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column categoryItemsWidget(
      String categoryImage, nameOfTheCategory, nextScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => nextScreen,
                ));
          },
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Image.asset(
                //"assets/images/phone.png",
                categoryImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          nameOfTheCategory,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
