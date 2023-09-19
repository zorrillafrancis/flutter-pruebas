import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Column(children: [
      ProductImages(product: widget.product),
      TopRoundedContainer(
        color: Colors.white,
        child: ProductDescription(widget: widget),
      )
    ]);
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
      height: 300,
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
