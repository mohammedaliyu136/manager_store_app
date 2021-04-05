
import 'manager.dart';

class Stock212 {
  String id;
  String item;
  int quantity;
  int price;
  Shop1 shop;
  itemCategory category;

  Stock212({this.id, this.item, this.quantity, this.price, this.shop, this.category}){
    this.id=id;
    this.item=item;
    this.quantity=quantity;
    this.price=price;
    this.shop=shop;
    this.category=category;
  }

}

class itemCategory {
  String id;
  String name;
  String description;

  itemCategory({this.id, this.name, this.description}){
    this.id=id;
    this.name=name;
    this.description=description;
  }
}