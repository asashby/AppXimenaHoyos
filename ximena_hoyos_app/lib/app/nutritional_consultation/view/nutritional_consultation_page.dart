import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:data/repositories/consultation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/main.dart';

import '../../../common/base_view.dart';

class NutritionalConsultationPage extends StatefulWidget {
  const NutritionalConsultationPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => NutritionalConsultationPage()
    );
  }

  @override
  State<NutritionalConsultationPage> createState() => _NutritionalConsultationPageState();
}

class _NutritionalConsultationPageState extends State<NutritionalConsultationPage> {
  final ConsultationRepository consultationRepository = ConsultationRepository(TokenStoreImp());
  late String nameField = '';
  late String lastNameField = '';
  late String phoneField = '';
  late String emailField = '';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BaseView(
        showBackButton: true,
        title: 'Consulta Nutricional',
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                SizedBox(height: 25,),
                Text(
                  'Solicita tu consulta nutricional y logra mejores resultados con un especialista a tu servicio.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                    
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 25,),
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
                    labelText: "Apellido*",
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
                      return "Apellido requerido";
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
                    labelText: "Correo electrónico*",
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
                      return "Correo electrónico requerido";
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
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Número de teléfono*",
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
                      return "Número de teléfono requerido";
                    }
                  },
                  onChanged: (value){
                    phoneField = value;
                  },
                ),
                SizedBox(height: kDefaultPadding),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kButtonGreenColor) 
                  ),
                  onPressed: () async {

                    showDialogIndicator(context);

                    var now = DateTime.now();
                    var dateFormatted = DateFormat('yyyy-MM-dd').format(now);
                    var body = {
                      'name': nameField,
                      'last_name': lastNameField,
                      'phone': phoneField,
                      'email': emailField,
                      'consultation_date': dateFormatted
                    };

                    consultationBody = body;
                    
                    await consultationRepository.sendNutritionalConsultation(body);

                    hideOpenDialog(context);

                    await showPaymentCompletedDialog(context, true);
                    /*Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          paymentTotal: 70,
                          paymentOrigin: PaymentOrigin.consultation,
                        )
                      )
                    );*/
                  }, 
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Solicitar consulta',
                      //'Solicitar consulta S/70',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                )
              ]
            ),
          ),
        ),
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
}