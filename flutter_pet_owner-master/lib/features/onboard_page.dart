import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/auth/screens/login_page.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);
  static const String routeName = '/onboard-page';

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController = PageController(initialPage: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    itemCount: demoData.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) => OnboardContent(
                          image: demoData[index].image,
                          title: demoData[index].title,
                          description: demoData[index].description,
                        )),
              ),
              Row(
                children: [
                  ...List.generate(
                      demoData.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(isActive: index == _pageIndex),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      },
                      style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.blue),
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                    width: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.blue),
                      child: const Text('Atla'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.lightBlue[200],
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard({required this.image, required this.title, required this.description});
}

final List<Onboard> demoData = [
  Onboard(
      image: "assets/png/dog_onboard.png",
      title: "Dostunun bilgileri hep seninle",
      description:
          "Bu uygulama sayesinde veterinerin ile görüşmeye gittiğin zaman evcil hayvanının sağlık karnesini fiziksel olarak yanında taşımana gerek kalmayacak"),
  Onboard(
      image: "assets/png/cat_onboard.png",
      title: "Veterinerlerle mesajlaş",
      description: "Uygulamayı kullanan veterinerler ile mesajlaşma imkanı"),
  Onboard(
      image: "assets/png/rabbit_onboard.png",
      title: "Veteriner görüntüle",
      description:
          "Farklı bir uygulama kullanmaya gerek kalmadan uygulamanın içinden veterinerleri haritada görüntüle"),
  Onboard(
      image: "assets/png/parrot_onboard.png",
      title: "Bilgilen",
      description: "Hayvan dostlarımız hakkında bilgiler edin")
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer()
      ],
    );
  }
}
