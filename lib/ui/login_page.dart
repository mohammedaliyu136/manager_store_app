import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/manager.dart';
import 'package:flutter_shopmanager_v21/repository/api.dart';
import 'package:provider/provider.dart';

import 'barchartsample.dart';
import 'stock/stocks_page.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  String username = "";
  bool error_username = false;
  bool error_password = false;
  String password = "";

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);

    return Scaffold(
      body: !bloc.isLoading?Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            error_username?Text("Username you entered is invalid", style: TextStyle(fontSize: 16),):Container(),
            error_username?SizedBox(height: 10,):Container(),
            TextField(

              decoration: InputDecoration(
                labelText: "Username",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 0.5),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  username=value;
                  error_username=false;
                });
              },
            ),
            SizedBox(height: 20,),
            error_password?Text("Password you entered is invalid", style: TextStyle(fontSize: 16),):Container(),
            error_password?SizedBox(height: 10,):Container(),
            TextField(
              //obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 0.5),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password=value;
                  error_password=false;
                });
              },
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                    onPressed: () async {
                      print("login details.............................");
                      print("username: $username, password: $password");
                      if(username.trim()==""){
                        setState(() {
                          error_username=true;
                        });
                      }
                      if(password.trim()==""){
                        setState(() {
                          error_password=true;
                        });
                      }
                      if(!error_username&&!error_password){
                        await login(username, password).then((res){
                          var body = json.decode(res.body);
                          if(body['status']=="Ok"){
                            List<Shop1> shops=[];
                            for(var i=0; i<body['data']['shops'].length; i++){
                              Shop1 shop = Shop1(id:body['data']['shops']['items'][i]['id'],name:body['data']['shops']['items'][i]['name'],address: body['data']['shops']['items'][i]['address']);
                              shops.add(shop);
                            }
                            Manager manager = Manager(
                                id:body['data']['id'],
                                name:body['data']['name'],
                                address:body['data']['address'],
                                phone:body['data']['phone'],
                                email:body['data']['email'],
                                username:body['data']['username'],
                                shops: shops
                            );

                            bloc.setManager(manager);
                          }
                        });


                        //bloc.getStocks();
                        bloc.getStocks2();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StocksPage()),
                        );
                      }

                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ):Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 0, 40, 1),),),
              SizedBox(height: 20,),
              Text("Loading, Please wait", style: TextStyle(fontSize: 20,),),
            ],
          ),
        ),
      ),
    );
  }
}
