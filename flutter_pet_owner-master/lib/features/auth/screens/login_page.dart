// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/auth/screens/send_password_email.dart';
import 'package:flutter_pet_owner/features/home/screens/home_page.dart';
import 'package:flutter_pet_owner/features/auth/screens/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  child: Image.asset("assets/png/petVet_login.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Boş bırakılmaz!';
                                }
                                return null;
                              },
                              controller: _emailController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'E-Mail',
                                prefixText: ' ',
                                hintStyle: TextStyle(color: Colors.white),
                                focusColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                              )),
                          TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Boş bırakılmaz!';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Parola',
                                prefixText: ' ',
                                hintStyle: TextStyle(color: Colors.white),
                                focusColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 180),
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, SendPasswordEmail.routeName),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white),
                              child: Text("Şifremi Unuttum"),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(authControllerProvider)
                                    .signIn(_emailController.text,
                                        _passwordController.text)
                                    .then((value) {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => HomePage())));
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)))),
                            child: SizedBox(
                                width: 240,
                                child: Center(
                                  child: Text(
                                    "Giriş Yap",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return RegisterPage();
                                },
                              ));
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white),
                            child: Text("Kayıt Ol"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                child:
                    Text("PET OWNER APP", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
