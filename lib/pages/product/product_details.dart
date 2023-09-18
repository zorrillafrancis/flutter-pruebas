import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/product/product_detail_body.dart';

import '../../models/productos.dart';
import 'custom_app_bar.dart';

class ProductDetails extends StatelessWidget implements PreferredSizeWidget {
  static String routeName = "/details";

  const ProductDetails({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arg =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          arg.product.rating.toString(),
        ),
      ),
      body: ProductDetailBody(
        product: arg.product,
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
