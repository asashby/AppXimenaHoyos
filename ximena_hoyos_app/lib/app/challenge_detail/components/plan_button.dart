import 'package:data/models/challenge_plan.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/payment/view/payment_page.dart';
import 'package:ximena_hoyos_app/main.dart';

class PlanButton extends StatelessWidget {

  final PlansByCourse plan;
  const PlanButton({ 
    Key? key,
    required this.plan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: () {
            selectedChallengeId = plan.id!;

            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  paymentTotal: double.parse(plan.price!),
                  paymentOrigin: PaymentOrigin.challenges,
                )
              )
            );
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                width: 1, 
                color: Color(0xff92e600)
              )
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              )
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 50
              )
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                plan.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff95d100),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              ),
              Text(
                plan.description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              ),
              Text(
                "S/" + plan.price!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff95d100),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              )
            ]
          ),
        ),
        SizedBox(
          height: 20,
        )
      ]
    );
  }
}