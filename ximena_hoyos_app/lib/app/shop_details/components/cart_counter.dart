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
            color: Colors.white
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
            color: Colors.white
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
      child: OutlineButton(
        onPressed: press, 
        child: icon,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        color: Colors.white,
      ),
    );
  }
}