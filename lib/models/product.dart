class Product {
  // Initialize all the necessary data for product

  final String productId;
  final String name;
  final double price;

  // Named constuctor @ postion is not important
  Product({this.productId, this.name, this.price});

  // Changing the data into Map (Json) for firestore because firestore only receive JSON type of data to be saved inside database
  Map<String, dynamic> toMap() {
    return {'productId': productId, 'name': name, 'price': price};
  }

  // Changing from Map (Json) from firestore to Product object to display it as a list.
  Product.fromFireStore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'];
}
