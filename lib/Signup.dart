import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/HomePage.dart';
import 'package:petrocardapppp/colors.dart';
import 'package:petrocardapppp/LoginPage.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}


class _SignUppageState extends State<SignUppage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPasswordfields = false;

  void showSnackBar(String message,{required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,),
    );
  }
  void handleSignUp() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = createPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackBar('Please fill in all fields.', isError: true);
    } else if (password != confirmPassword) {
      showSnackBar('Password and Confirm Password do not match.', isError: true);
    } else {
      // Perform signup logic here
      bool signUpSuccess = signUpUser(firstName, lastName, email, password);

      if (signUpSuccess) {
        showSnackBarAndNavigate('Signup Successful', isError: false);
      } else {
        showSnackBar('Signup failed. Please try again.', isError: true);
      }
    }
  }
  bool signUpUser(
      String firstName, String lastName, String email, String password) {
    // Perform signup authentication logic here
    // For example, check if the email is not already registered
    // and then store the new user data

    // For simplicity, assume all signups are successful
    return true;
  }
  void showSnackBarAndNavigate(String message, {required bool isError}) {
    showSnackBar(message, isError: isError);
    // Navigate to the home page after successful signup
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const HomePage()),
      );
    });
  }
// Other methods remain the same...


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
                    )
                ),
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 50.0),
        child: FadeInUp(duration: const Duration(milliseconds: 1200),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              FadeInUp(duration: Duration(milliseconds: 1000),
                child: Text(
                  "Sign up",
                  style:TextStyle(
                    color: AppColors.darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              FadeInUp(duration: Duration(milliseconds: 1300),
                child: Text(
                  "New here?",
                  style:TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              FadeInUp(duration: Duration(milliseconds: 1400),
                child: Text(
                  "Become a member",
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
              child: FadeInUp(duration: const Duration(milliseconds: 1600),
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // FadeInUp(duration: const Duration(milliseconds: 1500), child: const Text("Sign up", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                        const SizedBox(height: 20,),
                        FadeInUp(duration: const Duration(milliseconds: 1700), child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: const Color.fromRGBO(196, 135, 198, .3)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3)
                                  )),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(color: Colors.grey.shade700)
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        color: Color.fromRGBO(196, 135, 198, .3)
                                    ))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "E-mail address",
                                      hintStyle: TextStyle(color: Colors.grey.shade700)
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        color: Color.fromRGBO(196, 135, 198, .3)
                                    ))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Create Password",
                                      hintStyle: TextStyle(color: Colors.grey.shade700)
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        color: Color.fromRGBO(196, 135, 198, .3)
                                    ))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.grey.shade700)
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        const SizedBox(height: 20,),
                        FadeInUp(duration: const Duration(milliseconds: 1900), child: MaterialButton(
                          onPressed: () {},
                          color: const Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          child: const Center(
                            child: Text("Sign up", style: TextStyle(color: Colors.white),),
                          ),
                        )),
                        const SizedBox(height: 10.0,),
                        FadeInUp(duration: const Duration(milliseconds: 2000), child: Center(child: TextButton(onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }, child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?", style: TextStyle(color: AppColors.secondaryText,letterSpacing: 0.5,fontSize: 13.0),
                            ),
                            Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6),letterSpacing: 0.5,fontSize: 15.0),),
                          ],
                        )))),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

