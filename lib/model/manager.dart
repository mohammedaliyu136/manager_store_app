class Manager {
  String id;
  String name;
  String address;
  String phone;
  String email;
  String username;
  List<Shop1> shops;

  /*

  */

  Manager({this.id, this.name, this.address, this.phone, this.email, this.username, this.shops}){
    this.id=id;
    this.name=name;
    this.address=address;
    this.phone=phone;
    this.email=email;
    this.username=username;
    this.shops=shops;
  }

  update(name, address, phone, email, username){
    this.name=name;
    this.address=address;
    this.phone=phone;
    this.email=email;
    this.username=username;
  }

}
//{id: 32ff2d4b-4162-41a8-a0af-e4432337f810, name: Kijana, address: 10 Plot 6 Galadima aminu way yola}
class Shop1{
  String id;
  String name;
  String address;
  Shop1({this.id, this.name, this.address}){
    this.id=id;
    this.name=name;
    this.address=address;
  }
}