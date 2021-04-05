//{"id":1,"name":"Luisa Bohin","sells":40686,"shop_id":"Grocery"},
class Seller {
  final int id;
  String name;
  int sells;
  String shopID;

  Seller({this.id, this.name, this.sells, this.shopID});

  update(name, sells, shopID){
    this.name=name;
    this.sells=sells;
    this.shopID=shopID;
  }

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'] as int,
      name: json['name'] as String,
      sells: json['sells'] as int,
      shopID: json['shop_id'] as String,
    );
  }
}