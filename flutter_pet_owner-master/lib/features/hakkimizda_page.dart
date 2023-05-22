import 'package:flutter/material.dart';

class HakkimizdaPage extends StatefulWidget {
  HakkimizdaPage({super.key});

  @override
  State<HakkimizdaPage> createState() => _HakkimizdaPageState();
}

class _HakkimizdaPageState extends State<HakkimizdaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkimizda'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Biz Kimiz?',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'İlk etapta evcil hayvan sahiplerinin hayvan bilgilerini içeren fiziksel hayvan karnelerinin taşınmasını engellemek için bu uygulamayı geliştirmek üzere yola çıktık.'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                ' Daha sonrasında uygulamamızda kullanıcılara daha farklı ne sunabiliriz diye düşündük ve hayvan sahiplerine yardım etmek isteyen veterinerler için uygulamamıza veteriner girişi ekledik.Uygulamayı kullanan hayvan sahipleri ve veterinerlerin iletişime geçmesi için mesajlaşma özelliği ekledik.'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Hayvan sahiplerinin uygulamadan çıkmadan harita üzerinden veterinerleri görüntüleyebilmesi için harita entegre ettik. Hayvan sahipleri ve veterinerlerin okuyabileceği blog yazıları ekledik.'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Bu uygulama bakırçay üniversitesi bilgisayar mühendisliği öğrencileri Mehmet Nuri AYDIN, Emre HÜR ve Emircan GÜNER tarafından geliştirildi.'),
          )
        ],
      ),
    );
  }
}
