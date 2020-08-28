import 'package:delivery_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'food_selection.dart';
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FoodSelection(
              changeHandler: widget.model.updateMealCount,
            ),
            FoodSelection(
              changeHandler: widget.model.updateSideMealCount,
            ),
            FoodSelection(
              changeHandler: widget.model.updateDrinkCount,
            ),
          ],
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.05,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Container(
            height: mediaQuery.size.height * 0.25,
            width: mediaQuery.size.width * 0.6,
            child: widget.model.located
                ? buildMap(context, widget.model.position)
                : FlatButton(
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
        SizedBox(
          height: mediaQuery.size.height * 0.05,
        ),
        RaisedButton(
          color: theme.accentColor,
          child: Text(
            'Order now!',
            style: TextStyle(
              color: theme.textTheme.bodyText2.color,
              fontSize: 18,
            ),
          ),
          onPressed: widget.model.isOrderable()
              ? () {
                  Provider.of<Database>(context, listen: false)
                      .addOrder(widget.model.generateOrder());
                }
              : null,
        ),
      ],
    );
  }

  Widget buildMap(BuildContext context, Position position) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(position.latitude, position.longitude),
        zoom: 13.0,
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
                  Icons.location_on,
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
