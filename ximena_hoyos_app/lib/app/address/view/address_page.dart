import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class AddressPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => AddressPage());
  }

  Widget build(BuildContext context) {
    return BaseScaffold(
        child: BaseView(
      title: 'Mis direcciones',
      showBackButton: true,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 23, right: 22),
              child: Container(
                width: 330,
                height: 103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 39),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: Text(
                      'Agregar otra',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 26),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          fillColor: Color(0xFFB1B1B1).withOpacity(0.24),
                          filled: true,
                          hintText: 'Dirección',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28, right: 26, top: 16),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          fillColor: const Color(0xFFB1B1B1).withOpacity(0.24),
                          filled: true,
                          hintText: 'Número',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hoverColor: Color(0xFFB1B1B1),
                          focusColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 17,
                      right: 27.6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFB1B1B1).withOpacity(0.24),
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {},
                        height: 60,
                        minWidth: 321,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 27.6,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Provincia',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  iconEnabledColor: Color(0xFFCE9AAA),
                                  iconSize: 60,
                                  items: [],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 17,
                      right: 27.6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFB1B1B1).withOpacity(0.24),
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {},
                        height: 60,
                        minWidth: 321,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 27.6,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Distrito',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  iconEnabledColor: Color(0xFFCE9AAA),
                                  iconSize: 60,
                                  items: [],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                top: 130,
                right: 27.6,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF30D38B),
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  onPressed: () {},
                  height: 60,
                  minWidth: 321,
                  child: Text('Guardar',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
