import 'package:firebase_demo/models/product.dart';
import 'package:firebase_demo/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// KIV what is the purpose of changenotifier
class ProductProvider with ChangeNotifier {
  // Use the firestore service that we have created for backend purpose
  // Before we can use we need to initialize it first so we dont have to repeat the same code over again.
  final firestoreService = FirestoreService();
  // Initialize same as the class
  String _name;
  double _price;
  String _productId;
  // This line below is to initialize before using the Uuid package.
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners(); // To tell that the value has been changed
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners(); // To tell that the value has been changed
  }

  // This function is to load the product for updating the product inside editproduct page.
  // To give values to the textfield.
  loadValues(Product product) {
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  // Save or update the product inside firebase
  saveProduct() {
    // For creating a new record
    if (_productId == null) {
      var newProduct = Product(
          name: name,
          price: price,
          productId: uuid.v4()); // this will generate a random uuid
      firestoreService.saveProduct(newProduct);
    }
    // to update an existing record
    else {
      var updatedProduct = Product(
          name: name,
          price: price,
          productId:
              _productId); // this will use the same uuid as previous product id
      firestoreService.saveProduct(updatedProduct);
    }
  }

  // delete the product from firebase
  deleteProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
