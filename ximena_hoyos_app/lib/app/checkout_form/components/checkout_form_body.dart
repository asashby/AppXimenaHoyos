import 'dart:convert';

import 'package:data/models/mp_response_model.dart';
import 'package:data/models/shop_order.dart';
import 'package:data/models/shop_product.dart';
import 'package:data/models/woocommerce_order_model.dart';
import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ximena_hoyos_app/app/payment/view/mercadopago_view.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/main.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:data/models/mp_post_data_model.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;



final ProductsRepository repository = ProductsRepository(TokenStoreImp());
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

  Future<void> showPaymentCompletedDialog(BuildContext context) async {
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
                'form',
                fit: BoxFit.fitHeight,
                height: 200,
              ),
              Text(
                "¡Adquirido exitosamente!",
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }, 
                child: Text(
                  "Volver",
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
                          await generateOrder();
                          
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                paymentTotal: totalPrice + 13,
                                paymentOrigin: PaymentOrigin.shop,
                              )
                            )
                          );
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

    /*WoocommerceOrder order = WoocommerceOrder(
      paymentMethod: 'bacs',
      paymentMethodTitle: 'Direct Bank Transfer',
      status: 'pending',
      currency: 'PEN',
      setPaid: true,
      billing: Billing(
        firstName: nameField,
        lastName: lastNameField,
        address1: firstAddressField,
        address2: secondAddressField,
        city: cityField,
        state: stateField,
        country: 'PE',
        email: emailField,
        phone: phoneField
      ),
      shipping: Shipping(
        firstName: nameField,
        lastName: lastNameField,
        address1: firstAddressField,
        address2: secondAddressField,
        city: cityField,
        state: stateField,
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

    await repository.createWoocommerceOrder(order);*/
  }
}