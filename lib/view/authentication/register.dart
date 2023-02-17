import 'dart:convert';

import 'package:bronzed_blue/controller/RegisterController.dart';
import 'package:bronzed_blue/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../env.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height*0.07,
            ),
            SizedBox(
              child: Image.asset("assets/icon.png"),
            ),
            CustomTextField(
              hintText: "Enter UserName",
              headingText: "",
              prefixIcon: const Icon(Icons.person, color: Colors.black,),
              controller: registerController.nameController,
            ) ,
            SizedBox(height: height*0.02,),
            CustomTextField(
              hintText: "Enter Email",
              headingText: "",
              prefixIcon: const Icon(Icons.email, color: Colors.black,),
              controller: registerController.emailController,
            ) ,
            SizedBox(height: height*0.02,),
            CustomTextField(
              hintText: "Enter Mobile",
              headingText: "",
              prefixIcon: const Icon(Icons.phone, color: Colors.black,),
              controller: registerController.phoneController,
            ) ,
            SizedBox(height: height*0.02,),
            CustomTextField(
              obscureText: true,
              hintText: "Enter Password",
              headingText: "",
              prefixIcon: const Icon(Icons.lock, color: Colors.black,),
              controller: registerController.passwordController,
            ),

            SizedBox(height: height*0.02,),
            CustomTextField(
              obscureText: true,
              hintText: "Confirm Password",
              headingText: "",
              prefixIcon: const Icon(Icons.lock, color: Colors.black,),
              controller: registerController.cPasswordController,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Back to"),
                TextButton(onPressed: (){
                  Get.to(()=>const LoginScreen());
                }, child: const Text("Login", style: TextStyle(color: Colors.black),))
              ],
            ),

            SizedBox(
              width: width*0.5,
              child: CustomButton(onTap: () async {
                if(registerController.nameController.text !=""|| registerController.emailController.text!=""|| registerController.passwordController.text!=""){
                    if(registerController.passwordController.text !=registerController.cPasswordController.text){
                      Get.defaultDialog(
                        title: "Error",
                        content: Column(
                          children: [
                            const Text("Password Do not Match"),
                            TextButton(onPressed: (){
                              Get.back();
                            }, child: const Text("Ok"))
                          ],
                        )
                      );
                    }else{
                      var url = "${baseUrl}register";
                      var response = await http.post(Uri.parse(url),
                          headers: <String, String>{"Content-Type": "application/json"},
                          body: jsonEncode(<String, String>{
                            "username": registerController.nameController.text,
                            "email": registerController.emailController.text,
                            "password": registerController.passwordController.text,
                            "mobileNumber": registerController.phoneController.text,
                          }));

                      if(response.statusCode ==200){
                        Map<String, dynamic> details = jsonDecode(response.body);
                        if(details["success"]){
                          Get.defaultDialog(
                              title: "Success",
                              content: Column(
                                children: [
                                  Text(details["message"].toString()),
                                  TextButton(onPressed: (){
                                    Get.to(()=>const LoginScreen());
                                  }, child: const Text("0k"))
                                ],
                              )
                          );
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

                    }
                }else{
                  Get.defaultDialog(
                    title: "Info",
                    content: Column(
                      children: [
                        const Text("Enter all details"),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: const Text("Ok"))
                      ],
                    )
                  );
                }
              },
                btnText: "Register",
              ),
            )
          ],
        ),
      ),
    );
  }
}
