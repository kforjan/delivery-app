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
    @required this.orderId,
  }) : super(key: key);

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: theme.primaryColor,
          child: StreamBuilder(
            stream: Provider.of<Database>(context, listen: false)
                .getOrder(this.orderId),
            builder: (cotnext, snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.data != null) {
                Order order = snapshot.data;
                print('isdone ' + order.isDone.toString());
                print('isactive ' + order.isActive.toString());
                print('long ' + order.longitude.toString());
                print('lat ' + order.latitude.toString());
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
                        : _buildPlaceHolder(context, order),
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
      ),
    );
  }

  Widget _buildPlaceHolder(BuildContext context, Order order) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            order.isDone
                ? Icon(
                    Icons.check_circle,
                    size: 150,
                    color: Theme.of(context).accentColor,
                  )
                : Icon(
                    Icons.not_listed_location,
                    size: 150,
                    color: Theme.of(context).accentColor,
                  ),
            SizedBox(
              height: 80,
            ),
            order.isDone
                ? Text(
                    'Your order is at your location.\n Enjoy your meal!',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'Your order is being prepared.\nThank you for your patience!',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
            order.isDone
                ? SizedBox(
                    height: 50,
                  )
                : Container(),
            order.isDone
                ? ElevatedButton(
                    onPressed: () {
                      Provider.of<Database>(context, listen: false)
                          .deleteOrder(orderId);
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2.color),
                    ),
                  )
                : Container(),
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
