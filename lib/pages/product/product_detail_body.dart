import 'package:flutter/material.dart';
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
      Container(
        width: double.infinity,
        decoration: BoxDecoration(),
      )
    ]);
  }
}
