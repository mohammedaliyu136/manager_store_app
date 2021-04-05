// A function that converts a response body into a List<Photo>.
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_shopmanager_v21/model/seller.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';

import '../model/stock.dart';
import 'data/stocks.dart';
import 'package:http/http.dart' as http;


login(param_username, param_passowrd) async {
  String username = param_username;
  String password = param_passowrd;
  var bytes1 = utf8.encode("ajisaq1234567890tishaqpass1234");         // data being hashed
  var bytes2 = utf8.encode("ajisaq1234567890${username+password}");         // data being hashed
  var digest1 = sha512.convert(bytes1);
  var digest2 = sha512.convert(bytes2);
  print(digest1);
  print(digest2);
  var url = 'https://atstestshop.ajisaqsolutions.com/api/manager/login?username=tishaq&apiUser=ajisaq&apiKey=1234567890&hash=2e9c9ba64af41acd41ecf96d089ca9238b60b11a95f9ed7046efd68f4c3f86d432eff05e2a6e1a15df23ccd75722f59ec13d4fa1127310c28119384b3e8b7eda&password=pass1234';
  var url2 = 'https://atstestshop.ajisaqsolutions.com/api/manager/login?username=${param_username}&apiUser=ajisaq&apiKey=1234567890&hash=${digest2}&password=$param_passowrd';
  var response = await http.get(url);
  var response2 = await http.get(url2);
  //print(response.body);
  //print(response2.body);
  return response2;
}

getStocksAPI(apiUser, apiKey) async {
  var bytes = utf8.encode(apiUser+apiKey);
  var digest = sha512.convert(bytes);
  var url = 'https://atstestshop.ajisaqsolutions.com/api/stock/list?apiUser=$apiUser&apiKey=$apiKey&hash=$digest';
  var response = await http.get(url);
  return response;
}

getShopsAPI(apiUser, apiKey)async{
  var bytes = utf8.encode(apiUser+apiKey);
  var digest = sha512.convert(bytes);
  var url = 'https://atstestshop.ajisaqsolutions.com/api/shop/list?apiUser=$apiUser&apiKey=$apiKey&hash=$digest';
  var response = await http.get(url);
  return response;
}
addShopsAPI(apiUser, apiKey, Shop2 shop)async{
  var bytes3 = utf8.encode(apiUser+apiKey+shop.manager.trim()+shop.name.trim()+shop.address.trim());
  var digest3 = sha512.convert(bytes3).toString();
  var url = 'https://atstestshop.ajisaqsolutions.com/api/shop/add?apiUser=$apiUser&apiKey=$apiKey&hash=$digest3&name=${shop.name.trim()}&address=${shop.address.trim()}&managerId=${shop.manager.trim()}';

  var response = await http.post(url);
  return response;
}
deleteShopAPI(apiUser, apiKey, Shop2 shop)async{
  var bytes3 = utf8.encode(apiUser+apiKey+shop.id);
  var digest3 = sha512.convert(bytes3).toString();
  var url = 'https://atstestshop.ajisaqsolutions.com/api/shop/remove?apiUser=$apiUser&apiKey=$apiKey&hash=$digest3&id=${shop.id.trim()}';

  var response = await http.get(url);
  return response;
}

//stock category...
getStockCategoriesAPI(apiUser, apiKey)async{
  var bytes = utf8.encode(apiUser+apiKey);
  var digest = sha512.convert(bytes);
  var url = 'https://atstestshop.ajisaqsolutions.com/api/stockCategory/list?apiUser=$apiUser&apiKey=$apiKey&hash=$digest';
  var response = await http.get(url);
  return response;
}
addStockCategoryAPI(apiUser, apiKey, StockCategory2 stockCategory)async{
  print("--------------------------");
  print("--------------------------");
  print("--------------------------");
  print(stockCategory.shop);
  //1b422fa880a0229e72ffd7599ba9ccb5e12447d5a28ec3d84a83a8c665adcb6e330cd3f2c0cd463e8cee7373e9cb0d38124b0e0ce65eff54baa3c7bec136df96
  //1b422fa880a0229e72ffd7599ba9ccb5e12447d5a28ec3d84a83a8c665adcb6e330cd3f2c0cd463e8cee7373e9cb0d38124b0e0ce65eff54baa3c7bec136df96
  var bytes3 = utf8.encode(apiUser+apiKey+stockCategory.shop.id.trim()+stockCategory.name.trim()+stockCategory.description.trim());
  var digest3 = sha512.convert(bytes3).toString();
  var url = 'https://atstestshop.ajisaqsolutions.com/api/shop/add?apiUser=$apiUser&apiKey=$apiKey&hash=$digest3&id=${stockCategory.shop.id.trim()}&name=${stockCategory.name.trim()}&description=${stockCategory.description.trim()}}';

  var response = await http.post(url);
  return response;
}
deleteStockCategoryAPI(apiUser, apiKey, StockCategory2 stockCategory)async{
  var bytes3 = utf8.encode(apiUser+apiKey+stockCategory.id);
  var digest3 = sha512.convert(bytes3).toString();
  var url = 'https://atstestshop.ajisaqsolutions.com/api/shop/remove?apiUser=$apiUser&apiKey=$apiKey&hash=$digest3&id=${stockCategory.id.trim()}';

  var response = await http.get(url);
  return response;
}

List<Stock> parseStock2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Stock>((json) => Stock.fromJson(json)).toList();
}

List<Stock> parseStock(stocks_data) {
  return stocks_data.map<Stock>((json) => Stock.fromJson(json)).toList();
}


Future<List<Stock2>> parseStockweb() async {
  var url = "https://atstestshop.ajisaqsolutions.com/api/stock/list?apiUser=ajisaq&apiKey=1234567890&hash=d90578d3f1abba623a6556ecb20003f757d3a6a73a1e7866c0ed4a26fd1233dd9363484389eea2fa0c8bbeb9022a3ea72f89c50d59d9e8411f80d710e0a88215";
  var response = await http.get(url);
  print("00000000000000000");
  print(response.statusCode);
  var data = json.decode(response.body)["data"];

  return data.map<Stock2>((json) => Stock2.fromJson(json)).toList();
}
Future<List<Shop2>> parseShopsweb() async {
  var url = "https://atstestshop.ajisaqsolutions.com/api/shop/list?apiUser=ajisaq&apiKey=1234567890&hash=d90578d3f1abba623a6556ecb20003f757d3a6a73a1e7866c0ed4a26fd1233dd9363484389eea2fa0c8bbeb9022a3ea72f89c50d59d9e8411f80d710e0a88215";
  var response = await http.get(url);
  print("00000000000000000");
  print(response.statusCode);
  var data = json.decode(response.body)["data"];

  return data.map<Shop2>((json) => Shop2.fromJson(json)).toList();
}

List<Seller> parseSeller(seller_data) {
  return seller_data.map<Seller>((json) => Seller.fromJson(json)).toList();
}

List<Shop> parseShop(shop_data) {
  return shop_data.map<Shop>((json) => Shop.fromJson(json)).toList();
}