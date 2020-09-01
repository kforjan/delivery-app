import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../models/order.dart';
import 'deliver_model.dart';
import 'order_tile.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key key, this.model}) : super(key: key);

  final DeliverModel model;

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => DeliverModel(),
      child: Consumer<DeliverModel>(
        builder: (context, model, _) => OrdersList(model: model),
      ),
    );
  }

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final geolocator = Geolocator();
  final locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.model.position == null) {
      widget.model.setLocation();
    }

    geolocator.getPositionStream(locationOptions).listen((event) {
      widget.model.updatePosition(event);
      if (widget.model.order != null) {
        Provider.of<Database>(context, listen: false)
            .updateCurrentOrderLocation(widget.model.order, event);
      }
    });

    return StreamBuilder<List<Order>>(
      stream: Provider.of<Database>(context).getOrdersStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null || widget.model.position == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              ),
            );
          } else if (snapshot.data.isEmpty) {
            return Center(
              child: Text('There are no available orders at this time!'),
            );
          } else {
            return _buildListView(
              snapshot.data,
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          );
        }
      },
    );
  }

  Widget _buildListView(List<Order> orders) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return OrderTile(
            model: widget.model,
            order: orders[index],
          );
        },
      ),
    );
  }
}
