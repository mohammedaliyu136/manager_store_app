class Stock {
  final int id;
  String item;
  int quantity;
  String price;

  Stock({this.id, this.item, this.quantity, this.price});

  void update(item, quantity, price){
    this.item=item;
    this.quantity=quantity;
    this.price=price;

  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'] as int,
      item: json['item'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as String,
    );
  }
}

class Stock2 {
  final String id;
  final String itemCategory;
  final String item;
  //final int quantity;
  final int price;

  Stock2({this.id, this.itemCategory, this.item, this.price});

  factory Stock2.fromJson(Map<String, dynamic> json) {
    return Stock2(
      id: json['id'] as String,
      itemCategory: json['itemCategory'] as String,
      item: json['item'] as String,
      price: json['price'] as int,
    );
  }
}