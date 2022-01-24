import 'package:culqi_flutter/culqi_flutter.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_info_page.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/main.dart';
import 'package:data/models/payment_type.dart';
import 'package:data/models/woocommerce_order_model.dart';
import 'package:data/models/culqi_charge_model.dart';

final ProductsRepository productsRepository = ProductsRepository(TokenStoreImp());
final ChallengesRepository challengesRepository = ChallengesRepository(TokenStoreImp());
late String creditCard = '';
late String expMonth = '';
late String expYear = '';
late String cvvCode = '';
late String emailAddress = '';
class PaymentBody extends StatelessWidget {
  final double paymentTotal;
  final PaymentOrigin paymentOrigin;
  final _formKey = GlobalKey<FormState>();

  PaymentBody({ 
    Key? key, 
    required this.paymentTotal,
    required this.paymentOrigin
  }) : super(key: key);

  Future<void> showPaymentCompletedDialog(BuildContext context, bool isSuccess) async {
    
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color(0xff221c1c),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                isSuccess == true ? 'resources/success.png' : 'resources/fail.png',
                fit: BoxFit.fitHeight,
                height: 200,
              ),
              SizedBox(
                height: kDefaultPadding
              ),
              Text(
                isSuccess == true ? "¡Adquirido exitosamente!" : "Hubo un problema al procesar tu pago, intenta otra vez",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      width: 1, 
                      color: kButtonGreenColor
                    )
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(10)
                  ),
                ),
                onPressed: () {
                  if(paymentOrigin == PaymentOrigin.shop){
                    if(isSuccess == true){
                      checkoutItems.clear();
                    }
                    
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                  else{
                    var count = 0;
                    Navigator.popUntil(context, (route) {
                        return count++ == 4;
                    });
                  }
                }, 
                child: Text(
                  "Aceptar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )
                )
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
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
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  cursorColor: Color(0xff928dab),
                                  keyboardType: TextInputType.number,
                                  maxLength: 16,
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
                                  validator: (value){
                                    if(value!.length < 16){
                                      return "Tarjeta inválida";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 70,
                                      child: TextFormField(
                                        cursorColor: Color(0xff928dab),
                                        keyboardType: TextInputType.number,
                                        maxLength: 2,
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
                                        validator: (value){
                                          if(value!.length < 2){
                                            return "Mes inválido";
                                          }
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
                                      child: TextFormField(
                                        cursorColor: Color(0xff928dab),
                                        keyboardType: TextInputType.number,
                                        maxLength: 2,
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
                                        validator: (value){
                                          if(value!.length < 2){
                                            return "Año inválido";
                                          }
                                        },
                                      )
                                    ),
                                    SizedBox(
                                      width: kDefaultPadding / 6,
                                    ),
                                    Container(
                                      width: 120,
                                      child: TextFormField(
                                        cursorColor: Color(0xff928dab),
                                        keyboardType: TextInputType.number,
                                        maxLength: 3,
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
                                        validator: (value){
                                          if(value!.length < 3){
                                            return "Código inválido";
                                          }
                                        },
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: kDefaultPadding / 6,
                                ),
                                TextFormField(
                                  cursorColor: Color(0xff928dab),
                                  keyboardType: TextInputType.emailAddress,
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
                                  validator: (value){
                                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                                    if(emailValid == false){
                                      return "Correo inválido";
                                    }
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
                                    if (_formKey.currentState!.validate()) {
                                      showDialogIndicator(context);
                                      
                                      var isSuccess = await payCharge();
                                      
                                      hideOpenDialog(context);

                                      await showPaymentCompletedDialog(context, isSuccess);
                                    }
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
                          ),
                        )
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox()
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        bottom: kDefaultPadding,
                        right: kDefaultPadding),
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

  Future<bool> payCharge() async {
    
    try{
      CCard card = CCard(
        cardNumber: creditCard,
        expirationMonth: int.parse(expMonth),
        expirationYear: int.parse(expYear),
        cvv: cvvCode,
        email: emailAddress
      );

      CToken token = await createToken(card: card, apiKey: CulqiApiKey);

      var isSuccess = await productsRepository.createCulqiCharge(
        CulqiCharge(
          //amount: 500,
          amount: paymentTotal.toInt() * 100,
          currencyCode: 'PEN',
          email: emailAddress,
          sourceId: token.id
        )
      );

      if(isSuccess == true){
        if(paymentOrigin == PaymentOrigin.shop){
          await sendOrder();
          return true;
        }
        else{
          await challengesRepository.suscribeToChallenge(selectedChallengeId);
          return true;
        }
      }
      else{
        return false;
      }
    }
    catch(ex){
      return false;
    }
  }

  Future sendOrder() async {
    WoocommerceOrder order = WoocommerceOrder(
      paymentMethod: 'bacs',
      paymentMethodTitle: 'Direct Bank Transfer',
      status: 'pending',
      currency: 'PEN',
      setPaid: true,
      billing: userBilling,
      shipping: Shipping(
        firstName: userBilling.firstName,
        lastName: userBilling.lastName,
        address1: userBilling.address1,
        address2: userBilling.address2,
        city: userBilling.city,
        state: userBilling.state,
        country: 'PE'
      ),
      lineItems: shopOrderItems,
      shippingLines: [
        ShippingLines(
          methodId: 'flat_rate',
          methodTitle: 'Flat Rate',
          total: '10.00'
        )
      ]
    );

    await productsRepository.createWoocommerceOrder(order);
  }
}