import 'package:flutter/material.dart';
import 'package:mi_app_01/components/splash_content.dart';
import 'package:mi_app_01/constants.dart';
import 'package:mi_app_01/pages/sign_in/sign_in_screen.dart';
import 'package:mi_app_01/size_config.dart';

import 'default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenidos a School Solutions",
      "image": "lib/assets/images/splash_1.png"
    },
    {
      "text": "Ayudamos a personas a conectar con la tienda.",
      "image": "lib/assets/images/splash_2.png"
    },
    {
      "text": "Te mostramos lo facil que es comprar",
      "image": "lib/assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) {
                      return SplashContent(
                          text: splashData[index]["text"].toString(),
                          image: splashData[index]["image"].toString());
                    })),
            Expanded(
                flex: 3,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                splashData.length, (index) => buildDot(index))),
                        const Spacer(
                          flex: 3,
                        ),
                        DefaultButton(
                          text: "Continuar",
                          press: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
