import 'package:delivery_app/app/home/models/order.dart';
import 'package:delivery_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: theme.primaryColor,
        child: StreamBuilder(
          stream: Provider.of<Database>(context, listen: false)
              .getOrder(this.order),
          builder: (cotnext, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {
              Order order = snapshot.data;
              print(order.id);
              print(order.currentLongitude);
              return Column(
                children: [
                  (order.isActive &&
                          order.currentLongitude != null &&
                          order.currentLatitude != null)
                      ? SafeArea(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 400,
                                child: _buildMap(
                                  context,
                                  Position(
                                    longitude: order.currentLongitude,
                                    latitude: order.currentLatitude,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Text(
                                'Your order is being delivered.\nYou can track your order!',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                      : _buildPlaceHolder(context),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPlaceHolder(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.not_listed_location,
              size: 150,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              'Your order is being prepared.\nThank you for your patience!',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, Position position) {
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
