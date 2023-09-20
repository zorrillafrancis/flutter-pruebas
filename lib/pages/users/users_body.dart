import 'package:flutter/material.dart';
import 'package:mi_app_01/utils/constants.dart';

class UsersBody extends StatefulWidget {
  const UsersBody({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersBody> createState() => _UsersState();
}

class _UsersState extends State<UsersBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                height: 200,
                width: 120,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Euronews",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16 / 2),
                      child: Text(
                        "On politics with Lisa Loureniani: Warren’s growing crowds",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
