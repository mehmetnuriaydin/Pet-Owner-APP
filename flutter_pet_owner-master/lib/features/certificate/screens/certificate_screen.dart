import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/colors.dart';
import 'package:flutter_pet_owner/common/utils/utils.dart';
import 'package:flutter_pet_owner/features/certificate/controller/certificate_controller.dart';
import 'package:flutter_pet_owner/features/home/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/input_widget.dart';

class CertificateScreen extends ConsumerStatefulWidget {
  static const String routeName = '/certificate-screen';
  final String recieverUserId;
  const CertificateScreen({super.key, required this.recieverUserId});

  @override
  ConsumerState<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends ConsumerState<CertificateScreen> {
  void createCertificate(String recieverUserId, Map<String, dynamic> map) {
    ref.read(certificateControllerProvider).createCertificate(context, recieverUserId, map);
  }

  void clearControllers() {
    speciesController.clear();
    nameController.clear();
    breedController.clear();
    dateController.clear();
    sexController.clear();
    colorController.clear();
    microController.clear();
    vaccinationController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    speciesController.dispose();
    nameController.dispose();
    breedController.dispose();
    dateController.dispose();
    sexController.dispose();
    colorController.dispose();
    microController.dispose();
    vaccinationController.dispose();
  }

  List<bool> isSexSelected = [false, false];
  List<bool> breedIsSelect = [false, false];
  List<bool> isMicroChipSelected = [false, false];
  List<bool> isVaccationSelected = [false, false];

  final _formKey = GlobalKey<FormState>();
  TextEditingController speciesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController microController = TextEditingController();
  TextEditingController vaccinationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> map = {};
    createCertificate(widget.recieverUserId, map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Hayvan Karnesi Oluştur'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 24),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hayvan Karnesi Oluştur',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: InputField(
                  controller: speciesController,
                  hintText: 'Tür bilgisi',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: InputField(
                  controller: nameController,
                  hintText: 'İsim',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: DatePicker(dateController: dateController),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: InputField(
                  controller: colorController,
                  hintText: 'Renk',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(margin: const EdgeInsets.all(4), child: const Text('Cinsiyet')),
                          ToggleButtons(
                            onPressed: ((index) {
                              setState(() {
                                for (var i = 0; i < isSexSelected.length; i++) {
                                  if (i == index) {
                                    isSexSelected[i] = true;
                                    if (i == 0) {
                                      sexController.text = 'Erkek';
                                    } else {
                                      sexController.text = 'Dişi';
                                    }
                                  } else {
                                    isSexSelected[i] = false;
                                  }
                                }
                              });
                            }),
                            renderBorder: true,
                            fillColor: appBarBgColor,
                            selectedColor: bgColor,
                            borderRadius: BorderRadius.circular(12),
                            isSelected: isSexSelected,
                            children: const [
                              Center(child: Text('Erkek')),
                              Center(child: Text('Dişi')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            child: const Text('Mikroçip'),
                          ),
                          ToggleButtons(
                            onPressed: ((index) {
                              setState(() {
                                for (var i = 0; i < isMicroChipSelected.length; i++) {
                                  if (i == index) {
                                    isMicroChipSelected[i] = true;
                                    if (i == 0) {
                                      microController.text = 'Evet';
                                    } else {
                                      microController.text = 'Hayır';
                                    }
                                  } else {
                                    isMicroChipSelected[i] = false;

                                    microController.text = 'Evet';
                                  }
                                }
                              });
                            }),
                            renderBorder: true,
                            fillColor: appBarBgColor,
                            selectedColor: bgColor,
                            isSelected: isMicroChipSelected,
                            borderRadius: BorderRadius.circular(12),
                            children: const [
                              Center(child: Text('Evet')),
                              Center(child: Text('Hayır')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            child: const Text('Kuduz Aşısı'),
                          ),
                          ToggleButtons(
                            onPressed: ((index) {
                              setState(() {
                                for (var i = 0; i < isVaccationSelected.length; i++) {
                                  if (i == index) {
                                    isVaccationSelected[i] = true;
                                    if (i == 0) {
                                      vaccinationController.text = 'Evet';
                                    } else {
                                      vaccinationController.text = 'Hayır';
                                    }
                                  } else {
                                    isVaccationSelected[i] = false;
                                    vaccinationController.text = 'Evet';
                                  }
                                }
                              });
                            }),
                            renderBorder: true,
                            fillColor: appBarBgColor,
                            selectedColor: bgColor,
                            isSelected: isVaccationSelected,
                            borderRadius: BorderRadius.circular(12),
                            children: const [
                              Center(child: Text('Evet')),
                              Center(child: Text('Hayır')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: const Text('Cins'),
                      ),
                      ToggleButtons(
                        onPressed: ((index) {
                          setState(() {
                            for (int i = 0; i < breedIsSelect.length; i++) {
                              if (i == index) {
                                breedIsSelect[i] = true;
                                if (i == 0) {
                                  breedController.text = 'Kedi';
                                } else {
                                  breedController.text = 'Köpek';
                                }
                              } else {
                                breedIsSelect[i] = false;
                                breedController.text = 'Kedi';
                              }
                            }
                          });
                        }),
                        renderBorder: true,
                        fillColor: appBarBgColor,
                        selectedColor: bgColor,
                        isSelected: breedIsSelect,
                        borderRadius: BorderRadius.circular(12),
                        children: const [
                          Center(child: Text('Kedi')),
                          Center(child: Text('Köpek')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 130),
                child: MaterialButton(
                  onPressed: () {
                    Map<String, dynamic> map = {
                      'species': speciesController.text,
                      'name': nameController.text,
                      'breed': breedController.text,
                      'date': dateController.text,
                      'sex': sexController.text,
                      'color': colorController.text,
                      'microchip': microController.text,
                      'vaccination': vaccinationController.text,
                    };
                    if (_formKey.currentState!.validate()) {
                      createCertificate(widget.recieverUserId, map);
                      showSnackBar(context: context, content: 'Kaydedildi!');
                      Future.delayed(
                          const Duration(milliseconds: 500), () => Navigator.pushNamed(context, HomePage.routeName));
                    }
                  },
                  color: colorBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(child: Text('Kaydet')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: false,
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          locale: const Locale('tr', 'TR'),
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        ).then(
          (selectedDate) {
            if (selectedDate != null) {
              dateController.text = selectedDate.toString().split(" ").first;
            }
          },
        );
      },
      controller: dateController,
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        hintText: 'Doğum Tarihi',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
