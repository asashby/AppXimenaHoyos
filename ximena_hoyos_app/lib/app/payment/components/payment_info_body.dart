import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data/models/payment_type.dart';
import 'package:culqi_flutter/culqi_flutter.dart';

class PaymentInfoBody extends StatelessWidget {
  final PaymentType paymentType;

  const PaymentInfoBody({ 
    Key? key,
    required this.paymentType
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
            children: [
              Image(
                image: AssetImage(
                  'resources/card.png',
                ),
                width: 325,
                fit: BoxFit.fitWidth
              ),
            ],
          )
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
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
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
                                  labelText: "Titular",
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
                              ),
                              SizedBox(
                                width: kDefaultPadding * 1.5,
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
                                    cardNumber: '4111 1111 1111 1111',
                                    expirationMonth: 09,
                                    expirationYear: 22,
                                    cvv: '123',
                                    email: 'info@hostingonlineperu.com'
                                  );
                                  try{
                                    CToken token = await createToken(card: card, apiKey: "sk_test_e54fbd441558e961");

                                    //su token
                                    print(token.id);
                                  } on CulqiBadRequestException catch(ex){
                                    print(ex.cause);
                                  } on CulqiUnknownException catch(ex){
                                    //codigo de error del servidor
                                    print(ex.cause);
                                  }

                                  hideOpenDialog(context);

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
                  Expanded(child: SizedBox(),),
                  Image(
                    image: AssetImage(
                      'resources/mercadopago2.png',
                    ),
                    width: 110,
                    fit: BoxFit.fitWidth
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