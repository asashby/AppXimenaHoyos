import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class ChallengeResumePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ChallengeResumePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: BaseView(
            title: 'Resumen',
            showBackButton: true,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Row(
                      children: [
                        _ResumeChallenge(title: 'Tiempo', value: '27'),
                        _ResumeChallenge(title: 'Calorias', value: '230'),
                      ],
                    ),
                    Row(
                      children: [
                        _ResumeChallenge(title: 'Día', value: '130'),
                        _ResumeChallenge(title: 'Usuarios', value: '45'),
                      ],
                    ),
                    Center(
                      child: RatingBar.builder(
                          itemSize: 58,
                          ignoreGestures: true,
                          unratedColor: Colors.white,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF007885),
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {},
                        height: 60,
                        minWidth: 321,
                        child: Text('Compartir',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {},
                        height: 60,
                        minWidth: 321,
                        child: Text('Terminar',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ) // _commentChallengeForm()
              ]),
            )));
  }
}

class _ResumeChallenge extends StatelessWidget {
  final String? title;
  final String? value;

  const _ResumeChallenge({this.title, this.value}) : super();

  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 11),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFD8D8D8),
                borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 9, bottom: 9, left: 21, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      this.title!,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      this.value!,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
