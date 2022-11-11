import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Componets/defaualt_button.dart';
import './component/onboard_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to VMMS App, Let’s Start!",
      "image": "assets/images/sp1.png"
    },
    {
      "text": "We help people around Ethiopia \nAddis Ababa City",
      "image": "assets/images/sp2.png"
    },
    {
      "text":
          "We show the easy way to work with us. \nJust stay at home with us",
      "image": "assets/images/sp3.png"
    },
  ];
  final controller = PageController();
  bool isLastPage = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          itemCount: splashData.length,
          itemBuilder: (context, index) => onboardContent(
            image: splashData[index]["image"],
            text: splashData[index]['text'],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool("showHome", true);
                Get.offAllNamed("/signin");
              },
              child: const DefaultButton(
                text: "Get started",
              ),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Column(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 2,
                      effect: const WormEffect(
                          dotHeight: 6,
                          dotWidth: 6,
                          spacing: 10,
                          dotColor: Colors.blueGrey,
                          activeDotColor: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => controller.jumpToPage(2),
                            child: const Text(
                              "Skip",
                              style: TextStyle(color: kPrimaryColor),
                            )),
                        TextButton(
                            onPressed: () => controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceIn),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: kPrimaryColor),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
