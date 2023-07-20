import 'package:flutter/material.dart';
import 'package:m_mart_shopping/products/product_detail_screen.dart';
import 'package:m_mart_shopping/products/product_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    var data = Provider.of<ProductProvider>(context, listen: false);
    data.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var result =  Provider.of<ProductProvider>(context );
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  hintText: 'Search here...',
                  prefix: const Icon(Icons.search),
                  suffix: const Icon(Icons.clear),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              color: const Color(0xFFC1DF18),
              margin: const EdgeInsets.all(5),
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.shop_rounded,
                      size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shop_rounded,
                      size: 50,
                      semanticLabel: 'Shop Now',
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.movie_creation_outlined,
                        size: 50,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: ((_, product, __) {
                  return product.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          itemCount: product.products?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              productName: product
                                                  .products?[index].title,
                                              id: product.products?[index].id,
                                              image: product
                                                  .products?[index].image,
                                              price: product
                                                  .products?[index].price,
                                              description: product
                                                  .products?[index].description,
                                            )));
                              },
                              // onTap: (){
                              //   Navigator.push(context,MaterialPageRoute(builder:  (context)=>ProductDetailsScreen(productName: productName, id: id, image: image)));
                              // }
                              child: Card(
                                elevation: 3,
                                child: SizedBox(
                                  height: 250,
                                  width: 180,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        height: 120,
                                        width: 150,
                                        child: Image(
                                          image: NetworkImage(
                                              '${product.products?[index].image}'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${product.products?[index].title}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF444444))),
                                      ),
                                      Text(
                                        '₹ ${product.products?[index].price}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.orange.shade900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          },
                        );
                  // Text('${product.products? [2].title}');
                }),
              ),
            ),
            //  )
            // result.isLoading?  const Center(child: CircularProgressIndicator()):Text('${result.products? [1].title}'),
            // ChangeNotifierProvider<ProductProvider>(
            //   create: ((context) => ProductProvider()),
            //   builder: ((context, child) {
            //     return   Consumer<ProductProvider>(builder:  ((context, product, child) {
            //     return product.isLoading? const Center(child: CircularProgressIndicator()):
            //      Text('${product.products? [1].title}');
            //   }),);
            //   }),

            // )
          ],
        ),
      ),
      // ),
    );
  }
}
