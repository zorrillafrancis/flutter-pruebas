import 'package:flutter/material.dart';

import '../models/facturasDetalleModel.dart';
import '../utils/utils.dart';

class ProfileContainer extends StatelessWidget {
  final Header? header;

  const ProfileContainer({super.key, required this.header});
  @override
  Widget build(BuildContext context) {
    Util util = Util();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blueAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(2.3),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  maxRadius: 35.0,
                  backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/02/16/23/10/smile-2072907_960_720.jpg",
                  ),
                ),
              ),
              SizedBox(width: 21),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.numbers,
                              size: 15,
                              color: Colors.white,
                            ),
                            Text(header!.numeroFactura.toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Text(
                          util.formatDate(header!.fecha),
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(header!.cliente.cliente,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                          height: 20,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(header!.cliente.nombre,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.0),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android_outlined,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(header!.cliente.telefono,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("15 Dias", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 3.0),
                  Text(
                    "Pago",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 182, 221, 183),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "NCF",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 182, 221, 183),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "Itbis",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
