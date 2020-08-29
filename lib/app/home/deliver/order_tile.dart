import 'package:delivery_app/app/home/deliver/confirm_delivery_page.dart';
import 'package:delivery_app/app/home/deliver/deliver_model.dart';
import 'package:delivery_app/app/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key key,
    @required this.order,
    @required this.model,
  }) : super(key: key);

  final Order order;
  final DeliverModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.location_on,
            color: getActiveColor(theme),
          ),
          title: Text(
            _calculateDistanceFromOrder(context) + 'km away from you.',
            style: TextStyle(
              color: getActiveColor(theme),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.fade,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmDeliveryScreen(
                  model: model,
                  order: order,
                ),
              ),
            );
          },
          subtitle: Text(
            'Main meals: ${order.mealCount} Side meals: ${order.sideMealCount} Drinks: ${order.drinkCount}',
            style: TextStyle(color: theme.textTheme.bodyText2.color),
            overflow: TextOverflow.fade,
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

  Color getActiveColor(ThemeData theme) {
    return model.order == null
        ? theme.primaryColor
        : (model.order.id == order.id ? theme.hintColor : theme.primaryColor);
  }
}
