import 'package:culqi_flutter/culqi_flutter.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    late String creditCard;
    late String expMonth;
    late String expYear;
    late String cvvCode;
    late String emailAddress;
    return SingleChildScrollView(
      child: Column(
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
                    'resources/culqi.png',
                  ),
                  width: 275,
                  fit: BoxFit.fitWidth
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  "Pantalla de pago",
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          TextField(
                                            cursorColor: Color(0xff928dab),
                                            decoration: InputDecoration(
                                              labelText: "Número de tarjeta",
                                              labelStyle: TextStyle(
                                                fontSize: 18
                                              ),
                                              suffixIcon: FaIcon(
                                                FontAwesomeIcons.creditCard,
                                                color: Color(0xff928dab),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value){
                                              creditCard = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: kDefaultPadding,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              /*Expanded(
                                                child: TextField(
                                                  cursorColor: Color(0xff928dab),
                                                  decoration: InputDecoration(
                                                    labelText: "Fecha de caducidad",
                                                    labelStyle: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                    fillColor: Colors.white,
                                                    suffixIcon: FaIcon(
                                                      FontAwesomeIcons.calendar,
                                                      color: Color(0xff928dab),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: const BorderSide(
                                                        color: Colors.transparent,
                                                      ),
                                                    )
                                                  ),
                                                )
                                              ),*/
                                              Container(
                                                width: 70,
                                                child: TextField(
                                                  cursorColor: Color(0xff928dab),
                                                  decoration: InputDecoration(
                                                    labelText: "Mes",
                                                    labelStyle: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                    fillColor: Colors.white,
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: const BorderSide(
                                                        color: Colors.transparent,
                                                      ),
                                                    )
                                                  ),
                                                  onChanged: (value){
                                                    expMonth = value;
                                                  },
                                                )
                                              ),
                                              SizedBox(
                                                width: kDefaultPadding / 6,
                                              ),
                                              Text(
                                                "/",
                                                style: TextStyle(
                                                  color: Color(0xff928dab),
                                                  fontSize: 18
                                                ),
                                              ),
                                              SizedBox(
                                                width: kDefaultPadding / 6,
                                              ),
                                              Container(
                                                width: 120,
                                                child: TextField(
                                                  cursorColor: Color(0xff928dab),
                                                  decoration: InputDecoration(
                                                    labelText: "Año",
                                                    labelStyle: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                    fillColor: Colors.white,
                                                    suffixIcon: FaIcon(
                                                      FontAwesomeIcons.calendar,
                                                      color: Color(0xff928dab),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: const BorderSide(
                                                        color: Colors.transparent,
                                                      ),
                                                    )
                                                  ),
                                                  onChanged: (value){
                                                    expYear = value;
                                                  },
                                                )
                                              ),
                                              SizedBox(
                                                width: kDefaultPadding / 6,
                                              ),
                                              Container(
                                                width: 120,
                                                child: TextField(
                                                  cursorColor: Color(0xff928dab),
                                                  decoration: InputDecoration(
                                                    labelText: "CVV",
                                                    labelStyle: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                    fillColor: Colors.white,
                                                    suffixIcon: FaIcon(
                                                      FontAwesomeIcons.lock,
                                                      color: Color(0xff928dab),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: const BorderSide(
                                                        color: Colors.transparent,
                                                      ),
                                                    )
                                                  ),
                                                  onChanged: (value){
                                                    cvvCode = value;
                                                  },
                                                )
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: kDefaultPadding / 6,
                                          ),
                                          TextField(
                                            cursorColor: Color(0xff928dab),
                                            decoration: InputDecoration(
                                              labelText: "Correo electrónico",
                                              labelStyle: TextStyle(
                                                fontSize: 18
                                              ),
                                              fillColor: Colors.white,
                                              suffixIcon: FaIcon(
                                                FontAwesomeIcons.user,
                                                color: Color(0xff928dab),
                                              ),
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              )
                                            ),
                                            onChanged: (value){
                                              emailAddress = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: kDefaultPadding,
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Pagar ahora".toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white
                                              )
                                            ),
                                            onPressed: () async {
                                              showDialogIndicator(context);
                                              
                                              CCard card = CCard(
                                                cardNumber: creditCard,
                                                expirationMonth: int.parse(expMonth),
                                                expirationYear: int.parse(expYear),
                                                cvv: cvvCode,
                                                email: emailAddress
                                              );
                                              try{
                                                CToken token = await createToken(card: card, apiKey: "pk_live_519c60a11816cfdc");

                                                //su token
                                                print(token.id);
                                                print(card.expirationYear);
                                              } on CulqiBadRequestException catch(ex){
                                                print(ex.cause);
                                              } on CulqiUnknownException catch(ex){
                                                //codigo de error del servidor
                                                print(ex.cause);
                                              }

                                              hideOpenDialog(context);

                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text("Pago completado")
                                              ));

                                            },
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50)
                                                )
                                              ),
                                              backgroundColor: MaterialStateProperty.all(Color(0xff00c6a2)),
                                              padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 20
                                                )
                                              ),
                                              minimumSize: MaterialStateProperty.all<Size>(
                                                Size(200, 55)
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                    ]
                                  ),
                                )
                              ),
                            ],
                          ),
                        )
                      )
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
      )
    );
  }

  void showDialogIndicator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
            child: SimpleDialog(
              backgroundColor: Colors.black87,
              children: [_getLoadingIndicator()],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
            onWillPop: () async => false);
      },
    );
  }

  Widget _getLoadingIndicator() {
    return Center(
      child: Column(
        children: [
          Container(
              child: CircularProgressIndicator(strokeWidth: 3),
              width: 32,
              height: 32),
          SizedBox(
            height: 12,
          ),
          Text(
            'Espere un momento...',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  void hideOpenDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}