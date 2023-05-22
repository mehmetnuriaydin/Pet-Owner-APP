import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/utils.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/auth/screens/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendPasswordEmail extends ConsumerStatefulWidget {
  static const String routeName = '/send-email-page';
  const SendPasswordEmail({super.key});

  @override
  ConsumerState<SendPasswordEmail> createState() => _SendPasswordEmailState();
}

class _SendPasswordEmailState extends ConsumerState<SendPasswordEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void sendEmail(String email) {
    ref.read(authControllerProvider).sendEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
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
                          const SizedBox(
                            height: 22,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sendEmail(_emailController.text);
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  showSnackBar(
                                      context: context,
                                      content: 'E-Posta başarıyla gönderildi!');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const LoginPage())));
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(10),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)))),
                            child: const SizedBox(
                                width: 240,
                                child: Center(
                                  child: Text(
                                    "Email Gönder",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
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
