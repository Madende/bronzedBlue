import 'dart:convert';

import 'package:bronzed_blue/controller/LoginController.dart';
import 'package:bronzed_blue/env.dart';
import 'package:bronzed_blue/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'addUserScreen.dart';


class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  LoginController loginController  = Get.find();

  ///response from the server
  List<dynamic> resp =[] ;

  String loadingText = "Loading...";


  ///Get users method
  Future <void> _getUsers()async {
    try{
      var url = "${baseUrl}show-users";
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            "token": loginController.token,
          }));
      if(response.statusCode ==200) {
        Map<String, dynamic> details = jsonDecode(response.body);
        // print(details);
        resp = details["data"];
        print(resp);
      }

      setState(()  {
        loadingText = "There are no Users";
      });
    } catch(e){
      print(e);
    }

  }


  @override
  void initState() {
    super.initState();
    _getUsers();
  }


  ///onpop method
  Future<bool> _onClose() async {
    Get.to(()=>const LoginScreen());
    return true;
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onClose,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Users", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Get.to(()=>const AddUser());
            }, icon: const Icon(Icons.add, color: Colors.white,))
          ],

        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [
            ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: resp.length,
            itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: height*0.15,
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.0)

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 60,),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ID: ${resp[index]["id"]}", style: const TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: height*0.01,),
                          Text("UserName: ${resp[index]["name"]}",),
                          SizedBox(height: height*0.01,),
                          Text("Email: ${resp[index]["email"]}"),
                          SizedBox(height: height*0.01,),
                          Text("Date: ${resp[index]["created_at"]}")
                        ],
                      )
                    ],
                  )

                ),
              );
            }
            ),

              ///display loading text when querying the server
              ///display "no data" when list is empty
              if(resp.isEmpty)
                Center(
                  child: Text(loadingText),
                )


            ],
          ),
        ),
      ),
    );
  }
}
