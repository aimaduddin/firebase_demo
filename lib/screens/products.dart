import 'package:firebase_demo/models/product.dart';
import 'package:firebase_demo/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Stream of snapshots
    // Use the streamProvider
    final products = Provider.of<List<Product>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProduct()));
            },
          ),
        ],
      ),
      body: (products != null) // Check wheter there is any data or not
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  trailing: Text(products[index].price.toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProduct(products[index])));
                  },
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
