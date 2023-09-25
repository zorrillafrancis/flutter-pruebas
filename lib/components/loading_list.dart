import 'package:flutter/material.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Loading(
            height: 120,
            width: 120,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Loading(width: 80),
              SizedBox(height: 8),
              Loading(),
              SizedBox(height: 8),
              Loading(),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Loading()),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final double? height, width;

  const Loading({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
