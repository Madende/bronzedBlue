import 'dart:convert';

import 'package:bronzed_blue/view/authentication/register.dart';
import 'package:bronzed_blue/view/users/users.dart';
import 'package:bronzed_blue/widgets/custom_button.dart';
import 'package:bronzed_blue/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controller/LoginController.dart';
import '../../env.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height*0.15,
            ),
            SizedBox(
              child: Image.asset("assets/icon.png"),
            ),
            SizedBox(height: height*0.02,),
            ///Email address
            CustomTextField(
              hintText: "Enter Email",
              headingText: "",
              prefixIcon: const Icon(Icons.email, color: Colors.black,),
              controller: loginController.emailController,
            )   ,
            SizedBox(height: height*0.04,),

            ///Password field
            CustomTextField(
              obscureText: true,
              hintText: "Enter Password",
              headingText: "",
              prefixIcon: const Icon(Icons.lock, color: Colors.black,),
              controller: loginController.passwordController,
            ),
            SizedBox(height: height*0.02,),

            ///Go to register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do not have account,"),
                TextButton(onPressed: (){
                  Get.to(()=>const RegisterScreen());
                }, child: const Text("Register", style: TextStyle(color: Colors.black),))
              ],
            ),
            SizedBox(height: height*0.02,),

            ///Login button
            SizedBox(
              width: width*0.5,
              child: CustomButton(onTap: () async {
              if(loginController.passwordController.text !="" || loginController.emailController.text!=""){
                var url = "${baseUrl}login";
                var response = await http.post(Uri.parse(url),
                    headers: <String, String>{"Content-Type": "application/json"},
                    body: jsonEncode(<String, String>{
                      "email": loginController.emailController.text,
                      "password": loginController.passwordController.text,
                    }));

                if(response.statusCode ==200){
                  Map<String, dynamic> details = jsonDecode(response.body);
                  bool success = details["status"];
                  if(success){
                    loginController.token = details["token"];
                    loginController.userName = details["user"]["username"];
                    Get.to(()=>const UsersScreen());
                  }else{
                    Get.defaultDialog(
                        title: "Error",
                        content: Column(
                          children: [
                            Text(details["message"].toString()),
                            TextButton(onPressed: (){
                              Get.back();
                            }, child: const Text("0k"))
                          ],
                        )
                    );
                  }

                }else{
                  Map<String, dynamic> details = jsonDecode(response.body);
                  Get.defaultDialog(
                      title: "Error",
                      content: Column(
                        children: [
                          Text(details["message"]),
                          TextButton(onPressed: (){Get.back();}, child: const Text("Ok"))
                        ],
                      )
                  );
                }
              }else{
                Get.defaultDialog(
                  title: "Error",
                  content: Column(
                    children: [
                      const Text("Enter all the details"),
                      TextButton(onPressed: (){
                        Get.back();
                      }, child: const Text("Ok"))
                    ],
                  )
                );
              }


              },
              btnText: "Login",
              ),
            )
          ],
        ),
      ),
    );
  }
}

