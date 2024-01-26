import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Signup.dart';
import 'package:petrocardapppp/colors.dart';
import 'package:petrocardapppp/HomePage.dart';
import 'package:petrocardapppp/forgotpassword.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void showSnackBar(String message,{required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,),
    );
  }
  void handlelogin() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      showSnackBar('Please fill both username and password.', isError:true);
    }
    else {
      bool authenticationSuccess = authenticateUser(username, password);
      if (authenticationSuccess) {
        showSnackBarAndNavigate('Login Successful',isError: false);
      }
      else {
        showSnackBar('Username & password are Incorrect',isError: true);
      }
    }
  }
  void showSnackBarAndNavigate(String message, {required bool isError}) {
    showSnackBar(message, isError: isError);
    //home page after successful msg
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const HomePage()),
      );
    });
  }
  bool authenticateUser(String username, String password){
    return username == "Mustufa Memon" && password == "jerry123";
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        child: Column(
          children: <Widget>[
        FadeInDown(duration: Duration(milliseconds: 1000),
              child: Container(
                height: height * 0.25,
                width: width,
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.topLeft,
                end:  Alignment.bottomLeft,
                colors: [
                AppColors.translightPurple2,
                AppColors.neutralBackground,
                ]
              ),
                ),
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10.0),
              child: FadeInUp(duration: const Duration(milliseconds: 1200),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      FadeInUp(duration: Duration(milliseconds: 1000),
                    child: Text(
                      "Login",
                      style:TextStyle(
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                      SizedBox(height: 8,),
                      FadeInUp(duration: Duration(milliseconds: 1300),
                        child: Text(
                          "Hey there,",
                          style:TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                  FadeInUp(duration: Duration(milliseconds: 1400),
                    child: Text(
                      "Welcome Back",
                      style:TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
                ),
              ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FadeInUp(duration: const Duration(milliseconds: 1700),
                child: Container(
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0),
                      ),
                      color: AppColors.neutralBackground,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryText,
                          blurRadius: 15,
                          offset: Offset(0 ,10),
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20.0,),
                        FadeInUp(duration: const Duration(milliseconds: 1900), child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(color: AppColors.lightPurple),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.lightPurple,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]
                          ),
                          child: Column(
                              children: <Widget>[
                                Container(
                                  key: const Key('usernameTextField'),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: AppColors.lightPurple,
                                      ))
                                  ),
                                  child:  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.mail,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: usernameController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Username or e-mail ",
                                              hintStyle: TextStyle(color: AppColors.grey,letterSpacing: 0.7)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          key: const Key('passwordTextField'),
                                          controller: passwordController,
                                          onChanged: (text){
                                            setState(() {
                                              if(passwordController.text.isNotEmpty) {
                                                showPassword = false;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: const TextStyle(color: AppColors.grey,letterSpacing: 0.7),
                                            suffixIcon:passwordController.text.isNotEmpty
                                                ?IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: Icon(
                                                showPassword ? Icons.visibility : Icons.visibility_off,
                                                color: AppColors.grey,
                                              ),
                                            ):null,
                                          ),
                                          obscureText: !showPassword,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeInUp(duration: const Duration(milliseconds: 2100), child: Center(child:
                        TextButton(onPressed: () { Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Forgotpassword(),
                          ),
                        );
                        },
                            child: const Text("Forgot Password?",
                              style: TextStyle(color:AppColors.darkPurple,fontSize: 13.0,letterSpacing: 0.7),)))),

                        const SizedBox(height: 10,),
                        FadeInUp(duration: const Duration(milliseconds: 2100), child: MaterialButton(
                          onPressed: () {
                            handlelogin();
                          },
                          color:  AppColors.darkPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          minWidth: width * 0.3,
                          child: const Center(
                            child: Text("Login", style: TextStyle(color: Colors.white,letterSpacing: 0.5),),
                          ),
                        )),
                        const SizedBox(height: 20,),
                        FadeInUp(duration: const Duration(milliseconds: 2200), child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignUppage(),
                                ),
                              );
                            }, child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Not a member? ", style: TextStyle(color: AppColors.secondaryText,letterSpacing: 0.5,fontSize: 14.0)),
                                Text("Create Account", style: TextStyle(color: AppColors.darkPurple,letterSpacing: 0.5,fontSize: 14.0)),
                              ],
                            )))),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

