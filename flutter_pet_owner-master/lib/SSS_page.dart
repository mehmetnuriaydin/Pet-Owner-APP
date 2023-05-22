import 'package:flutter/material.dart';

class SSSPage extends StatelessWidget {
  const SSSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSS'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Sıkça Sorulan Sorular',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Text('1-Bu uygulamayı kimler kullanabilir?'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                ' Bu uygulamayı android veya ios işletim sistemini kullanan mobil cihazı olan herkes indirip kullanabilir.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Text('2-Bu uygulama nasıl indirilir ve yüklenir?'),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('Bu uygulamayı google play store ve app store üzerinden indirip kullanmaya başlayabilirsiniz.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Text('3-Bu uygulama ücretli mi?'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Bu uygulamayı indirirken ve kullanırken sizden hiç bir ücret talep edilmez.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Text('4-Bu uygulamayı kullanmak için internet erişimi gerekli mi?'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Evet uygulamamız veritabanı ile etkileşimde olduğu için internet erişimi gerekmektedir.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Text('5-Bu uygulamanın kullanımı sırasında beni reklamlar rahatsız edebilir mi?'),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('Uygulamanın şuan kullanmakta olduğunuz sürümünde reklam bulunmamaktadır.'),
          ),
        ],
      ),
    );
  }
}
