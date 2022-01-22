import 'dart:convert';

import 'package:data/models/mp_response_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ximena_hoyos_app/app/payment/view/mercadopago_view.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/main.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:data/models/mp_post_data_model.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;


/*final Map<String, Object> preferenceMap = {
  'external_reference': 'ABC',
  'notification_url': 'https://hookb.in/wN8Lkw2xVJTYKMwPmVoq',
  'items': [
    {
      'title': 'Test Product',
      'description': 'Description',
      'quantity': 1,
      'currency_id': 'PEN',
      'unit_price': 1,
      'picture_url': 'https://http2.mlstatic.com/resources/frontend/statics/growth-sellers-landings/device-mlb-point-i_medium@2x.png'
    }
  ],
  'payer': {
    'email': 'ciberash04@gmail.com'
  }
};*/

class CheckoutFormBody extends StatelessWidget {
  const CheckoutFormBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        labelText: "Nombre",
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
                    ),
                    SizedBox(height: kDefaultPadding),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white
                      ),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Apellidos",
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
                        labelText: "Dirección de la calle",
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
                    ),
                    SizedBox(height: kDefaultPadding),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white
                      ),
                      decoration: InputDecoration(
                        labelText: "Distrito",
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
                    ),
                    SizedBox(height: kDefaultPadding),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white
                      ),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telefono",
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
                    ),
                    SizedBox(height: kDefaultPadding),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Dirección de correo electrónico",
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
                )
              )
            ),
          ),
        ),
        SizedBox(height: kDefaultPadding,),
        ElevatedButton(
          child: Text(
            "Realizar el pedido".toUpperCase()
          ),
          onPressed: () async {

            /*showDialogIndicator(context);

            var body = {
              'external_reference': 'ABC',
              'notification_url': 'https://hookb.in/wN8Lkw2xVJTYKMwPmVoq',
              'items': [
                {
                  'title': 'Test Product',
                  'description': 'Description',
                  'quantity': 1,
                  'currency_id': 'PEN',
                  'unit_price': 1,
                  'picture_url': 'https://http2.mlstatic.com/resources/frontend/statics/growth-sellers-landings/device-mlb-point-i_medium@2x.png'
                }
              ],
            };

            var client = new http.Client();
            var url = Uri.parse('https://api.mercadolibre.com/checkout/preferences?access_token=' + MercadoPagoAccessToken);

            var res = await client.post(
              url, 
              body: json.encode(body),
              encoding: Encoding.getByName("utf-8")
            );

            var decodedResponse = jsonDecode(res.body);

            final Map<String, dynamic> parsed = json.decode(res.body); 

            final mercadopagoResponse = MPResponse.fromMap(parsed);
            hideOpenDialog(context);*/
          
            /*Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => MercadopagoView(url: mercadopagoResponse.sandboxInitPoint)
              )
            );*/

            /*if (await canLaunch(mercadopagoResponse.sandboxInitPoint))
              await launch(mercadopagoResponse.sandboxInitPoint);
            else 
              throw "Could not launch " + mercadopagoResponse.sandboxInitPoint;*/

            /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(res.statusCode.toString()),
            ));

            print('Response status: ${mercadopagoResponse.sandboxInitPoint}');*/

            /*print('Response status: ${res.statusCode}');
            print('Response body: ${res.body}');*/
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => PaymentPage(paymentTotal: 1,)
              )
            );
            /*var data = new MPPostDataModel(
              payment_method_id: '', 
              description: '', 
              installments: 1, 
              payer: Payer(
                name: "test",
                email: "test@gmail.com"
              ), 
              transaction_amount: 55);*/

            /*var mp = MP.fromAccessToken(MercadoPagoAccessToken);
            var result = mp.get("/sites");
            print(result);*/

            /*(
              await MercadoPagoIntegration.startCheckout(
                publicKey: MercadoPagoPublicKey,
                preference: preferenceMap,
                accessToken: MercadoPagoAccessToken
              )
            );*/
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kButtonGreenColor)
          ),
        ),
        SizedBox(height: kDefaultPadding,)
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