class Shop {
  final int id;
  String shop_id;
  int sells;
  String location;

  Shop({this.id, this.shop_id, this.sells, this.location});
  update(shop_id, sells, location){
    this.shop_id=shop_id;
    this.sells=sells;
    this.location=location;
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int,
      shop_id: json['shop_id'] as String,
      sells: json['quantity'] as int,
      location: json['location'] as String,
    );
  }
}
//-----------v2------------------
class Shop2 {
  final String id;
  final String name;
  final String manager;
  final String address;

  Shop2({this.id, this.name, this.manager, this.address});

  factory Shop2.fromJson(Map<String, dynamic> json) {
    return Shop2(
      id: json['id'] as String,
      name: json['name'] as String,
      manager: json['manager'] as String,
      address: json['address'] as String,
    );
  }
}
class StockCategory2 {
  final String id;
  final String name;
  final String description;
  final Shop2 shop;

  StockCategory2({this.id, this.name, this.description, this.shop});

}