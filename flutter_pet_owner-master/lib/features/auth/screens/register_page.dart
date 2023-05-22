// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet_owner/common/utils/utils.dart';
import 'package:flutter_pet_owner/common/widgets/error.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/auth/screens/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('Kayıt Ol'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 160,
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
                              controller: _nameController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Ad-Soyad',
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
                          TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Boş bırakılmaz!';
                                }
                                return null;
                              },
                              controller: _passwordAgainController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Parola Tekrar',
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
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (_passwordController.text ==
                                          _passwordAgainController.text) {
                                        ref
                                            .read(authControllerProvider)
                                            .createUser(
                                                _nameController.text,
                                                _emailController.text,
                                                _passwordController.text)
                                            .then((value) {
                                          return Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      LoginPage())));
                                        });
                                      } else {
                                        showSnackBar(
                                            context: context,
                                            content: 'Parolalar eşleşmiyor');
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13)))),
                                  child: SizedBox(
                                      width: 240,
                                      child: Center(
                                        child: Text(
                                          "Kayıt Ol",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (_passwordController.text ==
                                          _passwordAgainController.text) {
                                        ref
                                            .read(authControllerProvider)
                                            .createVeterinary(
                                                _nameController.text,
                                                _emailController.text,
                                                _passwordController.text)
                                            .then((value) {
                                          return Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      LoginPage())));
                                        }).onError((error, stackTrace) =>
                                                ErrorScreen(
                                                    error: error.toString()));
                                      } else {
                                        showSnackBar(
                                            context: context,
                                            content: 'Parolalar eşleşmiyor');
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13)))),
                                  child: SizedBox(
                                      width: 240,
                                      child: Center(
                                        child: Text(
                                          "Veteriner Kayıt Ol",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 125,
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
