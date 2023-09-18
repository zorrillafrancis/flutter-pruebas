import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "lib/assets/icons/Cash.svg", "text": "Cobros"},
      {"icon": "lib/assets/icons/Bill Icon.svg", "text": "Clientes"},
      {"icon": "lib/assets/icons/Gift Icon.svg", "text": "Compras"},
      {"icon": "lib/assets/icons/Game Icon.svg", "text": "Contacto"},
      {"icon": "lib/assets/icons/Discover.svg", "text": "Mapa"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            categories.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {},
                  ),
                )),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon, text;
  final GestureTapCallback press;

  const CategoryCard(
      {super.key, required this.icon, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          width: 63,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              padding: const EdgeInsets.all(7),
              height: 55,
              width: 63,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ])),
    );
  }
}
