import 'package:data/models/challenge_detail.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/plan_button.dart';
import 'package:ximena_hoyos_app/app/comment_challenge/view/comment_challenge_page.dart';
import 'package:ximena_hoyos_app/app/commentaries/view/comentaries_page.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/challenge_attribute_view.dart';

class ChallengeBody extends StatelessWidget {
  final ChallengeDetail detail;
  final List<PlansByCourse> plans;
  final bool enableComments;

  const ChallengeBody({
    Key? key,
    required this.detail,
    required this.plans,
    this.enableComments = true,
  }) : super(key: key);

  Future<void> showPlansDialog(BuildContext context) async {
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
                  "Seleccione el plan de su conveniencia:",
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
                Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                        itemCount: plans.length,
                        itemBuilder: (context, index){
                          return PlanButton(plan: plans[index]);
                        }
                    )
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF221b1c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)
          )
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            detail.subtitle ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            detail.title ?? "",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            detail.type ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 30,
          ),
          RawMaterialButton(
            onPressed: () {
              if (enableComments) {
                Navigator.of(context).push(CommentariesPage.route(detail.slug!));
              }
            },
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                RatingBar(
                    ignoreGestures: true,
                    unratedColor: Colors.white,
                    allowHalfRating: true,
                    initialRating: detail.rating,
                    ratingWidget: RatingWidget(
                        empty: Icon(
                          Icons.star_outline_rounded,
                          color: Colors.white,
                        ),
                        half: Icon(
                          Icons.star_half_rounded,
                          color: Colors.white,
                        ),
                        full: Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                        )),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: ChallengeAttributeView(
                    title: "Nivel",
                    value: detail.level ?? "",
                  ),
                ),
                Expanded(
                  child: ChallengeAttributeView(
                    title: "Frecuencia",
                    value: detail.frequency ?? "",
                  ),
                ),
                Expanded(
                  child: ChallengeAttributeView(
                    title: "Días",
                    value: detail.days.toString(),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff20d0fc), width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          enableComments || detail.coursePaid != 1 ? Padding(
            padding: const EdgeInsets.only(top: 24),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              color: Color(0xff92e600),
              onPressed: () async {
                if (detail.coursePaid == 1 && enableComments) {
                  Navigator.push(context, CommentChallengePage.route(detail));
                } else {
                  try {
                    await showPlansDialog(context);
                  } on Exception catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reseña publicada'))
                    );
                  }
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                  detail.coursePaid == 1 ? "Comentar" : "Solicita tu plan",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
            ),
          ) : SizedBox.shrink(),
          SizedBox(
            height: 36,
          ),
          Text(
            detail.description ?? "",
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}