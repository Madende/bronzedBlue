import 'dart:convert';

import 'package:bronzed_blue/view/users/users.dart';
import 'package:bronzed_blue/widgets/custom_button.dart';
import 'package:bronzed_blue/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controller/LoginController.dart';
import '../../controller/UserController.dart';
import '../../env.dart';


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final UserController userController = Get.put(UserController());
  LoginController loginController  = Get.find();

  Future<bool> _onClose() async {
    Get.to(()=>const UsersScreen());
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
          title: const Text("Add User", style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*0.1,),
              CustomTextField(
                headingText: "",
                hintText: "User Name",
                controller: userController.nameController,
              ) ,
              SizedBox(height: height*0.02,),
              CustomTextField(
                headingText: "",
                hintText: "User Email",
                controller: userController.emailController,
              ),

              SizedBox(height: height*0.04,),

              CustomButton(onTap: () async {
                var url = "${baseUrl}add-user";
                var response = await http.post(Uri.parse(url),
                    headers: <String, String>{"Content-Type": "application/json"},
                    body: jsonEncode(<String, String>{
                      "email": userController.emailController.text,
                      "name": userController.nameController.text,
                      "token": loginController.token,
                    }));

                if(response.statusCode ==200){
                  Map<String, dynamic> details = jsonDecode(response.body);
                    Get.defaultDialog(
                    title: "Success",
                    content: Column(
                      children: [
                        Text(details["message"].toString()),
                        TextButton(onPressed: (){
                          Get.to(()=>const UsersScreen());
                        }, child: const Text("Ok"))
                      ],
                    )
                  );

                }

              },
              btnText: 'Add',
              )



            ],
          ),
        ),
      ),
    );
  }
}
