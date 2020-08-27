import 'package:delivery_app/app/home/deliver/deliver_model.dart';
import 'package:delivery_app/app/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key key, @required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.location_on,
            color: theme.primaryColor,
          ),
          title: Text(
            _calculateDistanceFromOrder(context) + 'km away from you.',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {},
          subtitle: Text(
            'Main meals: ${order.mealCount} Side meals: ${order.sideMealCount} Drinks: ${order.drinkCount}',
            style: TextStyle(color: theme.textTheme.bodyText2.color),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: theme.canvasColor,
          ),
        ),
        Divider(
          color: theme.canvasColor,
        )
      ],
    );
  }

  String _calculateDistanceFromOrder(BuildContext context) {
    return (Geodesy().distanceBetweenTwoGeoPoints(
              LatLng(
                Provider.of<DeliverModel>(context).position.latitude,
                Provider.of<DeliverModel>(context).position.longitude,
              ),
              LatLng(
                order.latitude,
                order.longitude,
              ),
            ) /
            1000)
        .toStringAsFixed(2);
  }
}
