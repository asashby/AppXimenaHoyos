import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:ximena_hoyos_app/main.dart';

final Map<String, Object> preferenceMap = {
  'items': [
    {
      'title': 'Test Product',
      'description': 'Description',
      'quantity': 1,
      'currency_id': 'PEN',
      'unit_price': 1,
    }
  ],
  'payer': {
    'name': 'Buyer G.', 
    'email': 'test@gmail.com'
  },
};

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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "DNI",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "DNI requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Nombre",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Nombre requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Apellidos",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Apellidos requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Empresa (Opcional)",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: "Dirección de la calle",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Dirección requerida";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Departamento (opcional)",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Distrito",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Distrito requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telefono",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Teléfono requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Dirección de correo electrónico",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email requerido";
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2,),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Notas del pedido (opcional)",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.grey,
                          )
                        ),
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
            (await MercadoPagoIntegration.startCheckout(
              publicKey: MercadoPagoPublicKey,
              preference: preferenceMap,
              accessToken: MercadoPagoAccessToken,
            ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kButtonGreenColor)
          ),
        ),
        SizedBox(height: kDefaultPadding,)
      ],
    );
  }
}