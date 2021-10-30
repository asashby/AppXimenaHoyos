import 'package:data/models/company_model.dart';
import 'package:data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

enum ContentType { privacy, terms }

class PrivacyPage extends StatelessWidget {
  final ContentType contentType;

  const PrivacyPage({Key? key, required this.contentType}) : super(key: key);

  static Route route(ContentType contentType) {
    return MaterialPageRoute(
        builder: (_) => PrivacyPage(
              contentType: contentType,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: BaseView(
      showBackButton: true,
      title: contentType == ContentType.terms
          ? "Terminos y condiciones"
          : "Politicas de privacidad",
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: FutureBuilder<Company?>(
              future: context.read<CompanyRepository>().getCompanyInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Text(
                    contentType == ContentType.terms
                        ? snapshot.data!.helpCenter.description
                        : snapshot.data!.privacyPolicy.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.35),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
        ),
      ),
    ));
  }
}
