import 'package:delivery_app/app/home/models/order.dart';
import 'package:delivery_app/app/home/order/tracking_page.dart';
import 'package:delivery_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'food_selector.dart';
import 'order_model.dart';

class OrderSelection extends StatefulWidget {
  OrderSelection({this.model});
  final OrderModel model;

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => OrderModel(),
      child: Consumer<OrderModel>(
        builder: (context, model, _) => OrderSelection(
          model: model,
        ),
      ),
    );
  }

  @override
  _OrderSelectionState createState() => _OrderSelectionState();
}

class _OrderSelectionState extends State<OrderSelection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FoodSelector(
                changeHandler: widget.model.updateMealCount,
                imagePath: 'assets/images/main-meal.jpg',
              ),
              FoodSelector(
                changeHandler: widget.model.updateSideMealCount,
                imagePath: 'assets/images/side-meal.jpg',
              ),
              FoodSelector(
                changeHandler: widget.model.updateDrinkCount,
                imagePath: 'assets/images/drink.jpg',
              ),
            ],
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.05,
          ),
          Divider(
            color: theme.accentColor,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: Container(
              height: mediaQuery.size.height * 0.25,
              width: mediaQuery.size.width * 0.75,
              child: widget.model.located
                  ? buildMap(context, widget.model.position)
                  : ElevatedButton(
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: theme.accentColor,
                        ),
                        title: Text(
                          'Find my location',
                          style: TextStyle(
                            color: theme.textTheme.bodyText2.color,
                          ),
                        ),
                      ),
                      onPressed: () {
                        widget.model.updateLocation();
                      },
                    ),
            ),
          ),
          Divider(
            color: theme.accentColor,
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.05,
          ),
          ButtonTheme(
            height: mediaQuery.size.height * 0.07,
            minWidth: mediaQuery.size.width * 0.4,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.accentColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                ),
              ),
              child: Text(
                'Order now!',
                style: TextStyle(
                  color: theme.textTheme.bodyText2.color,
                  fontSize: 18,
                ),
              ),
              onPressed: widget.model.isOrderable
                  ? () {
                      Order order = widget.model.generateOrder();
                      Provider.of<Database>(context, listen: false)
                          .addOrder(order);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingPage(
                            orderId: order.id,
                          ),
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMap(BuildContext context, Position position) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(position.latitude, position.longitude),
        zoom: 13.5,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                position.latitude,
                position.longitude,
              ),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
