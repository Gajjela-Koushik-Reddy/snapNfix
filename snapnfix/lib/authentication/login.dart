import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromRGBO(1, 32, 46, 1),
          child: Center(
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "SnapNFix",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 48),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 30),
                    ),
                  ),

                  // Email Input
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.length < 10) {
                          return "Enter Valid Email Address";
                        }

                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(241, 226, 226, 1),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Email",
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(1, 32, 46, 1)),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color.fromRGBO(1, 32, 46, 1),
                        ),
                        errorStyle: TextStyle(fontSize: 14,)
                      ),
                    ),
                  ),

                  // Password Input
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(241, 226, 226, 1),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(1, 32, 46, 1)),
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Color.fromRGBO(1, 32, 46, 1),
                          )),
                    ),
                  ),

                  // Login button
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 75,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(_emailController.text);
                              print(_passwordController.text);
                            }
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(193, 104, 62, 1),
                          ),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(
                                      color: Color.fromRGBO(193, 104, 62, 1),
                                      width: 3))),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log in", style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      )),

                  // break line
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "or",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.5),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // signup button
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 75,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(3, 58, 81, 1),
                            ),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(
                                        color: Color.fromRGBO(193, 104, 62, 1),
                                        width: 3)))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign Up", style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      )),

                  // Google Login
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/google-icon.png")),
                ],
              ),
            )),
          )),
    );
  }
}
