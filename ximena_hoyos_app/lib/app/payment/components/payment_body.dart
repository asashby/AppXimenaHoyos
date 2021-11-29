import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_info_page.dart';
import 'package:ximena_hoyos_app/main.dart';
import 'package:data/models/payment_type.dart';

class PaymentBody extends StatelessWidget {
  final double paymentTotal;

  const PaymentBody({ 
    Key? key, 
    required this.paymentTotal 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.35,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xff00a0e6)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(
                  'resources/mercadopago.png',
                ),
                width: 275,
                fit: BoxFit.fitWidth
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(
                "Escoja su medio de pago",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoRegular'
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffececf6)
            ),
            child: Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('resources/debit_card.png'),
                            color: Colors.transparent,
                            iconSize: 75,
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(
                                  builder: (context) => PaymentInfoPage(paymentType: PaymentType.debit_card)
                                )
                              );
                            },
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Text(
                            "Tarjeta de débito",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoRegular'
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('resources/credit_card.png'),
                            color: Colors.transparent,
                            iconSize: 75,
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(
                                  builder: (context) => PaymentInfoPage(paymentType: PaymentType.credit_card)
                                )
                              );
                            },
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Text(
                            "Tarjeta de crédito",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoRegular'
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: SizedBox()
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total a pagar",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'RobotoRegular'
                          ),
                        ),
                        Text(
                          "S/ " + paymentTotal.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'RobotoRegular'
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  )
                ],
              ),
            )
          )
        )
      ],
    );
  }
}