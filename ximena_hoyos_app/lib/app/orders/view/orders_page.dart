import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class OrdersPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => OrdersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: BaseView(
            title: 'Mis pedidos',
            showBackButton: true,
            sliver: SliverToBoxAdapter(
                child: Padding(
                    padding:
                        const EdgeInsets.only(right: 24, left: 24, bottom: 60),
                    child: Column(children: [
                      Container(
                        width: 327,
                        height: 375,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12, left: 12, right: 19, bottom: 31),
                          child: Column(children: [
                            _OrderHeader(),
                            _ShippingData(),
                            _OrderDetail()
                          ]),
                        ),
                      ),
                    ])))));
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    Key? key,
  }) : super(key: key);

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
                      '12',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Abril',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2021',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              'Pedido: 309-483294',
              style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
            ),
            Text(
              'En camino',
              style: TextStyle(fontSize: 20, color: Color(0xFFF5A623)),
            )
          ],
        ),
      ],
    );
  }
}

class _ShippingData extends StatelessWidget {
  final String? dataShipping;
  final String? dataPayment;

  const _ShippingData({
    Key? key,
    this.dataShipping,
    this.dataPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 6, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direccion de Entrega',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                'Av Pardo 123, Miraflores',
                style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medio de Pago',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                'Visa: 4567 4567 4567 4568',
                style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _OrderDetail extends StatelessWidget {
  final String? dataShipping;
  final String? dataPayment;

  const _OrderDetail({
    Key? key,
    this.dataShipping,
    this.dataPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 6, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Productos',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '- Ipsum loren',
                    style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                  ),
                  Expanded(
                    child: Text(
                      'S/XXX',
                      style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- Ipsum loren',
                    style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                  ),
                  Expanded(
                    child: Text(
                      'S/XXX',
                      style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- Ipsum loren',
                    style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                  ),
                  Expanded(
                    child: Text(
                      'S/XXX',
                      style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                    ),
                  )
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 142),
                child: Text(
                  'S/XXX',
                  style: TextStyle(fontSize: 17, color: Color(0xFF000000)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
