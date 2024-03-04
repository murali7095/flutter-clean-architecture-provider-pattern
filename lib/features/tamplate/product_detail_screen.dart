import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? productName;
  final num? id;
  final num? price;
  final String? image;
  final String? description;

  const ProductDetailsScreen(
      {Key? key,
      required this.productName,
      required this.id,
      required this.image,
      this.price,
      this.description})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 300,
                width: double.infinity,
                //color: Colors.grey,
                child: Image(
                  image: NetworkImage('${widget.image}'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              "${widget.productName}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const Text(
                  "'\$':",
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
                Text(
                  widget.price.toString(),
                  style: const TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.description.toString(),
                  textAlign: TextAlign.left,
                )),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: const Text(
                    'Buy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
