import 'dart:convert';

import 'package:data/models/shop_order.dart' as ShopOrderModel;
import 'package:data/models/shop_product.dart';
import 'package:data/models/woocommerce_order_model.dart';
import 'package:data/repositories/exchange_rate_repository.dart';
import 'package:data/models/shop_order.dart';
import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/main.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:data/repositories/products_repository.dart';



final ProductsRepository repository = ProductsRepository(TokenStoreImp());
final ExchangeRateRepository exchangeRateRepository = ExchangeRateRepository(TokenStoreImp());
final ProductsRepository productsRepository = ProductsRepository(TokenStoreImp());
final ChallengesRepository challengesRepository = ChallengesRepository(TokenStoreImp());
final Key checkoutFormKey = Key('checkoutFormKey');
class CheckoutFormBody extends StatelessWidget {
  late String nameField = '';
  late String lastNameField = '';
  late String firstAddressField = '';
  late String secondAddressField = '';
  late String cityField = '';
  late String stateField = '';
  late String emailField = '';
  late String phoneField = '';
  final _formKey = GlobalKey<FormState>();

  CheckoutFormBody({ 
    Key? key
  }) : super(key: key);

  
  Future<void> showPaymentTypeDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color(0xff221c1c),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Seleccione un método de pago:",
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
                child: Image(
                  image: NetworkImage("https://www.ximehoyos.com/_nuxt/img/paypal.93ff7ed.png"),
                  width: 150,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                onPressed: () async {

                  var exchangeRate = await exchangeRateRepository.getExchangeRate();

                  await generateOrder();

                  var totalPriceInUSD = totalPrice / exchangeRate.data!;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId: PaypalClientId,
                          secretKey: PaypalSecretKey,
                          returnURL: "https://ximehoyos.com/return",
                          cancelURL: "https://ximehoyos.com/cancel",
                          transactions: [
                            {
                              "amount": {
                                "total": totalPriceInUSD,
                                "currency": "USD",
                                "details": {
                                  "subtotal": totalPriceInUSD,
                                  "shipping": '13',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "Compra tienda Ximena Hoyos",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": '10.12',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": userBilling.firstName! + " " + userBilling.lastName!,
                                  "line1": userBilling.address1,
                                  "line2": userBilling.address2,
                                  "city": userBilling.city,
                                  "country_code": "PE",
                                  "phone": userBilling.phone,
                                  "state": userBilling.state
                                },
                              }
                            }
                          ],
                          note: "Contáctanos si tienes alguna pregunta acerca de tu orden.",
                          onSuccess: (Map params) async {
                            await sendOrder();
                            await showPaymentCompletedDialog(context, true);
                          },
                          onError: (error) async {
                            await showPaymentCompletedDialog(context, false);
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Image(
                  image: NetworkImage("https://www.ximehoyos.com/_nuxt/img/credit-cards.61ee137.png"),
                  width: 150,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                onPressed: () async {
                  await generateOrder();
                  
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        paymentTotal: totalPrice + 13,
                        paymentOrigin: PaymentOrigin.shop,
                      )
                    )
                  );
                },
              )
            ],
          ),
        );
      }
    );
  }

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
                  if(isSuccess == true){
                    checkoutItems.clear();
                  }
                  
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "DNI*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "DNI requerido";
                            }
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Nombre*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Nombre requerido";
                            }
                          },
                          onChanged: (value){
                            nameField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Apellidos*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Apellidos requerido";
                            }
                          },
                          onChanged: (value){
                            lastNameField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Empresa (Opcional)",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: "Dirección de la calle*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Dirección requerida";
                            }
                          },
                          onChanged: (value){
                            firstAddressField = value;
                            secondAddressField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Departamento (opcional)",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          onChanged: (value){
                            stateField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                            labelText: "Distrito*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Distrito requerido";
                            }
                          },
                          onChanged: (value){
                            cityField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Telefono*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Teléfono requerido";
                            }
                          },
                          onChanged: (value){
                            phoneField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Dirección de correo electrónico*",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Email requerido";
                            }
                          },
                          onChanged: (value){
                            emailField = value;
                          },
                        ),
                        SizedBox(height: kDefaultPadding),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Notas del pedido (opcional)",
                            labelStyle: TextStyle(
                              color: Colors.white 
                            ),
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                            )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding,),
                    ElevatedButton(
                      child: Text(
                        "Realizar el pedido".toUpperCase()
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await showPaymentTypeDialog(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kButtonGreenColor)
                      ),
                    ),
                    SizedBox(height: kDefaultPadding,)
                  ],
                )
              )
            ),
          ),
        ),
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

  Future generateOrder() async {
    shopOrderItems.clear();

    checkoutItems.forEach((element) {
      shopOrderItems.add(
        ShopItem(
          productId: element.product.id,
          count: element.quantity,
          name: element.product.name,
          productImage: element.product.urlImage,
          productHasChallengePromo: element.product.hasChallengePromo,
          productChallengeId: element.product.challengeId,
          category: element.product.categories![0].name
        )
      );

      shopProducts.add(
        ShopProduct(
          productId: element.product.id,
          name: element.product.name,
          count: element.quantity
        )
      );
    });

    userBilling = Billing(
      firstName: nameField,
      lastName: lastNameField,
      address1: firstAddressField,
      address2: secondAddressField,
      city: cityField,
      state: stateField,
      country: 'PE',
      email: emailField,
      phone: phoneField
    );

  }

  Future sendOrder() async {

    shopOrderItems.forEach((element) async { 
      if(element.category!.toUpperCase() == "PROMOCIONES"){
        shopPromoItems.add(element.productId!);
        orderHasPromo = true;
      }
    });

    ShopOrder shopOrder = ShopOrder(
      origin: 'store',
      lineItems: shopOrderItems,
      shipping: ShopOrderModel.Shipping(
        firstName: userBilling.firstName,
        lastName: userBilling.lastName,
        address1: userBilling.address1,
        address2: userBilling.address2,
        city: userBilling.city,
        state: userBilling.state,
        country: 'PE'
      ),
      costShipping: 13.00,
      total: totalPrice
    );

    //await productsRepository.createWoocommerceOrder(order);
    await productsRepository.createOrder(shopOrder);
    
    if(orderHasPromo == true){
      await challengesRepository.registerOrderWithPromoData(shopPromoItems, shopProducts, totalPrice + 13);
    }
    else {
      await challengesRepository.registerOrderData(shopProducts, totalPrice + 13);
    }

    checkoutItems = [];
    shopOrderItems = [];
    shopProducts = [];
    shopPromoItems = [];
    orderHasPromo = false;
    totalPrice = 0;
  }
}