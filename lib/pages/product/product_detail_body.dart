import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_app_01/components/default_button.dart';
import 'package:mi_app_01/components/rounded_icon_btn.dart';
import 'package:mi_app_01/utils/constants.dart';
import 'package:mi_app_01/utils/size_config.dart';
import '../../pages/product/product_images.dart';
import '../../models/productos.dart';

class ProductDetailBody extends StatefulWidget {
  final Product product;
  const ProductDetailBody({super.key, required this.product});

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(widget: widget),
              TopRoundedContainer(
                  color: const Color(0xFFF6F6F9),
                  child: Column(
                    children: [
                      ColorDots(product: widget.product),
                      TopRoundedContainer(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.15,
                                right: SizeConfig.screenWidth * 0.15,
                                top: getProportionateScreenWidth(1),
                                bottom: getProportionateScreenWidth(10)),
                            child: DefaultButton(text: "Agregar", press: () {}),
                          ))
                    ],
                  ))
            ],
          ),
        )
      ]),
    );
  }
}

class ColorDots extends StatelessWidget {
  final Product product;

  const ColorDots({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    int selectedColor = 2;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Row(
            children: [
              ...List.generate(product.colors.length, (index) {
                return ColorDot(
                  color: product.colors[index],
                  isSelected: selectedColor == index,
                );
              }),
            ],
          ),
          const Spacer(),
          RoundededIconBtn(iconData: Icons.remove, press: () {}),
          RoundededIconBtn(iconData: Icons.add, press: () {})
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorDot({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 2),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
            //   color: widget.product.colors[0],
            shape: BoxShape.circle,
            border: Border.all(
                color: isSelected ? kPrimaryColor : Colors.transparent)),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ));
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.widget,
  });

  final ProductDetailBody widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color: widget.product.isFavourite
                  ? const Color(0xFFFFE6E6)
                  : const Color(0xFFF5F5F9),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
            child: SvgPicture.asset(
              'lib/assets/icons/Heart Icon_2.svg',
              color: widget.product.isFavourite
                  ? const Color(0xFFFF4848)
                  : const Color(0xFFDBDEE4),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64)),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20), vertical: 10),
          child: const Row(
            children: [
              Text(
                'Ver mas detalle',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: kPrimaryColor,
              )
            ],
          ),
        )
      ],
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const TopRoundedContainer({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}
