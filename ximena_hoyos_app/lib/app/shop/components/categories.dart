import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override 
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>{

  List<String> categories = ["PROTEINA", "IMPLEMENTOS", "COLÁGENO", "PROMOCIONES"];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) =>  buildCategory(index),
        )
      ),
    );
  }

  Widget buildCategory(int index){
    return GestureDetector(
      onTap:(){
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              )
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        )
      ),
    );
  }
}
