import 'package:firebase_demo/models/product.dart';
import 'package:firebase_demo/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  // This one is to get value from product page if there is available (optional) ->
  // Product page to edit product @ get product information
  final Product product;
  EditProduct(
      [this.product]); // [] -> means optional. it can have value or not.

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  // TextEditingController is for when updating an exisiting product
  // This will make the text input filled with existing product's data
  // name and price
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override

  // This method is for clearing the text field when it has been used.
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // This function is to initialize the product data whenever editproduct page is been loaded up.
    // To check whether there is any product data has been seen to the page.

    // If there is no data, the textfield will be set to default value
    // We need to update both the textfield and state (provider)
    if (widget.product == null) {
      // New record
      nameController.text = "";
      priceController.text = "";
      //State update
      // The provider value will be default value too.
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context,
            listen:
                false); // listen:false is necessary to avoid errors because we just need the value not to update it so we do not have to listen everytime.
        productProvider.loadValues(Product());
      });
    } else {
      // Exisiting record
      // Controller update
      // Set the textfield value with the data that has been passed from Products page.
      nameController.text = widget.product.name;
      priceController.text = widget.product.price.toString();

      //State update
      // Update the value inside the provider.
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the provider so that we can use the provider's function that we have set @ product_provider
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Product Name'),
              onChanged: (value) {
                // Execute the function to change the value inside provider
                productProvider.changeName(value);
              },
              controller:
                  nameController, // bind the textfield with the exisiting value.
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Product Price'),
              onChanged: (value) {
                productProvider.changePrice(
                    value); // Execute the function to change the value inside provider
              },
              controller:
                  priceController, // bind the textfield with the exisiting value.
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                productProvider
                    .saveProduct(); // Execute the function to save the product to firestore
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            (widget.product != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      productProvider.deleteProduct(widget.product
                          .productId); // Execute the function to delete product & we need to pass the productId so that the firebase know which data that we want to delete.
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
