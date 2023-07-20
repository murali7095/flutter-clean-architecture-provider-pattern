 
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
      required this.image, this.price, this.description})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productName}" ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [        
            Center(
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 300,
                width: 300,
                child: Image(
                  image: NetworkImage('${widget.image}'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(title: const Text("Price:",style: TextStyle(color: Colors.orange,fontSize: 25.0),),trailing: Text(widget.price.toString()),),
            Row(children: [
              const Text('Description  '),
              Expanded(child: Text(widget.description.toString(),textAlign: TextAlign.left,)),
            ],),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              IconButton(onPressed:  (){}, icon:  const Icon(Icons.favorite_border)),
              ElevatedButton(onPressed:  (){}, child:  const Text('Add to cart'))
            ],),
           ],
        ),
      ),
    );
  }
}
