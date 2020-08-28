import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    if (widget.model.position == null) {
      widget.model.updateLocation();
    }
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<Database>(context).getOrders(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null || widget.model.position == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data.documents.isEmpty) {
          return Center(
            child: Text('There are no available orders at this time!'),
          );
        } else {
          print(snapshot.data.documents[0].data);

          return _buildListView(
            snapshot.data.documents.map((e) => Order.fromMap(e.data)).toList(),
          );
        }
      },
    );
  }

  Widget _buildListView(List<Order> orders) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return OrderTile(
          order: orders[index],
        );
      },
    );
  }
}
