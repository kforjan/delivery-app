import 'package:delivery_app/app/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

class ConfirmDeliveryScreen extends StatelessWidget {
  const ConfirmDeliveryScreen({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.accentColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: theme.accentColor,
        child: Column(
          children: [
            Container(
              height: mediaQuery.size.height * 0.3,
              width: mediaQuery.size.width * 0.95,
              child: buildMap(
                context,
                Position(
                  latitude: order.latitude,
                  longitude: order.longitude,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.1,
            ),
            _buildOrderCountInfo(),
            SizedBox(
              height: mediaQuery.size.height * 0.27,
            ),
            RaisedButton(
              color: theme.primaryColor,
              onPressed: () {},
              child: Text(
                'START DELIVERY',
                style: TextStyle(color: theme.textTheme.bodyText2.color),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Opacity(
              opacity: 0.4,
              child: Text(
                '*user will be able to track your location after starting the delivery',
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCountInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Main meals: ${order.mealCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'Side meals: ${order.sideMealCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'Drinks: ${order.drinkCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
