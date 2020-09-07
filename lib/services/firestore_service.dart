import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/models/product.dart';

class FirestoreService {
  // We need to initialize the instance before we can use any Firestore functions.
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // save the product to the database
  Future<void> saveProduct(Product product) {
    return _db.collection('products').doc(product.productId).set(product
        .toMap()); // need to convert the product object into map (json) type so that firebase can save it to database
  }

  // Getting the products from firebase
  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => // .map is a loop
                Product.fromFireStore(document.data())) // from json -> object
            .toList()); // each object will be compile it into a list (array)
  }

  // remove the product from the database
  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}
