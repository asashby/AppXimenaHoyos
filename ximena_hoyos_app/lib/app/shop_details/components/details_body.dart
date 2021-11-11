import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';

class DetailsBody extends StatelessWidget {

  final Product product;

  const DetailsBody({ 
    Key? key, 
    required this.product 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.3
                  ),
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.title,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            color: kTextColor,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Precio: ",
                                  style: TextStyle(
                                    color: kTextColor
                                  )),
                                TextSpan(
                                  text: "S/" + product.price.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34,
                                    color: Colors.blueGrey,
                                  ),
                                )
                              ]
                            )
                          ),
                          SizedBox(width: kDefaultPadding),
                          Expanded(
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.fill)
                          )
                        ],
                      )
                    ],
                  )
                )
              ]
            ),
          )
        ],
      )
    );
  }
}