import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/checkout_form/components/checkout_form_body.dart';

class CheckoutFormPage extends StatefulWidget {
  const CheckoutFormPage({ Key? key }) : super(key: key);

  @override
  _CheckoutFormPageState createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends State<CheckoutFormPage> {

  late String dni;
  late String name;
  late String lastName;
  late String enterprise;
  late String address;
  late String department;
  late String district;
  late String phoneNumber;
  late String email;
  late String aditionalInfo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildDni(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "DNI"
      ),
      validator: (value){
        if(value!.isEmpty){
          return "DNI requerido";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CheckoutFormBody(),
      backgroundColor: backgroundMainColor
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: backgroundMainColor,
      elevation: 0,
      leading: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Facturación y envío".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}