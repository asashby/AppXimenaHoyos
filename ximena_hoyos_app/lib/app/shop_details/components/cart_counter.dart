import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/main.dart';


class CartCounter extends StatefulWidget {
  const CartCounter({ Key? key }) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icon(
            FontAwesomeIcons.minus,
            color: Colors.black
          ), 
          press: () {
            setState(() {
              if(numOfCardItems > 1){
                numOfCardItems--;
              }
            });
          }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
          ),
          child: Text(
            numOfCardItems.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
          ),
        ),
        buildOutlineButton(
          icon: Icon(
            FontAwesomeIcons.plus, 
            color: Colors.black
          ), 
          press: () {
            setState((){
              numOfCardItems++;
            });
          }
        ),
      ],
    );
  }

  SizedBox buildOutlineButton({required Icon icon, required Function()? press}){
    return SizedBox(
      width: 40,
      height: 32,
      child: TextButton(
        onPressed: press, 
        child: icon,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0),
            )
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
      ),
    );
  }
}